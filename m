Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Sat, 09 Jan 2016 10:45:29 +0000
Message-ID: <bug-100461-62941-hdytYhY1lt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

--- Comment #8 from Weiwu Zhang <zhangweiwu@realss.com> ---
(In reply to jbMacAZ from comment #7)
> I had the same result. The solution is to move the BCM4324B.hcd file up 1
> folder from /lib/firmware/brcm/ to /lib/firmware/  I don't understand why
> that would matter, so YMMV.

It's amazing! Yes, you are right! In my case, simply moving it to /lib/firmware
made the last 3 bytes of BD address change from 00-00-00 to 00:1F:AC.

It's so unreasonable!

> The btattach still won't return, but the BD Address from hciconfig is real
> and it is possible to pair bt devices. 

In my case btattach runs (although it doesn't fork to background like the
tutorial suggested). If I enable bluetooth ($ sudo hciconfig hci1 up) I can
scan devices.

To connect and pair devices, the bluetooth shipped with Ubuntu 15.10 won't
work. blueman (launch with blueman-manager)'s "add new device" wizard works for
me.

It's the first time I got bluetooth mouse working since I bought the computer
one year ago.

-- 
You are receiving this mail because:
You are the assignee for the bug.
