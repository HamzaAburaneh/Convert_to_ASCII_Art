import Codec.BMP
import Data.ByteString
import Data.Either
import GHC.Word
import System.IO.Unsafe

loadBitmap :: FilePath -> [[(Int, Int, Int)]]
loadBitmap filename = repackAs2DList (either returnEmptyOnError processDataOnBMP (unsafePerformIO (readBMP filename)))
  
returnEmptyOnError :: Error -> ([(Int, Int, Int)], (Int, Int))
returnEmptyOnError _ = ([], (0, 0))

processDataOnBMP :: BMP -> ([(Int, Int, Int)], (Int, Int))
processDataOnBMP bmp = ((parseIntoRGBVals (convertToInts (unpack (unpackBMPToRGBA32 bmp)))), (bmpDimensions bmp))
  
convertToInts :: [Word8] -> [Int]
convertToInts [] = []
convertToInts (h:t) = (fromIntegral (toInteger h)) : (convertToInts t)

parseIntoRGBVals :: [Int] -> [(Int, Int, Int)]
parseIntoRGBVals [] = []
parseIntoRGBVals (h:i:j:_:t) = (h,i,j) : (parseIntoRGBVals t)

repackAs2DList :: ([(Int, Int, Int)], (Int, Int)) -> [[(Int, Int, Int)]]
repackAs2DList (pixels, (width, height)) = (Prelude.reverse (repackAs2DList' pixels width height))

repackAs2DList' :: [(Int, Int, Int)] -> Int -> Int -> [[(Int, Int, Int)]]
repackAs2DList' []  width  height = []
repackAs2DList' pixels width height = (Prelude.take width pixels) : (repackAs2DList' (Prelude.drop width pixels) width height)

showAsASCIIArt :: [[Char]] -> IO ()
showAsASCIIArt pixels = Prelude.putStr (unlines pixels)

-----------------------------------------------------------------------------------------------------------------------------------

--Main Function ran for Q1--
displayImage :: [Char] -> Bool -> [[(Int, Int, Int)]] -> [[Char]]
displayImage str bool img = mymap (mymap (intervalFunc ((if bool then id else myReverse) str))) (convertToLum img) 

--converts all rgb to lum--
convertToLum :: [[(Int, Int, Int)]] -> [[(Int)]]
convertToLum img = mymap (mymap convertPixel) img

--map function--
mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

--convert single pixel--
convertPixel :: (Int, Int, Int) -> Int
convertPixel (r, g, b) = round((fromIntegral r * 0.3) +  (fromIntegral g * 0.59) +  (fromIntegral b * 0.11))

--Decide intervals for Lum values--
intervalFunc :: [Char] -> Int -> Char
intervalFunc str lum = str !! ((lum -1) `quot` round (255 / fromIntegral (myLength str))) 

--length function--
myLength :: [Char] -> Int
myLength [] = 0
myLength (x:xs) = 1 + (myLength xs)

--reverse function--
myReverse :: [a] -> [a]
myReverse list = myReverse' list []

myReverse' :: [a] -> [a] -> [a]
myReverse' [] rev = rev
myReverse' (x:xs) rev = myReverse' xs (x:rev)


