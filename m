Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use macros for connectionless slave broadcast features
Date: Sun,  8 Dec 2013 11:55:33 -0800
Message-Id: <1386532533-48770-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the LMP feature constants for connectionless slave broadcast
and use them for capability testing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      | 6 ++++++
 include/net/bluetooth/hci_core.h | 6 ++++++
 net/bluetooth/hci_core.c         | 6 +++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1784c48699f0..cc2da73055fa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -275,6 +275,12 @@ enum {
 #define LMP_EXTFEATURES	0x80
 
 /* Extended LMP features */
+#define LMP_CSB_MASTER	0x01
+#define LMP_CSB_SLAVE	0x02
+#define LMP_SYNC_TRAIN	0x04
+#define LMP_SYNC_SCAN	0x08
+
+/* Host features */
 #define LMP_HOST_SSP		0x01
 #define LMP_HOST_LE		0x02
 #define LMP_HOST_LE_BREDR	0x04
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f8555ad7b104..b796161fb04e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -798,6 +798,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_transp_capable(dev)    ((dev)->features[0][2] & LMP_TRANSPARENT)
 
 /* ----- Extended LMP capabilities ----- */
+#define lmp_csb_master_capable(dev) ((dev)->features[2][0] & LMP_CSB_MASTER)
+#define lmp_csb_slave_capable(dev)  ((dev)->features[2][0] & LMP_CSB_SLAVE)
+#define lmp_sync_train_capable(dev) ((dev)->features[2][0] & LMP_SYNC_TRAIN)
+#define lmp_sync_scan_capable(dev)  ((dev)->features[2][0] & LMP_SYNC_SCAN)
+
+/* ----- Host capabilities ----- */
 #define lmp_host_ssp_capable(dev)  ((dev)->features[1][0] & LMP_HOST_SSP)
 #define lmp_host_le_capable(dev)   (!!((dev)->features[1][0] & LMP_HOST_LE))
 #define lmp_host_le_br_capable(dev) (!!((dev)->features[1][0] & LMP_HOST_LE_BREDR))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 03e83558a411..8b8b5f80dd89 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1228,7 +1228,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 	/* If Connectionless Slave Broadcast master role is supported
 	 * enable all necessary events for it.
 	 */
-	if (hdev->features[2][0] & 0x01) {
+	if (lmp_csb_master_capable(hdev)) {
 		events[1] |= 0x40;	/* Triggered Clock Capture */
 		events[1] |= 0x80;	/* Synchronization Train Complete */
 		events[2] |= 0x10;	/* Slave Page Response Timeout */
@@ -1238,7 +1238,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 	/* If Connectionless Slave Broadcast slave role is supported
 	 * enable all necessary events for it.
 	 */
-	if (hdev->features[2][0] & 0x02) {
+	if (lmp_csb_slave_capable(hdev)) {
 		events[2] |= 0x01;	/* Synchronization Train Received */
 		events[2] |= 0x02;	/* CSB Receive */
 		events[2] |= 0x04;	/* CSB Timeout */
@@ -1309,7 +1309,7 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_set_event_mask_page_2(req);
 
 	/* Check for Synchronization Train support */
-	if (hdev->features[2][0] & 0x04)
+	if (lmp_sync_train_capable(hdev))
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
 }
 
-- 
1.8.3.1

