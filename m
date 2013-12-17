Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v2 bluetooth-next 0/7] 6lowpan: udp compression/uncompression fix
Date: Tue, 17 Dec 2013 11:32:46 +0100
Message-Id: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current 6LoWPAN udp compression/uncompression is completely broken.
This patch series fix a lot of udp compression/uncompression issues and
add support parsing with lowpan_fetch_skb function.

I already sent this patch series to netdev some time ago. That's why I add a
v2 to this series. Now we doing all 6lowpan things into bluetooth-next to
avoid merge conflicts.

Changes since v2:
 - remove unnecessary casts and brackes, suggested by Werner Almesberger.
 - use pr_debug_ratelimited instead of pr_debug on patch 4/7.

Alexander Aring (7):
  6lowpan: fix udp nullpointer dereferencing
  6lowpan: fix udp compress ordering
  6lowpan: fix udp byte ordering
  6lowpan: add udp warning for elided checksum
  6lowpan: udp use lowpan_fetch_skb function
  6lowpan: udp use subtraction on both conditions
  6lowpan: cleanup udp compress function

 net/ieee802154/6lowpan.h      |  1 +
 net/ieee802154/6lowpan_iphc.c | 79 +++++++++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 37 deletions(-)

-- 
1.8.5.1

