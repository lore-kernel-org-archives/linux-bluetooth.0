Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98693C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 00:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C72078D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 00:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgFIAR1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgFHXSw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:52 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208109] New: bluetooth module blocking suspend on Toshiba X30-F
Date:   Mon, 08 Jun 2020 23:18:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: grbitt@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-208109-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208109

            Bug ID: 208109
           Summary: bluetooth module blocking suspend on Toshiba X30-F
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.7.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: grbitt@gmail.com
        Regression: No

Tested suspend like in this article
https://www.kernel.org/doc/html/latest/power/basic-pm-debugging.html

Sometime when I do 'devices' or higher ('plaform', 'core', 'none') step s2ram
do not do anything and return "s2ram_do: Device or resource busy". In dmesg
there are this lines:
[168559.764356] Bluetooth: hci0: command 0x2042 tx timeout
[168559.764362] Bluetooth: hci0: No way to reset. Ignoring and continuing
[168559.770445] PM: suspend exit

On any new try I get the same reaction. But, if I cahnge suspend mode back to
'freezer':

$ echo freezer > /sys/power/pm_test
$ s2ram
KMS graphics driver is in use, skipping quirks.

and after that run 's2ram', system will freeze all processes successfuly. After
that I can get back to 'devices', or even 'none' mode and usually sleep will
work well at least couple of times.

$ echo none > /sys/power/pm_test
$ s2ram


Also in some cases, after waking up from suspend my system hangs every
halfsecond-second. Strace'ign every process, inculding init (and, by the way,
killing all of them excluding init and login/bash) didn't worked out well, I'v
still got no clue. There is nothing interesting or somehow related to hangs
activity or polling or whatever.

So, here is dmesg before suspend
====================== BEFORE BUGGY SUSPEND ======================
[191829.790397] PM: suspend entry (s2idle)
[191829.807975] Filesystems sync: 0.017 seconds
[191829.808803] Freezing user space processes ... (elapsed 0.002 seconds) done.
[191829.811519] OOM killer disabled.
[191829.811521] Freezing remaining freezable tasks ... (elapsed 0.001 seconds)
done.
[191829.813097] printk: Suspending console(s) (use no_console_suspend to debug)
[191829.818779] wlan0: deauthenticating from b0:e2:35:ca:1b:5b by local choice
(Reason: 3=DEAUTH_LEAVING)
==================================================================

And after suspend which lead to hangs:
====================== AFTER BUGGGY SUSPEND ======================
[198262.334096] ACPI: EC: interrupt unblocked
[198265.608349] OOM killer enabled.
[198265.608351] Restarting tasks ... 
[198265.608452] pci_bus 0000:05: Allocating resources
[198265.608480] pci_bus 0000:39: Allocating resources
[198265.615005] done.
[198265.621481] PM: suspend exit
[198266.125942] usb 1-10: new full-speed USB device number 12 using xhci_hcd
[198266.254840] usb 1-10: New USB device found, idVendor=8087, idProduct=0aaa,
bcdDevice= 0.02
[198266.254845] usb 1-10: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[198266.256821] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
[198266.257838] Bluetooth: hci0: Device revision is 2
[198266.257842] Bluetooth: hci0: Secure boot is enabled
[198266.257844] Bluetooth: hci0: OTP lock is enabled
[198266.257845] Bluetooth: hci0: API lock is enabled
[198266.257846] Bluetooth: hci0: Debug lock is disabled
[198266.257848] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[198266.259721] Bluetooth: hci0: Found device firmware: intel/ibt-17-16-1.sfi
[198267.636489] Bluetooth: hci0: Waiting for firmware download to complete
[198267.636793] Bluetooth: hci0: Firmware loaded in 1347969 usecs
[198267.636949] Bluetooth: hci0: Waiting for device to boot
[198267.649795] Bluetooth: hci0: Device booted in 12590 usecs
[198267.650018] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-17-16-1.ddc
[198267.652809] Bluetooth: hci0: Applying Intel DDC parameters completed
[198267.654810] Bluetooth: hci0: Firmware revision 0.1 build 26 week 11 2020
=============================================================================

But I can solve hangs problem by changing debug suspend mode and running
'devices' suspend. After that system goes to suspend fine, exit suspend just
fine and works after that just fine.


Here is example of dmesg with correct suspend and wakeup:
[204009.881166] PM: suspend entry (s2idle)
[204009.887627] Filesystems sync: 0.006 seconds
[204009.993112] Freezing user space processes ... (elapsed 0.002 seconds) done.
[204009.996092] OOM killer disabled.
[204009.996093] Freezing remaining freezable tasks ... (elapsed 0.001 seconds)
done.
[204009.997225] printk: Suspending console(s) (use no_console_suspend to debug)
[204009.997714] wlan0: deauthenticating from 4c:5e:0c:5c:22:6d by local choice
(Reason: 3=DEAUTH_LEAVING)
[204010.442910] PM: suspend debug: Waiting for 5 second(s).
[204015.465110] nvme nvme0: Shutdown timeout set to 8 seconds
[204015.473568] nvme nvme0: 8/0/0 default/read/poll queues
[204015.900672] OOM killer enabled.
[204015.900673] Restarting tasks ... done.
[204015.927051] PM: suspend exit
[204018.264651] atkbd serio0: Spurious NAK on isa0060/serio0. Some program
might be trying to access hardware directly.

And of course usb-devices for bluetooth module:

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#= 12 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0aaa Rev=00.02
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Bug tested with 5.7.0 with PM debug options. I'm using MX 19.2 patito feo.

Any logs or testing needed?

-- 
You are receiving this mail because:
You are the assignee for the bug.
