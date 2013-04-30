Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/14] Bluetooth: Make inquiry_cache_flush non-static
Date: Tue, 30 Apr 2013 15:29:27 -0300
Message-Id: <1367346580-6647-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to use HCI request framework in start_discovery, we'll need
to call inquiry_cache_flush in mgmt.c. Therefore, this patch adds the
hci_ prefix to inquiry_cache_flush and makes it non-static.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 35a57cd..1ff7f67 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -432,6 +432,7 @@ void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
 				      struct inquiry_entry *ie);
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 			      bool name_known, bool *ssp);
+void hci_inquiry_cache_flush(struct hci_dev *hdev);
 
 /* ----- HCI Connections ----- */
 enum {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 33843c5..8aefd17 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -746,7 +746,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	hdev->discovery.state = state;
 }
 
-static void inquiry_cache_flush(struct hci_dev *hdev)
+void hci_inquiry_cache_flush(struct hci_dev *hdev)
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *p, *n;
@@ -959,7 +959,7 @@ int hci_inquiry(void __user *arg)
 	hci_dev_lock(hdev);
 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
 	    inquiry_cache_empty(hdev) || ir.flags & IREQ_CACHE_FLUSH) {
-		inquiry_cache_flush(hdev);
+		hci_inquiry_cache_flush(hdev);
 		do_inquiry = 1;
 	}
 	hci_dev_unlock(hdev);
@@ -1225,7 +1225,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 
 	hci_dev_lock(hdev);
-	inquiry_cache_flush(hdev);
+	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
 	hci_dev_unlock(hdev);
 
@@ -1326,7 +1326,7 @@ int hci_dev_reset(__u16 dev)
 	skb_queue_purge(&hdev->cmd_q);
 
 	hci_dev_lock(hdev);
-	inquiry_cache_flush(hdev);
+	hci_inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
 	hci_dev_unlock(hdev);
 
@@ -3553,7 +3553,7 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		return -EINPROGRESS;
 
-	inquiry_cache_flush(hdev);
+	hci_inquiry_cache_flush(hdev);
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(&cp.lap, lap, sizeof(cp.lap));
-- 
1.8.2.1

