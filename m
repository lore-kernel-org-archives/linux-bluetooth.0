Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date: Wed, 30 Mar 2016 17:53:32 +0000
Message-ID: <bug-86931-62941-JPM4P7Z2yj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=86931

jbMacAZ <jbmacbrodie@yahoo.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jbmacbrodie@yahoo.com

--- Comment #3 from jbMacAZ <jbmacbrodie@yahoo.com> ---
Bluetooth behavior was good in ubuntu 15.10 - bluez5.35, blueman device manager
and kernel 4.3.6.  I use a bt mouse and OEM bt keydock (Asus T100-CHI)

Starting with 4.4 thru 4.6-rc1-next*, I have to open blueman's device manager
to search for devices after idle timeouts.  I also need to leave the device
manager dialogue open/minimized to prevent rapid loss of connection.  Device
pairing is remembered, but manually searching is difficult when the pointing
devices stop working.  My test setup has a usb mouse as a workaround.

dmesg has "unknown main item tag 0x0" after each idle timeout".  If I move
mouse during boot, it will auto-connect, but it then suffers a rapid timeout
soon after booting.  See dmesg posted at #114561.  It looks like something is
incrementing the bluetooth input assignment # when anything times out.

-- 
You are receiving this mail because:
You are the assignee for the bug.
