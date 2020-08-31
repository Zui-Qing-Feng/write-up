#!/usr/bin/env sage
from Crypto.Util.number import long_to_bytes as l2b
from config import enc

DEBUG = True
p = 294214241043210847882633628460406569791004369248219469864868650839944892041552240115071921799516814453729223636385495706851064791673605812405426598104306214287211381632931839743688359795486667731446998689421253087437104672397328045443587236120188583037287351172306262921448876283904175440304649379775701352449
q = 57317700419715468513185509060583512178200535449200562119327466031665644769904333354067160157145008150370597520080962086380559115254150287086026192349765034581949024305095306399787645130021756225377516198895786544717767497375889752986343077823214180643260929105311546605264454435411893914316040420635895658369


def decrypt(p, q):
    d = inverse_mod(0x10001, (p - 1) * (q - 1))
    flag = l2b(pow(enc, d, p * q))
    if b'CCTF' in flag:
        print(flag.decode())
        exit()

if DEBUG:
    decrypt(p, q)

primes = []
x = 1
while True:
    x += 1
    for m in range(int(log(2 ^ 1019, x)), 100000):
        target = x ^ (m + 1) - (x + 1) ^ m
        bitlen = target.nbits()
        if bitlen < 1030:
            if is_prime(target):
                primes.append(target)
        else:
            break
    if len(primes) == 24:
        break

for i in range(len(primes)):
    for j in range(i + 1, len(primes)):
        p, q = primes[i], primes[j]
        decrypt(p, q)