Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 109321] ASUS T100TA Bluetooth stopped working
Date: Thu, 17 Dec 2015 03:24:16 +0000
Message-ID: <bug-109321-62941-R05gfTSZki@https.bugzilla.kernel.org/>
In-Reply-To: <bug-109321-62941@https.bugzilla.kernel.org/>
References: <bug-109321-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=109321

Brian Loften <bloften80@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bloften80@gmail.com

--- Comment #2 from Brian Loften <bloften80@gmail.com> ---
(In reply to Johan Hedberg from comment #1)
> There was an answer to this, but you may have missed it since it was only
> sent to the mailing list:
> http://www.spinics.net/lists/linux-bluetooth/msg65800.html

yes this got it working again thank you for the information

i did the btmgmt static-addr and public-addr and cannot get the bluetooth
devices to stay after each boot (mouse, speaker, etc) any ideas how to get the
system to remember bluetooth devices with btattach? 

with hciconfig it was hciconfig /dev/ttyS4 bcm43xx 921600 flow bdaddr
XX:XX:XX:XX:XX:XX and the system will remember the devices whcih each boot

the BDADDR keeps changing after boot if i do not set static-addr or public-addr 

is this a driver issue or a bluez issue?

thanks again for your help

-- 
You are receiving this mail because:
You are the assignee for the bug.
