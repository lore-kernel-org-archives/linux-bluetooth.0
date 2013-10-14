Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Update Set Connectable to also impact the advertising type
Date: Mon, 14 Oct 2013 13:52:43 +0300
Message-Id: <1381747965-24599-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Set Connectable Management command to also update
the advertising type to either connectable or non-connectable
advertising. Extra care needs to be taken when BR/EDR is disabled since
then we need to have an extra flip of the HCI_CONNECTABLE flag in the
set_bredr() handler as well as an extra new_settings() call in the
request completion callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0200c7e..b8feb8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1115,6 +1115,9 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		goto unlock;
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		new_settings(hdev, cmd->sk);
+
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
 
 	mgmt_pending_remove(cmd);
@@ -1129,15 +1132,15 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
-	u8 scan, status;
+	u8 scan;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	status = mgmt_bredr_support(hdev);
-	if (status)
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				  status);
+				  MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
@@ -1208,6 +1211,14 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
 		write_fast_connectable(&req, false);
 
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
+	    hci_conn_num(hdev, LE_LINK) == 0) {
+		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+			change_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+		disable_advertising(&req);
+		enable_advertising(&req, cp->val);
+	}
+
 	err = hci_req_run(&req, set_connectable_complete);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
-- 
1.8.3.1

