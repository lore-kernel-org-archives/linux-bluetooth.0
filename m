Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 0/8] Bluetooth LE 6LoWPAN
Date: Fri,  8 Nov 2013 17:23:07 +0200
Message-Id: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is 6LoWPAN code for BT LE as described in
http://tools.ietf.org/html/draft-ietf-6lowpan-btle-12

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
- Discovery of 6LoWPAN service needs be automatic.
- Refactor compression and uncompression code after these are fixed
  in net/ieee802154/6lowpan.c. Bluetooth 6LoWPAN should be able to share
  that part of the code.

Known issues:
- route to peer is not removed when connection is dropped
- no UUID handling yet


Cheers,
Jukka


Jukka Rissanen (8):
  net: if_arp: add ARPHRD_RAWIP type
  ipv6: Add checks for RAWIP ARP type
  Bluetooth: Initial skeleton code for BT 6LoWPAN
  Bluetooth: Enable 6LoWPAN support for BT LE devices
  Bluetooth: Enable 6LoWPAN if device supports it
  route: Exporting ip6_route_add() so that Bluetooth 6LoWPAN can use it
  Bluetooth: Set route to peer for 6LoWPAN
  Bluetooth: Manually enable or disable 6LoWPAN between devices

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |    1 +
 include/uapi/linux/if_arp.h      |    1 +
 net/bluetooth/6lowpan.c          | 1723 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h          |   27 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/hci_core.c         |    4 +
 net/bluetooth/hci_event.c        |    3 +
 net/bluetooth/l2cap_core.c       |   25 +-
 net/ipv6/addrconf.c              |    4 +-
 net/ipv6/route.c                 |    1 +
 12 files changed, 1790 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.c
 create mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

