Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth 0/5] mac802154: ieee802154: stable patches
Date: Tue, 19 Aug 2014 11:02:58 +0200
Message-Id: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

these patches contains patches for the bluetooth branch.

This series includes memory leak fixes and an errno value fix.
Also there are two patches for sending and receiving 1280 6LoWPAN packets,
which makes the IEEE 802.15.4 6LoWPAN stack more RFC compliant.

- Alex

Alexander Aring (2):
  ieee802154: 6lowpan_rtnl: fix correct errno value
  ieee802154: 6lowpan: ensure of sending 1280 packets

Martin Townsend (3):
  mac802154: fixed potential skb leak with mac802154_parse_frame_start
  ieee802154: mac802154: handle the reserved dest mode by dropping the
    packet
  ieee802154: 6lowpan: ensure MTU of 1280 for 6lowpan

 include/net/netns/ieee802154_6lowpan.h |  1 -
 net/ieee802154/6lowpan_rtnl.c          |  4 ++--
 net/ieee802154/reassembly.c            | 13 +++----------
 net/mac802154/wpan.c                   |  6 +++++-
 4 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.0.3
