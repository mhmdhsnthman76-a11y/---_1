<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>آلة حاسبة ماكسوس</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #080818, #101c35);
    font-family: Arial, sans-serif;
    color: white;
}

.calculator {
    width: 340px;
    max-width: 95%;
    padding: 22px;
    border-radius: 25px;
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(0,255,200,0.3);
    box-shadow: 0 0 30px rgba(0,255,200,0.15);
}

h2 {
    text-align: center;
    color: #00ffc8;
    margin-top: 0;
}

#display {
    width: 100%;
    height: 85px;
    margin-bottom: 20px;
    padding: 15px;
    border: none;
    outline: none;
    border-radius: 15px;
    background: #080d1b;
    color: #00ffc8;
    font-size: 30px;
    text-align: left;
    direction: ltr;
    box-shadow: inset 0 0 10px #000;
}

.buttons {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
}

button {
    height: 58px;
    border: none;
    border-radius: 14px;
    background: #1a2740;
    color: white;
    font-size: 21px;
    cursor: pointer;
    transition: 0.2s;
}

button:active {
    transform: scale(0.92);
}

.operator {
    background: #075f58;
    color: #00ffc8;
}

.clear {
    background: #a62942;
}

.equal {
    background: #00cba9;
    color: #07131b;
    font-weight: bold;
}

.zero {
    grid-column: span 2;
}

.footer {
    text-align: center;
    margin-top: 20px;
    font-size: 12px;
    color: #aab7ca;
}
</style>
</head>

<body>

<div class="calculator">
    <h2>𒆜 ماكسوس MAXSUS 𒆜</h2>

    <input id="display" type="text"
           value="0" readonly aria-label="شاشة الآلة الحاسبة">

    <div class="buttons">
        <button class="clear" onclick="clearDisplay()">AC</button>
        <button class="operator" onclick="deleteLast()">⌫</button>
        <button class="operator" onclick="percent()">%</button>
        <button class="operator" onclick="append('/')">÷</button>

        <button onclick="append('7')">7</button>
        <button onclick="append('8')">8</button>
        <button onclick="append('9')">9</button>
        <button class="operator" onclick="append('*')">×</button>

        <button onclick="append('4')">4</button>
        <button onclick="append('5')">5</button>
        <button onclick="append('6')">6</button>
        <button class="operator" onclick="append('-')">−</button>

        <button onclick="append('1')">1</button>
        <button onclick="append('2')">2</button>
        <button onclick="append('3')">3</button>
        <button class="operator" onclick="append('+')">+</button>

        <button class="zero" onclick="append('0')">0</button>
        <button onclick="append('.')">.</button>
        <button class="equal" onclick="calculate()">=</button>
    </div>

    <div class="footer">
        جميع الحقوق محفوظة لدى المبرمج ماكسوس
    </div>
</div>

<script>
const display = document.getElementById("display");
let expression = "";
let finished = false;

function update() {
    display.value = expression || "0";
}

function append(value) {
    if (finished && /[0-9.]/.test(value)) {
        expression = "";
    }

    finished = false;

    if ("+-*/".includes(value)) {
        if (!expression && value !== "-") return;

        if (/[+\-*/]$/.test(expression)) {
            expression = expression.slice(0, -1);
        }
    }

    expression += value;
    update();
}

function clearDisplay() {
    expression = "";
    finished = false;
    update();
}

function deleteLast() {
    expression = expression.slice(0, -1);
    finished = false;
    update();
}

function percent() {
    const match = expression.match(/(\d+\.?\d*)$/);

    if (match) {
        const number = Number(match[0]) / 100;
        expression = expression.slice(0, -match[0].length) + number;
        update();
    }
}

function calculate() {
    if (!expression) return;

    try {
        if (!/^[0-9+\-*/.() ]+$/.test(expression)) {
            throw new Error("Invalid");
        }

        if (/[+\-*/.]$/.test(expression)) {
            throw new Error("Incomplete");
        }

        const result = Function(
            '"use strict"; return (' + expression + ')'
        )();

        if (!Number.isFinite(result)) {
            throw new Error("Math error");
        }

        expression = String(
            Number(result.toPrecision(12))
        );

        finished = true;
        update();

    } catch (error) {
        display.value = "خطأ";
        expression = "";
        finished = false;
    }
}
</script>

</body>
</html>