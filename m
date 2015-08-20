Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 1/3] Bluetooth: Classify HCI cmd complete event under corresponding config option
Date: Thu, 20 Aug 2015 17:09:03 +0800
Message-Id: <1440061745-24356-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Bluetooth spec, HCI command are supported by related
controllers, we can sort them under corresponding kernel config option

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/hci_event.c |  770 +++++++++++++++++++++++----------------------
 1 file changed, 392 insertions(+), 378 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ba35a9..4d7dfd3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -41,6 +41,219 @@
 
 /* Handle HCI Event packets */
 
+static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	clear_bit(HCI_RESET, &hdev->flags);
+
+	if (status)
+		return;
+
+	/* Reset all non-persistent flags */
+	hci_dev_clear_volatile_flags(hdev);
+
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
+	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
+	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
+
+	memset(hdev->adv_data, 0, sizeof(hdev->adv_data));
+	hdev->adv_data_len = 0;
+
+	memset(hdev->scan_rsp_data, 0, sizeof(hdev->scan_rsp_data));
+	hdev->scan_rsp_data_len = 0;
+
+	hdev->le_scan_type = LE_SCAN_PASSIVE;
+
+	hdev->ssp_debug_mode = 0;
+
+	hci_bdaddr_list_clear(&hdev->le_white_list);
+}
+
+static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_local_version *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		hdev->hci_ver = rp->hci_ver;
+		hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
+		hdev->lmp_ver = rp->lmp_ver;
+		hdev->manufacturer = __le16_to_cpu(rp->manufacturer);
+		hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);
+	}
+}
+
+static void hci_cc_read_local_commands(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_read_local_commands *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    hci_dev_test_flag(hdev, HCI_CONFIG))
+		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
+}
+
+static void hci_cc_read_local_features(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_read_local_features *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	memcpy(hdev->features, rp->features, 8);
+
+	/* Adjust default settings according to features
+	 * supported by device.
+	 */
+
+	if (hdev->features[0][0] & LMP_3SLOT)
+		hdev->pkt_type |= (HCI_DM3 | HCI_DH3);
+
+	if (hdev->features[0][0] & LMP_5SLOT)
+		hdev->pkt_type |= (HCI_DM5 | HCI_DH5);
+
+	if (hdev->features[0][1] & LMP_HV2) {
+		hdev->pkt_type  |= (HCI_HV2);
+		hdev->esco_type |= (ESCO_HV2);
+	}
+
+	if (hdev->features[0][1] & LMP_HV3) {
+		hdev->pkt_type  |= (HCI_HV3);
+		hdev->esco_type |= (ESCO_HV3);
+	}
+
+	if (lmp_esco_capable(hdev))
+		hdev->esco_type |= (ESCO_EV3);
+
+	if (hdev->features[0][4] & LMP_EV4)
+		hdev->esco_type |= (ESCO_EV4);
+
+	if (hdev->features[0][4] & LMP_EV5)
+		hdev->esco_type |= (ESCO_EV5);
+
+	if (hdev->features[0][5] & LMP_EDR_ESCO_2M)
+		hdev->esco_type |= (ESCO_2EV3);
+
+	if (hdev->features[0][5] & LMP_EDR_ESCO_3M)
+		hdev->esco_type |= (ESCO_3EV3);
+
+	if (hdev->features[0][5] & LMP_EDR_3S_ESCO)
+		hdev->esco_type |= (ESCO_2EV5 | ESCO_3EV5);
+}
+
+static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->acl_mtu  = __le16_to_cpu(rp->acl_mtu);
+	hdev->sco_mtu  = rp->sco_mtu;
+	hdev->acl_pkts = __le16_to_cpu(rp->acl_max_pkt);
+	hdev->sco_pkts = __le16_to_cpu(rp->sco_max_pkt);
+
+	if (test_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks)) {
+		hdev->sco_mtu  = 64;
+		hdev->sco_pkts = 8;
+	}
+
+	hdev->acl_cnt = hdev->acl_pkts;
+	hdev->sco_cnt = hdev->sco_pkts;
+
+	BT_DBG("%s acl mtu %d:%d sco mtu %d:%d", hdev->name, hdev->acl_mtu,
+	       hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
+}
+
+static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_bd_addr *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	if (test_bit(HCI_INIT, &hdev->flags))
+		bacpy(&hdev->bdaddr, &rp->bdaddr);
+
+	if (hci_dev_test_flag(hdev, HCI_SETUP))
+		bacpy(&hdev->setup_addr, &rp->bdaddr);
+}
+
+static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_read_rssi *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (conn)
+		conn->rssi = rp->rssi;
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_cp_read_tx_power *sent;
+	struct hci_rp_read_tx_power *rp = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
+	if (!sent)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn)
+		goto unlock;
+
+	switch (sent->type) {
+	case 0x00:
+		conn->tx_power = rp->tx_power;
+		break;
+	case 0x01:
+		conn->max_tx_power = rp->tx_power;
+		break;
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -186,38 +399,6 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 	hdev->link_policy = get_unaligned_le16(sent);
 }
 
-static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	__u8 status = *((__u8 *) skb->data);
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	clear_bit(HCI_RESET, &hdev->flags);
-
-	if (status)
-		return;
-
-	/* Reset all non-persistent flags */
-	hci_dev_clear_volatile_flags(hdev);
-
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-
-	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
-	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
-
-	memset(hdev->adv_data, 0, sizeof(hdev->adv_data));
-	hdev->adv_data_len = 0;
-
-	memset(hdev->scan_rsp_data, 0, sizeof(hdev->scan_rsp_data));
-	hdev->scan_rsp_data_len = 0;
-
-	hdev->le_scan_type = LE_SCAN_PASSIVE;
-
-	hdev->ssp_debug_mode = 0;
-
-	hci_bdaddr_list_clear(&hdev->le_white_list);
-}
-
 static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
@@ -539,90 +720,6 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_read_local_version *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG)) {
-		hdev->hci_ver = rp->hci_ver;
-		hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
-		hdev->lmp_ver = rp->lmp_ver;
-		hdev->manufacturer = __le16_to_cpu(rp->manufacturer);
-		hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);
-	}
-}
-
-static void hci_cc_read_local_commands(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	struct hci_rp_read_local_commands *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG))
-		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
-}
-
-static void hci_cc_read_local_features(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	struct hci_rp_read_local_features *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	memcpy(hdev->features, rp->features, 8);
-
-	/* Adjust default settings according to features
-	 * supported by device. */
-
-	if (hdev->features[0][0] & LMP_3SLOT)
-		hdev->pkt_type |= (HCI_DM3 | HCI_DH3);
-
-	if (hdev->features[0][0] & LMP_5SLOT)
-		hdev->pkt_type |= (HCI_DM5 | HCI_DH5);
-
-	if (hdev->features[0][1] & LMP_HV2) {
-		hdev->pkt_type  |= (HCI_HV2);
-		hdev->esco_type |= (ESCO_HV2);
-	}
-
-	if (hdev->features[0][1] & LMP_HV3) {
-		hdev->pkt_type  |= (HCI_HV3);
-		hdev->esco_type |= (ESCO_HV3);
-	}
-
-	if (lmp_esco_capable(hdev))
-		hdev->esco_type |= (ESCO_EV3);
-
-	if (hdev->features[0][4] & LMP_EV4)
-		hdev->esco_type |= (ESCO_EV4);
-
-	if (hdev->features[0][4] & LMP_EV5)
-		hdev->esco_type |= (ESCO_EV5);
-
-	if (hdev->features[0][5] & LMP_EDR_ESCO_2M)
-		hdev->esco_type |= (ESCO_2EV3);
-
-	if (hdev->features[0][5] & LMP_EDR_ESCO_3M)
-		hdev->esco_type |= (ESCO_3EV3);
-
-	if (hdev->features[0][5] & LMP_EDR_3S_ESCO)
-		hdev->esco_type |= (ESCO_2EV5 | ESCO_3EV5);
-}
-
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -653,48 +750,6 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 	hdev->flow_ctl_mode = rp->mode;
 }
 
-static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	hdev->acl_mtu  = __le16_to_cpu(rp->acl_mtu);
-	hdev->sco_mtu  = rp->sco_mtu;
-	hdev->acl_pkts = __le16_to_cpu(rp->acl_max_pkt);
-	hdev->sco_pkts = __le16_to_cpu(rp->sco_max_pkt);
-
-	if (test_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks)) {
-		hdev->sco_mtu  = 64;
-		hdev->sco_pkts = 8;
-	}
-
-	hdev->acl_cnt = hdev->acl_pkts;
-	hdev->sco_cnt = hdev->sco_pkts;
-
-	BT_DBG("%s acl mtu %d:%d sco mtu %d:%d", hdev->name, hdev->acl_mtu,
-	       hdev->acl_pkts, hdev->sco_mtu, hdev->sco_pkts);
-}
-
-static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_read_bd_addr *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	if (test_bit(HCI_INIT, &hdev->flags))
-		bacpy(&hdev->bdaddr, &rp->bdaddr);
-
-	if (hci_dev_test_flag(hdev, HCI_SETUP))
-		bacpy(&hdev->setup_addr, &rp->bdaddr);
-}
-
 static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
@@ -815,28 +870,6 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	hdev->amp_status = rp->amp_status;
-	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
-	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
-	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
-	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
-	hdev->amp_type = rp->amp_type;
-	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
-	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
-	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
-	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
-}
-
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
@@ -893,6 +926,126 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr, ACL_LINK, 0,
+						 rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
+						     ACL_LINK, 0, rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr, ACL_LINK,
+						 0, rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	if (hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
+						     ACL_LINK, 0, rp->status);
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+}
+
+static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
+					   struct sk_buff *skb)
+{
+	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+}
+
+static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	u8 status = *((u8 *) skb->data);
+	u8 *mode;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (status)
+		return;
+
+	mode = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE);
+	if (mode)
+		hdev->ssp_debug_mode = *mode;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_BT_HS)
+static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->amp_status = rp->amp_status;
+	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
+	hdev->amp_max_bw = __le32_to_cpu(rp->max_bw);
+	hdev->amp_min_latency = __le32_to_cpu(rp->min_latency);
+	hdev->amp_max_pdu = __le32_to_cpu(rp->max_pdu);
+	hdev->amp_type = rp->amp_type;
+	hdev->amp_pal_cap = __le16_to_cpu(rp->pal_cap);
+	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
+	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
+	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_BT_LE)
 static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
@@ -937,84 +1090,6 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 	hdev->adv_tx_power = rp->tx_power;
 }
 
-static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr, ACL_LINK, 0,
-						 rp->status);
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
-					  struct sk_buff *skb)
-{
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
-						     ACL_LINK, 0, rp->status);
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr, ACL_LINK,
-						 0, rp->status);
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
-					  struct sk_buff *skb)
-{
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
-						     ACL_LINK, 0, rp->status);
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
-				       struct sk_buff *skb)
-{
-	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-}
-
-static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
-					   struct sk_buff *skb)
-{
-	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-}
-
 static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1368,74 +1443,7 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 	hdev->adv_addr_type = cp->own_address_type;
 	hci_dev_unlock(hdev);
 }
-
-static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_read_rssi *rp = (void *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
-	if (conn)
-		conn->rssi = rp->rssi;
-
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_cp_read_tx_power *sent;
-	struct hci_rp_read_tx_power *rp = (void *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_TX_POWER);
-	if (!sent)
-		return;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
-	if (!conn)
-		goto unlock;
-
-	switch (sent->type) {
-	case 0x00:
-		conn->tx_power = rp->tx_power;
-		break;
-	case 0x01:
-		conn->max_tx_power = rp->tx_power;
-		break;
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_cc_write_ssp_debug_mode(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	u8 status = *((u8 *) skb->data);
-	u8 *mode;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status)
-		return;
-
-	mode = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE);
-	if (mode)
-		hdev->ssp_debug_mode = *mode;
-}
+#endif
 
 static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
@@ -2751,6 +2759,39 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	skb_pull(skb, sizeof(*ev));
 
 	switch (*opcode) {
+	case HCI_OP_RESET:
+		hci_cc_reset(hdev, skb);
+		break;
+
+	case HCI_OP_READ_LOCAL_VERSION:
+		hci_cc_read_local_version(hdev, skb);
+		break;
+
+	case HCI_OP_READ_LOCAL_COMMANDS:
+		hci_cc_read_local_commands(hdev, skb);
+		break;
+
+	case HCI_OP_READ_LOCAL_FEATURES:
+		hci_cc_read_local_features(hdev, skb);
+		break;
+
+	case HCI_OP_READ_BUFFER_SIZE:
+		hci_cc_read_buffer_size(hdev, skb);
+		break;
+
+	case HCI_OP_READ_BD_ADDR:
+		hci_cc_read_bd_addr(hdev, skb);
+		break;
+
+	case HCI_OP_READ_RSSI:
+		hci_cc_read_rssi(hdev, skb);
+		break;
+
+	case HCI_OP_READ_TX_POWER:
+		hci_cc_read_tx_power(hdev, skb);
+		break;
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 	case HCI_OP_INQUIRY_CANCEL:
 		hci_cc_inquiry_cancel(hdev, skb);
 		break;
@@ -2787,10 +2828,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_def_link_policy(hdev, skb);
 		break;
 
-	case HCI_OP_RESET:
-		hci_cc_reset(hdev, skb);
-		break;
-
 	case HCI_OP_READ_STORED_LINK_KEY:
 		hci_cc_read_stored_link_key(hdev, skb);
 		break;
@@ -2847,30 +2884,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_write_sc_support(hdev, skb);
 		break;
 
-	case HCI_OP_READ_LOCAL_VERSION:
-		hci_cc_read_local_version(hdev, skb);
-		break;
-
-	case HCI_OP_READ_LOCAL_COMMANDS:
-		hci_cc_read_local_commands(hdev, skb);
-		break;
-
-	case HCI_OP_READ_LOCAL_FEATURES:
-		hci_cc_read_local_features(hdev, skb);
-		break;
-
 	case HCI_OP_READ_LOCAL_EXT_FEATURES:
 		hci_cc_read_local_ext_features(hdev, skb);
 		break;
 
-	case HCI_OP_READ_BUFFER_SIZE:
-		hci_cc_read_buffer_size(hdev, skb);
-		break;
-
-	case HCI_OP_READ_BD_ADDR:
-		hci_cc_read_bd_addr(hdev, skb);
-		break;
-
 	case HCI_OP_READ_PAGE_SCAN_ACTIVITY:
 		hci_cc_read_page_scan_activity(hdev, skb);
 		break;
@@ -2895,10 +2912,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
 
-	case HCI_OP_READ_LOCAL_AMP_INFO:
-		hci_cc_read_local_amp_info(hdev, skb);
-		break;
-
 	case HCI_OP_READ_CLOCK:
 		hci_cc_read_clock(hdev, skb);
 		break;
@@ -2923,18 +2936,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_local_oob_ext_data(hdev, skb);
 		break;
 
-	case HCI_OP_LE_READ_BUFFER_SIZE:
-		hci_cc_le_read_buffer_size(hdev, skb);
-		break;
-
-	case HCI_OP_LE_READ_LOCAL_FEATURES:
-		hci_cc_le_read_local_features(hdev, skb);
-		break;
-
-	case HCI_OP_LE_READ_ADV_TX_POWER:
-		hci_cc_le_read_adv_tx_power(hdev, skb);
-		break;
-
 	case HCI_OP_USER_CONFIRM_REPLY:
 		hci_cc_user_confirm_reply(hdev, skb);
 		break;
@@ -2951,6 +2952,30 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_user_passkey_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_SSP_DEBUG_MODE:
+		hci_cc_write_ssp_debug_mode(hdev, skb);
+		break;
+#endif
+
+#if IS_ENABLED(CONFIG_BT_HS)
+	case HCI_OP_READ_LOCAL_AMP_INFO:
+		hci_cc_read_local_amp_info(hdev, skb);
+		break;
+#endif
+
+#if IS_ENABLED(CONFIG_BT_LE)
+	case HCI_OP_LE_READ_BUFFER_SIZE:
+		hci_cc_le_read_buffer_size(hdev, skb);
+		break;
+
+	case HCI_OP_LE_READ_LOCAL_FEATURES:
+		hci_cc_le_read_local_features(hdev, skb);
+		break;
+
+	case HCI_OP_LE_READ_ADV_TX_POWER:
+		hci_cc_le_read_adv_tx_power(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_RANDOM_ADDR:
 		hci_cc_le_set_random_addr(hdev, skb);
 		break;
@@ -3006,18 +3031,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 	case HCI_OP_LE_SET_ADV_PARAM:
 		hci_cc_set_adv_param(hdev, skb);
 		break;
-
-	case HCI_OP_READ_RSSI:
-		hci_cc_read_rssi(hdev, skb);
-		break;
-
-	case HCI_OP_READ_TX_POWER:
-		hci_cc_read_tx_power(hdev, skb);
-		break;
-
-	case HCI_OP_WRITE_SSP_DEBUG_MODE:
-		hci_cc_write_ssp_debug_mode(hdev, skb);
-		break;
+#endif
 
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
-- 
1.7.9.5

