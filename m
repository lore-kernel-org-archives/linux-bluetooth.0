Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 0/7] Bluetooth LE 6LoWPAN
Date: Wed, 30 Oct 2013 11:00:54 +0200
Message-Id: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is 6LoWPAN code for BT LE as described in
http://tools.ietf.org/html/draft-ietf-6lowpan-btle-12

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
- Refactor compression and fragmentation code after these are fixed
  in net/ieee802154/6lowpan.c. Bluetooth 6LoWPAN should be able to share
  that part of the code.


Cheers,
Jukka


Jukka Rissanen (7):
  net: if_arp: add ARPHRD_RAWIP type
  ipv6: Add checks for RAWIP ARP type
  Bluetooth: Initial skeleton code for BT 6LoWPAN
  Bluetooth: Enable 6LoWPAN support for BT LE devices
  route: Exporting ip6_route_add() so that Bluetooth 6LoWPAN can use it
  Bluetooth: Set route to peer for 6LoWPAN
  Bluetooth: Manually enable or disable 6LoWPAN between devices

 include/net/bluetooth/l2cap.h |    1 +
 include/uapi/linux/if_arp.h   |    1 +
 net/bluetooth/6lowpan.c       | 1722 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h       |   28 +
 net/bluetooth/Makefile        |    2 +-
 net/bluetooth/hci_core.c      |    4 +
 net/bluetooth/l2cap_core.c    |   20 +-
 net/ipv6/addrconf.c           |   14 +-
 net/ipv6/route.c              |    1 +
 9 files changed, 1790 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.c
 create mode 100644 net/bluetooth/6lowpan.h

-- 
1.7.11.7

