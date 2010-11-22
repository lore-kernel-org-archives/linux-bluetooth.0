Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: do not use assignment in if condition
Date: Mon, 22 Nov 2010 13:21:37 +0200
Message-Id: <1290424897-32463-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Fix checkpatch errors like:
"ERROR: do not use assignment in if condition"
Simplify code and fix one long line.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/hci_event.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4165895..3c1957c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -996,12 +996,14 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 		hci_dev_lock(hdev);
 
-		if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr)))
+		ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+		if (ie)
 			memcpy(ie->data.dev_class, ev->dev_class, 3);
 
 		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
-			if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
+			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
+			if (!conn) {
 				BT_ERR("No memory for new connection");
 				hci_dev_unlock(hdev);
 				return;
@@ -1608,7 +1610,8 @@ static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *sk
 	if (conn && !ev->status) {
 		struct inquiry_entry *ie;
 
-		if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst))) {
+		ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+		if (ie) {
 			ie->data.clock_offset = ev->clock_offset;
 			ie->timestamp = jiffies;
 		}
@@ -1642,7 +1645,8 @@ static inline void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr))) {
+	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+	if (ie) {
 		ie->data.pscan_rep_mode = ev->pscan_rep_mode;
 		ie->timestamp = jiffies;
 	}
@@ -1713,7 +1717,8 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 	if (!ev->status && ev->page == 0x01) {
 		struct inquiry_entry *ie;
 
-		if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst)))
+		ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+		if (ie)
 			ie->data.ssp_mode = (ev->features[0] & 0x01);
 
 		conn->ssp_mode = (ev->features[0] & 0x01);
@@ -1886,7 +1891,8 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
 
 	hci_dev_lock(hdev);
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr)))
+	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+	if (ie)
 		ie->data.ssp_mode = (ev->features[0] & 0x01);
 
 	hci_dev_unlock(hdev);
-- 
1.7.1

