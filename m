Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: Convert Pair Device to use cmd_complete callback
Date: Fri,  5 Dec 2014 13:36:04 +0200
Message-Id: <1417779369-6428-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
References: <1417779369-6428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the Pair Device mgmt command to use the new
cmd_complete callback for pending mgmt commands. The already existing
pairing_complete() function is exactly what's needed and doesn't need
changing.

In addition to getting the return parameters always right this patch
actually fixes a reference counting bug and memory leak with the
hci_conn that's attached to the pending mgmt command - something that
would occur when powering off or unplugging the adapter while pairing is
in progress.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0fc3d6914ef0..d3ee7285c303 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3129,7 +3129,7 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 
 	cmd = find_pairing(conn);
 	if (cmd)
-		pairing_complete(cmd, status);
+		cmd->cmd_complete(cmd, status);
 }
 
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3142,7 +3142,7 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!cmd)
 		BT_DBG("Unable to find a pending command");
 	else
-		pairing_complete(cmd, mgmt_status(status));
+		cmd->cmd_complete(cmd, mgmt_status(status));
 }
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3158,7 +3158,7 @@ static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!cmd)
 		BT_DBG("Unable to find a pending command");
 	else
-		pairing_complete(cmd, mgmt_status(status));
+		cmd->cmd_complete(cmd, mgmt_status(status));
 }
 
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3255,6 +3255,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	cmd->cmd_complete = pairing_complete;
+
 	/* For LE, just connecting isn't a proof that the pairing finished */
 	if (cp->addr.type == BDADDR_BREDR) {
 		conn->connect_cfm_cb = pairing_complete_cb;
-- 
2.1.0

