Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 0/6] Bluetooth LE 6LoWPAN
Date: Wed, 13 Nov 2013 12:11:29 +0200
Message-Id: <1384337495-9043-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is 6LoWPAN code for BT LE as described in
http://tools.ietf.org/html/draft-ietf-6lowpan-btle-12

v4:
- removed the route setting code, neighbour discovery
  should allow the devices to discover each other
- fix the uncompression of Traffic Class in IPv6 header,
  this makes ssh to work between devices over a BT 6lowpan link
- removed setting of /proc conf options, they were useless
  and not to be done in kernel module anyway


v3:
- misc changes according to Marcel's comments
- supports multiple connections / interface
- removed unused fragmentation code
- setup 6lowpan connection automatically if enabled via debugfs

The automatic 6lowpan enabling is done by setting

echo 1 > /sys/kernel/debug/bluetooth/hci0/6lowpan

before devices are connected.


v2:
- Change ARPHRD_IEEE802154 to ARPHRD_RAWIP. The generic code
  in patches 1 and 2 is also sent to netdev mailing list.
- Sending route exporting patch 5 to netdev ml
- Check private/public BT address and toggle universal/local bit
  accordingly in patch 3.
- The virtual interface template name is now shorter (bt%d)
- Various function name renames
- devtype of the interface set to "bluetooth"


v1:
- initial release


TODO:
- Discovery of 6LoWPAN service needs be automatic (UUID support)
- Refactor compression and uncompression code after these are fixed
  in net/ieee802154/6lowpan.c. Bluetooth 6LoWPAN should be able to share
  that part of the code.

Known issues:
- no UUID handling yet


Cheers,
Jukka


Jukka Rissanen (6):
  net: if_arp: add ARPHRD_RAWIP type
  ipv6: Add checks for RAWIP ARP type
  Bluetooth: Initial skeleton code for BT 6LoWPAN
  Bluetooth: Enable 6LoWPAN support for BT LE devices
  Bluetooth: Enable 6LoWPAN if device supports it
  Bluetooth: Manually enable or disable 6LoWPAN between devices

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |    1 +
 include/uapi/linux/if_arp.h      |    1 +
 net/bluetooth/6lowpan.c          | 1687 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h          |   27 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/hci_core.c         |    4 +
 net/bluetooth/hci_event.c        |    3 +
 net/bluetooth/l2cap_core.c       |   25 +-
 net/ipv6/addrconf.c              |    4 +-
 11 files changed, 1753 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.c
 create mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

