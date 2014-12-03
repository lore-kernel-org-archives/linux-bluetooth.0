Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 36/49] Bluetooth: Add skeleton for BR/EDR SMP channel
Date: Wed,  3 Dec 2014 17:02:30 +0200
Message-Id: <1417618963-18010-37-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the very basic code for creating and destroying SMP
L2CAP channels for BR/EDR connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/l2cap.h    |  2 +
 net/bluetooth/smp.c              | 89 ++++++++++++++++++++++++++++++++--------
 3 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 42f9362a83c1..f39e65096b1f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -306,6 +306,7 @@ struct hci_dev {
 	__u32			req_result;
 
 	void			*smp_data;
+	void			*smp_bredr_data;
 
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d71dc3579354..eee3ef530e79 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -141,6 +141,7 @@ struct l2cap_conninfo {
 #define L2CAP_FC_ATT		0x10
 #define L2CAP_FC_SIG_LE		0x20
 #define L2CAP_FC_SMP_LE		0x40
+#define L2CAP_FC_SMP_BREDR	0x80
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
@@ -255,6 +256,7 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_ATT		0x0004
 #define L2CAP_CID_LE_SIGNALING	0x0005
 #define L2CAP_CID_SMP		0x0006
+#define L2CAP_CID_SMP_BREDR	0x0007
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff
 #define L2CAP_CID_LE_DYN_END	0x007f
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3aad5864a5e1..8c1b53f32f10 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2504,6 +2504,9 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p", chan);
 
+	if (hcon->type == ACL_LINK)
+		return;
+
 	if (!smp)
 		return;
 
@@ -2527,10 +2530,14 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 
 static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
+	struct hci_conn *hcon = chan->conn->hcon;
 	int err;
 
 	BT_DBG("chan %p", chan);
 
+	if (hcon->type == ACL_LINK)
+		return -EOPNOTSUPP;
+
 	err = smp_sig_channel(chan, skb);
 	if (err) {
 		struct smp_chan *smp = chan->data;
@@ -2627,34 +2634,40 @@ static const struct l2cap_ops smp_root_chan_ops = {
 	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
 };
 
-int smp_register(struct hci_dev *hdev)
+static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 {
 	struct l2cap_chan *chan;
 	struct crypto_blkcipher	*tfm_aes;
 
-	BT_DBG("%s", hdev->name);
+	if (cid == L2CAP_CID_SMP_BREDR) {
+		tfm_aes = NULL;
+		goto create_chan;
+	}
 
 	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, 0);
 	if (IS_ERR(tfm_aes)) {
-		int err = PTR_ERR(tfm_aes);
 		BT_ERR("Unable to create crypto context");
-		return err;
+		return ERR_PTR(PTR_ERR(tfm_aes));
 	}
 
+create_chan:
 	chan = l2cap_chan_create();
 	if (!chan) {
 		crypto_free_blkcipher(tfm_aes);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	chan->data = tfm_aes;
 
-	l2cap_add_scid(chan, L2CAP_CID_SMP);
+	l2cap_add_scid(chan, cid);
 
 	l2cap_chan_set_defaults(chan);
 
 	bacpy(&chan->src, &hdev->bdaddr);
-	chan->src_type = BDADDR_LE_PUBLIC;
+	if (cid == L2CAP_CID_SMP)
+		chan->src_type = BDADDR_LE_PUBLIC;
+	else
+		chan->src_type = BDADDR_BREDR;
 	chan->state = BT_LISTEN;
 	chan->mode = L2CAP_MODE_BASIC;
 	chan->imtu = L2CAP_DEFAULT_MTU;
@@ -2663,20 +2676,14 @@ int smp_register(struct hci_dev *hdev)
 	/* Set correct nesting level for a parent/listening channel */
 	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
 
-	hdev->smp_data = chan;
-
-	return 0;
+	return chan;
 }
 
-void smp_unregister(struct hci_dev *hdev)
+static void smp_del_chan(struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan = hdev->smp_data;
-	struct crypto_blkcipher *tfm_aes;
-
-	if (!chan)
-		return;
+	struct crypto_blkcipher	*tfm_aes;
 
-	BT_DBG("%s chan %p", hdev->name, chan);
+	BT_DBG("chan %p", chan);
 
 	tfm_aes = chan->data;
 	if (tfm_aes) {
@@ -2684,6 +2691,52 @@ void smp_unregister(struct hci_dev *hdev)
 		crypto_free_blkcipher(tfm_aes);
 	}
 
-	hdev->smp_data = NULL;
 	l2cap_chan_put(chan);
 }
+
+int smp_register(struct hci_dev *hdev)
+{
+	struct l2cap_chan *chan;
+
+	BT_DBG("%s", hdev->name);
+
+	chan = smp_add_cid(hdev, L2CAP_CID_SMP);
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	hdev->smp_data = chan;
+
+	if (!lmp_sc_capable(hdev) &&
+	    !test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+		return 0;
+
+	chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
+	if (IS_ERR(chan)) {
+		int err = PTR_ERR(chan);
+		chan = hdev->smp_data;
+		hdev->smp_data = NULL;
+		smp_del_chan(chan);
+		return err;
+	}
+
+	hdev->smp_bredr_data = chan;
+
+	return 0;
+}
+
+void smp_unregister(struct hci_dev *hdev)
+{
+	struct l2cap_chan *chan;
+
+	if (hdev->smp_bredr_data) {
+		chan = hdev->smp_bredr_data;
+		hdev->smp_bredr_data = NULL;
+		smp_del_chan(chan);
+	}
+
+	if (hdev->smp_data) {
+		chan = hdev->smp_data;
+		hdev->smp_data = NULL;
+		smp_del_chan(chan);
+	}
+}
-- 
2.1.0

