Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] Bluetooth: Fix busy condition testing for EIR and class updates
Date: Sun, 10 Mar 2013 07:18:41 +0200
Message-Id: <1362892723-14967-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362892723-14967-1-git-send-email-johan.hedberg@gmail.com>
References: <1362892723-14967-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The add/remove_uuid and set_dev_class mgmt commands can trigger both EIR
and class HCI commands, so testing just for a pending class command is
enough. The simplest way to monitor conflicts that should trigger "busy"
error returns is to check for any pending mgmt command that can trigger
these HCI commands. This patch adds a helper function for this
(pending_eir_or_class) and uses it instead of the old HCI_PENDING_CLASS
flag to test for busy conditions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bf17a62..367837d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1336,6 +1336,29 @@ unlock:
 	return err;
 }
 
+/* This is a helper function to test for pending mgmt commands that can
+ * cause CoD or EIR HCI commands. We can only allow one such pending
+ * mgmt command at a time since otherwise we cannot easily track what
+ * the current values are, will be, and based on that calculate if a new
+ * HCI command needs to be sent and if yes with what value.
+ */
+static bool pending_eir_or_class(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		switch (cmd->opcode) {
+		case MGMT_OP_ADD_UUID:
+		case MGMT_OP_REMOVE_UUID:
+		case MGMT_OP_SET_DEV_CLASS:
+		case MGMT_OP_SET_POWERED:
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static const u8 bluetooth_base_uuid[] = {
 			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
 			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -1367,7 +1390,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (pending_eir_or_class(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
 				 MGMT_STATUS_BUSY);
 		goto failed;
@@ -1439,7 +1462,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
+	if (pending_eir_or_class(hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
 				 MGMT_STATUS_BUSY);
 		goto unlock;
@@ -1515,15 +1538,19 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				  MGMT_STATUS_BUSY);
+	hci_dev_lock(hdev);
 
-	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				  MGMT_STATUS_INVALID_PARAMS);
+	if (pending_eir_or_class(hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
 
-	hci_dev_lock(hdev);
+	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				 MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
 
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
-- 
1.7.10.4

