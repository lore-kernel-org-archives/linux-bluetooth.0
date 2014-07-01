Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use NRPA discovery only when background scanning is active
Date: Tue,  1 Jul 2014 21:52:31 +0200
Message-Id: <1404244351-26011-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/mgmt.c        | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 58c5930dea60..37f967360f9a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -134,6 +134,7 @@ enum {
 	HCI_SC_ENABLED,
 	HCI_SC_ONLY,
 	HCI_PRIVACY,
+	HCI_NRPA_DISCOV,
 	HCI_RPA_EXPIRED,
 	HCI_RPA_RESOLVING,
 	HCI_HS_ENABLED,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba5e215a7561..cbe002b884c0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3488,6 +3488,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
 	u8 status, own_addr_type;
+	bool require_privacy;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3584,8 +3585,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		/* All active scans will be done with either a resolvable
 		 * private address (when privacy feature has been enabled)
 		 * or unresolvable private address.
+		 *
+		 * However if background scanning is not activated, then for
+		 * compatibility reasons, it is better to not require the
+		 * use of non-resolvable private addresses.
 		 */
-		err = hci_update_random_address(&req, true, &own_addr_type);
+		require_privacy = test_bit(HCI_NRPA_DISCOV, &hdev->dev_flags);
+
+		err = hci_update_random_address(&req, require_privacy,
+						&own_addr_type);
 		if (err < 0) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_FAILED);
@@ -5051,6 +5059,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
 
+	/* If this command is issued at least once, the controller
+	 * will be using background scanning for all auto-connection
+	 * procedures. This means that for discovery a non-resolvable
+	 * private address can be used.
+	 */
+	set_bit(HCI_NRPA_DISCOV, &hdev->dev_flags);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
@@ -5109,6 +5124,13 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
 			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
 
+	/* If this command is issued at least once, the controller
+	 * will be using background scanning for all auto-connection
+	 * procedures. This means that for discovery a non-resolvable
+	 * private address can be used.
+	 */
+	set_bit(HCI_NRPA_DISCOV, &hdev->dev_flags);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
-- 
1.9.3

