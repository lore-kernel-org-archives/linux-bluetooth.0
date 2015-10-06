Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: 6lowpan: Remove unnecessary chan_get() function
Date: Tue,  6 Oct 2015 13:03:24 +0300
Message-Id: <1444125804-15577-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The chan_get() function just adds unnecessary indirection to calling
the chan_create() call. The only added value it gives is the chan->ops
assignment, but that can equally well be done in the calling code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index e20b97297a15..9363f05275f4 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1051,28 +1051,17 @@ static inline __u8 bdaddr_type(__u8 type)
 		return BDADDR_LE_RANDOM;
 }
 
-static struct l2cap_chan *chan_get(void)
-{
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
-	chan->ops = &bt_6lowpan_chan_ops;
-
-	return chan;
-}
-
 static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 {
 	struct l2cap_chan *chan;
 	int err;
 
-	chan = chan_get();
+	chan = chan_create();
 	if (!chan)
 		return -EINVAL;
 
+	chan->ops = &bt_6lowpan_chan_ops;
+
 	err = l2cap_chan_connect(chan, cpu_to_le16(L2CAP_PSM_IPSP), 0,
 				 addr, dst_type);
 
@@ -1109,10 +1098,11 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
 	if (!enable_6lowpan)
 		return NULL;
 
-	chan = chan_get();
+	chan = chan_create();
 	if (!chan)
 		return NULL;
 
+	chan->ops = &bt_6lowpan_chan_ops;
 	chan->state = BT_LISTEN;
 	chan->src_type = BDADDR_LE_PUBLIC;
 
-- 
2.4.3

