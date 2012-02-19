Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: mgmt: Fix Pair Device response status values
Date: Sun, 19 Feb 2012 13:54:26 +0200
Message-Id: <1329652469-28973-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the status in Pair Device responses to follow proper
mgmt status values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 61d0250..79255f5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1728,7 +1728,7 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!cmd)
 		BT_DBG("Unable to find a pending command");
 	else
-		pairing_complete(cmd, status);
+		pairing_complete(cmd, mgmt_status(status));
 }
 
 static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
@@ -1739,7 +1739,6 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	struct pending_cmd *cmd;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
-	u8 status = 0;
 	int err;
 
 	BT_DBG("");
@@ -1773,17 +1772,16 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	rp.addr.type = cp->addr.type;
 
 	if (IS_ERR(conn)) {
-		status = -PTR_ERR(conn);
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE, status,
-							&rp, sizeof(rp));
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+						MGMT_STATUS_CONNECT_FAILED,
+						&rp, sizeof(rp));
 		goto unlock;
 	}
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_put(conn);
-		status = EBUSY;
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE, status,
-							&rp, sizeof(rp));
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
 	}
 
-- 
1.7.9

