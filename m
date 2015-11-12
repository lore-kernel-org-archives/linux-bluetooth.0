Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73411] Unknown vendor ID [105b:e065] - Broadcom BCM43142 device
Date: Thu, 12 Nov 2015 09:46:39 +0000
Message-ID: <bug-73411-62941-2ZkDKW34Bg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73411-62941@https.bugzilla.kernel.org/>
References: <bug-73411-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73411

kolAflash <kolAflash@kolahilft.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kolAflash@kolahilft.de

--- Comment #8 from kolAflash <kolAflash@kolahilft.de> ---
Any progress on this?


I just followed this guide to make a 105b:e065 Bluetooth adapter work on a
Lenovo G700 (model 20251, product 59387531).

http://www.gnebehay.com/blog/lenovo-flexpad-bluetooth-debian/

Works fine!
Connected successfully to my phone and send a file.

So it would be very great, if

{ USB_DEVICE(0x105b, 0xe065), .driver_info = BTUSB_BCM_PATCHRAM },

would be included into

linux-source/drivers/btusb.c


Thanks!

-- 
You are receiving this mail because:
You are the assignee for the bug.
