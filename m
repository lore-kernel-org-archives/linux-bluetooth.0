Return-Path: <cyrus@holtmann.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 106391] New: Intel 7265 BT on NUC5i3RYH constantly
 disconnecting from USB when trying to pair
Date: Wed, 21 Oct 2015 00:28:59 +0000
Message-ID: <bug-106391-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=106391

            Bug ID: 106391
           Summary: Intel 7265 BT on NUC5i3RYH constantly disconnecting
                    from USB when trying to pair
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.3.0-997-generic #201510110154
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: ernstp@gmail.com
        Regression: No

This keeps happening when I'm trying to pair a PlayStation 3 controller to my
NUC:

It works fine on another system with BlueZ 5.35.
I have played around with a lot of settings, like disabling xhci, disabling
wifi.
Tried many different kernels.

Not sure about the firmwares though?

http://git.kernel.org/cgit/linux/kernel/git/iwlwifi/linux-firmware.git/commit/intel?id=07cd0b29e95f61bb0cdbcc86fc5cc2def0755916

http://git.kernel.org/cgit/linux/kernel/git/iwlwifi/linux-firmware.git/commit/intel?id=d82d3c1e5eddb811a38513a7e5b33202773f0fff

Not sure if I have a D0 or D1? And I don't understand how the firmware loading
works...
It says 11003110e like a D0 but patchlevel 9 like a D1?

[    2.561895] Bluetooth: Core ver 2.20
[    2.561912] Bluetooth: HCI device and connection manager initialized
[    2.561917] Bluetooth: HCI socket layer initialized
[    2.561920] Bluetooth: L2CAP socket layer initialized
[    2.561926] Bluetooth: SCO socket layer initialized
[    2.600716] Bluetooth: hci0: read Intel version: 370810011003110e09
[    2.600720] Bluetooth: hci0: Intel device is already patched. patch num: 09
[    4.139943] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.139947] Bluetooth: BNEP filters: protocol multicast
[    4.139953] Bluetooth: BNEP socket layer initialized
[    5.962779] Bluetooth: RFCOMM TTY layer initialized
[    5.962787] Bluetooth: RFCOMM socket layer initialized
[    5.962795] Bluetooth: RFCOMM ver 1.11
[  125.858335] usb 1-7: USB disconnect, device number 5
[  126.143577] usb 1-7: new full-speed USB device number 6 using xhci_hcd
[  126.273042] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2a
[  126.273046] usb 1-7: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  126.288497] Bluetooth: hci0: read Intel version: 370810011003110e09
[  126.288501] Bluetooth: hci0: Intel device is already patched. patch num: 09
[  146.048939] usb 1-7: USB disconnect, device number 6
[  146.333537] usb 1-7: new full-speed USB device number 7 using xhci_hcd
[  146.463058] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2a
[  146.463062] usb 1-7: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  146.478908] Bluetooth: hci0: read Intel version: 370810011003110e09
[  146.478912] Bluetooth: hci0: Intel device is already patched. patch num: 09
[  166.251823] usb 1-7: USB disconnect, device number 7
[  166.543630] usb 1-7: new full-speed USB device number 8 using xhci_hcd
[  166.673097] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2a
[  166.673101] usb 1-7: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  166.691331] Bluetooth: hci0: read Intel version: 370810011003110e09
[  166.691336] Bluetooth: hci0: Intel device is already patched. patch num: 09
[  197.892438] usb 1-7: USB disconnect, device number 8
[  198.179619] usb 1-7: new full-speed USB device number 9 using xhci_hcd
[  198.309093] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2a
[  198.309096] usb 1-7: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  198.327653] Bluetooth: hci0: read Intel version: 370810011003110e09
[  198.327657] Bluetooth: hci0: Intel device is already patched. patch num: 09

-- 
You are receiving this mail because:
You are the assignee for the bug.
