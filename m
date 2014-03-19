Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Pair Device response parameters for pairing failure
Date: Wed, 19 Mar 2014 17:00:49 +0200
Message-Id: <1395241249-8235-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It is possible that pairing fails after we've already received remote
identity information. One example of such a situation is when
re-encryption using the LTK fails. In this case the hci_conn object has
already been updated with the identity address but user space does not
yet know about it (since we didn't notify it of the new IRK yet).

To ensure user space doesn't get a Pair Device command response with an
unknown address always use the same address in the response as was used
for the original command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 75df93679276..96670f581bb0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2762,11 +2762,23 @@ static struct pending_cmd *find_pairing(struct hci_conn *conn)
 
 static void pairing_complete(struct pending_cmd *cmd, u8 status)
 {
+	const struct mgmt_cp_pair_device *cp = cmd->param;
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
 
-	bacpy(&rp.addr.bdaddr, &conn->dst);
-	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	/* If we had a pairing failure we might have already received
+	 * the remote Identity Address Information and updated the
+	 * hci_conn variables with it, however we would not yet have
+	 * notified user space of the resolved identity. Therefore, use
+	 * the address given in the Pair Device command in case the
+	 * pairing failed.
+	 */
+	if (status) {
+		memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
+	} else {
+		bacpy(&rp.addr.bdaddr, &conn->dst);
+		rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	}
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
-- 
1.8.5.3

