Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org,
	alex.aring@gmail.com,
	jukka.rissanen@linux.intel.com,
	Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next 4/5] Remove unused skb_delivery_cb typedef.
Date: Sat, 18 Oct 2014 08:09:12 +0100
Message-Id: <1413616153-7562-5-git-send-email-mtownsend1973@gmail.com>
In-Reply-To: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 include/net/6lowpan.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 99aa7e3..abfa359 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -372,8 +372,6 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
-typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
-
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
 		const u8 *saddr, const u8 saddr_type, const u8 saddr_len,
 		const u8 *daddr, const u8 daddr_type, const u8 daddr_len,
-- 
1.9.1
