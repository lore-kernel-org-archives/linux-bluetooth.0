Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Aug 2015 09:58:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 103671] New: systemd throws Bluetooth: hci0 hardware error
 0x37, but bluetooth works fine
Message-ID: <20150828095810.5974a39e@urahara>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>



Begin forwarded message:

Date: Fri, 28 Aug 2015 16:05:20 +0000
From: "bugzilla-daemon@bugzilla.kernel.org" <bugzilla-daemon@bugzilla.kernel.org>
To: "shemminger@linux-foundation.org" <shemminger@linux-foundation.org>
Subject: [Bug 103671] New: systemd throws Bluetooth: hci0 hardware error 0x37, but bluetooth works fine


https://bugzilla.kernel.org/show_bug.cgi?id=103671

            Bug ID: 103671
           Summary: systemd throws Bluetooth: hci0 hardware error 0x37,
                    but bluetooth works fine
           Product: Networking
           Version: 2.5
    Kernel Version: 4.1.6
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Other
          Assignee: shemminger@linux-foundation.org
          Reporter: 44gala@gmx.com
        Regression: No

On every boot it throws 

Bluetooth: hci0 hardware error 0x37

But bluetooth funcitonality is not impacted with blueman.

Adapter is 2-in-1 Wireless and Bluetooth:

gala [ ~ ]$ lspci | grep Network
02:00.0 Network controller: Ralink corp. RT3090 Wireless 802.11n 1T/1R PCIe

gala [ ~ ]$ lsmod | grep blue
bluetooth             458752  32 bnep,btbcm,btusb,rfcomm,btintel
rfkill                 24576  6 cfg80211,hp_wmi,bluetooth
crc16                  16384  2 ext4,bluetooth
gala [ ~ ]$ lsmod | grep rt  
rt2800pci              16384  0
rt2800mmio             20480  1 rt2800pci
rt2800lib              86016  2 rt2800pci,rt2800mmio
rt2x00pci              16384  1 rt2800pci
rt2x00mmio             16384  2 rt2800pci,rt2800mmio
rt2x00lib              49152  5
rt2x00pci,rt2800lib,rt2800pci,rt2800mmio,rt2x00mmio
led_class              16384  1 rt2x00lib
mac80211              667648  3 rt2x00lib,rt2x00pci,rt2800lib
cfg80211              483328  2 mac80211,rt2x00lib
eeprom_93cx6           16384  1 rt2800pci
crc_ccitt              16384  1 rt2800lib

-- 
You are receiving this mail because:
You are the assignee for the bug.
