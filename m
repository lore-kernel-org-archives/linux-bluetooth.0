Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 15/16] Bluetooth: mgmt: multi adv for remove_advertising()
Date: Mon, 25 May 2015 00:39:13 +0200
Message-Id: <1432507154-22925-16-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The remove_advertising() and remove_advertising_complete() functions
had a hard coded instance identifier. This is being fixed by referencing
the instance identifier from the management API call instead.

remove_advertising() would not allow for instance identifiers other than
0x01. We now allow for arbitrary and/or multiple instance identifiers
while maintaining the previous semantics that an instance identifier of
0x00 signals that all advertising instances should be removed.

The code is made more readable by factoring advertising instance
management and initialization into the low-level
hci_remove_adv_instance() and hci_adv_instances_clear() functions.

This change still relies on the fact that we only allow for a single
advertising instance as it should only switch off advertising when there
are no more active advertising instances. It should advertise the next
active advertising instance instead in case there are remaining
advertising instances. A corresponding TODO has been inserted into the
code.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39e6b772..6a54eb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7089,6 +7089,7 @@ static void remove_advertising_complete(struct hci_dev *hdev, u8 status,
 					u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_remove_advertising *cp;
 	struct mgmt_rp_remove_advertising rp;
 
 	BT_DBG("status %d", status);
@@ -7103,7 +7104,8 @@ static void remove_advertising_complete(struct hci_dev *hdev, u8 status,
 	if (!cmd)
 		goto unlock;
 
-	rp.instance = 1;
+	cp = cmd->param;
+	rp.instance = cp->instance;
 
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, MGMT_STATUS_SUCCESS,
 			  &rp, sizeof(rp));
@@ -7118,21 +7120,23 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_remove_advertising *cp = data;
 	struct mgmt_rp_remove_advertising rp;
+	struct adv_info *adv_instance;
 	int err;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
 
 	BT_DBG("%s", hdev->name);
 
-	/* The current implementation only allows modifying instance no 1. A
-	 * value of 0 indicates that all instances should be cleared.
-	 */
-	if (cp->instance > 1)
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
-				       MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
+	if (cp->instance != 0x00 &&
+	    !hci_find_adv_instance(hdev, cp->instance)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_REMOVE_ADVERTISING,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
 	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_SET_LE, hdev)) {
@@ -7147,13 +7151,21 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
-
-	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-
-	advertising_removed(sk, hdev, 1);
+	/* A value of 0 indicates that all instances should be cleared. */
+	if (cp->instance == 0x00) {
+		list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
+			advertising_removed(sk, hdev, adv_instance->instance);
+		}
+		hci_adv_instances_clear(hdev);
+	} else {
+		err = hci_remove_adv_instance(hdev, cp->instance);
+		if (!err)
+			advertising_removed(sk, hdev, cp->instance);
+	}
 
+	/* TODO: Only switch off advertising if the instance list is empty
+	 * else switch to the next remaining adv instance.
+	 */
 	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
 	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
@@ -7161,7 +7173,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 	 */
 	if (!hdev_is_powered(hdev) ||
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		rp.instance = 1;
+		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id,
 					MGMT_OP_REMOVE_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
1.9.1

