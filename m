Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 109321] New: ASUS T100TA Bluetooth stopped working
Date: Mon, 14 Dec 2015 01:36:06 +0000
Message-ID: <bug-109321-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=109321

            Bug ID: 109321
           Summary: ASUS T100TA Bluetooth stopped working
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.4-rc4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: bloften80@gmail.com
        Regression: No

Hello

since kernel 4.2.3 the bluetooth on ASUS t100TA stopped working 

can no longer initialize it using hciattach /dev/ttyS4 bcm43xx command it
always times out it also registers different in dmesg

 80860F0A:00: ttyS4 at MMIO 0x9094d000 (irq = 191, base_baud = 2764800) is a
16550A
[    5.629222] Bluetooth: Core ver 2.21
[    5.629287] NET: Registered protocol family 31
[    5.629291] Bluetooth: HCI device and connection manager initialized
[    5.629299] Bluetooth: HCI socket layer initialized
[    5.629305] Bluetooth: L2CAP socket layer initialized
[    5.629318] Bluetooth: SCO socket layer initialized
[    5.643749] Bluetooth: HCI UART driver ver 2.3
[    5.643757] Bluetooth: HCI UART protocol H4 registered
[    5.643760] Bluetooth: HCI UART protocol BCSP registered
[    5.643763] Bluetooth: HCI UART protocol LL registered
[    5.643765] Bluetooth: HCI UART protocol ATH3K registered
[    5.643768] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    5.643853] Bluetooth: HCI UART protocol Intel registered
[    5.657970] hci_bcm BCM2E39:00: BCM irq: 192
[    5.658046] Bluetooth: BCM2E39:00: Asus T100TA: Overwriting IRQ polarity to
active low
[    5.658051] hci_bcm BCM2E39:00: BCM2E39:00 device registered.
[    5.658224] Bluetooth: HCI UART protocol BCM registered

not sure if this is a bug in the kernel driver or if something was changed
BlueZ and not updated in the bcm driver

also it no longer registers with rfkill which i think was changed

let me know if you need any more information

thanks

-- 
You are receiving this mail because:
You are the assignee for the bug.
