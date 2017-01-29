Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 64671] hci0 command 0x1009 tx timeout, bluez can't find adapter
Date: Sun, 29 Jan 2017 21:50:51 +0000
Message-ID: <bug-64671-62941-NCGU8mI1Xg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-64671-62941@https.bugzilla.kernel.org/>
References: <bug-64671-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64671

Leif Liddy <leif.liddy@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |leif.liddy@gmail.com

--- Comment #5 from Leif Liddy <leif.liddy@gmail.com> ---
Have you tried resetting the usb port? Fixed an issue on my laptop where the
bluetooth controller wouldn't work after suspend+resume. Was receiving the same
sort of timeout errors. Worth a shot in any case.

#!/usr/bin/python

from usb.core import find as finddev
dev = finddev(idVendor=0x13d3, idProduct=0x3362)
dev.reset()


**I wouldn't normally post a python script, but in this case, it's much simpler
then the corresponding shell script would be

**requires pyusb to run. "pip install pyusb" or "dnf install pyusb"

-- 
You are receiving this mail because:
You are the assignee for the bug.
