Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 3/8] Bluetooth: Add logical link create function
Date: Tue, 16 Oct 2012 18:01:05 +0300
Message-Id: <1350399670-12418-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After physical link is created logical link needs to be created
above physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/amp.c         |   46 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |    9 +++++++++
 net/bluetooth/l2cap_core.c  |    9 +++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 2e7c79e..70d5c15 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -46,5 +46,6 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct hci_conn *hcon);
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
+void amp_create_logical_link(struct l2cap_chan *chan);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index e525e23..6f10e8b 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -374,3 +374,49 @@ void amp_accept_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	hci_send_cmd(hdev, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
 }
+
+void amp_create_logical_link(struct l2cap_chan *chan)
+{
+	struct hci_cp_create_accept_logical_link cp;
+	struct hci_conn *hcon;
+	struct hci_dev *hdev;
+
+	BT_DBG("chan %p", chan);
+
+	hdev = hci_dev_get(chan->ctrl_id);
+	if (!hdev)
+		return;
+
+	BT_DBG("chan %p ctrl_id %d dst %pMR", chan, chan->ctrl_id,
+	       chan->conn->dst);
+
+	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, chan->conn->dst);
+	if (!hcon)
+		goto done;
+
+	cp.phy_handle = hcon->handle;
+
+	cp.tx_flow_spec.id = chan->local_id;
+	cp.tx_flow_spec.stype = chan->local_stype;
+	cp.tx_flow_spec.msdu = cpu_to_le16(chan->local_msdu);
+	cp.tx_flow_spec.sdu_itime = cpu_to_le32(chan->local_sdu_itime);
+	cp.tx_flow_spec.acc_lat = cpu_to_le32(chan->local_acc_lat);
+	cp.tx_flow_spec.flush_to = cpu_to_le32(chan->local_flush_to);
+
+	cp.rx_flow_spec.id = chan->remote_id;
+	cp.rx_flow_spec.stype = chan->remote_stype;
+	cp.rx_flow_spec.msdu = cpu_to_le16(chan->remote_msdu);
+	cp.rx_flow_spec.sdu_itime = cpu_to_le32(chan->remote_sdu_itime);
+	cp.rx_flow_spec.acc_lat = cpu_to_le32(chan->remote_acc_lat);
+	cp.rx_flow_spec.flush_to = cpu_to_le32(chan->remote_flush_to);
+
+	if (hcon->out)
+		hci_send_cmd(hdev, HCI_OP_CREATE_LOGICAL_LINK, sizeof(cp),
+			     &cp);
+	else
+		hci_send_cmd(hdev, HCI_OP_ACCEPT_LOGICAL_LINK, sizeof(cp),
+			     &cp);
+
+done:
+	hci_dev_put(hdev);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2c37896..3f99214 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1744,6 +1744,11 @@ static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
 	amp_write_remote_assoc(hdev, cp->phy_handle);
 }
 
+static void hci_cs_create_logical_link(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2570,6 +2575,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_accept_phylink(hdev, ev->status);
 		break;
 
+	case HCI_OP_CREATE_LOGICAL_LINK:
+		hci_cs_create_logical_link(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f3cfe89..382d92a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -38,6 +38,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 bool disable_ertm;
 
@@ -964,6 +965,12 @@ static bool __amp_capable(struct l2cap_chan *chan)
 		return false;
 }
 
+static bool l2cap_check_efs(struct l2cap_chan *chan)
+{
+	/* Check EFS parameters */
+	return true;
+}
+
 void l2cap_send_conn_req(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -3801,6 +3808,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 			}
 
 			/* check compatibility */
+			if (l2cap_check_efs(chan))
+				amp_create_logical_link(chan);
 
 			if (!chan->ctrl_id)
 				l2cap_send_efs_conf_rsp(chan, buf, cmd->ident,
-- 
1.7.9.5

