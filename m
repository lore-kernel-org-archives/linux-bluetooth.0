Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 197121] New: Bluetooth regression "no bluetooth adapters found"
 Baytrail T100CHI (SDIO) BCM4324B3
Date: Tue, 03 Oct 2017 19:08:48 +0000
Message-ID: <bug-197121-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=197121

            Bug ID: 197121
           Summary: Bluetooth regression "no bluetooth adapters found"
                    Baytrail T100CHI (SDIO) BCM4324B3
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.14-{rc1,rc2,rc3}
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: jbmacbrodie@yahoo.com
        Regression: No

Bluetooth no longer works in 4.14.  Starting Blueman device manager with kernel
4.14-rc1 produces the error "No bluetooth adapters found".  Bluetooth has been
working on the T100CHI since 4.3.5 [patched with bt deviceID until 4.7].  The
CHI uses bluetooth to connect to its keyboard/touchpad.

Reverting first bad commit 33cd149e767be9afbab9fcd3d5165a2de62313c8 does not
fix bluetooth.  (See report below)

Excerpt from dmesg 4.13 vs. 4.14 shows that the bluetooth binary blob is not
being loaded in 4.14.  The Asus T100CHI uses the brcmfmac43241b4-sdio chip.

4.13$ dmesg | grep -i blue
[    6.158598] Bluetooth: Core ver 2.22
[    6.158639] Bluetooth: HCI device and connection manager initialized
[    6.158646] Bluetooth: HCI socket layer initialized
[    6.158650] Bluetooth: L2CAP socket layer initialized
[    6.158662] Bluetooth: SCO socket layer initialized
[    6.176397] Bluetooth: HCI UART driver ver 2.3
[    6.176401] Bluetooth: HCI UART protocol H4 registered
[    6.176402] Bluetooth: HCI UART protocol BCSP registered
[    6.176403] Bluetooth: HCI UART protocol ATH3K registered
[    6.176405] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    6.176501] Bluetooth: HCI UART protocol Intel registered
[    6.196331] Bluetooth: BCM2E71:00: Asus T100CHI: Overwriting IRQ polarity to
active low
[    6.196415] Bluetooth: HCI UART protocol Broadcom registered
[    6.196417] Bluetooth: HCI UART protocol QCA registered
[    7.321304] Bluetooth: hci0: BCM: chip id 84
[    7.321309] Bluetooth: hci0: BCM4324B3 (002.004.006) build 0000
[    7.857971] Bluetooth: hci0: BCM (002.004.006) build 0112
[    7.935107] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.935110] Bluetooth: BNEP filters: protocol multicast
[    7.935119] Bluetooth: BNEP socket layer initialized
[   10.429274] Bluetooth: RFCOMM TTY layer initialized
[   10.429285] Bluetooth: RFCOMM socket layer initialized
[   10.429297] Bluetooth: RFCOMM ver 1.11

4.14
[    7.135356] Bluetooth: Core ver 2.22
[    7.135394] Bluetooth: HCI device and connection manager initialized
[    7.136202] Bluetooth: HCI socket layer initialized
[    7.136206] Bluetooth: L2CAP socket layer initialized
[    7.136220] Bluetooth: SCO socket layer initialized
[    7.197479] Bluetooth: HCI UART driver ver 2.3
[    7.197483] Bluetooth: HCI UART protocol H4 registered
[    7.197484] Bluetooth: HCI UART protocol BCSP registered
[    7.197485] Bluetooth: HCI UART protocol ATH3K registered
[    7.197486] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    7.197610] Bluetooth: HCI UART protocol Intel registered
[    7.197611] Bluetooth: HCI UART protocol QCA registered
[   10.658881] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.658884] Bluetooth: BNEP filters: protocol multicast
[   10.658891] Bluetooth: BNEP socket layer initialized

33cd149e767be9afbab9fcd3d5165a2de62313c8 is the first bad commit
commit 33cd149e767be9afbab9fcd3d5165a2de62313c8
Author: Loic Poulain <loic.poulain@gmail.com>
Date:   Thu Aug 17 19:59:51 2017 +0200

    Bluetooth: hci_bcm: Add serdev support

    Add basic support for Broadcom serial slave devices.
    Probe the serial device, retrieve its maximum speed and
    register a new hci uart device.

    Tested/compatible with bcm43438 (RPi3).

    Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

:040000 040000 3af031525c70a2aeece054513df42905b5735e38
355ed6de455f3063c1ce3ad132fd115705f55b08 M      drivers

-- 
You are receiving this mail because:
You are the assignee for the bug.