Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add a new mgmt_set_bredr command
Date: Wed,  2 Oct 2013 12:10:40 +0300
Message-Id: <1380705040-16300-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com>
References: <1380705040-16300-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch introduces a new mgmt command for enabling/disabling BR/EDR
functionality. This can be convenient when one wants to make a dual-mode
controller behave like a single-mode one. The command is only available
for dual-mode controllers and requires that LE is enabled before using
it. The BR/EDR setting can be enabled at any point, however disabling it
requires the controller to be powered off (otherwise a "rejected"
response will be sent).

Disabling the BR/EDR setting will automatically disable all other BR/EDR
related settings.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |   2 +
 net/bluetooth/hci_event.c    |   5 ++
 net/bluetooth/mgmt.c         | 124 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 421d763..7347df8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -354,6 +354,8 @@ struct mgmt_cp_set_device_id {
 
 #define MGMT_OP_SET_ADVERTISING		0x0029
 
+#define MGMT_OP_SET_BREDR		0x002A
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d171c04b..4785ab0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -297,6 +297,11 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	/* We need to ensure that we set this back on if someone changed
+	 * the scan mode through a raw HCI socket.
+	 */
+	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
 	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
 	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1c41b0..8b9b337 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -75,6 +75,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_UNBLOCK_DEVICE,
 	MGMT_OP_SET_DEVICE_ID,
 	MGMT_OP_SET_ADVERTISING,
+	MGMT_OP_SET_BREDR,
 };
 
 static const u16 mgmt_events[] = {
@@ -3337,6 +3338,125 @@ unlock:
 	return err;
 }
 
+static void set_bredr_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_BREDR, hdev);
+	if (!cmd)
+		goto unlock;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		/* We need to restore the flag if related HCI commands
+		 * failed.
+		 */
+		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
+		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+	} else {
+		send_settings_rsp(cmd->sk, MGMT_OP_SET_BREDR, hdev);
+		new_settings(hdev, cmd->sk);
+	}
+
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_request req;
+	u8 val, enabled;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_bredr_capable(hdev) || !lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				  MGMT_STATUS_REJECTED);
+
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				  MGMT_STATUS_REJECTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	val = !!cp->val;
+	enabled = test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
+	if (val == enabled) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
+		goto unlock;
+	}
+
+	if (!hdev_is_powered(hdev)) {
+		if (!val) {
+			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+			clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+			clear_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+			clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+		}
+
+		change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
+		if (err < 0)
+			goto unlock;
+
+		err = new_settings(hdev, sk);
+		goto unlock;
+	}
+
+	/* Reject disabling when powered on */
+	if (!val) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				 MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_BREDR, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_BREDR, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* We need to flip the bit already here so that hci_update_ad
+	 * generates the correct flags.
+	 */
+	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
+	hci_req_init(&req, hdev);
+	hci_update_ad(&req);
+	err = hci_req_run(&req, set_bredr_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->authenticated != 0x00 && key->authenticated != 0x01)
@@ -3452,6 +3572,7 @@ static const struct mgmt_handler {
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
 	{ set_advertising,        false, MGMT_SETTING_SIZE },
+	{ set_bredr,              false, MGMT_SETTING_SIZE },
 };
 
 
@@ -3633,6 +3754,9 @@ static int powered_update_hci(struct hci_dev *hdev)
 		    cp.simul != lmp_host_le_br_capable(hdev))
 			hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED,
 				    sizeof(cp), &cp);
+
+		/* In case BR/EDR was toggled during the AUTO_OFF phase */
+		hci_update_ad(&req);
 	}
 
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
-- 
1.8.3.1

