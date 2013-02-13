Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/12] Bluetooth: Remove empty HCI event handlers
Date: Wed, 13 Feb 2013 16:50:45 +0200
Message-Id: <1360767045-26958-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With the removal of hci_req_complete() several HCI event handles have
essentially become empty and can be removed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |  133 ---------------------------------------------
 1 file changed, 133 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 805580e..22864f2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -424,13 +424,6 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev,
 		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
 }
 
-static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -884,13 +877,6 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 	       hdev->block_cnt, hdev->block_len);
 }
 
-static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -953,29 +939,6 @@ a2mp_rsp:
 	a2mp_send_create_phy_link_req(hdev, rp->status);
 }
 
-static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
-					  struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
-static void hci_cc_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
-static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
-				      struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -987,13 +950,6 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 		hdev->inq_tx_power = rp->tx_power;
 }
 
-static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_pin_code_reply *rp = (void *) skb->data;
@@ -1267,26 +1223,6 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 		hdev->le_white_list_size = rp->size;
 }
 
-static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_le_ltk_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-}
-
-static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_le_ltk_neg_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-}
-
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
@@ -1817,11 +1753,6 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	}
 }
 
-static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
-{
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_create_phy_link *cp;
@@ -1863,11 +1794,6 @@ static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
 	amp_write_remote_assoc(hdev, cp->phy_handle);
 }
 
-static void hci_cs_create_logical_link(struct hci_dev *hdev, u8 status)
-{
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2424,17 +2350,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	BT_DBG("%s", hdev->name);
-}
-
-static void hci_qos_setup_complete_evt(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	BT_DBG("%s", hdev->name);
-}
-
 static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
@@ -2523,10 +2438,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_voice_setting(hdev, skb);
 		break;
 
-	case HCI_OP_HOST_BUFFER_SIZE:
-		hci_cc_host_buffer_size(hdev, skb);
-		break;
-
 	case HCI_OP_WRITE_SSP_MODE:
 		hci_cc_write_ssp_mode(hdev, skb);
 		break;
@@ -2559,10 +2470,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_data_block_size(hdev, skb);
 		break;
 
-	case HCI_OP_WRITE_CA_TIMEOUT:
-		hci_cc_write_ca_timeout(hdev, skb);
-		break;
-
 	case HCI_OP_READ_FLOW_CONTROL_MODE:
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
@@ -2575,26 +2482,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_local_amp_assoc(hdev, skb);
 		break;
 
-	case HCI_OP_DELETE_STORED_LINK_KEY:
-		hci_cc_delete_stored_link_key(hdev, skb);
-		break;
-
-	case HCI_OP_SET_EVENT_MASK:
-		hci_cc_set_event_mask(hdev, skb);
-		break;
-
-	case HCI_OP_WRITE_INQUIRY_MODE:
-		hci_cc_write_inquiry_mode(hdev, skb);
-		break;
-
 	case HCI_OP_READ_INQ_RSP_TX_POWER:
 		hci_cc_read_inq_rsp_tx_power(hdev, skb);
 		break;
 
-	case HCI_OP_SET_EVENT_FLT:
-		hci_cc_set_event_flt(hdev, skb);
-		break;
-
 	case HCI_OP_PIN_CODE_REPLY:
 		hci_cc_pin_code_reply(hdev, skb);
 		break;
@@ -2655,14 +2546,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_white_list_size(hdev, skb);
 		break;
 
-	case HCI_OP_LE_LTK_REPLY:
-		hci_cc_le_ltk_reply(hdev, skb);
-		break;
-
-	case HCI_OP_LE_LTK_NEG_REPLY:
-		hci_cc_le_ltk_neg_reply(hdev, skb);
-		break;
-
 	case HCI_OP_LE_READ_SUPPORTED_STATES:
 		hci_cc_le_read_supported_states(hdev, skb);
 		break;
@@ -2755,10 +2638,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
 
-	case HCI_OP_LE_START_ENC:
-		hci_cs_le_start_enc(hdev, ev->status);
-		break;
-
 	case HCI_OP_CREATE_PHY_LINK:
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
@@ -2767,10 +2646,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_accept_phylink(hdev, ev->status);
 		break;
 
-	case HCI_OP_CREATE_LOGICAL_LINK:
-		hci_cs_create_logical_link(hdev, ev->status);
-		break;
-
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
@@ -4072,14 +3947,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_features_evt(hdev, skb);
 		break;
 
-	case HCI_EV_REMOTE_VERSION:
-		hci_remote_version_evt(hdev, skb);
-		break;
-
-	case HCI_EV_QOS_SETUP_COMPLETE:
-		hci_qos_setup_complete_evt(hdev, skb);
-		break;
-
 	case HCI_EV_CMD_COMPLETE:
 		hci_cmd_complete_evt(hdev, skb);
 		break;
-- 
1.7.10.4

