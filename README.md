# 1111LogicDesign-FinalProject
- Topic:猜數字遊戲
- Authors:第7組(110321014林以恆 110321015陳奕羱 110321018張簡雲翔)
- Equipment:FPGA(EP3C10E144C8) Notebook
## Menu
- [Input/Output Unit](#inputoutput-unit)
- [Features description](#features-description)
- [Program structure](#program-structure)
- [Demo Video](#demo-video)

## Input/Output Unit

### Input

#### 指撥開關
- 設定輸入數字位數
- 設定輸入數字大小
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_203306.jpg)
#### 輕觸按鈕
- 遊戲開始鍵
- 數字輸入鍵
- 比較答案鍵
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_203319.jpg)
### Output

#### LED
- 提示輸入數字與答案的大小
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_203356.jpg)
#### 7段顯示器
- 顯示目前輸入的數字
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_204055.jpg)
#### 8x8全彩矩陣燈
- 顯示剩餘秒數
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_204011.jpg)
- 顯示遊戲勝利畫面
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_204238.jpg)
- 顯示時間結束畫面
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_204134.jpg)
#### 蜂鳴器
- 遊戲勝利時會發出聲音提示
![](https://github.com/ase12345636/1111LogicDesign-FinalProject/blob/main/Hardware%20Photo/20230108_203340.jpg)
## Features description
- 能隨機產生被猜的數字
- 有遊戲開始鍵
- 顯示目前輸入的數字
- 可以選擇輸入的數字大小
- 可以選擇輸入的數字位數
- 透過輕觸開關進行數字比較
- 顯示剩餘遊戲時間
- 遊戲結束時會有結束畫面
- 每次比較後，會透過LED提示應該要再猜大或小
- 猜對數字時，會有提示音
## Program structure
### 產生亂數方法
透過數個四個頻率的Clock，在每個Clock變化的時候數字+1，當加的數字超過9則歸回0，在Start按下時，就不繼續加，因為四個Clock頻率都不一樣，所以說也很難算出來數字大小，用來做到產生隨機數字的方法。
### 倒數計時
BCD Counter
### 8x8全採顯示
視覺暫留速度夠快
### 蜂鳴器
1會叫 0不會叫
## Demo Video
- IO布局介紹
https://youtu.be/lqq4aMi5bnc
- 猜對數字結束畫面
https://youtu.be/nhQXlHIgDvQ
- 時間到結束畫面
https://youtu.be/9c-kTVm7kts
