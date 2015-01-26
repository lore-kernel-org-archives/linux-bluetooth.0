Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 26 Jan 2015 10:09:00 +0800
Message-ID: <CACw_oNeRd1nv0TFFdCrxEPtvcfhOdDiFY7TtYY2EGz9dUU2SkA@mail.gmail.com>
Subject: question about no responds to my bluetooth keyboard
From: M Ren <itux.ren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[bluetooth]# connect 01:02:03:04:05:06

Hi,

The issue I met is simple:
I use bluetoothctl connect to a bluetooth keyboard on my dev board,
follow this instruction https://wiki.archlinux.org/index.php/Bluetooth_keyboard
[bluetooth]# power on
[bluetooth]# agent KeyboardOnly
[bluetooth]# pairable on
[bluetooth]# pair 01:02:03:04:05:06
[bluetooth]# trust 01:02:03:04:05:06
[bluetooth]# connect 01:02:03:04:05:06
[bluetooth]# quit
output shows "Connection successful"

But dev board didn't respond to any keypress.
What maybe the reason ?
appreciate any advices, if some log is needed, please tell me.

BTW, keyboard on pc works ok.

Thanks.
