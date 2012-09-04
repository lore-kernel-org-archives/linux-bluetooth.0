Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 02/15] Bluetooth: Add logical link create function
Date: Tue,  4 Sep 2012 16:44:21 +0300
Message-Id: <1346766274-21612-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After physical link is created logical link needs to be created
above physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/amp.c         |   43 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |    9 +++++++++
 net/bluetooth/l2cap_core.c  |    9 +++++++++
 4 files changed, 62 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index cf64ba4..96b9cf6 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -25,5 +25,6 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct phy_link *plink);
 void amp_write_remote_assoc(struct hci_dev *hdev, u8 handle);
 void amp_write_rem_assoc_continue(struct hci_dev *hdev, u8 handle);
+void amp_create_logical_link(struct l2cap_chan *chan);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 185d086..a927888 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -154,3 +154,46 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 	hci_send_cmd(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
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
+	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, chan->conn->dst);
+	if (!hcon)
+		goto done;
+
+	cp.phy_handle = hcon->phy_link->handle;
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
+	if (chan->conn->hcon->out)
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
index 5b6b41d..2a517e0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1717,6 +1717,11 @@ static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
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
@@ -2534,6 +2539,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
 
+	case HCI_OP_CREATE_LOGICAL_LINK:
+		hci_cs_create_logical_link(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aea2b50..9a21a31 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -39,6 +39,7 @@
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/pal.h>
+#include <net/bluetooth/amp.h>
 
 bool disable_ertm;
 
@@ -1021,6 +1022,12 @@ static bool __amp_capable(struct l2cap_chan *chan)
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
@@ -3771,6 +3778,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			}
 
 			/* check compatibility */
+			if (l2cap_check_efs(chan))
+				amp_create_logical_link(chan);
 
 			clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
 			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-- 
1.7.9.5

