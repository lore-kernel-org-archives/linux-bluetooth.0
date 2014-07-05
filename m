Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Use a more simpler style for HCI event callbacks
Date: Sat,  5 Jul 2014 10:48:01 +0200
Message-Id: <1404550083-29418-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI event callbacks have grown over the last years and some
functions handle status checking different than others. For the
simple ones, check the status at the beginning and exit if an
error with the HCI command occured.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 142 ++++++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 54 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 27c1d2edeebe..013c371d3c87 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -175,12 +175,14 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_DEF_LINK_POLICY);
 	if (!sent)
 		return;
 
-	if (!status)
-		hdev->link_policy = get_unaligned_le16(sent);
+	hdev->link_policy = get_unaligned_le16(sent);
 }
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
@@ -270,27 +272,30 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
+	__u8 param;
 	void *sent;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_ENCRYPT_MODE);
 	if (!sent)
 		return;
 
-	if (!status) {
-		__u8 param = *((__u8 *) sent);
+	param = *((__u8 *) sent);
 
-		if (param)
-			set_bit(HCI_ENCRYPT, &hdev->flags);
-		else
-			clear_bit(HCI_ENCRYPT, &hdev->flags);
-	}
+	if (param)
+		set_bit(HCI_ENCRYPT, &hdev->flags);
+	else
+		clear_bit(HCI_ENCRYPT, &hdev->flags);
 }
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 param, status = *((__u8 *) skb->data);
+	__u8 status = *((__u8 *) skb->data);
+	__u8 param;
 	int old_pscan, old_iscan;
 	void *sent;
 
@@ -602,8 +607,10 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
-		hdev->flow_ctl_mode = rp->mode;
+	if (rp->status)
+		return;
+
+	hdev->flow_ctl_mode = rp->mode;
 }
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
@@ -649,7 +656,10 @@ static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status) {
+	if (rp->status)
+		return;
+
+	if (test_bit(HCI_INIT, &hdev->flags)) {
 		hdev->page_scan_interval = __le16_to_cpu(rp->interval);
 		hdev->page_scan_window = __le16_to_cpu(rp->window);
 	}
@@ -681,7 +691,10 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status)
+	if (rp->status)
+		return;
+
+	if (test_bit(HCI_INIT, &hdev->flags))
 		hdev->page_scan_type = rp->type;
 }
 
@@ -825,8 +838,10 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
-		hdev->inq_tx_power = rp->tx_power;
+	if (rp->status)
+		return;
+
+	hdev->inq_tx_power = rp->tx_power;
 }
 
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -897,8 +912,10 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
-		memcpy(hdev->le_features, rp->features, 8);
+	if (rp->status)
+		return;
+
+	memcpy(hdev->le_features, rp->features, 8);
 }
 
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
@@ -908,8 +925,10 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
-		hdev->adv_tx_power = rp->tx_power;
+	if (rp->status)
+		return;
+
+	hdev->adv_tx_power = rp->tx_power;
 }
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1009,14 +1028,16 @@ static void hci_cc_le_set_random_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_RANDOM_ADDR);
 	if (!sent)
 		return;
 
 	hci_dev_lock(hdev);
 
-	if (!status)
-		bacpy(&hdev->random_addr, sent);
+	bacpy(&hdev->random_addr, sent);
 
 	hci_dev_unlock(hdev);
 }
@@ -1027,11 +1048,11 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
-	if (!sent)
+	if (status)
 		return;
 
-	if (status)
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
+	if (!sent)
 		return;
 
 	hci_dev_lock(hdev);
@@ -1061,14 +1082,16 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_PARAM);
 	if (!cp)
 		return;
 
 	hci_dev_lock(hdev);
 
-	if (!status)
-		hdev->le_scan_type = cp->type;
+	hdev->le_scan_type = cp->type;
 
 	hci_dev_unlock(hdev);
 }
@@ -1110,11 +1133,11 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
-	if (!cp)
+	if (status)
 		return;
 
-	if (status)
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
+	if (!cp)
 		return;
 
 	switch (cp->enable) {
@@ -1167,8 +1190,10 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
 
-	if (!rp->status)
-		hdev->le_white_list_size = rp->size;
+	if (rp->status)
+		return;
+
+	hdev->le_white_list_size = rp->size;
 }
 
 static void hci_cc_le_clear_white_list(struct hci_dev *hdev,
@@ -1178,8 +1203,10 @@ static void hci_cc_le_clear_white_list(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	if (!status)
-		hci_white_list_clear(hdev);
+	if (status)
+		return;
+
+	hci_white_list_clear(hdev);
 }
 
 static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
@@ -1190,12 +1217,14 @@ static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_WHITE_LIST);
 	if (!sent)
 		return;
 
-	if (!status)
-		hci_white_list_add(hdev, &sent->bdaddr, sent->bdaddr_type);
+	hci_white_list_add(hdev, &sent->bdaddr, sent->bdaddr_type);
 }
 
 static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
@@ -1206,12 +1235,14 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_WHITE_LIST);
 	if (!sent)
 		return;
 
-	if (!status)
-		hci_white_list_del(hdev, &sent->bdaddr, sent->bdaddr_type);
+	hci_white_list_del(hdev, &sent->bdaddr, sent->bdaddr_type);
 }
 
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
@@ -1221,8 +1252,10 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
-		memcpy(hdev->le_states, rp->le_states, 8);
+	if (rp->status)
+		return;
+
+	memcpy(hdev->le_states, rp->le_states, 8);
 }
 
 static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
@@ -1233,25 +1266,26 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
+	if (status)
+		return;
+
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED);
 	if (!sent)
 		return;
 
-	if (!status) {
-		if (sent->le) {
-			hdev->features[1][0] |= LMP_HOST_LE;
-			set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
-		} else {
-			hdev->features[1][0] &= ~LMP_HOST_LE;
-			clear_bit(HCI_LE_ENABLED, &hdev->dev_flags);
-			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
-		}
-
-		if (sent->simul)
-			hdev->features[1][0] |= LMP_HOST_LE_BREDR;
-		else
-			hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
+	if (sent->le) {
+		hdev->features[1][0] |= LMP_HOST_LE;
+		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+	} else {
+		hdev->features[1][0] &= ~LMP_HOST_LE;
+		clear_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+		clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	}
+
+	if (sent->simul)
+		hdev->features[1][0] |= LMP_HOST_LE_BREDR;
+	else
+		hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
 }
 
 static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.9.3

