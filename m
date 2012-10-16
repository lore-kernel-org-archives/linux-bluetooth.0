Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 2/8] Bluetooth: AMP: Process Logical Link complete evt
Date: Tue, 16 Oct 2012 18:01:04 +0300
Message-Id: <1350399670-12418-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After receiving HCI Logical Link Complete event finish EFS
configuration by sending L2CAP Conf Response with success code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/hci_event.c     |   42 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |   17 +++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6d3615e..150199e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -807,5 +807,6 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
+void l2cap_finish_efs_config(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a1ce09f..2c37896 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3592,6 +3592,44 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 	}
 }
 
+static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_conn *hcon;
+	struct hci_chan *hchan;
+	struct amp_mgr *mgr;
+
+	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
+	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
+	       ev->status);
+
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
+	BT_DBG("hcon %p mgr %p hchan %p", hcon, hcon->amp_mgr, hchan);
+
+	mgr = hcon->amp_mgr;
+	if (mgr && mgr->bredr_chan) {
+		struct l2cap_chan *bredr_chan = mgr->bredr_chan;
+
+		bredr_chan->hs_hcon = hcon;
+		bredr_chan->hs_hchan = hchan;
+		hcon->l2cap_data = bredr_chan->conn;
+
+		l2cap_finish_efs_config(bredr_chan);
+		hci_conn_hold(hcon);
+		bredr_chan->conn->mtu = hdev->block_mtu;
+	}
+}
+
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -3923,6 +3961,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_phy_link_complete_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LOGICAL_LINK_COMPLETE:
+		hci_loglink_complete_evt(hdev, skb);
+		break;
+
 	case HCI_EV_NUM_COMP_BLOCKS:
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4035fce..f3cfe89 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3635,6 +3635,23 @@ static void l2cap_send_efs_conf_rsp(struct l2cap_chan *chan, void *data,
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
+	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
+		set_default_fcs(chan);
+		l2cap_chan_ready(chan);
+	}
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
-- 
1.7.9.5

