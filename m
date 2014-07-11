Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move HCI request internals to net/bluetooth/hci_core.c
Date: Fri, 11 Jul 2014 05:51:58 +0200
Message-Id: <1405050718-51197-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The internals of the HCI request framework should not be leaking to
its users. Move them all into net/bluetooth/hci_core.c and provide
a simple hci_req_pending helper function for the one user outside
the framework.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  9 +--------
 net/bluetooth/hci_core.c         | 14 ++++++++++++++
 net/bluetooth/hci_event.c        |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fffd0da2e0fc..b52c2ef3f56d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1240,6 +1240,7 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		    const void *param, u8 event);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+bool hci_req_pending(struct hci_dev *hdev);
 
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
@@ -1349,14 +1350,6 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
-/* ----- HCI requests ----- */
-#define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
-
-#define hci_req_lock(d)		mutex_lock(&d->req_lock)
-#define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
-
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb8eff8a6918..902233516664 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -54,6 +54,15 @@ DEFINE_RWLOCK(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
+/* ----- HCI requests ----- */
+
+#define HCI_REQ_DONE	  0
+#define HCI_REQ_PEND	  1
+#define HCI_REQ_CANCELED  2
+
+#define hci_req_lock(d)		mutex_lock(&d->req_lock)
+#define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
+
 /* ---- HCI notifications ---- */
 
 static void hci_notify(struct hci_dev *hdev, int event)
@@ -4432,6 +4441,11 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 	return 0;
 }
 
+bool hci_req_pending(struct hci_dev *hdev)
+{
+	return (hdev->req_status == HCI_REQ_PEND);
+}
+
 static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
 				       u32 plen, const void *param)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 591bb30f4887..daa63b14163d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4624,7 +4624,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Received events are (currently) only needed when a request is
 	 * ongoing so avoid unnecessary memory allocation.
 	 */
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (hci_req_pending(hdev)) {
 		kfree_skb(hdev->recv_evt);
 		hdev->recv_evt = skb_clone(skb, GFP_KERNEL);
 	}
-- 
1.9.3

