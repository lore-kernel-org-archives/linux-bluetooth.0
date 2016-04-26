Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 117251] New: btusb and/or btintel cannot correctly restore
 after resume from suspend
Date: Tue, 26 Apr 2016 20:46:08 +0000
Message-ID: <bug-117251-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=117251

            Bug ID: 117251
           Summary: btusb and/or btintel cannot correctly restore after
                    resume from suspend
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.6.0-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: yaroslav.isakov@gmail.com
        Regression: No

Hello! I have Lenovo Thinkpad T460s with Wifi/BT chip Intel 8260. There is a
problem with bluetooth - device disappears from bluetoothctl list. I could see
such error message in the log file:
[ 9077.430266] Bluetooth: hci0: Failed to send firmware data (-38)
If I manually rmmod btusb && modprobe btusb, I could see:
[ 9220.767742] usbcore: deregistering interface driver btusb
[ 9225.687528] usbcore: registered new interface driver btusb
[ 9225.689227] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 9225.694233] Bluetooth: hci0: Device revision is 5
[ 9225.694240] Bluetooth: hci0: Secure boot is enabled
[ 9225.694243] Bluetooth: hci0: OTP lock is enabled
[ 9225.694246] Bluetooth: hci0: API lock is enabled
[ 9225.694249] Bluetooth: hci0: Debug lock is disabled
[ 9225.694254] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 9225.694561] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 9227.605395] Bluetooth: hci0: Waiting for firmware download to complete
[ 9227.606321] Bluetooth: hci0: Firmware loaded in 1883432 usecs
[ 9227.606505] Bluetooth: hci0: Waiting for device to boot
[ 9227.618390] Bluetooth: hci0: Device booted in 11793 usecs
[ 9227.618463] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[ 9227.620415] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 9227.621411] Bluetooth: hci0: Setting Intel event mask failed (-16)
and everything will start working again. I'm using linux-firmware-20160331.

-- 
You are receiving this mail because:
You are the assignee for the bug.
