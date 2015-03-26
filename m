Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 2/8] Bluetooth: Support the "connectable mode" adv flag
Date: Wed, 25 Mar 2015 18:53:40 -0700
Message-Id: <1427334826-14858-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427334826-14858-1-git-send-email-armansito@chromium.org>
References: <1427334826-14858-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "connectable mode" flag of the
Add Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 87 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 38b03bd..e6280dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1013,11 +1013,8 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-static void update_adv_data(struct hci_request *req)
+static u8 get_current_adv_instance(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev = req->hdev;
-	u8 instance;
-
 	/* The "Set Advertising" setting supersedes the "Add Advertising"
 	 * setting. Here we set the advertising data based on which
 	 * setting was set. When neither apply, default to the global settings,
@@ -1025,9 +1022,54 @@ static void update_adv_data(struct hci_request *req)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
 	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		instance = 0x01;
-	else
-		instance = 0x00;
+		return 0x01;
+
+	return 0x00;
+}
+
+static bool get_connectable(struct hci_dev *hdev)
+{
+	struct mgmt_pending_cmd *cmd;
+
+	/* If there's a pending mgmt command the flag will not yet have
+	 * it's final value, so check for this first.
+	 */
+	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (cmd) {
+		struct mgmt_mode *cp = cmd->param;
+
+		return cp->val;
+	}
+
+	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
+}
+
+static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
+{
+	u32 flags;
+
+	if (instance > 0x01)
+		return 0;
+
+	if (instance == 1)
+		return hdev->adv_instance.flags;
+
+	flags = 0;
+
+	/* For instance 0, assemble the flags from global settings */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE) ||
+	    get_connectable(hdev))
+		flags |= MGMT_ADV_FLAG_CONNECTABLE;
+
+	/* TODO: Add the rest of the flags */
+
+	return flags;
+}
+
+static void update_adv_data(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 instance = get_current_adv_instance(hdev);
 
 	update_adv_data_for_instance(req, instance);
 }
@@ -1159,22 +1201,6 @@ static void update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
-static bool get_connectable(struct hci_dev *hdev)
-{
-	struct mgmt_pending_cmd *cmd;
-
-	/* If there's a pending mgmt command the flag will not yet have
-	 * it's final value, so check for this first.
-	 */
-	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
-	if (cmd) {
-		struct mgmt_mode *cp = cmd->param;
-		return cp->val;
-	}
-
-	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
-}
-
 static void disable_advertising(struct hci_request *req)
 {
 	u8 enable = 0x00;
@@ -1188,6 +1214,8 @@ static void enable_advertising(struct hci_request *req)
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
+	u8 instance;
+	u32 flags;
 
 	if (hci_conn_num(hdev, LE_LINK) > 0)
 		return;
@@ -1202,10 +1230,9 @@ static void enable_advertising(struct hci_request *req)
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
-		connectable = true;
-	else
-		connectable = get_connectable(hdev);
+	instance = get_current_adv_instance(hdev);
+	flags = get_adv_instance_flags(hdev, instance);
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE);
 
 	/* Set require_privacy to true only when non-connectable
 	 * advertising is used. In that case it is fine to use a
@@ -6623,10 +6650,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
 
-	/* The current implementation only supports adding one instance and
-	 * doesn't support flags.
-	 */
-	if (cp->instance != 0x01 || flags)
+	/* The current implementation only supports adding one instance */
+	if (cp->instance != 0x01)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.2.0.rc0.207.ga3a616c

