Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net
Cc: werner@almesberger.net, linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH v3 bluetooth-next 1/8] 6lowpan: introduce lowpan_push_hc_data function
Date: Tue, 17 Dec 2013 14:21:21 +0100
Message-Id: <1387286488-29382-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
References: <1387286488-29382-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduce the lowpan_push_hc_data function to set data in
the iphc buffer.

It's a common case to set data and increase the buffer pointer. This
helper function can be used many times in header_compress function to
generate the iphc header.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ieee802154/6lowpan.h b/net/ieee802154/6lowpan.h
index 10909e5..4981bf8 100644
--- a/net/ieee802154/6lowpan.h
+++ b/net/ieee802154/6lowpan.h
@@ -298,6 +298,13 @@ static inline bool lowpan_fetch_skb(struct sk_buff *skb,
 	return false;
 }
 
+static inline void lowpan_push_hc_data(u8 **hc_ptr, const void *data,
+				       const size_t len)
+{
+	memcpy(*hc_ptr, data, len);
+	*hc_ptr += len;
+}
+
 typedef int (*skb_delivery_cb)(struct sk_buff *skb, struct net_device *dev);
 
 int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
-- 
1.8.5.1

