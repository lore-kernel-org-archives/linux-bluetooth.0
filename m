Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 4 Dec 2010 11:36:31 -0700
Message-ID: <AANLkTinS82Qk38qZEDBKggFO81RJc_g3dmo23+Cog4+O@mail.gmail.com>
Subject: HID parser for Bluetooth devices
From: Viswanathan Sankararam <developervishwa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All, I am new to bluetooth. I am trying to understand where in Linux
stack a bluetooth HID device parser exists. Is it part of the
bluetooth HIDP driver or somehow hooks into the HID driver for USB HID
devices. Also I see that bluez sources has a directory called input
and an input.so file is created. What is the function of this library?
I would really appreciate an explanation of how bluez integrates with
Linxu input subsystem and HID parser.

Thanks
Vish
