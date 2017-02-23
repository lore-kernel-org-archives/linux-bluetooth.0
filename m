Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 190831] Intel Bluetooth 8260 breaks with latest firmware
Date: Thu, 23 Feb 2017 16:28:46 +0000
Message-ID: <bug-190831-62941-njv0KG3cSI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-190831-62941@https.bugzilla.kernel.org/>
References: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

--- Comment #48 from ahxcker@gmail.com ---
I got same problem i checked some wikis and forums tried many ways like:
disable NetworkManager, bluetoothctl pair device

Lenovo Thinkpad T460p
debian stretch (i used Arch Linux with latest kernel 2017-02-15, same issue)
kernel 4.9
Plasma for desktop env 
Intel dual band wireless 8260

Checked dmesg:
[ 656.245284] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 656.252273] Bluetooth: hci0: Device revision is 5
[ 656.252274] Bluetooth: hci0: Secure boot is enabled
[ 656.252275] Bluetooth: hci0: OTP lock is enabled
[ 656.252275] Bluetooth: hci0: API lock is enabled
[ 656.252276] Bluetooth: hci0: Debug lock is disabled
[ 656.252276] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 656.252510] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 657.920245] Bluetooth: hci0: Waiting for firmware download to complete
[ 657.920247] Bluetooth: hci0: Firmware loaded in 1636664 usecs
[ 657.920294] Bluetooth: hci0: Waiting for device to boot
[ 657.931249] Bluetooth: hci0: Device booted in 10706 usecs
[ 657.931276] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[ 657.932254] Bluetooth: hci0: Failed to send Intel_Write_DDC (-22)

First connection will keep for few minutes after it will lost connection.
When you check plasma Bluetooth-applet, it shows device is connected however,
when you try to disconnect device, it will keep showing connected unless you
disable Bluetooth,
It will automatically connect your mouse when you enable Bluetooth.

-- 
You are receiving this mail because:
You are the assignee for the bug.