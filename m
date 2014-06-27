Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Fix missing hdev locking in smp_cmd_ident_addr_info
Date: Fri, 27 Jun 2014 14:23:02 +0300
Message-Id: <1403868187-19396-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hdev lock must be held before calling into smp_distribute_keys. Also
things such as hci_add_irk() require the lock. This patch fixes the
issue by adding the necessary locking into the smp_cmd_ident_addr_info
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 976fce2315fd..a38941593e8b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1076,6 +1076,8 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 
 	skb_pull(skb, sizeof(*info));
 
+	hci_dev_lock(hcon->hdev);
+
 	/* Strictly speaking the Core Specification (4.1) allows sending
 	 * an empty address which would force us to rely on just the IRK
 	 * as "identity information". However, since such
@@ -1085,8 +1087,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	 */
 	if (!bacmp(&info->bdaddr, BDADDR_ANY)) {
 		BT_ERR("Ignoring IRK with no identity address");
-		smp_distribute_keys(conn);
-		return 0;
+		goto distribute;
 	}
 
 	bacpy(&smp->id_addr, &info->bdaddr);
@@ -1100,8 +1101,11 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
 				      smp->id_addr_type, smp->irk, &rpa);
 
+distribute:
 	smp_distribute_keys(conn);
 
+	hci_dev_unlock(hcon->hdev);
+
 	return 0;
 }
 
-- 
1.9.3

