Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Move move logic into set_connectable complete callback
Date: Mon, 14 Oct 2013 16:20:04 +0300
Message-Id: <1381756807-14900-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
References: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves the responsibility of setting/clearing the
HCI_CONNECTABLE flag to the request completion callback of the Set
Connectable command. This will allow us to cleanly add support for LE
Advertising hooks in later patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cfd8d44..8dcea77 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1075,6 +1075,8 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
+	bool changed;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -1084,8 +1086,17 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		goto unlock;
 
+	cp = cmd->param;
+	if (cp->val)
+		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
 
+	if (changed)
+		new_settings(hdev, cmd->sk);
+
 	mgmt_pending_remove(cmd);
 
 unlock:
@@ -4053,10 +4064,16 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
-	struct pending_cmd *cmd;
 	bool changed = false;
 	int err = 0;
 
+	/* Nothing needed here if there's a pending command since that
+	 * commands request completion callback takes care of everything
+	 * necessary.
+	 */
+	if (mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+		return 0;
+
 	if (connectable) {
 		if (!test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 			changed = true;
@@ -4065,10 +4082,8 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 			changed = true;
 	}
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev);
-
 	if (changed)
-		err = new_settings(hdev, cmd ? cmd->sk : NULL);
+		err = new_settings(hdev, NULL);
 
 	return err;
 }
-- 
1.8.3.1

