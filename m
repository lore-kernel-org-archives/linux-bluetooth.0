Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 104011] SMP Security check breaks formerly working bluetooth
 mouse connection
Date: Wed, 17 Aug 2016 00:19:45 +0000
Message-ID: <bug-104011-62941-PWfse2hM7L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-104011-62941@https.bugzilla.kernel.org/>
References: <bug-104011-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=104011

Peter Lindener <lindener.peter@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lindener.peter@gmail.com

--- Comment #13 from Peter Lindener <lindener.peter@gmail.com> ---
I am running a fresh build of Mint 18, modified for real-time by:
  sudo apt-get install linux-lowlatency linux-headers-lowlatency

Linux 4.4.0-34-lowlatency #53-Ubuntu SMP PREEMPT Wed Jul 27 19:23:26 UTC 2016
x86_64 x86_64 x86_64 GNU/Linux 

I am typing this on a Dell XPS 15, with a Broadcom BCM20703A bluetooth chip.
that is now persistently paired / connected to a "Arc Touch Mouse SE".

two issues were encountered while getting this bluetooth mouse to work.

   2. the "Bluetooth: SMP security requested but not available" error message
that is encountered via ">> dmesg | tail" during BT mouse pairing (required
only once) due to an apparently incorrect..
 [powered in legacy way (eg hciconfig up) where SMP is not correctly
initialized. see comment #5 above] was worked around by "sudo bluetoothctl -a"
power off/on toggling...  so it seems Szymon Janc's hunch is on the right
track..  but it also seems likely that successful blue-tooth device pairing
likely requires running bluetoothctl with some level of elevated privilege, if
one wishes this bluetooth pairing to remain persistent across reboots.
   having done this once paired, my Arc Touch Mouse SE seems to come up working
after a reboot..

   1. But before the above SMP security bug workaround might work..
if one's bluetooth controller happens to be a Broadcom device..
in my case the BCM20703A found in a more recent Dell XPS 15.
you may find this error message in the logs:
>> dmesg | egrep 'blue|firm'
[    4.220629] brcmfmac 0000:02:00.0: Direct firmware load for
brcm/brcmfmac43602-pcie.txt failed with error -2

if so, you will also likely want to place this file:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1589889/+attachment/4683974/+files/BCM-0a5c-6410.hcd 
into the  /lib/firmware/bcrm/ directory..
for details see: 
http://osdir.com/ml/ubuntu-bluetooth/2016-06/msg00043.html

   That said, my really cool Arc Touch Mouse bluetooth mouse seems quite
happily persistently paired to new dell XPS 15..
   thanks for the clue regarding the need to work around the power mode during
blue-tooth device pairing..!   hope this helps resolve the last remaining
blue-tooth driver issues for Linux..

-- 
You are receiving this mail because:
You are the assignee for the bug.
