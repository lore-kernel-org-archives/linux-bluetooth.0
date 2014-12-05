Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: Add callback to create proper cmd_complete events
Date: Fri,  5 Dec 2014 13:36:00 +0200
Message-Id: <1417779369-6428-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We've got a couple of generic scenarios where all pending mgmt commands
are processed and responses are sent to them. These scenarios are
powering off the adapter and removing the adapter. So far the code has
been generating cmd_status responses with NOT_POWERED and INVALID_INDEX
resposes respectively, but this violates the mgmt specification for
commands that should always generate a cmd_complete.

This patch adds support for specifying a callback for the pending_cmd
context that each command handler can use for command-specific
cmd_complete event generation. The actual per-command event generators
will come in subsequent patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74571a4b85ec..98537b07b720 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -137,6 +137,7 @@ struct pending_cmd {
 	void *param;
 	struct sock *sk;
 	void *user_data;
+	void (*cmd_complete)(struct pending_cmd *cmd, u8 status);
 };
 
 /* HCI to MGMT error code conversion table */
@@ -1471,6 +1472,20 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
+static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
+{
+	if (cmd->cmd_complete) {
+		u8 *status = data;
+
+		cmd->cmd_complete(cmd, *status);
+		mgmt_pending_remove(cmd);
+
+		return;
+	}
+
+	cmd_status_rsp(cmd, data);
+}
+
 static u8 mgmt_bredr_support(struct hci_dev *hdev)
 {
 	if (!lmp_bredr_capable(hdev))
@@ -5976,7 +5991,7 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
 
 	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 		mgmt_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0, NULL);
@@ -6111,7 +6126,7 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
-	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status_not_powered);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status_not_powered);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0)
 		mgmt_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-- 
2.1.0

