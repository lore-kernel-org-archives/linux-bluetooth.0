Return-Path: <cyrus@holtmann.org>
Message-ID: <4BC19B11.1090409@xyzw.org>
Date: Sun, 11 Apr 2010 02:49:05 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Mouse authentication regression after 4.63
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Upon trying out a newer version of BlueZ, I found a regression in 
support for my mouse caused by the following commit:

commit aee26b30bbc24cde464ba1a557c2b258ddec6432
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Tue Mar 30 13:36:46 2010 +0300

     Make BtIO default security level MEDIUM

     MEDIUM makes more sense than the kernel default LOW which maps to "no
     bonding" with SSP (something that's useful only for very special cases
     such as OPP).


After this commit, when I turn on or move my mouse, I get prompted for a 
PIN to use for the connection. "0000" won't work, and blank isn't 
accepted, so the mouse can't connect. Deleting and re-pairing my mouse 
doesn't work either. I suspect my mouse just does not support 
encryption. I've never seen AUTH or ENCRYPT on my mouse in the output of 
"hcitool con" and I can't enable encryption on a working bluez using 
"hcitool auth". It just prompts for a PIN, and disconnects the mouse 
when I enter one. And there's no documentation on what PIN should be 
used with this mouse.

With the above commit reverted, it works fine again. The mouse 
information is below. Could this be a device-specific quirk? What 
information is needed to resolve this?

$ hcitool info 00:12:A1:63:EF:3A
Requesting information ...
         BD Address:  00:12:A1:63:EF:3A
         Device Name: Interlink Bluetooth Mouse
         LMP Version: 2.0 (0x3) LMP Subversion: 0x229
         Manufacturer: Broadcom Corporation (15)
         Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch>
<sniff mode> <RSSI> <power control> <enhanced iscan>
<interlaced iscan> <interlaced pscan> <AFH cap. slave>

