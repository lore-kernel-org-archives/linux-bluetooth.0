Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59db4868.479e620a.fe1bd.2ebf@mx.google.com>
Date: Mon, 9 Oct 2017 15:30:36 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 2/3] Add and delete devices in the resolving list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Devices are added to the resolving list when IRKs are loaded
through mgmt API or when a peer IRK is received through the
SMP pairing procedure.A device is deleted from the resolving
list when it is upaired through mgmt API.

Copy of resolving list maintained by kernel is a sorted list.
When a connection or pairing is done for a device it is pushed
to the tail of the list. When a device is to to be deleted to
make space for new one, the LRU entry at the head is removed.

Signed-off-by: Shermin Joy <shermin.joy@gmail.com>
---
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_event.c        |   5 ++
 net/bluetooth/hci_request.c      | 166 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |   4 +
 net/bluetooth/mgmt.c             |  10 +++
 net/bluetooth/smp.c              |   4 +
 6 files changed, 192 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 65ba086..a52ca7e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1547,6 +1547,9 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
 
 void hci_clear_resolving_list(struct hci_dev *hdev);
+int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
+				  bdaddr_t *bdaddr, u8 irk[16]);
+void hci_load_resolving_list(struct hci_dev *hdev);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6252307..62d101a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2281,6 +2281,11 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	} else if (ev->link_type != ACL_LINK)
 		hci_connect_cfm(conn, ev->status);
 
+	/* If the device IRK is known, it has to be added
+	 * to the resolving list.
+	 */
+	hci_req_check_and_update_resolving_list(hdev, conn->type, &conn->dst);
+
 unlock:
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8bdc22b..347054d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -835,6 +835,172 @@ void hci_clear_resolving_list(struct hci_dev *hdev)
 	}
 }
 
+int hci_req_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				  bdaddr_t *bdaddr, u8 irk_val[16])
+{
+	struct hci_request req;
+	struct hci_cp_le_add_to_resolving_list cp;
+	struct hci_irk *irk;
+	u8 entries;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return -1;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if (hdev->le_ll_addr_resolve_enabled &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return -1;
+
+	hci_req_init(&req, hdev);
+
+	irk = hci_resolving_list_lookup(hdev, bdaddr, addr_type);
+	if (irk) {
+		/* Device is present in resolving list.*/
+		if (!memcmp(irk->val, irk_val, 16)) {
+			/* Device present in resolving list with same IRK.
+			 * No HCI communication is required.Sort the
+			 * Kernel list.
+			 */
+			hci_update_resolving_list(hdev, addr_type, bdaddr,
+						  irk->val);
+			return 0;
+		}
+
+		/* IRK has changed for the device in resolving list
+		 * Queue up commands to delete the existing entry and
+		 * add new one. Sorting will be done when command complete
+		 * for add command is receieved.
+		 */
+		goto remove_device;
+	}
+
+	/* Device is not present in resolving list.If resolving list
+	 * is not full add the device to resolving list.
+	 */
+	entries = 0;
+	list_for_each_entry(irk, &hdev->resolvinglist, list) {
+		entries++;
+	}
+
+	if (entries < hdev->le_resolving_list_size)
+		goto add_device;
+
+	/* If the resolving list is full, queue up HCI command to delete
+	 * the entry that was used least recently to make space for the
+	 * new device. Kernel list will be updated when command complete
+	 * is received.
+	 */
+	irk = list_first_entry_or_null(&hdev->resolvinglist,
+				       struct hci_irk, list);
+	if (!irk)
+		return -1;
+
+remove_device:
+	hci_req_del_from_resolving_list(hdev, irk->addr_type, &irk->bdaddr);
+
+add_device:
+	cp.peer_bdaddr_type = addr_type;
+	bacpy(&cp.peer_bdaddr, bdaddr);
+	memcpy(cp.peer_irk, irk, 16);
+	memcpy(cp.local_irk, hdev->irk, 16);
+
+	hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLVING_LIST, sizeof(cp), &cp);
+	hci_req_run(&req, NULL);
+	return 0;
+}
+
+void hci_req_check_and_update_resolving_list(struct hci_dev *hdev,
+					     u8 addr_type, bdaddr_t *bdaddr)
+{
+	struct smp_irk *irk;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if (hdev->le_ll_addr_resolve_enabled &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return;
+
+	irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
+	if (irk)
+		hci_req_update_resolving_list(hdev, irk->addr_type,
+					      &irk->bdaddr, irk->val);
+}
+
+void hci_load_resolving_list(struct hci_dev *hdev)
+{
+	struct smp_irk *irk;
+	u8 num = 0;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if (hdev->le_ll_addr_resolve_enabled &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return;
+
+	/* Load the first le_resolving_list_size entries from IRK
+	 * list in to resolving list.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (num++ >= hdev->le_resolving_list_size)
+			return;
+
+		hci_req_update_resolving_list(hdev, irk->addr_type,
+					      &irk->bdaddr, irk->val);
+	}
+	rcu_read_unlock();
+}
+
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				     bdaddr_t *bdaddr)
+{
+	struct hci_cp_le_del_from_resolving_list cp;
+	struct hci_request req;
+
+	/* Nothing to be done if LL privacy is not supported. */
+	if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
+		return;
+
+	/* Resolving List cannot be updated if address resolution
+	 * in the controller is enabled and advertisement or scanning
+	 * or create connection command is ongoing.
+	 */
+	if (hdev->le_ll_addr_resolve_enabled &&
+	    ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
+	    (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
+	    (hci_lookup_le_connect(hdev))))
+		return;
+
+	hci_req_init(&req, hdev);
+	cp.peer_bdaddr_type = addr_type;
+	bacpy(&cp.peer_bdaddr, bdaddr);
+
+	hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLVING_LIST, sizeof(cp), &cp);
+	hci_req_run(&req, NULL);
+}
+
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index ab4aac6..535716c 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -73,6 +73,10 @@ int hci_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
 int hci_delete_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
 				   bdaddr_t *bdaddr);
 void hci_clear_resolving_list(struct hci_dev *hdev);
+void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
+				     bdaddr_t *bdaddr);
+void hci_req_check_and_update_resolving_list(struct hci_dev *hdev,
+					     u8 addr_type, bdaddr_t *bdaddr);
 
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1fba2a0..7050528 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2300,6 +2300,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
 
+	hci_req_del_from_resolving_list(hdev, addr_type, &cp->addr.bdaddr);
+
 	err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	if (err < 0) {
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
@@ -4700,6 +4702,9 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			    BDADDR_ANY);
 	}
 
+	/* Load the resolving list with entries from IRK list.*/
+	hci_load_resolving_list(hdev);
+
 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
@@ -6652,6 +6657,11 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 	if (match.sk)
 		sock_put(match.sk);
 
+	/* If load _irk was called when controller was powered down,
+	 * then the resolving list has to be updated now.
+	 */
+	hci_load_resolving_list(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d41449b..94cb7fa 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2563,6 +2563,10 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
 				      smp->id_addr_type, smp->irk, &rpa);
 
+	/* Add the device to the resolving list.*/
+	hci_req_update_resolving_list(conn->hcon->hdev, smp->id_addr_type,
+				      &smp->id_addr, smp->irk);
+
 distribute:
 	if (!(smp->remote_key_dist & KEY_DIST_MASK))
 		smp_distribute_keys(smp);
-- 
1.9.1

