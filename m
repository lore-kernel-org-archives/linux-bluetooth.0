Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Run page scan updates through hdev->req_workqueue
Date: Tue, 24 Nov 2015 14:02:01 +0200
Message-Id: <1448366527-29714-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
References: <1448366527-29714-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since Add/Remove Device perform the page scan updates independently
from the HCI command completion we've introduced a potential race when
multiple mgmt commands are queued. Doing the page scan updates through
the req_workqueue ensures that the state changes are performed in a
race-free manner.

At the same time, to make the request helper more widely usable,
extend it to also cover Inquiry Scan changes since those are behind
the same HCI command. This is also reflected in the new name of the
API as well as the work struct name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/hci_request.c      | 27 ++++++++++++++++++---------
 net/bluetooth/hci_request.h      |  8 ++++++--
 net/bluetooth/mgmt.c             | 16 ++++++++--------
 5 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 55ce209157b1..eda809a5c3df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -329,6 +329,7 @@ struct hci_dev {
 
 	struct work_struct	discov_update;
 	struct work_struct	bg_scan_update;
+	struct work_struct	scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d57c11c1c6b5..703e37f1a955 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2176,7 +2176,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
 
-			hci_update_page_scan(hdev);
+			hci_req_update_scan(hdev);
 		}
 
 		/* Set packet type for incoming connection */
@@ -2362,7 +2362,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 
-		hci_update_page_scan(hdev);
+		hci_req_update_scan(hdev);
 	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e639671f54bd..78c026b4ffa1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -637,7 +637,7 @@ static bool disconnected_whitelist_entries(struct hci_dev *hdev)
 	return false;
 }
 
-void __hci_update_page_scan(struct hci_request *req)
+void __hci_req_update_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 scan;
@@ -657,22 +657,29 @@ void __hci_update_page_scan(struct hci_request *req)
 	else
 		scan = SCAN_DISABLED;
 
-	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
-		return;
-
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		scan |= SCAN_INQUIRY;
 
+	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE) &&
+	    test_bit(HCI_ISCAN, &hdev->flags) == !!(scan & SCAN_INQUIRY))
+		return;
+
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-void hci_update_page_scan(struct hci_dev *hdev)
+static int update_scan(struct hci_request *req, unsigned long opt)
 {
-	struct hci_request req;
+	hci_dev_lock(req->hdev);
+	__hci_req_update_scan(req);
+	hci_dev_unlock(req->hdev);
+	return 0;
+}
 
-	hci_req_init(&req, hdev);
-	__hci_update_page_scan(&req);
-	hci_req_run(&req, NULL);
+static void scan_update_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, scan_update);
+
+	hci_req_sync(hdev, update_scan, 0, HCI_CMD_TIMEOUT, NULL);
 }
 
 /* This function controls the background scanning based on hdev->pend_le_conns
@@ -1270,6 +1277,7 @@ void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->discov_update, discov_update);
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
+	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 }
@@ -1280,6 +1288,7 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->bg_scan_update);
+	cancel_work_sync(&hdev->scan_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 6b9e59f7f7a9..cc8275520fb2 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -61,8 +61,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req);
 /* Returns true if HCI commands were queued */
 bool hci_req_stop_discovery(struct hci_request *req);
 
-void hci_update_page_scan(struct hci_dev *hdev);
-void __hci_update_page_scan(struct hci_request *req);
+static inline void hci_req_update_scan(struct hci_dev *hdev)
+{
+	queue_work(hdev->req_workqueue, &hdev->scan_update);
+}
+
+void __hci_req_update_scan(struct hci_request *req);
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3d9d2e4839c5..0d20e1328528 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1810,7 +1810,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 	 * entries.
 	 */
 	hci_req_init(&req, hdev);
-	__hci_update_page_scan(&req);
+	__hci_req_update_scan(&req);
 	update_class(&req);
 	hci_req_run(&req, NULL);
 
@@ -2058,7 +2058,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	if (conn_changed || discov_changed) {
 		new_settings(hdev, cmd->sk);
-		hci_update_page_scan(hdev);
+		hci_req_update_scan(hdev);
 		if (discov_changed)
 			mgmt_update_adv_data(hdev);
 		hci_update_background_scan(hdev);
@@ -2092,7 +2092,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		return err;
 
 	if (changed) {
-		hci_update_page_scan(hdev);
+		hci_req_update_scan(hdev);
 		hci_update_background_scan(hdev);
 		return new_settings(hdev, sk);
 	}
@@ -5041,7 +5041,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	hci_req_init(&req, hdev);
 
 	write_fast_connectable(&req, false);
-	__hci_update_page_scan(&req);
+	__hci_req_update_scan(&req);
 
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
@@ -5927,7 +5927,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_update_page_scan(hdev);
+		hci_req_update_scan(hdev);
 
 		goto added;
 	}
@@ -6024,7 +6024,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			hci_update_page_scan(hdev);
+			hci_req_update_scan(hdev);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -6089,7 +6089,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_update_page_scan(hdev);
+		hci_req_update_scan(hdev);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -7397,7 +7397,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 			write_fast_connectable(&req, true);
 		else
 			write_fast_connectable(&req, false);
-		__hci_update_page_scan(&req);
+		__hci_req_update_scan(&req);
 		update_class(&req);
 		update_name(&req);
 		update_eir(&req);
-- 
2.5.0

