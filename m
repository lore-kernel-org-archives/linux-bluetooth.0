Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix incorrect removing of IRKs
Date: Tue, 26 Jan 2016 11:51:49 -0500
Message-Id: <1453827109-29431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The commit cad20c278085d893ebd616cd20c0747a8e9d53c7 was supposed to
fix handling of devices first using public addresses and then
switching to RPAs after pairing. Unfortunately it missed a couple of
key places in the code.

1. When evaluating which devices should be removed from the existing
white list we also need to consider whether we have an IRK for them or
not, i.e. a call to hci_find_irk_by_addr() is needed.

2. In smp_notify_keys() we should not be requiring the knowledge of
the RPA, but should simply keep the IRK around if the other conditions
require it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 4.4+
---
 net/bluetooth/hci_request.c | 39 ++++++++++++++++++++++++++++-----------
 net/bluetooth/smp.c         | 16 ----------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 41b5f3813f02..e86cac02ed7a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -674,6 +674,16 @@ static void add_to_white_list(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
 }
 
+static void del_from_white_list(struct hci_request *req, struct bdaddr_list *b)
+{
+	struct hci_cp_le_del_from_white_list cp;
+
+	cp.bdaddr_type = b->bdaddr_type;
+	bacpy(&cp.bdaddr, &b->bdaddr);
+
+	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
+}
+
 static u8 update_white_list(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -688,21 +698,28 @@ static u8 update_white_list(struct hci_request *req)
 	 * command to remove it from the controller.
 	 */
 	list_for_each_entry(b, &hdev->le_white_list, list) {
-		struct hci_cp_le_del_from_white_list cp;
-
-		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					      &b->bdaddr, b->bdaddr_type) ||
-		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					      &b->bdaddr, b->bdaddr_type)) {
-			white_list_entries++;
+		/* If the device not found in pend_le_conns or
+		 * pend_le_reports remove it from the whitelist.
+		 */
+		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					       &b->bdaddr, b->bdaddr_type) &&
+		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					       &b->bdaddr, b->bdaddr_type)) {
+			del_from_white_list(req, b);
 			continue;
 		}
 
-		cp.bdaddr_type = b->bdaddr_type;
-		bacpy(&cp.bdaddr, &b->bdaddr);
+		/* If the device was found in the above lists but we
+		 * have an IRK for it, also remove it from the list
+		 * since it'll likely be using an RPA now.
+		 */
+		if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
+			del_from_white_list(req, b);
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
 
-		hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST,
-			    sizeof(cp), &cp);
+		white_list_entries++;
 	}
 
 	/* Since all no longer valid white list entries have been
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ffed8a1d4f27..4b175df35184 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1072,22 +1072,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 			hcon->dst_type = smp->remote_irk->addr_type;
 			queue_work(hdev->workqueue, &conn->id_addr_update_work);
 		}
-
-		/* When receiving an indentity resolving key for
-		 * a remote device that does not use a resolvable
-		 * private address, just remove the key so that
-		 * it is possible to use the controller white
-		 * list for scanning.
-		 *
-		 * Userspace will have been told to not store
-		 * this key at this point. So it is safe to
-		 * just remove it.
-		 */
-		if (!bacmp(&smp->remote_irk->rpa, BDADDR_ANY)) {
-			list_del_rcu(&smp->remote_irk->list);
-			kfree_rcu(smp->remote_irk, rcu);
-			smp->remote_irk = NULL;
-		}
 	}
 
 	if (smp->csrk) {
-- 
2.5.0

