Return-Path: <cyrus@holtmann.org>
Message-ID: <516D1011.1020306@gmx.de>
Date: Tue, 16 Apr 2013 10:47:13 +0200
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Progress an Broadcom BCM20702A0 USB adapter (id 0489:e031)
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello folks,

a short summary of the situation concerning the adapter mentioned above
with latest kernel 3.8.7:

When the bluetooth service is started a device hci0 is created. The
adaper still needs a firmware upload to work properly.

I extracted the firmware from the windows driver and converted it to hcd
format using hex2hcd.

There is a tool called
'brcm_patchram_plus'(http://code.google.com/p/broadcom-bluetooth/source/browse/brcm_patchram_plus.c)
that loads the firmware into the adapter.

After that the adapter is working with linux-bluetooth.

Question: Is there any way to perform the upload without using 3rd party
tools? Can bluetoothd do this by itself?

Thank you
Harvey

-- 
I am root. If you see me laughing, you'd better have a backup!

