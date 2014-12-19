Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Split hci_update_page_scan into two functions
Date: Fri, 19 Dec 2014 13:40:19 +0200
Message-Id: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To keep the parameter list and its semantics clear it makes sense to
split the hci_update_page_scan function into two separate functions: one
taking a hci_dev and another taking a hci_request. The one taking a
hci_dev constructs its own hci_request and then calls the other
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 17 ++++++++++++-----
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/mgmt.c             | 16 ++++++++--------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3c7827005c25..664451a64d72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1306,7 +1306,8 @@ bool hci_req_pending(struct hci_dev *hdev);
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
-void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req);
+void hci_update_page_scan(struct hci_dev *hdev);
+void __hci_update_page_scan(struct hci_request *req);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5dcacf9607e4..3aa9015a8858 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5787,8 +5787,9 @@ static bool disconnected_whitelist_entries(struct hci_dev *hdev)
 	return false;
 }
 
-void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req)
+void __hci_update_page_scan(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	u8 scan;
 
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
@@ -5812,8 +5813,14 @@ void hci_update_page_scan(struct hci_dev *hdev, struct hci_request *req)
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		scan |= SCAN_INQUIRY;
 
-	if (req)
-		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-	else
-		hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
+void hci_update_page_scan(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+	__hci_update_page_scan(&req);
+	hci_req_run(&req, NULL);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 39a5c8a01726..65f4ec8945a4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2127,7 +2127,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
 
-			hci_update_page_scan(hdev, NULL);
+			hci_update_page_scan(hdev);
 		}
 
 		/* Set packet type for incoming connection */
@@ -2308,7 +2308,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev);
 	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 693ce8bcd06e..f86f3ec684ba 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1566,7 +1566,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	 * entries.
 	 */
 	hci_req_init(&req, hdev);
-	hci_update_page_scan(hdev, &req);
+	__hci_update_page_scan(&req);
 	update_class(&req);
 	hci_req_run(&req, NULL);
 
@@ -1813,7 +1813,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 
 	if (conn_changed || discov_changed) {
 		new_settings(hdev, cmd->sk);
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev);
 		if (discov_changed)
 			mgmt_update_adv_data(hdev);
 		hci_update_background_scan(hdev);
@@ -1847,7 +1847,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		return err;
 
 	if (changed) {
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev);
 		hci_update_background_scan(hdev);
 		return new_settings(hdev, sk);
 	}
@@ -4697,7 +4697,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	hci_req_init(&req, hdev);
 
 	write_fast_connectable(&req, false);
-	hci_update_page_scan(hdev, &req);
+	__hci_update_page_scan(&req);
 
 	/* Since only the advertising data flags will change, there
 	 * is no need to update the scan response data.
@@ -5473,7 +5473,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev);
 
 		goto added;
 	}
@@ -5556,7 +5556,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			hci_update_page_scan(hdev, NULL);
+			hci_update_page_scan(hdev);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -5607,7 +5607,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_update_page_scan(hdev, NULL);
+		hci_update_page_scan(hdev);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
@@ -6139,7 +6139,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 
 	if (lmp_bredr_capable(hdev)) {
 		write_fast_connectable(&req, false);
-		hci_update_page_scan(hdev, &req);
+		__hci_update_page_scan(&req);
 		update_class(&req);
 		update_name(&req);
 		update_eir(&req);
-- 
2.1.0

