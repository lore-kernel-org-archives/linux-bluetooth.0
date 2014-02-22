Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/15] Bluetooth: Add skeleton for Set Privacy command
Date: Sat, 22 Feb 2014 19:06:36 +0200
Message-Id: <1393088805-28658-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the basic skeleton for handing the Set Privacy mgmt
command, including copying the value to hdev->irk and toggling the
HCI_PRIVACY flag. The patch does not yet add any kind of RPA generation
and HCI command sending.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 301b18a1c6a0..145254f84975 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -81,6 +81,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_SCAN_PARAMS,
 	MGMT_OP_SET_SECURE_CONN,
 	MGMT_OP_SET_DEBUG_KEYS,
+	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
 };
 
@@ -4187,6 +4188,45 @@ unlock:
 	return err;
 }
 
+static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
+		       u16 len)
+{
+	struct mgmt_cp_set_privacy *cp = cp_data;
+	bool changed;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->privacy != 0x00 && cp->privacy != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (cp->privacy) {
+		changed = !test_and_set_bit(HCI_PRIVACY, &hdev->dev_flags);
+		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
+	} else {
+		changed = test_and_clear_bit(HCI_PRIVACY, &hdev->dev_flags);
+		memset(hdev->irk, 0, sizeof(hdev->irk));
+	}
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_PRIVACY, hdev);
+	if (err < 0)
+		goto unlock;
+
+	if (changed)
+		err = new_settings(hdev, sk);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static bool irk_is_valid(struct mgmt_irk_info *irk)
 {
 	switch (irk->addr.type) {
@@ -4401,7 +4441,7 @@ static const struct mgmt_handler {
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
-	{ },
+	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
 };
 
-- 
1.8.5.3

