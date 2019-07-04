(* Wolfram Language package *)
folder = "/Users/AaronLopes/Desktop/newsela_article_corpus/articles/";\

metadata = 
  Import["/Users/AaronLopes/Desktop/newsela_article_corpus/articles_\
metadata.csv", "Dataset", "HeaderLines" -> 1];
allFileNames = 
  metadata[Select[#language == "en" &]][All, "filename"] // Normal;
rand = allFileNames[[RandomInteger[Length[allFileNames]]]];
(*find better operation for this portion*)

h = StringSplit[rand, "."][[1]];
lowLevelFileNames = 
  Lookup[Lookup[Normal@GroupBy[metadata, #gradelevel <= 6.0 &], 
    False], "filename"];
highLevelFileNames = 
  Lookup[Lookup[Normal@GroupBy[metadata, #gradelevel <= 6.0 &], 
    True], "filename"];
(*Search for filename in low level category, construct filepath*)

lowtext = Select[
  	lowLevelFileNames, 
   	StringMatchQ[h <> ".en." ~~ DigitCharacter ~~ ".txt"]
   ];

lt = StringJoin[folder, #] & /@ lowtext;

hightext = 
  Select[highLevelFileNames, 
   StringMatchQ[h <> ".en." ~~ DigitCharacter ~~ ".txt"]];

ht = StringJoin[folder, #] & /@ hightext; 
randCorpusHigh = Import[#] & /@ ht;
randCorpusLow = Import[#] & /@ lt;
 