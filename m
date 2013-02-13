Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/12] Bluetooth: Convert hci_request to use HCI transactions
Date: Wed, 13 Feb 2013 16:50:43 +0200
Message-Id: <1360767045-26958-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the hci_request procedure to make use of HCI
transactions. Since the completion callback is now private to hci_core.c
there is no need to have a public hci_req_complete() function anymore.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 -
 net/bluetooth/hci_core.c         |   49 ++++--------------------
 net/bluetooth/hci_event.c        |   76 ++------------------------------------
 3 files changed, 11 insertions(+), 116 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ce7fbf7..fe7df9e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1177,8 +1177,6 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
-
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c75acb2..ea4937b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,45 +57,10 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI requests ---- */
 
-void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
+static void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
 {
 	BT_DBG("%s command 0x%4.4x result 0x%2.2x", hdev->name, cmd, result);
 
-	/* If this is the init phase check if the completed command matches
-	 * the last init command, and if not just return.
-	 */
-	if (test_bit(HCI_INIT, &hdev->flags) && hdev->init_last_cmd != cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
-		struct sk_buff *skb;
-
-		/* Some CSR based controllers generate a spontaneous
-		 * reset complete event during init and any pending
-		 * command will never be completed. In such a case we
-		 * need to resend whatever was the last sent
-		 * command.
-		 */
-
-		if (cmd != HCI_OP_RESET || opcode == HCI_OP_RESET)
-			return;
-
-		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
-		hci_transaction_lock(hdev);
-		if (skb) {
-			struct hci_transaction *transaction =
-						hdev->current_transaction;
-			if (transaction) {
-				skb_queue_head(&transaction->cmd_q, skb);
-				queue_work(hdev->workqueue, &hdev->cmd_work);
-			} else {
-				kfree_skb(skb);
-			}
-		}
-		hci_transaction_unlock(hdev);
-
-		return;
-	}
-
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
@@ -124,12 +89,19 @@ static int __hci_request(struct hci_dev *hdev,
 
 	BT_DBG("%s start", hdev->name);
 
+	err = hci_start_transaction(hdev);
+	if (err < 0)
+		return err;
+
 	hdev->req_status = HCI_REQ_PEND;
 
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	req(hdev, opt);
+
+	hci_complete_transaction(hdev, hci_req_complete);
+
 	schedule_timeout(timeout);
 
 	remove_wait_queue(&hdev->req_wait_q, &wait);
@@ -218,9 +190,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 
 	/* Driver initialization */
 
-	if (hci_start_transaction(hdev) < 0)
-		return;
-
 	hci_transaction_lock(hdev);
 
 	transaction = hdev->build_transaction;
@@ -252,8 +221,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
 	}
-
-	hci_complete_transaction(hdev, NULL);
 }
 
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1045a31..805580e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -55,8 +55,6 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
-	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
-
 	hci_conn_check_pending(hdev);
 }
 
@@ -185,8 +183,6 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
 	if (!status)
 		hdev->link_policy = get_unaligned_le16(sent);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, status);
 }
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
@@ -197,8 +193,6 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_RESET, &hdev->flags);
 
-	hci_req_complete(hdev, HCI_OP_RESET, status);
-
 	/* Reset all non-persistent flags */
 	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
 			     BIT(HCI_PERIODIC_INQ));
@@ -233,8 +227,6 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!status && !test_bit(HCI_INIT, &hdev->flags))
 		hci_update_ad(hdev);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_LOCAL_NAME, status);
 }
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -272,8 +264,6 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_auth_enable_complete(hdev, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_AUTH_ENABLE, status);
 }
 
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -295,8 +285,6 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			clear_bit(HCI_ENCRYPT, &hdev->flags);
 	}
-
-	hci_req_complete(hdev, HCI_OP_WRITE_ENCRYPT_MODE, status);
 }
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
@@ -345,7 +333,6 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 done:
 	hci_dev_unlock(hdev);
-	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
 }
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
@@ -442,8 +429,6 @@ static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_HOST_BUFFER_SIZE, status);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -686,7 +671,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto done;
+		return;
 
 	hdev->hci_ver = rp->hci_ver;
 	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
@@ -699,9 +684,6 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hci_setup(hdev);
-
-done:
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
 }
 
 static void hci_setup_link_policy(struct hci_dev *hdev)
@@ -730,15 +712,12 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto done;
+		return;
 
 	memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
 
 	if (test_bit(HCI_INIT, &hdev->flags) && (hdev->commands[5] & 0x10))
 		hci_setup_link_policy(hdev);
-
-done:
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, rp->status);
 }
 
 static void hci_cc_read_local_features(struct hci_dev *hdev,
@@ -821,7 +800,7 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto done;
+		return;
 
 	switch (rp->page) {
 	case 0:
@@ -834,9 +813,6 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 
 	if (test_bit(HCI_INIT, &hdev->flags) && lmp_le_capable(hdev))
 		hci_set_le_support(hdev);
-
-done:
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
 
 static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
@@ -850,8 +826,6 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 		return;
 
 	hdev->flow_ctl_mode = rp->mode;
-
-	hci_req_complete(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, rp->status);
 }
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
@@ -888,8 +862,6 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!rp->status)
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
-
-	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
 }
 
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
@@ -910,8 +882,6 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 
 	BT_DBG("%s blk mtu %d cnt %d len %d", hdev->name, hdev->block_mtu,
 	       hdev->block_cnt, hdev->block_len);
-
-	hci_req_complete(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, rp->status);
 }
 
 static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
@@ -919,8 +889,6 @@ static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_CA_TIMEOUT, status);
 }
 
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
@@ -944,8 +912,6 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
-
 a2mp_rsp:
 	a2mp_send_getinfo_rsp(hdev);
 }
@@ -993,8 +959,6 @@ static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_DELETE_STORED_LINK_KEY, status);
 }
 
 static void hci_cc_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1002,8 +966,6 @@ static void hci_cc_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_SET_EVENT_MASK, status);
 }
 
 static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
@@ -1012,8 +974,6 @@ static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_INQUIRY_MODE, status);
 }
 
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
@@ -1025,8 +985,6 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 
 	if (!rp->status)
 		hdev->inq_tx_power = rp->tx_power;
-
-	hci_req_complete(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, rp->status);
 }
 
 static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1034,8 +992,6 @@ static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_SET_EVENT_FLT, status);
 }
 
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1097,8 +1053,6 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hdev->le_cnt = hdev->le_pkts;
 
 	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
 }
 
 static void hci_cc_le_read_local_features(struct hci_dev *hdev,
@@ -1110,8 +1064,6 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 
 	if (!rp->status)
 		memcpy(hdev->le_features, rp->features, 8);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, rp->status);
 }
 
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
@@ -1126,8 +1078,6 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 		if (!test_bit(HCI_INIT, &hdev->flags))
 			hci_update_ad(hdev);
 	}
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_ADV_TX_POWER, rp->status);
 }
 
 static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1135,8 +1085,6 @@ static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_LE_SET_EVENT_MASK, status);
 }
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1237,8 +1185,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!test_bit(HCI_INIT, &hdev->flags))
 		hci_update_ad(hdev);
-
-	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_ENABLE, status);
 }
 
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1247,8 +1193,6 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
-
 	if (status) {
 		hci_dev_lock(hdev);
 		mgmt_start_discovery_failed(hdev, status);
@@ -1271,8 +1215,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
-		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
-
 		if (status) {
 			hci_dev_lock(hdev);
 			mgmt_start_discovery_failed(hdev, status);
@@ -1323,8 +1265,6 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 
 	if (!rp->status)
 		hdev->le_white_list_size = rp->size;
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, rp->status);
 }
 
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1335,8 +1275,6 @@ static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (rp->status)
 		return;
-
-	hci_req_complete(hdev, HCI_OP_LE_LTK_REPLY, rp->status);
 }
 
 static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1347,8 +1285,6 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (rp->status)
 		return;
-
-	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
@@ -1360,8 +1296,6 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 
 	if (!rp->status)
 		memcpy(hdev->le_states, rp->le_states, 8);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, rp->status);
 }
 
 static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
@@ -1391,8 +1325,6 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
 	    !test_bit(HCI_INIT, &hdev->flags))
 		mgmt_le_enable_complete(hdev, sent->le, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, status);
 }
 
 static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
@@ -1414,7 +1346,6 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	if (status) {
-		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
 		if (test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -1945,7 +1876,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 	hci_transaction_cmd_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
-- 
1.7.10.4

