Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: 6lowpan: Rename confusing 'pchan' variables
Date: Tue,  6 Oct 2015 13:03:23 +0300
Message-Id: <1444125804-15577-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
References: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The typical convention when having both a child and a parent channel
variable is to call the former 'chan' and the latter 'pchan'. When
there's only one variable it's called chan. Rename the 'pchan'
variables in the 6lowpan code to follow this convention.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/6lowpan.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 77eb698d898e..e20b97297a15 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1053,32 +1053,32 @@ static inline __u8 bdaddr_type(__u8 type)
 
 static struct l2cap_chan *chan_get(void)
 {
-	struct l2cap_chan *pchan;
+	struct l2cap_chan *chan;
 
-	pchan = chan_create();
-	if (!pchan)
+	chan = chan_create();
+	if (!chan)
 		return NULL;
 
-	pchan->ops = &bt_6lowpan_chan_ops;
+	chan->ops = &bt_6lowpan_chan_ops;
 
-	return pchan;
+	return chan;
 }
 
 static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 {
-	struct l2cap_chan *pchan;
+	struct l2cap_chan *chan;
 	int err;
 
-	pchan = chan_get();
-	if (!pchan)
+	chan = chan_get();
+	if (!chan)
 		return -EINVAL;
 
-	err = l2cap_chan_connect(pchan, cpu_to_le16(L2CAP_PSM_IPSP), 0,
+	err = l2cap_chan_connect(chan, cpu_to_le16(L2CAP_PSM_IPSP), 0,
 				 addr, dst_type);
 
-	BT_DBG("chan %p err %d", pchan, err);
+	BT_DBG("chan %p err %d", chan, err);
 	if (err < 0)
-		l2cap_chan_put(pchan);
+		l2cap_chan_put(chan);
 
 	return err;
 }
@@ -1103,31 +1103,31 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 static struct l2cap_chan *bt_6lowpan_listen(void)
 {
 	bdaddr_t *addr = BDADDR_ANY;
-	struct l2cap_chan *pchan;
+	struct l2cap_chan *chan;
 	int err;
 
 	if (!enable_6lowpan)
 		return NULL;
 
-	pchan = chan_get();
-	if (!pchan)
+	chan = chan_get();
+	if (!chan)
 		return NULL;
 
-	pchan->state = BT_LISTEN;
-	pchan->src_type = BDADDR_LE_PUBLIC;
+	chan->state = BT_LISTEN;
+	chan->src_type = BDADDR_LE_PUBLIC;
 
-	atomic_set(&pchan->nesting, L2CAP_NESTING_PARENT);
+	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
 
-	BT_DBG("chan %p src type %d", pchan, pchan->src_type);
+	BT_DBG("chan %p src type %d", chan, chan->src_type);
 
-	err = l2cap_add_psm(pchan, addr, cpu_to_le16(L2CAP_PSM_IPSP));
+	err = l2cap_add_psm(chan, addr, cpu_to_le16(L2CAP_PSM_IPSP));
 	if (err) {
-		l2cap_chan_put(pchan);
+		l2cap_chan_put(chan);
 		BT_ERR("psm cannot be added err %d", err);
 		return NULL;
 	}
 
-	return pchan;
+	return chan;
 }
 
 static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
-- 
2.4.3

