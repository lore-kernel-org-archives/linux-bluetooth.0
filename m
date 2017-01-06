Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Fri, 06 Jan 2017 12:25:12 +0000
Message-ID: <bug-190831-62941-x7kWDGaLEK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #22 from Marcin Kurek <morgoth6@gmail.com> ---
Hmm, the #250451 and #250461 looks like current version of .sfi file and older
.ddc file.

Anyway just tired with #250481:

873629534cf972411618c6c13aef80f2  ibt-11-5.ddc
413da432ba53076ed31a1dda17a1f43d  ibt-11-5.sfi

The .sfi file has same md5 sum as file currently in linux-firmware repository
and only .ddc is different. And it loads fine:

Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Bluetooth: hci0: Device revision is 5
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1312477 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 10720 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed

I can not see any event mask errors which is nice and for now I had no problem
with sudden mouse stops/disconect, but it still feels a bit jumpy and
definitely not so smooth as it should be.

-- 
You are receiving this mail because:
You are the assignee for the bug.
