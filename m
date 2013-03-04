Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/11] Bluetooth: Remove empty HCI event handlers
Date: Mon,  4 Mar 2013 12:09:08 +0200
Message-Id: <1362391748-21653-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

With the removal of hci_req_complete() several HCI event handles have
essentially become empty and can be removed. The only potential benefit
of these could have been logging, but the hci_event, hci_cmd_complete
and hci_cmd_status already provide a log for events which they do not
have an explicit handler for.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |  164 ---------------------------------------------
 1 file changed, 164 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0dd85a0..e89707f 100644
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
@@ -632,13 +625,6 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
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
@@ -701,29 +687,6 @@ a2mp_rsp:
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
@@ -735,13 +698,6 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
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
@@ -828,13 +784,6 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 	}
 }
 
-static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-}
-
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
@@ -1015,26 +964,6 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
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
@@ -1565,11 +1494,6 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
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
@@ -1611,11 +1535,6 @@ static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
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
@@ -2172,17 +2091,6 @@ unlock:
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
@@ -2270,10 +2178,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_write_voice_setting(hdev, skb);
 		break;
 
-	case HCI_OP_HOST_BUFFER_SIZE:
-		hci_cc_host_buffer_size(hdev, skb);
-		break;
-
 	case HCI_OP_WRITE_SSP_MODE:
 		hci_cc_write_ssp_mode(hdev, skb);
 		break;
@@ -2306,10 +2210,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_data_block_size(hdev, skb);
 		break;
 
-	case HCI_OP_WRITE_CA_TIMEOUT:
-		hci_cc_write_ca_timeout(hdev, skb);
-		break;
-
 	case HCI_OP_READ_FLOW_CONTROL_MODE:
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
@@ -2322,26 +2222,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2366,10 +2250,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_le_read_adv_tx_power(hdev, skb);
 		break;
 
-	case HCI_OP_LE_SET_EVENT_MASK:
-		hci_cc_le_set_event_mask(hdev, skb);
-		break;
-
 	case HCI_OP_USER_CONFIRM_REPLY:
 		hci_cc_user_confirm_reply(hdev, skb);
 		break;
@@ -2402,14 +2282,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2501,10 +2373,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_le_create_conn(hdev, ev->status);
 		break;
 
-	case HCI_OP_LE_START_ENC:
-		hci_cs_le_start_enc(hdev, ev->status);
-		break;
-
 	case HCI_OP_CREATE_PHY_LINK:
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
@@ -2513,10 +2381,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_accept_phylink(hdev, ev->status);
 		break;
 
-	case HCI_OP_CREATE_LOGICAL_LINK:
-		hci_cs_create_logical_link(hdev, ev->status);
-		break;
-
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
@@ -3077,18 +2941,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_sync_conn_changed_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	BT_DBG("%s", hdev->name);
-}
-
-static void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_sniff_subrate *ev = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-}
-
 static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
@@ -3816,14 +3668,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3880,14 +3724,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_sync_conn_complete_evt(hdev, skb);
 		break;
 
-	case HCI_EV_SYNC_CONN_CHANGED:
-		hci_sync_conn_changed_evt(hdev, skb);
-		break;
-
-	case HCI_EV_SNIFF_SUBRATE:
-		hci_sniff_subrate_evt(hdev, skb);
-		break;
-
 	case HCI_EV_EXTENDED_INQUIRY_RESULT:
 		hci_extended_inquiry_result_evt(hdev, skb);
 		break;
-- 
1.7.10.4

