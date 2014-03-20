Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix address value for early disconnection events
Date: Thu, 20 Mar 2014 11:47:45 +0200
Message-Id: <1395308865-27200-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to ensure that we do not send events to user space with the
identity address if we have not yet notified user space of the IRK. The
code was previously trying to handle this for the mgmt_pair_device
response (which worked well enough) but this is not the only connection
related event that might be sent to user space before pairing is
successful: another important event is Device Disconnected.

The issue can actually be solved more simply than the solution
previously used for mgmt_pair_device. Since we do have the identity
address tracked as part of the remote IRK struct we can just copy it
over from there to the hci_conn struct once we've for real sent the mgmt
event for the new IRK.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 16 ++--------------
 net/bluetooth/smp.c  | 13 ++++++++-----
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 739887c6b286..d2d4e0d5aed0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2762,23 +2762,11 @@ static struct pending_cmd *find_pairing(struct hci_conn *conn)
 
 static void pairing_complete(struct pending_cmd *cmd, u8 status)
 {
-	const struct mgmt_cp_pair_device *cp = cmd->param;
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
 
-	/* If we had a pairing failure we might have already received
-	 * the remote Identity Address Information and updated the
-	 * hci_conn variables with it, however we would not yet have
-	 * notified user space of the resolved identity. Therefore, use
-	 * the address given in the Pair Device command in case the
-	 * pairing failed.
-	 */
-	if (status) {
-		memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
-	} else {
-		bacpy(&rp.addr.bdaddr, &conn->dst);
-		rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
-	}
+	bacpy(&rp.addr.bdaddr, &conn->dst);
+	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 13919ff82e05..8604e073b134 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1058,10 +1058,6 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
 				      smp->id_addr_type, smp->irk, &rpa);
 
-	/* Track the connection based on the Identity Address from now on */
-	bacpy(&hcon->dst, &smp->id_addr);
-	hcon->dst_type = smp->id_addr_type;
-
 	l2cap_conn_update_id_addr(hcon);
 
 	smp_distribute_keys(conn);
@@ -1214,8 +1210,15 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
 	bool persistent;
 
-	if (smp->remote_irk)
+	if (smp->remote_irk) {
 		mgmt_new_irk(hdev, smp->remote_irk);
+		/* Now that user space can be considered to know the
+		 * identity address track the connection based on it
+		 * from now on.
+		 */
+		bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
+		hcon->dst_type = smp->remote_irk->addr_type;
+	}
 
 	/* The LTKs and CSRKs should be persistent only if both sides
 	 * had the bonding bit set in their authentication requests.
-- 
1.8.5.3

