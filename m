Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Gottfried Haider <gottfried.haider@gmail.com>
Date: Sat, 16 Apr 2011 18:38:59 +0200
Message-ID: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
Subject: [Regression] Bluetooth pairing does not work anymore in 2.6.39-rc3
 (works in 2.6.38.3)
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am having problems pairing bluetooth devices in 2.6.39. Scanning
works fine (hcitool scan), but when I try to pair a device using
"bluez-simple-agent hci0 $MAC", I receive the following error message:
"Creating device failed: org.bluez.Error.Failed: Input/output error"

The same command reliably works on a 2.6.38.3 kernel with pretty much
the same config.

According to lsusb, I have a Broadcom Bluetooth Controller with ID
0a5c:217f. I don't see anything related in either of the dmesgs.
My lspci output is here: http://sukzessiv.net/x120e/
Userspace is an up-to-date Ubuntu 11.04 beta (with bluez 4.91).

If there are any debugging steps that I could do or patches to try or
revert, let me know. Unfortunately I can't do a proper bisect since
the machine is a netbook type.

cheers,
gohai
