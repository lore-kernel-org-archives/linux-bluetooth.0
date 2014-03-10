Return-Path: <cyrus@holtmann.org>
Date: Sun, 9 Mar 2014 21:35:16 -0500
From: Ranjan Maitra <maitra.mbox.ignored@inbox.com>
To: linux-bluetooth@vger.kernel.org
Subject: DUNS for GPRS/EDGE-enabled 2G phone under BlueZ5.14
Message-Id: <20140309213516.771f26f90438fdcdea7efa8a@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am new to this list and I am writing because I am in urgent need of
some pointers/help. I connect through a GPRS/EDGE-enabled 2G phone
using Bluetooth which worked seamlessly under Bluez4. However, I am
unable to get it to work under Bluez-5.14 (on Fedora 20). I tried using
bluetoothctl but I am unable to even pair the device.

Here is what I get:

$ bluetoothctl 
[NEW] Controller B4:B6:76:57:B1:46 alakananda.stat.iastate.edu-0
[default] [NEW] Device FC:A1:3E:B8:26:D4 SGH-T249
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# devices
Device FC:A1:3E:B8:26:D4 SGH-T249
[bluetooth]# pair FC:A1:3E:B8:26:D4 
Attempting to pair with FC:A1:3E:B8:26:D4
[CHG] Device FC:A1:3E:B8:26:D4 Paired: yes
Pairing successful
[CHG] Device FC:A1:3E:B8:26:D4 Connected: yes
[CHG] Device FC:A1:3E:B8:26:D4 Paired: no
[CHG] Device FC:A1:3E:B8:26:D4 Connected: no
....

I do not know how to get this to work. Is DUNS no longer there under
Bluez5? Or am I missing some library?

I am sorry if this is a simple question but it would be really nice to
get some pointers. I am not afraid of reading manuals and going
through the commandline.

Please keep replies to the list.

Many thanks for any help!

Best wishes,
Ranjan 
-- 
Important Notice: This mailbox is ignored: e-mails are set to be
deleted on receipt. Please respond to the mailing list if appropriate.
For those needing to send personal or professional e-mail, please use
appropriate addresses.

____________________________________________________________
Send any screenshot to your friends in seconds...
Works in all emails, instant messengers, blogs, forums and social networks.
TRY IM TOOLPACK at http://www.imtoolpack.com/default.aspx?rc=if2 for FREE


