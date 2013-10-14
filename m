Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Convert Set Discoverable to use an asynchronous request
Date: Mon, 14 Oct 2013 21:15:27 +0300
Message-Id: <1381774527-13746-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
References: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts Set Discoverable to use an asynchronous request
along with its own completion callback. This is necessary for splitting
raw HCI socket use cases from mgmt, as well as for enabling the hooking
up of Advertising parameters together with the HCI_DISCOVERABLE flag
(coming in later patches).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0bad451..813012f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -935,11 +935,52 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 		return MGMT_STATUS_SUCCESS;
 }
 
+static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct pending_cmd *cmd;
+	struct mgmt_mode *cp;
+	bool changed;
+
+	BT_DBG("status 0x%02x", status);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
+	if (!cmd)
+		goto unlock;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		goto remove_cmd;
+	}
+
+	cp = cmd->param;
+	if (cp->val)
+		changed = !test_and_set_bit(HCI_DISCOVERABLE,
+					    &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_DISCOVERABLE,
+					     &hdev->dev_flags);
+
+	send_settings_rsp(cmd->sk, MGMT_OP_SET_DISCOVERABLE, hdev);
+
+	if (changed)
+		new_settings(hdev, cmd->sk);
+
+remove_cmd:
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
 	struct mgmt_cp_set_discoverable *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	u16 timeout;
 	u8 scan, status;
 	int err;
@@ -1021,6 +1062,8 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	hci_req_init(&req, hdev);
+
 	scan = SCAN_PAGE;
 
 	if (cp->val)
@@ -1028,7 +1071,9 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		cancel_delayed_work(&hdev->discov_off);
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+
+	err = hci_req_run(&req, set_discoverable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -4074,10 +4119,16 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 
 int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
-	struct cmd_lookup match = { NULL, hdev };
 	bool changed = false;
 	int err = 0;
 
+	/* Nothing needed here if there's a pending command since that
+	 * commands request completion callback takes care of everything
+	 * necessary.
+	 */
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+		return 0;
+
 	if (discoverable) {
 		if (!test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 			changed = true;
@@ -4086,14 +4137,8 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 			changed = true;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, settings_rsp,
-			     &match);
-
 	if (changed)
-		err = new_settings(hdev, match.sk);
-
-	if (match.sk)
-		sock_put(match.sk);
+		err = new_settings(hdev, NULL);
 
 	return err;
 }
-- 
1.8.3.1

