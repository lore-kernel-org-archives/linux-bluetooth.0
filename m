Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 100461] No BCM43341 uart support on T100TAF
Date: Wed, 06 Jan 2016 19:54:27 +0000
Message-ID: <bug-100461-62941-Q3mPOaeMvP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-100461-62941@https.bugzilla.kernel.org/>
References: <bug-100461-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=100461

jbMacAZ <jbmacbrodie@yahoo.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jbmacbrodie@yahoo.com

--- Comment #7 from jbMacAZ <jbmacbrodie@yahoo.com> ---
(In reply to Weiwu Zhang from comment #6)
> Hi Luka Karinja - I followed your instruction to have a patched-up kernel
> 4.3.3 and bluez 5.37 and the set of firmwares provided by you. It doesn't
> work for me.
<snip>
> $ sudo btattach --bredr /dev/ttyS4 -P bcm
> Attaching BR/EDR controller to /dev/ttyS4
> Switched line discipline from 0 to 15
> Device index 1 attached
> [not returning to command line]
> 
> $ sudo hciconfig 
> hci1:	Type: BR/EDR  Bus: UART
> 	BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
> 	DOWN 
> 	RX bytes:0 acl:0 sco:0 events:0 errors:0
> 	TX bytes:9 acl:0 sco:0 commands:2 errors:0
> 
> hci0:	Type: BR/EDR  Bus: SDIO
> 	BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
> 	DOWN 
> 	RX bytes:0 acl:0 sco:0 events:0 errors:0
> 	TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 

I had the same result. The solution is to move the BCM4324B.hcd file up 1
folder from /lib/firmware/brcm/ to /lib/firmware/  I don't understand why that
would matter, so YMMV.

The btattach still won't return, but the BD Address from hciconfig is real and
it is possible to pair bt devices.  I haven't figured out how to make the
btattach auto connect at boot time, for me it is still manual after each boot.

Like other T100CHI users, I need the device ID patched to include BCM2E71. 
Debian kernels seem to use ttyS4, ARCH derivatives use ttyS1.

-- 
You are receiving this mail because:
You are the assignee for the bug.