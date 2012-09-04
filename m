Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 08/15] Bluetooth: AMP: Send EFS Conf Rsp when loglink cmpl
Date: Tue,  4 Sep 2012 16:44:27 +0300
Message-Id: <1346766274-21612-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After receiving HCI Logical Link Complete event send
L2CAP Configuration Response.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/hci_event.c     |   22 ++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |   14 ++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3ec8679..064be7f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -777,5 +777,6 @@ void l2cap_conn_set_timer(struct l2cap_conn *conn, struct delayed_work *work,
 bool l2cap_conn_clear_timer(struct l2cap_conn *conn,
 			    struct delayed_work *work);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
+void l2cap_finish_efs_config(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 00387aa..a4b2f1d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3493,12 +3493,34 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+	struct hci_chan *hchan;
+	struct amp_mgr *mgr;
 
 	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
 	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
 	       ev->status);
 
 	/* Return Config Rsp with success */
+	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
+	if (!hcon)
+		return;
+
+	/* Create AMP hchan */
+	hchan = hci_chan_create(hcon);
+	if (!hchan)
+		return;
+
+	hchan->handle = le16_to_cpu(ev->handle);
+
+	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->phy_link->mgr, hchan);
+
+	mgr = hcon->phy_link->mgr;
+	if (mgr) {
+		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
+
+		l2cap_finish_efs_config(bredr_chan);
+	}
 }
 
 static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 609a4cd..c662344 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3647,6 +3647,20 @@ static void l2cap_send_efs_conf_rsp(struct l2cap_chan *chan, void *data,
 					    L2CAP_CONF_SUCCESS, flags), data);
 }
 
+void l2cap_finish_efs_config(struct l2cap_chan *chan)
+{
+	char buf[64];
+
+	BT_DBG("chan %p", chan);
+
+	/* Init also BR/EDR chan */
+	l2cap_ertm_init(chan);
+
+	l2cap_send_efs_conf_rsp(chan, buf, chan->ident, 0);
+
+	l2cap_chan_ready(chan);
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
-- 
1.7.9.5

