Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org,
	alex.aring@gmail.com,
	Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH][linux-bluetooth 0/3] Fix lowpan_rcv
Date: Wed, 10 Sep 2014 15:06:04 +0100
Message-Id: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This series aims to cleanup the lowpan receive path and fix a few issues. 
RFC compliancy by supported fragmented uncompressed IPv6 headers
Fix incorrect return values in lowpan_rcv
To achieve this it also refactors the receive path to
  1) free skb only from lowpan_rcv and not functions that it calls
  2) move skb delivery from IPHC

Martin Townsend (3):
  6lowpan: skb freed locally from lowpan_rcv
  6lowpan: Move skb delivery from IPHC.
  6lowpan: Refactored lowpan_rcv so it's RFC compliant

I have only compile tested the changes for bluetooth as I don't have any HW
available so would be grateful for any testing from the Bluetooth developers.
I have done some minimal testing for IEEE802.15.4


 include/net/6lowpan.h         | 22 ++++++++++-
 net/6lowpan/iphc.c            | 80 ++++++++++++++++----------------------
 net/bluetooth/6lowpan.c       | 20 +++++++---
 net/ieee802154/6lowpan_rtnl.c | 90 +++++++++++++++++++++++++------------------
 4 files changed, 120 insertions(+), 92 deletions(-)

-- 
1.9.1
