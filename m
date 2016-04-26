Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 117251] btusb and/or btintel cannot correctly restore after
 resume from suspend
Date: Tue, 26 Apr 2016 20:59:26 +0000
Message-ID: <bug-117251-62941-Ntbaj5ePMt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-117251-62941@https.bugzilla.kernel.org/>
References: <bug-117251-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=117251

--- Comment #2 from Yaroslav Isakov <yaroslav.isakov@gmail.com> ---
Ok, here is a full log for after resume:
[ 9900.440872] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 9900.445860] Bluetooth: hci0: Device revision is 5
[ 9900.445865] Bluetooth: hci0: Secure boot is enabled
[ 9900.445868] Bluetooth: hci0: OTP lock is enabled
[ 9900.445870] Bluetooth: hci0: API lock is enabled
[ 9900.445872] Bluetooth: hci0: Debug lock is disabled
[ 9900.445876] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 9900.445880] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 9900.478350] psmouse serio1: synaptics: queried max coordinates: x [..5676],
y [..4762]
[ 9900.514546] psmouse serio1: synaptics: queried min coordinates: x [1266..],
y [1094..]
[ 9900.540594] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9900.541872] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9900.543026] iwlwifi 0000:04:00.0: can't access the RSA semaphore it is write
protected
[ 9900.550896] Bluetooth: hci0: Failed to send firmware data (-38)
[ 9900.677527] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9900.678075] iwlwifi 0000:04:00.0: L1 Enabled - LTR Enabled
[ 9900.679214] iwlwifi 0000:04:00.0: can't access the RSA semaphore it is write
protected
It seems that bluetooth breaks on "Bluetooth: hci0: Waiting for firmware
download to complete" step

-- 
You are receiving this mail because:
You are the assignee for the bug.
