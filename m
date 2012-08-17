Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 26/26] Bluetooth: Add logical link create function
Date: Fri, 17 Aug 2012 17:33:21 +0300
Message-Id: <1345214001-7053-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After physical link is created logical link needs to be created
above physical link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/amp.h |    1 +
 net/bluetooth/amp.c         |   43 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c   |   12 ++++++++++++
 net/bluetooth/l2cap_core.c  |    9 +++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index ab4e195..dcc05a0 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -23,5 +23,6 @@ void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
 				   struct phy_link *plink);
 void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			struct phy_link *plink);
+void amp_create_logical_link(struct l2cap_chan *chan);
 
 #endif /* __AMP_H */
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 07afb21..1693ea9 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -294,3 +294,46 @@ void amp_create_phylink(struct hci_dev *hdev, struct amp_mgr *mgr,
 			      amp_create_phylink_cs_cb, mgr, cb_destructor,
 			      GFP_KERNEL);
 }
+
+void amp_create_logical_link(struct l2cap_chan *chan)
+{
+	struct hci_chan *hchan = chan->conn->hchan;
+	struct hci_cp_create_accept_logical_link cp;
+	struct phy_link *plink;
+	struct hci_conn *hcon;
+	struct hci_dev *hdev;
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
index cdb32da..8acef1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1704,6 +1704,14 @@ static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 	hci_callback_process(hdev, HCI_OP_CREATE_PHY_LINK, status);
 }
 
+static void hci_cs_create_logical_link(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_create_logical_link *cp;
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2521,6 +2529,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
index d99eaf9..84bb4f8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -39,6 +39,7 @@
 #include <net/bluetooth/smp.h>
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/pal.h>
+#include <net/bluetooth/amp.h>
 
 bool disable_ertm;
 
@@ -1018,6 +1019,12 @@ static bool __amp_capable(struct l2cap_chan *chan)
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
@@ -3800,6 +3807,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			}
 
 			/* check compatibility */
+			if (l2cap_check_efs(chan))
+				amp_create_logical_link(chan);
 
 			clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
 			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-- 
1.7.9.5

