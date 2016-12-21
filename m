Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 190831] New: Intel Bluetooth 8260 breaks with latest firmware
Date: Wed, 21 Dec 2016 17:54:07 +0000
Message-ID: <bug-190831-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=190831

            Bug ID: 190831
           Summary: Intel Bluetooth 8260 breaks with latest firmware
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.8.14
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jan.steffens@gmail.com
        Regression: No

My Bluetooth mouse only works for a few seconds (the exact time appears random)
after the Bluetooth controller is reset. At first, it seems only its "frame
rate" is reduced drastically, then it completely stops working. It also makes
pairing nearly impossible. "hciconfig hci0 reset" briefly gets the mouse
working again.


Firmware revision "0.0 build 95 week 37 2016" from linux-firmware 91ddce4
(built 2016-12-05) is broken. The driver boots with these messages:

Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Bluetooth: hci0: Device revision is 5
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1474407 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 10684 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Bluetooth: hci0: Failed to send Intel_Write_DDC (-22)


Firmware revision "0.0 build 30 week 18 2016" from linux-firmware 9c71af9
(built 2016-10-05) works fine. The driver boots with these messages:

Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Bluetooth: hci0: Device revision is 5
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is enabled
Bluetooth: hci0: API lock is enabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 1555030 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 16567 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Setting Intel event mask failed (-16)


This problem seemed similar to
https://bugzilla.kernel.org/show_bug.cgi?id=189641 but the loss of function
doesn't correlate with any messages. However, while it is broken I do see the
occasional repeat of

Bluetooth: hci0 command 0x200c tx timeout

with varying command numbers.


As an aside, it appears the driver will only print the version if a firmware is
already loaded. This is a bit irritating as after a complete power-off (to
clear the firmware) btusb has to be unloaded and reloaded in order to print the
version.


Kernel is linux-zen 4.8.14 x86_64.

Hardware:
Intel Wireless 8260
Logitech MX Master

Downstream bug: https://bugs.archlinux.org/task/52214

-- 
You are receiving this mail because:
You are the assignee for the bug.
