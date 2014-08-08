Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add SMP L2CAP channel skeleton
Date: Fri,  8 Aug 2014 09:37:16 +0300
Message-Id: <1407479838-5652-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch creates the initial SMP L2CAP channels and a skeleton for
their callbacks. There is one per-adapter channel created upon adapter
registration, and then one channel per-connection created through the
new_connection callback. The channels are registered with the reserved
CID 0x1f for now in order to not conflict with existing SMP
functionality. Once everything is in place the value can be changed to
what it should be, i.e. L2CAP_CID_SMP.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |   1 +
 net/bluetooth/smp.c              | 131 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cc2eb7730fbc..2571fc1cb1c5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -303,6 +303,7 @@ struct hci_dev {
 	__u32			req_result;
 
 	struct crypto_blkcipher	*tfm_aes;
+	void			*smp_data;
 
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a72965f6bc2f..1a037ba4b6f4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -637,6 +637,7 @@ struct l2cap_conn {
 
 	struct delayed_work	security_timer;
 	struct smp_chan		*smp_chan;
+	struct l2cap_chan	*smp;
 
 	struct list_head	chan_l;
 	struct mutex		chan_lock;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ab07649ecc77..2362ae35a4d5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1456,8 +1456,106 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	return 0;
 }
 
+static void smp_teardown_cb(struct l2cap_chan *chan, int err)
+{
+	struct l2cap_conn *conn = chan->conn;
+
+	BT_DBG("chan %p", chan);
+
+	conn->smp = NULL;
+	l2cap_chan_put(chan);
+}
+
+static void smp_ready_cb(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+
+	BT_DBG("chan %p", chan);
+
+	conn->smp = chan;
+	l2cap_chan_hold(chan);
+}
+
+static struct sk_buff *smp_alloc_skb_cb(struct l2cap_chan *chan,
+					unsigned long hdr_len,
+					unsigned long len, int nb)
+{
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	skb->priority = HCI_PRIO_MAX;
+	bt_cb(skb)->chan = chan;
+
+	return skb;
+}
+
+static const struct l2cap_ops smp_chan_ops = {
+	.name			= "Security Manager",
+	.ready			= smp_ready_cb,
+	.alloc_skb		= smp_alloc_skb_cb,
+	.teardown		= smp_teardown_cb,
+
+	.new_connection		= l2cap_chan_no_new_connection,
+	.recv			= l2cap_chan_no_recv,
+	.state_change		= l2cap_chan_no_state_change,
+	.close			= l2cap_chan_no_close,
+	.defer			= l2cap_chan_no_defer,
+	.suspend		= l2cap_chan_no_suspend,
+	.resume			= l2cap_chan_no_resume,
+	.set_shutdown		= l2cap_chan_no_set_shutdown,
+	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
+	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
+};
+
+static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	BT_DBG("pchan %p", pchan);
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	chan->chan_type	= pchan->chan_type;
+	chan->ops	= &smp_chan_ops;
+	chan->scid	= pchan->scid;
+	chan->dcid	= chan->scid;
+	chan->imtu	= pchan->imtu;
+	chan->omtu	= pchan->omtu;
+	chan->mode	= pchan->mode;
+
+	BT_DBG("created chan %p", chan);
+
+	return chan;
+}
+
+static const struct l2cap_ops smp_root_chan_ops = {
+	.name			= "Security Manager Root",
+	.new_connection		= smp_new_conn_cb,
+
+	/* None of these are implemented for the root channel */
+	.close			= l2cap_chan_no_close,
+	.alloc_skb		= l2cap_chan_no_alloc_skb,
+	.recv			= l2cap_chan_no_recv,
+	.state_change		= l2cap_chan_no_state_change,
+	.teardown		= l2cap_chan_no_teardown,
+	.ready			= l2cap_chan_no_ready,
+	.defer			= l2cap_chan_no_defer,
+	.suspend		= l2cap_chan_no_suspend,
+	.resume			= l2cap_chan_no_resume,
+	.set_shutdown		= l2cap_chan_no_set_shutdown,
+	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
+	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
+};
+
 int smp_register(struct hci_dev *hdev)
 {
+	struct l2cap_chan *chan;
+
 	BT_DBG("%s", hdev->name);
 
 	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
@@ -1469,15 +1567,46 @@ int smp_register(struct hci_dev *hdev)
 		return err;
 	}
 
+	chan = l2cap_chan_create();
+	if (!chan) {
+		crypto_free_blkcipher(hdev->tfm_aes);
+		hdev->tfm_aes = NULL;
+		return -ENOMEM;
+	}
+
+	/* FIXME: Using reserved 0x1f value for now - to be changed to
+	 * L2CAP_CID_SMP once all functionality is in place.
+	 */
+	l2cap_add_scid(chan, 0x1f);
+
+	l2cap_chan_set_defaults(chan);
+
+	bacpy(&chan->src, &hdev->bdaddr);
+	chan->src_type = BDADDR_LE_PUBLIC;
+	chan->state = BT_LISTEN;
+	chan->mode = L2CAP_MODE_BASIC;
+	chan->imtu = L2CAP_DEFAULT_MTU;
+	chan->ops = &smp_root_chan_ops;
+
+	hdev->smp_data = chan;
+
 	return 0;
 }
 
 void smp_unregister(struct hci_dev *hdev)
 {
-	BT_DBG("%s", hdev->name);
+	struct l2cap_chan *chan = hdev->smp_data;
+
+	if (!chan)
+		return;
+
+	BT_DBG("%s chan %p", hdev->name, chan);
 
 	if (hdev->tfm_aes) {
 		crypto_free_blkcipher(hdev->tfm_aes);
 		hdev->tfm_aes = NULL;
 	}
+
+	hdev->smp_data = NULL;
+	l2cap_chan_put(chan);
 }
-- 
1.9.3

