Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?Bj=c3=b6rn_Hauffe?= <bjoern@64b.de>
Subject: Bug in D-BUS bluez agent API (potentially)
Message-ID: <6e0e8b33-84cc-dafd-cf43-dfbe2fc13109@64b.de>
Date: Fri, 3 Aug 2018 16:15:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

i hope this is the right place to report this bug. If i try to pair a 
Bluetooth 4.0 Keyboard with the bluez daemon and the first try wasn't 
successful, the successful try after that won't displayed by the 
registered bluetooth Agent (e.g. GUI). The Pin is still displayed by the 
Bluetooth tool forever. I think the problem is, that the registered 
reply method is never called by the bluez daemon (over  D-Bus).

Tested with Bluetooth GUI tool from Ubuntu 18.04.1 and Fedora 28 (Bluez 
5.49). Also tested with a self written D-Bus based pairing agent.

My hardware for testing: Logitech K850, Microsoft Designer Keyboard


Steps to reproduce:

1. made a pairing try with a bluetooth 4.0 Keyboard, but let it fail 
(wrong pin for example)

2. the second pin will displayed by the bluetooth tool

3. enter the new displayed pin correct to successful finish the pairing 
process

4. you can't see that the pairing process is finish, because the GUI 
will not show any feedback.

5. open bluetoothctl and check that the keyboard is paired.


If i miss something, please let me know.


Best regards

Björn

