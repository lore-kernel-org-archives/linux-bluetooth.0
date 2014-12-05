Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Convert Get Clock Info to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:07 +0200
Message-Id: <1417779369-6428-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the Get Clock Information mgmt command to take
advantage of the new cmd_complete callback for pending commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 59 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ddaeebbccfba..8467d3552aa9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5287,10 +5287,40 @@ unlock:
 	return err;
 }
 
-static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
+static void clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	struct mgmt_cp_get_clock_info *cp;
+	struct hci_conn *conn = cmd->user_data;
 	struct mgmt_rp_get_clock_info rp;
+	struct hci_dev *hdev;
+
+	memset(&rp, 0, sizeof(rp));
+	memcpy(&rp.addr, &cmd->param, sizeof(rp.addr));
+
+	if (status)
+		goto complete;
+
+	hdev = hci_dev_get(cmd->index);
+	if (hdev) {
+		rp.local_clock = cpu_to_le32(hdev->clock);
+		hci_dev_put(hdev);
+	}
+
+	if (conn) {
+		rp.piconet_clock = cpu_to_le32(conn->clock);
+		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
+	}
+
+complete:
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp, sizeof(rp));
+
+	if (conn) {
+		hci_conn_drop(conn);
+		hci_conn_put(conn);
+	}
+}
+
+static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
+{
 	struct hci_cp_read_clock *hci_cp;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
@@ -5314,29 +5344,8 @@ static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		goto unlock;
 
-	cp = cmd->param;
-
-	memset(&rp, 0, sizeof(rp));
-	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
-
-	if (status)
-		goto send_rsp;
-
-	rp.local_clock = cpu_to_le32(hdev->clock);
-
-	if (conn) {
-		rp.piconet_clock = cpu_to_le32(conn->clock);
-		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
-	}
-
-send_rsp:
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
-		     &rp, sizeof(rp));
+	cmd->cmd_complete(cmd, mgmt_status(status));
 	mgmt_pending_remove(cmd);
-	if (conn) {
-		hci_conn_drop(conn);
-		hci_conn_put(conn);
-	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5392,6 +5401,8 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	cmd->cmd_complete = clock_info_cmd_complete;
+
 	hci_req_init(&req, hdev);
 
 	memset(&hci_cp, 0, sizeof(hci_cp));
-- 
2.1.0

