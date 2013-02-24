Return-Path: <cyrus@holtmann.org>
Message-ID: <512A82B3.405@kamens.us>
Date: Sun, 24 Feb 2013 16:14:27 -0500
From: Jonathan Kamens <jik@kamens.us>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
References: <51100E6E.8070804@kamens.us> <CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com>
In-Reply-To: <CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010705090709030405050306"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010705090709030405050306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anderson,

Thanks for your response.

On 02/24/2013 09:59 AM, Anderson Lizardo wrote:
> Hi Jonathan,
>
> On Mon, Feb 4, 2013 at 3:39 PM, Jonathan Kamens <jik@kamens.us> wrote:
>> Greetings,
>>
>> Using Fedora 18 x86_64, I've tested two different USB Bluetooth dongles
>> (cheap generic Cambridge Silicon and more expensive BlueRigger BTD-400) and
>> two different headsets (Motorola SF600, BrainyTrade BH-M20), in all
>> combinations, the A2DP High-Fidelity profile for audio output works, but the
>> HFP/HSP Telephony profile does not.
> More details on which steps you take to reproduce the problem should
> help identifying the issue.
I posted extensive details in both the bugzilla ticket and the Fedora 
Testers List message to which I linked; that is why I linked to them. 
Here's what I put into the Bugzilla ticket:

    I have this Bluetooth USB dongle:

    Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
    Bluetooth Dongle (HCI mode)

    If I pair my Motorola SF600 headset with my computer using this
    dongle, then The HSP/HFP Telephony profile doesn't work. More
    specifically, input works but output does not. At least, I think
    input is working -- I can see the mic level move in the sound
    settings control panel when I talk, though I can't play it back
    because output doesn't work.

    In addition, with various combinations of pairing, unpairing,
    turning on, and turning off, I managed to get things into two
    interesting states relatively quickly -- one in which the sound
    settings let me change the profile drop-down but refused to actually
    switch the headset to that profile, and one in which bluetooth
    stopped working completely and shutting it off and on wouldn't help
    -- it would not turn back on. Right now, for example, I connected
    the headset, went to the sound settings, saw that it was set to the
    telephony profile, changed it to the high fidelity profile, and then
    clicked Test Speakers. The speaker testing window should have two
    buttons, one for left and one for right, but it has only one, as if
    it's still in telephony mode, and clicking the Test button hangs for
    a while without doing anything. In short, it's  bit of a mess.

    I also tested with a second Bluetooth USB dongle; this one, neither
    input NOR output works when I select the HSP/HFP Telephony profile:

    Bus 004 Device 002: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0

    I also tested a cheap Bluetiger bluetooth headset with the same result.

    In contrast, the HSP/HFP Telephony profile _does_ work with this
    headset when I pair it to Fedora 18 on my ThinkPad T420i, with this
    BlueTooth hardware:

    Bus 001 Device 021: ID 0a5c:217f Broadcom Corp. Bluetooth Controller

Today, I tested this issue with Fedora 17 64-bit, Ubuntu 12.10 32-bit, 
and Ubuntu 12.10 64-bit Live CDs. Fedora 17  doesn't recognize the 
Bluetooth the Bluetooth 4.0 USB dongle at all, and Ubuntu has the same 
problem as Fedora 18, i.e., my test results contradict BlueRigger's 
claim that the problem I'm experiencing does not occur in Ubuntu.
> Also run "sudo hcidump -w hcidump.dump"  while you do these steps and
> attach the generated hcidump.dump to your email so we can see what's
> going on.
I've attached hcidump.dump from when I first pair the headset and 
connect to it using the Bluetooth 4.0 dongle, switch it to the HSP/HFP 
profile, and attempt to test sound output, yielding only silence from 
the headset.
> The information below is also important because not everyone here uses
> Fedora 18:
> * kernel version ("uname -r")
> * bluez version ("bluetoothd --version", or at least the package
> version from the distro).
$ uname -r
3.7.9-201.fc18.x86_64
$ bluetoothd --version
4.101
$

Thanks,

Jonathan Kamens


--------------010705090709030405050306
Content-Type: application/gzip;
 name="hcidump.dump.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="hcidump.dump.gz"

H4sICPOBKlEAA2hjaWR1bXAuZHVtcADsnXl4FUW6h7/q0zkrIYSAIawREEGCEiCgKFsCiCLL
sIiIIqsIEpYEAUdkuSiiiDAIKCgIbkFAR1FRQAUe514VBRT1ugCyi4Ql7Ltkqvt00l/mdGq8
9079M/cXrAdzTnW9X1fXr94+J3k4A8bkjhg5chTJL0Hky5d/R5xmWA/SnvfSD318Xy0RSQ2I
8lTefowCTvO5XYbVMsuaspf1gN9pbIRh2aJMqiGE98Gjz1gHl/E+OD+ydJ11sDc5P/LmRvfg
kNPYwW/uEcKMazxjsVnK8WvGmgkmyU5yCoxoY09fvy3evKFQ/N6BWpSXU2SatefFrQmEMjs0
6NSooRE2I77qicHESGJ8YtlE+jf+Mp3mzkzvQy+Y9gWNXTH5vfPn/pMVk9/7TBfFipFPzyl9
xeT3/r2SasX0ef5JxYrps/wb9+BEp7GDlxeKODM+esUrfWU94V1En1VL7ZUTZ81LWae5T+fE
LTF9ETkxRWvHs9Qcf1lRxTQi3qXmJPayEVUsRNhp7OmUmmZqwB2/aHjW45bbzSqyijjvEodk
mhGrxMLCWVdeKOw9lRXBShwyRFS1TsV7GnJyyK6xqlVjOaexpye+Y9aKlwwRXSzRr6JaGGXi
1yLFDEdPxiht1eRMm2jDUrzTmju9kxkodGY8mlH6//gVu85yp48TiaWus9y5QXtaE61rWLSJ
sqdf2Gkm+6OzSu5CZKO/UCjKmG6PeKexIV5ZaZYNy05U3MmDs2KimR47CuOsWCjqm6GiFe/z
Rr3b3kLVZ6gyTnM7jZm312zkDOSzCbEDTVqcZjZ2VuSUsj7vU5+0uKtIU576pM0Rq540Vk9s
lJ843NxsGnB7VHaa22N6mxpmpeRohxrNm22dO+GJncPr1Kn11L0pL5nkFf7pHY6Zfh+VuOZu
4dNvC4ik0mM9vcfr9pJIMj2fntH4KjNoUvToBKcRe/oOudbCsiBBYRlSG1vRacLttv5DI5Ja
Tl4bQRERLMq99VW0MbMx1x+UY5ahoOxsGLI0am09FXQaq+3bJmZSnIiURn16eUox1WcE5TCt
rSG9O8881jOmc6klzjz2SHGJps8s6prkNHfUWS/GyVHLyhkSFOfzu2PGns1fXpkdPRvhXeDc
7snFBZp2gda2aO97yU4j1rmjLLC83Hsl1wg7XKd7Nafx7otl90pUQXa01lZChi9FSFtkxMnV
W1joXfDcYY+z6b/JaazgXe/JgptQQzmotajqU52m4pqm1DtE9nzITUFk+FMSq6eU94XIzChj
QzPiUgx7t6/hNFbl7ltklZXpKrtKQYklq4weFlvH/ILyrA5h1UG+oAiRPyMUGjwiRMNCQtYS
ygja1YREnPz+moQO/Q3a4VnH/IL5rA4jpg77sNj5es6YpZyv5zMLWJ2GVeeIQbkN2ucMHpz6
0IihY0K+xBBVaUpdnfkTzvwFDVrtWefzWVNYnb7YOld71rFgRjlWh8+q4x+vkJw/I3b+DJrt
WceCGQtZHWZsHbM952vB4jnK+Vq0/z5Wp2nVaV/BoFWOvIKBDoP7D8odLOfNqCua0o3OtBkh
g4Z51rnoQDKrMy62zmGedbx0bgmrI85eX0Iemhix5qycLMmanhT5N6WEhFG80uINautZx0vn
r2F1+GPraOs5X0sCTZTztbTVBlan36rTKsdaVWx6fKFo8WXd4g2q7lnn0ta3sjoDsXVah93g
NLeOl4+Ok3VcJ2fJqiNAV1P1ECVb05PMg1jW+sYuzjowds96dWFltmcF7T2r/D/bs15962U2
R7H79WsHGzv7tVVbUF5NI4O8+a8fasb4IZufWL0EP/Ya5AVbsWsQsvdEuueP7In2QLHXIC84
i12DsH0NWBXRw2LnIa/KF8q1kldrPqsz/D/ZM5O866ydwuqMxNZpHVbbaayOlsdlHTWoil1H
RB6e5LEnWr1jJZ3X6if3PsI05dm38V4UeZ1nKO8j8u681701MINymDal30fkzR8V09n5KurM
Spw/U5boOD0uaHcVxhmf59rMW/+zey8R548dl3X97A33XsFXYtzYe4W8z7517xV8YWdcp3vR
bS7r/rmV+qDccNuQr5Wo6j2lP2SyKS0ahBW497ws0BkkV/zgXdi+q53CZKeCilMTjeMBOu6j
wChv5tkpjFk0nMtc9uAnkhkdThRUnJJo7A7QJPnkcs/zXDa8dvF5RlqJ3p7nsez0hOLziOSK
OeS1EJedqewsROs8QvviIjNHsY5stPN95GjRjsLuGL/ce8TzL/MR98iO3nPyRuA0m5NY4htJ
KzhRDjTTIha9bCfW8RtJDMkNUZ5oobh6GuvFhkt+Vg4X7RUqFAn3eBdVqyMrqpLT2CgvWhFK
ki815CgFyW161M/s1r19i0bN4lvLHlWcxmpb1MiwtobyVm0F1eLDdv/mqY0zGsWHF5KbJX6I
dStpZck6JD4+3KVjtKtHte9+p6x2eb0Et9rCioYsN+u2zm1btIq3zv5ppxHrv1Gin6CpNrpQ
Vmt1b55at+aA/mPGDHxgSM20ug0bZNSrl1a3Zu7QISP6D+cPDM4ZO3TgYOuRtHT7kYH9hw//
h2/lPc9Do+yDGhc/9sDg4YPshxrZD+WM7J9tH2Wdc3mn8Rq/lDXGy+tt1RiRQ5c2kcvrbfmj
E7m87T3KfK6oc7E4n6HCJJ8zkdF5vMZpLnnFtXmSnEpVbXJ68TxmpGWkpac1jP4prewV1779
R8te0TyXlX2109yyV1ZsK8uuKleFVfa19vXv1K5bi8ZpqQ3t/9LtE4itYWXFE3+0hpV1v1Cu
wTVdI3wNClnDnbd2b5HeqBT0mq4nvdGxO8TazNbODhG1qKBM66lYl63NnFjsMkt8mdGORF4b
2NrMae4LaL9Z1DX2zNf2XKc887VD28eeeacW6Q1LOfO1w7p5n3msRNdmX+9KNC5o11jqC+61
2Xe5EpX3NNETcrrHunzt6BTX5X6/O1UeMzBhE5uBovtQNtSZY3Io6z40035VnJARV1lOdw2q
kyFvIa033qim01i5Z8/IcqtRijzIek1cQd6QJWTEl7ijs/rWchrDXdgqcdXlrZw14fWtCc/q
bm3PDYsyl9bMnvurnMagF4dKaKLcV6y5T4oPt+vWrUu30tb8utBIpbrWVaxbvDD99hLK9F5r
6yp2L15rAbejB7H2px5Ed6D1Y95xbygDpj15nitn/cEF7j1gIEhZsmOpN4zrD4+N6ex8eZRw
eL6bm6ApO1Mpoxb0cRdvoGjxTvK+A1xf8LC7eANhZ1Sne+w8rb9yUfkiasOozu7iDvpV57Nh
tHCnNGTKumx20U+aeMeasqP1bktWFBVb1oap3ylv4zf2XehOdCgoX0VnFV2V2ME+bZXE3o2L
vfH7at5/Ojd+mWQI0zq46M1nt+iv5neSRVvvoWRROcN6gzXFae5Am0c9LgeqIDfOTCpvWCvU
fj2UYRolNOkOunl0XediZVGqzzSjh1xd0X6hGnsimycnK2dl84nsmFkp9XJtPrHIXX5h034j
wnvUC+nu8gsG7TFLXX6bL9zmLr9g2BnV6V60FNjYhePl2NZSyKSaPs+J30IJxRPf0G96TsyW
4BblKt5SKcddxWG/Oy2xFW1Z1KW4okZ+z5nbsug3d6FHrL3DPkuPst7+WrkJbXn/ZPFA/jJm
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

--------------010705090709030405050306--
