Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 4/6] Bluetooth: Implement the Add Advertising command
Date: Thu, 19 Mar 2015 17:04:35 -0700
Message-Id: <1426809877-22469-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1426809877-22469-1-git-send-email-armansito@chromium.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the most basic implementation for the
"Add Advertisement" command. All state updates between the
various HCI settings (POWERED, ADVERTISING, ADVERTISING_INSTANCE,
and LE_ENABLED) has been implemented. The command currently
supports only setting the advertising data fields, with no flags
and no scan response data.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 271 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 467cac9..f4ed4fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -866,7 +866,7 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	return 0;
 }
 
-static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
+static u8 create_default_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
 
@@ -898,6 +898,35 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 	return ad_len;
 }
 
+static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
+{
+	u8 ad_len = 0, flags = 0;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		flags |= LE_AD_NO_BREDR;
+
+	/* TODO: Set the appropriate entries based on advertising instance flags
+	 * here once flags other than 0 are supported.
+	 */
+
+	if (flags) {
+		BT_DBG("instance adv flags 0x%02x", flags);
+
+		ptr[0] = 2;
+		ptr[1] = EIR_FLAGS;
+		ptr[2] = flags;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
+	memcpy(ptr, hdev->adv_instance.adv_data,
+	       hdev->adv_instance.adv_data_len);
+	ad_len += hdev->adv_instance.adv_data_len;
+
+	return ad_len;
+}
+
 static void update_adv_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -909,7 +938,11 @@ static void update_adv_data(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = create_adv_data(hdev, cp.data);
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		len = create_default_adv_data(hdev, cp.data);
+	else
+		len = create_instance_adv_data(hdev, cp.data);
 
 	if (hdev->adv_data_len == len &&
 	    memcmp(cp.data, hdev->adv_data, len) == 0)
@@ -1692,7 +1725,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 
 update_ad:
-	update_adv_data(&req);
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		update_adv_data(&req);
 
 	err = hci_req_run(&req, set_discoverable_complete);
 	if (err < 0)
@@ -4364,10 +4398,17 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void enable_advertising_instance(struct hci_dev *hdev, u8 status,
+					u16 opcode)
+{
+	BT_DBG("status %d", status);
+}
+
 static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
 	struct cmd_lookup match = { NULL, hdev };
+	struct hci_request req;
 
 	hci_dev_lock(hdev);
 
@@ -4392,6 +4433,18 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	if (match.sk)
 		sock_put(match.sk);
 
+	/* If instance advertising was set up, then reconfigure advertising */
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		goto unlock;
+
+	hci_req_init(&req, hdev);
+
+	update_adv_data(&req);
+	enable_advertising(&req);
+
+	if (hci_req_run(&req, enable_advertising_instance) < 0)
+		BT_ERR("Failed to re-configure advertising");
+
 unlock:
 	hci_dev_unlock(hdev);
 }
@@ -6295,6 +6348,13 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	rp_len = sizeof(*rp);
+
+	/* Currently only one instance is supported, so just add 1 to the
+	 * response length.
+	 */
+	if (hdev->cur_adv_index)
+		rp_len++;
+
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		hci_dev_unlock(hdev);
@@ -6302,10 +6362,16 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	rp->supported_flags = cpu_to_le32(0);
-	rp->max_adv_data_len = 31;
-	rp->max_scan_rsp_len = 31;
-	rp->max_instances = 0;
-	rp->num_instances = 0;
+	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
+	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
+	rp->max_instances = 1;
+
+	/* Currently only one instance is supported, so simply return the
+	 * current instance number.
+	 */
+	rp->num_instances = hdev->cur_adv_index ? 1 : 0;
+	if (hdev->cur_adv_index)
+		rp->instance[0] = hdev->cur_adv_index;
 
 	hci_dev_unlock(hdev);
 
@@ -6317,14 +6383,198 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static bool adv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *adv_data,
+			      u8 adv_data_len)
+{
+	u8 max_adv_len = HCI_MAX_AD_LENGTH;
+	int i, cur_len;
+
+	/* TODO: Correctly reduce adv_len based on adv_flags. */
+
+	/* The only global settings that affects the maximum length is BREDR
+	 * support, which must be included in the "flags" AD field.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		max_adv_len -= 3;
+
+	if (adv_data_len > max_adv_len)
+		return false;
+
+	/* Make sure that adv_data is correctly formatted and doesn't contain
+	 * any fields that are managed by adv_flags and global settings.
+	 */
+	for (i = 0, cur_len = 0; i < adv_data_len; i += (cur_len + 1)) {
+		cur_len = adv_data[i];
+
+		/* If the current field length would exceed the total data
+		 * length, then it's invalid.
+		 */
+		if (i + cur_len >= adv_data_len)
+			return false;
+
+		/* We use a whitelist for the allowed AD fields */
+		switch (adv_data[i + 1]) {
+		case EIR_UUID16_SOME:
+		case EIR_UUID16_ALL:
+		case EIR_UUID32_SOME:
+		case EIR_UUID32_ALL:
+		case EIR_UUID128_SOME:
+		case EIR_UUID128_ALL:
+		case EIR_NAME_SHORT:
+		case EIR_NAME_COMPLETE:
+		case LE_AD_FIELD_SOLICIT16:
+		case LE_AD_FIELD_SOLICIT32:
+		case LE_AD_FIELD_SOLICIT128:
+		case LE_AD_FIELD_SVC_DATA16:
+		case LE_AD_FIELD_SVC_DATA32:
+		case LE_AD_FIELD_SVC_DATA128:
+		case LE_AD_FIELD_PUB_TRGT_ADDR:
+		case LE_AD_FIELD_RND_TRGT_ADDR:
+		case LE_AD_FIELD_APPEARANCE:
+		case LE_AD_FIELD_MANUF_DATA:
+			break;
+		default:
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void add_advertising_complete(struct hci_dev *hdev, u8 status,
+				     u16 opcode)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct mgmt_rp_add_advertising rp;
+
+	BT_DBG("status %d", status);
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+		hdev->cur_adv_index = 0;
+
+		/* TODO: Send Advertising Removed event */
+	}
+
+	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
+	if (!cmd)
+		goto unlock;
+
+	rp.instance = hdev->cur_adv_index;
+
+	if (status)
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+				mgmt_status(status));
+	else
+		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+				  mgmt_status(status), &rp, sizeof(rp));
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
+	struct mgmt_cp_add_advertising *cp = data;
+	struct mgmt_rp_add_advertising rp;
+	u32 flags;
+	u8 status;
+	int err;
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+
 	BT_DBG("%s", hdev->name);
 
-	/* TODO: Implement this command. */
-	return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
-			       MGMT_STATUS_NOT_SUPPORTED);
+	status = mgmt_le_support(hdev);
+	if (status)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				       status);
+
+	/* The current implementation supports the bare minimum set of features:
+	 *    - Single instance.
+	 *    - 0 flag
+	 *    - No timeouts
+	 *    - Only advertising data can be modified.
+	 * Return error if the parameters contain any unsupported parameters.
+	 */
+	if (cp->instance != 1 || cp->flags || cp->timeout || cp->scan_rsp_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	flags = __le32_to_cpu(cp->flags);
+
+	hci_dev_lock(hdev);
+
+	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
+	    pending_find(MGMT_OP_SET_LE, hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (!adv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	hdev->adv_instance.flags = cp->flags;
+	hdev->adv_instance.adv_data_len = cp->adv_data_len;
+	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
+
+	if (cp->adv_data_len)
+		memcpy(hdev->adv_instance.adv_data, cp->data, cp->adv_data_len);
+
+	if (cp->scan_rsp_len)
+		memcpy(hdev->adv_instance.scan_rsp_data,
+		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
+
+	/* TODO: Send Advertising Added event if the index changed
+	 * from 0 to 1.
+	 */
+	hdev->cur_adv_index = cp->instance;
+
+	hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
+
+	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
+	 * we have no HCI communication to make. Simply return.
+	 */
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
+		rp.instance = hdev->cur_adv_index;
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+		goto unlock;
+	}
+
+	/* We're good to go, update advertising data, parameters, and start
+	 * advertising.
+	 */
+	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_ADVERTISING, hdev, data,
+			       data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_req_init(&req, hdev);
+
+	update_adv_data(&req);
+	enable_advertising(&req);
+
+	err = hci_req_run(&req, add_advertising_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
 }
 
 static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
@@ -6595,7 +6845,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 			update_scan_rsp_data(&req);
 		}
 
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+		    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 			enable_advertising(&req);
 
 		restart_le_actions(&req);
@@ -6707,7 +6958,13 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 			    sizeof(scan), &scan);
 	}
 	update_class(&req);
-	update_adv_data(&req);
+
+	/* Advertising instances don't use the global discoverable setting, so
+	 * only update AD if advertising was enabled using Set Advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		update_adv_data(&req);
+
 	hci_req_run(&req, NULL);
 
 	hdev->discov_timeout = 0;
@@ -7608,7 +7865,8 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 {
 	struct hci_request req;
 
-	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		return;
 
 	hci_req_init(&req, hdev);
-- 
2.2.0.rc0.207.ga3a616c

