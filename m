Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 0/5] Bluetooth LE 6LoWPAN
Date: Wed, 11 Dec 2013 09:38:45 +0200
Message-Id: <1386747530-15830-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is 6LoWPAN code for BT LE as described in
http://tools.ietf.org/html/draft-ietf-6lo-btle-00

v9:
- code style issues fixed in patch 4
- removed obsolete code from patch 5


v8:
- misc changes to patches 4 and 5 according to Marcel's
  comments
- added Alex's Acked-by to patch 1


v7:
- rebased on top of current bluetooth
- David Miller acked the patches 2 and 3 so adding Acked-by
  to those two patches


v6:
- Common IP header compression code for IEEE 802154 and Bluetooth
  moved to net/ieee802154/6lowpan_iphc.c. This is in patch 1 which
  is also sent separately to netdev ml.
- New ARPHRD type in patches 2 and 3 are also sent to netdev ml.
- fixes when counting number of 6lowpan peers (was not atomic)


v5:
- Moved the header compression functionality to net/core/6lowpan.c
  and rebased both BT and IEEE 802154 code to use it in patch 1.
  I will send a separate patch to net-next for comments.
- locking fixes
- debugfs handling moved to hci_core.c
- misc changes according to Marcel's comments


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
- Enable/disable header compression for easier debugging

Known issues:
- no UUID handling yet


Cheers,
Jukka



Jukka Rissanen (5):
  6lowpan: Moving generic compression code into 6lowpan_iphc.c
  net: if_arp: add ARPHRD_6LOWPAN type
  ipv6: Add checks for 6LOWPAN ARP type
  Bluetooth: Enable 6LoWPAN support for BT LE devices
  Bluetooth: Manually enable or disable 6LoWPAN between devices

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |   1 +
 include/uapi/linux/if_arp.h      |   1 +
 net/bluetooth/6lowpan.c          | 874 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h          |  26 ++
 net/bluetooth/Makefile           |   6 +-
 net/bluetooth/hci_core.c         |  53 +++
 net/bluetooth/hci_event.c        |   3 +
 net/bluetooth/l2cap_core.c       |  12 +
 net/ieee802154/6lowpan.c         | 753 ++-------------------------------
 net/ieee802154/6lowpan.h         |  32 ++
 net/ieee802154/6lowpan_iphc.c    | 807 ++++++++++++++++++++++++++++++++++++
 net/ieee802154/Makefile          |   2 +-
 net/ipv6/addrconf.c              |   4 +-
 15 files changed, 1855 insertions(+), 721 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.c
 create mode 100644 net/bluetooth/6lowpan.h
 create mode 100644 net/ieee802154/6lowpan_iphc.c

-- 
1.8.3.1

