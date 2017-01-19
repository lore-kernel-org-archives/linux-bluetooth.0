Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Thu, 19 Jan 2017 10:22:46 +0000
Message-ID: <bug-190831-62941-oyTKiUkmtb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #32 from Marcin Kurek <morgoth6@gmail.com> ---
I give a quick try to 252421, but it gives me an error on boot:

Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Bluetooth: hci0: Device revision is 5
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1333260 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 10661 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Bluetooth: hci0: Failed to send Intel_Write_DDC (-95)

But I give a try to another combination with ddc file from 250481 and this new
sfi:

873629534cf972411618c6c13aef80f2  ibt-11-5.ddc
9bddc765acb16165ae970e7b588b5ea3  ibt-11-5.sfi

This combination seems to be fine, but it takes looooong time for mouse to make
initial connection (I was sure bluetooth doesn't work at all)

-- 
You are receiving this mail because:
You are the assignee for the bug.
