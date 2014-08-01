Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Create unified helper function for updating page scan
Date: Fri,  1 Aug 2014 11:13:31 +0300
Message-Id: <1406880812-19731-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
References: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Similar to our hci_update_background_scan() function we can simplify a
lot of code by creating a unified helper function for doing page scan
updates. This patch adds such a function to hci_core.c and updates all
the relevant places to use it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++
 net/bluetooth/mgmt.c             | 72 +++++++---------------------------------
 3 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8394abc4fd87..cc2eb7730fbc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -968,6 +968,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
 #define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
 
+#define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
+				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1256,6 +1259,8 @@ bool hci_req_pending(struct hci_dev *hdev);
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
+void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req);
+
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 32b96f1aaf42..e3f42c80070e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5686,3 +5686,34 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (err)
 		BT_ERR("Failed to run HCI request: err %d", err);
 }
+
+void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req)
+{
+	u8 scan;
+
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (mgmt_powering_down(hdev))
+		return;
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
+	    !list_empty(&hdev->whitelist))
+		scan = SCAN_PAGE;
+	else
+		scan = SCAN_DISABLED;
+
+	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
+		return;
+
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	if (req)
+		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	else
+		hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c9de0d9945f5..c2457435a670 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -129,9 +129,6 @@ static const u16 mgmt_events[] = {
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
-#define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
-				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-
 struct pending_cmd {
 	struct list_head list;
 	u16 opcode;
@@ -1536,9 +1533,11 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 
 	/* When the discoverable mode gets changed, make sure
 	 * that class of device has the limited discoverable
-	 * bit correctly set.
+	 * bit correctly set. Also update page scan based on whitelist
+	 * entries.
 	 */
 	hci_req_init(&req, hdev);
+	hci_update_page_scan(hdev, &req);
 	update_class(&req);
 	hci_req_run(&req, NULL);
 
@@ -1785,6 +1784,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 
 	if (conn_changed || discov_changed) {
 		new_settings(hdev, cmd->sk);
+		hci_update_page_scan(hdev, NULL);
 		if (discov_changed)
 			mgmt_update_adv_data(hdev);
 		hci_update_background_scan(hdev);
@@ -1818,6 +1818,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		return err;
 
 	if (changed) {
+		hci_update_page_scan(hdev, NULL);
 		hci_update_background_scan(hdev);
 		return new_settings(hdev, sk);
 	}
@@ -4381,27 +4382,6 @@ unlock:
 	return err;
 }
 
-static void set_bredr_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 scan = 0;
-
-	/* Ensure that fast connectable is disabled. This function will
-	 * not do anything if the page scan parameters are already what
-	 * they should be.
-	 */
-	write_fast_connectable(req, false);
-
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
-	    !list_empty(&hdev->whitelist))
-		scan |= SCAN_PAGE;
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-		scan |= SCAN_INQUIRY;
-
-	if (scan)
-		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
 static void set_bredr_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -4507,9 +4487,8 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) ||
-	    !list_empty(&hdev->whitelist))
-		set_bredr_scan(&req);
+	write_fast_connectable(&req, false);
+	hci_update_page_scan(hdev, &req);
 
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
@@ -5235,27 +5214,6 @@ unlock:
 	return err;
 }
 
-/* Helper for Add/Remove Device commands */
-static void update_page_scan(struct hci_dev *hdev, u8 scan)
-{
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return;
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	/* If HCI_CONNECTABLE is set then Add/Remove Device should not
-	 * make any changes to page scanning.
-	 */
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		return;
-
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-		scan |= SCAN_INQUIRY;
-
-	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
 static void device_added(struct sock *sk, struct hci_dev *hdev,
 			 bdaddr_t *bdaddr, u8 type, u8 action)
 {
@@ -5291,8 +5249,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->addr.type == BDADDR_BREDR) {
-		bool update_scan;
-
 		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
@@ -5301,15 +5257,12 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		update_scan = list_empty(&hdev->whitelist);
-
 		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
 					  cp->addr.type);
 		if (err)
 			goto unlock;
 
-		if (update_scan)
-			update_page_scan(hdev, SCAN_PAGE);
+		hci_update_page_scan(hdev, NULL);
 
 		goto added;
 	}
@@ -5392,8 +5345,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			if (list_empty(&hdev->whitelist))
-				update_page_scan(hdev, SCAN_DISABLED);
+			hci_update_page_scan(hdev, NULL);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -5444,7 +5396,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		update_page_scan(hdev, SCAN_DISABLED);
+		hci_update_page_scan(hdev, NULL);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -5969,8 +5921,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 			    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-			set_bredr_scan(&req);
+		write_fast_connectable(&req, false);
+		hci_update_page_scan(hdev, &req);
 		update_class(&req);
 		update_name(&req);
 		update_eir(&req);
-- 
1.9.3

