Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: Hard-configuring a BT Module
Date: Mon, 30 Mar 2015 18:30:22 -0400
Message-ID: <87k2xyp18h.fsf@digitalsignallabs.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

we are building a custom board using the TI AM335x ARM processor and
want to base it on the armhf port of debian linux.

to save cost/power/etc), our system will not have a usb bridge, so the
usual method of adding a bluetooth device via plugging it into a usb
port will not be used.

is it possible to configure bluez and/or the kernel to recognize and use
a BT module (an LSR TiWi-uB2) that has its HCI serial interface
hard-wired to a specific serial port / uart on the ARM?

also, is the LSR TiWi-uB2 known to operate with bluez correctly?

thanks for any help you can suggest.
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
