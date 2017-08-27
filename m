Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: liu peng <pwlp@me.com>
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Dose  bluez 4.101 can work BLE good ?
Message-id: <C6D328E4-4955-468D-A0E8-C0146EFD5D0A@me.com>
Date: Sun, 27 Aug 2017 22:03:12 +0800
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all.

There is a question. I did not find an answer and no any idea.

My goal is create bluetooth peripheral and services on a board. And then =
my iOS App can discover that peripheral and services.My app will write =
some data to board via bluetooth.

I use Bluez4.101. It run in an embedded ubuntu, the kernel version is =
3.10. I know the Bluez version is too old. but Bluez5.x needs kernel =
3.15+. it's impossible to upgrade kernel , It=E2=80=99s a long story.

this problem is.

While I run this below command

hciconfig hci0 leadv

My iOS App can found my peripheral and it's connectable. but when =
peripheral connected I have call discoverServices. I can not discover =
any service. I have tried run bluez's test script simple-service and I =
run sdptool browse local, it list a lot of services. for example:

Service Name: AVRCP TG Service RecHandle: 0x10002 Service Class ID List: =
"AV Remote Target" (0x110c) Protocol Descriptor List:
"L2CAP" (0x0100) PSM: 23 "AVCTP" (0x0017) uint16: 0x103 Profile =
Descriptor List: "AV Remote" (0x110e) Version: 0x0104

Service Name: AVRCP CT Service RecHandle: 0x10003 Service Class ID List: =
"AV Remote" (0x110e) Protocol Descriptor List: "L2CAP" (0x0100) PSM: 23 =
"AVCTP" (0x0017) uint16: 0x103 Profile Descriptor List: "AV Remote" =
(0x110e) Version: 0x0100
I'm not sure whether I did wrong thing.
Some one can tell me how to do? Or the bluez 4.101 whether can work to =
satisfy my requirement?

Thanks.

