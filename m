Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vincent Petry <pvince81@googlemail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Cannot use any submenu in bluetoothctl since bluez 5.48
Message-ID: <1135e315-5170-76b4-2c91-b0ab7a24cf5b@gmail.com>
Date: Mon, 5 Feb 2018 07:57:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

It appears that since bluez 5.48, the gatt commands and others have been
moved into a submenu in the bluetoothctl shell.

I'm struggling to find a way to access the gatt commands. In the past I
could just type "list-attributes" but now it says "Invalid command".

None of the following commands work:

- gatt
- gatt help
- help gatt
- list-attributes

I had a quick look at the source code and I have the feeling that there
is actually no way to access these commands.

If there is a way already, please make it easier and more intuitive to find.

My env:
- openSUSE Tumbleweed snapshot 20180130
- bluez 5.48
- kernel 4.14.15-1-default

Thanks,

Vincent


