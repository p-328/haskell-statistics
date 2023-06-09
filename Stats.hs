module Stats where
    import MathUtils

    avg :: [Double] -> Double
    avg dataset = summation dataset / fromIntegral (length dataset)
    
    sampleStdev :: [Double] -> Double
    sampleStdev dataset = sqrt (summation [pow (distance mean num) 2 | num <- dataset] / (fromIntegral (length dataset) - 1))
        where 
            mean = avg dataset
    
    populationStdev :: [Double] -> Double
    populationStdev dataset = sqrt (summation [pow (distance mean num) 2 | num <- dataset] / fromIntegral (length dataset))
        where
            mean = avg dataset

    describe :: [Double] -> [([Char], Double)]
    describe dataset = [
        ("Mean", avg dataset), 
        ("Sample Standard Deviation", sampleStdev dataset), 
        ("Population Standard Deviation", populationStdev dataset)]
    
    findNumberOfItemsInFreqTable :: [(Double, Int)] -> Int
    findNumberOfItemsInFreqTable dataset = summation [freq | (_, freq) <- dataset]

    extractValuesFromTable :: [(Double, Int)] -> [Double]
    extractValuesFromTable freqTable = [num * fromIntegral freq | (num, freq) <- freqTable]

    avgFreq :: [(Double, Int)] -> Double
    avgFreq dataset = summation values / fromIntegral itemCount
        where 
            values = extractValuesFromTable dataset
            itemCount = findNumberOfItemsInFreqTable dataset

    sampleStdevFreq :: [(Double, Int)] -> Double
    sampleStdevFreq dataset = sqrt (summation [pow (distance mean num) 2 * fromIntegral freq | (num, freq) <- dataset] / itemCount)
        where 
            mean = avgFreq dataset
            itemCount = fromIntegral (findNumberOfItemsInFreqTable dataset - 1)

    populationStdevFreq :: [(Double, Int)] -> Double
    populationStdevFreq dataset = sqrt (summation [pow (distance mean num) 2 * fromIntegral freq | (num, freq) <- dataset] / itemCount)
        where
            mean = avgFreq dataset
            itemCount = fromIntegral (findNumberOfItemsInFreqTable dataset)

    describeFreq :: [(Double, Int)] -> [([Char], Double)]
    describeFreq dataset = [
        ("Mean", avgFreq dataset),
        ("Sample Standard Deviation", sampleStdevFreq dataset),
        ("Population Standard Deviation", populationStdevFreq dataset)]

    zScore :: Double -> [(Double, Int)] -> Double
    zScore x dataset = (x - mean) / stdev
      where 
        mean = avgFreq dataset 
        stdev = populationStdevFreq dataset

    