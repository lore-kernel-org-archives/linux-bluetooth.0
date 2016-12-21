Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Wed, 21 Dec 2016 18:08:39 +0000
Message-ID: <bug-190831-62941-3vSebHR6lb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #2 from Jan Steffens <jan.steffens@gmail.com> ---
New firmware with old DDC indeed works. The "Setting Intel event mask failed"
message seen with the old firmware didn't reappear, either.

Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Bluetooth: hci0: Device revision is 5
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1424291 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 15526 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed

-- 
You are receiving this mail because:
You are the assignee for the bug.
