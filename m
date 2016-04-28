Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Apr 2016 16:43:58 +0900
Message-ID: <CAArnnE5VYZT7eG591qkBtOd8tL_NAr2H3vYCGNDFiCpVRA6ghg@mail.gmail.com>
Subject: How to use BLE with kernel 3.4?
From: Hyuntak Lee <pphdev12@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’m working on an embedded board of allwinner.
I try to use BLE to communicate with mobile or other BLE peripheral devices.
But kernel version of provided allwinner is ‘3.4’.
I already know BlueZ5 BLE supports at least kernel 3.5 version, and
‘LEAdvertisingManager1’ is 4.1 and later versions support only.
I would much prefer to use bluez, but the embedded system kernel
version is too low.

Do you have any plan for supporting the embedded system?
Almost embedded systems are low kernel version.

At this point, I can consider two options

1. Try to backports for updating Linux BT subsystem of kernel 4.1 and
later. And try to BLE with the most recent bluez.
2. Find and try another BLE stack implementations

Please give me some advice or an opinion.
Thank you for your consideration.

Best regards,
Tak
