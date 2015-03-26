Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 8/8] Bluetooth: Unify advertising data code paths
Date: Wed, 25 Mar 2015 18:14:16 -0700
Message-Id: <1427332456-7148-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1427332456-7148-1-git-send-email-armansito@chromium.org>
References: <1427332456-7148-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch simplifies the code paths for assembling the advertising data
used by advertising instances 0 and 1.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 155 +++++++++++++++++++++------------------------------
 1 file changed, 64 insertions(+), 91 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4d9d467..92c9fb9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -941,52 +941,73 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
 	return 0;
 }
 
-static u8 create_default_adv_data(struct hci_dev *hdev, u8 *ptr)
+static u8 get_current_adv_instance(struct hci_dev *hdev)
 {
-	u8 ad_len = 0, flags = 0;
-
-	flags |= get_adv_discov_flags(hdev);
+	/* The "Set Advertising" setting supersedes the "Add Advertising"
+	 * setting. Here we set the advertising data based on which
+	 * setting was set. When neither apply, default to the global settings,
+	 * represented by instance "0".
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return 0x01;
 
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		flags |= LE_AD_NO_BREDR;
+	return 0x00;
+}
 
-	if (flags) {
-		BT_DBG("adv flags 0x%02x", flags);
+static bool get_connectable(struct hci_dev *hdev)
+{
+	struct mgmt_pending_cmd *cmd;
 
-		ptr[0] = 2;
-		ptr[1] = EIR_FLAGS;
-		ptr[2] = flags;
+	/* If there's a pending mgmt command the flag will not yet have
+	 * it's final value, so check for this first.
+	 */
+	cmd = pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
+	if (cmd) {
+		struct mgmt_mode *cp = cmd->param;
 
-		ad_len += 3;
-		ptr += 3;
+		return cp->val;
 	}
 
-	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID) {
-		ptr[0] = 2;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8) hdev->adv_tx_power;
+	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
+}
 
-		ad_len += 3;
-		ptr += 3;
-	}
+static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
+{
+	u32 flags;
 
-	return ad_len;
+	if (instance > 0x01)
+		return 0;
+
+	if (instance == 0x01)
+		return hdev->adv_instance.flags;
+
+	/* Instance 0 always manages the "Tx Power" and "Flags" fields */
+	flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+	/* For instance 0, assemble the flags from global settings */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE) ||
+	    get_connectable(hdev))
+		flags |= MGMT_ADV_FLAG_CONNECTABLE;
+
+	return flags;
 }
 
-static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
+static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
+	u32 instance_flags = get_adv_instance_flags(hdev, instance);
 
 	/* The Add Advertising command allows userspace to set both the general
 	 * and limited discoverable flags.
 	 */
-	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_DISCOV)
+	if (instance_flags & MGMT_ADV_FLAG_DISCOV)
 		flags |= LE_AD_GENERAL;
 
-	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
+	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
 		flags |= LE_AD_LIMITED;
 
-	if (flags || (hdev->adv_instance.flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
+	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
 		/* If a discovery flag wasn't provided, simply use the global
 		 * settings.
 		 */
@@ -996,16 +1017,22 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 			flags |= LE_AD_NO_BREDR;
 
-		ptr[0] = 0x02;
-		ptr[1] = EIR_FLAGS;
-		ptr[2] = flags;
+		/* If flags would still be empty, then there is no need to
+		 * include the "Flags" AD field".
+		 */
+		if (flags) {
+			ptr[0] = 0x02;
+			ptr[1] = EIR_FLAGS;
+			ptr[2] = flags;
 
-		ad_len += 3;
-		ptr += 3;
+			ad_len += 3;
+			ptr += 3;
+		}
 	}
 
+	/* Provide Tx Power only if we can provide a valid value for it */
 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
-	    (hdev->adv_instance.flags & MGMT_ADV_FLAG_TX_POWER)) {
+	    (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
 		ptr[0] = 0x02;
 		ptr[1] = EIR_TX_POWER;
 		ptr[2] = (u8)hdev->adv_tx_power;
@@ -1014,9 +1041,11 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 		ptr += 3;
 	}
 
-	memcpy(ptr, hdev->adv_instance.adv_data,
-	       hdev->adv_instance.adv_data_len);
-	ad_len += hdev->adv_instance.adv_data_len;
+	if (instance) {
+		memcpy(ptr, hdev->adv_instance.adv_data,
+		       hdev->adv_instance.adv_data_len);
+		ad_len += hdev->adv_instance.adv_data_len;
+	}
 
 	return ad_len;
 }
@@ -1032,10 +1061,7 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (instance)
-		len = create_instance_adv_data(hdev, cp.data);
-	else
-		len = create_default_adv_data(hdev, cp.data);
+	len = create_instance_adv_data(hdev, instance, cp.data);
 
 	/* There's nothing to do if the data hasn't changed */
 	if (hdev->adv_data_len == len &&
@@ -1050,59 +1076,6 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-static u8 get_current_adv_instance(struct hci_dev *hdev)
-{
-	/* The "Set Advertising" setting supersedes the "Add Advertising"
-	 * setting. Here we set the advertising data based on which
-	 * setting was set. When neither apply, default to the global settings,
-	 * represented by instance "0".
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
-	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return 0x01;
-
-	return 0x00;
-}
-
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
-
-		return cp->val;
-	}
-
-	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
-}
-
-static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
-{
-	u32 flags;
-
-	if (instance > 0x01)
-		return 0;
-
-	if (instance == 1)
-		return hdev->adv_instance.flags;
-
-	flags = 0;
-
-	/* For instance 0, assemble the flags from global settings */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE) ||
-	    get_connectable(hdev))
-		flags |= MGMT_ADV_FLAG_CONNECTABLE;
-
-	/* TODO: Add the rest of the flags */
-
-	return flags;
-}
-
 static void update_adv_data(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
-- 
2.2.0.rc0.207.ga3a616c

