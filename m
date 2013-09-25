Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/7] Bluetooth: Move mgmt response convenience functions to a better location
Date: Wed, 25 Sep 2013 13:26:07 +0300
Message-Id: <1380104770-8022-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The settings_rsp and cmd_status_rsp functions can be useful for all mgmt
command handlers when asynchronous request callbacks are used. They will
e.g. be used by subsequent patches to change set_le to use an async
request as well as a new set_advertising command. Therefore, move them
higher up in the mgmt.c file to avoid unnecessary forward declarations
or mixing this trivial change with other patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 60 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 85bfa21..61d4b19 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -886,6 +886,36 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
 }
 
+struct cmd_lookup {
+	struct sock *sk;
+	struct hci_dev *hdev;
+	u8 mgmt_status;
+};
+
+static void settings_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct cmd_lookup *match = data;
+
+	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
+
+	list_del(&cmd->list);
+
+	if (match->sk == NULL) {
+		match->sk = cmd->sk;
+		sock_hold(match->sk);
+	}
+
+	mgmt_pending_free(cmd);
+}
+
+static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
+{
+	u8 *status = data;
+
+	cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
+	mgmt_pending_remove(cmd);
+}
+
 static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
@@ -3374,14 +3404,6 @@ done:
 	return err;
 }
 
-static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
-{
-	u8 *status = data;
-
-	cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
-	mgmt_pending_remove(cmd);
-}
-
 int mgmt_index_added(struct hci_dev *hdev)
 {
 	if (!mgmt_valid_hdev(hdev))
@@ -3402,28 +3424,6 @@ int mgmt_index_removed(struct hci_dev *hdev)
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
-struct cmd_lookup {
-	struct sock *sk;
-	struct hci_dev *hdev;
-	u8 mgmt_status;
-};
-
-static void settings_rsp(struct pending_cmd *cmd, void *data)
-{
-	struct cmd_lookup *match = data;
-
-	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
-
-	list_del(&cmd->list);
-
-	if (match->sk == NULL) {
-		match->sk = cmd->sk;
-		sock_hold(match->sk);
-	}
-
-	mgmt_pending_free(cmd);
-}
-
 static void set_bredr_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
-- 
1.8.3.1

