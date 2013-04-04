Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/17] Bluetooth: Rename LE_SCANNING_* macros
Date: Thu,  4 Apr 2013 20:21:02 -0300
Message-Id: <1365117675-2202-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames LE_SCANNING_ENABLED and LE_SCANNING_DISABLED
macros to LE_SCAN_ENABLE and LE_SCAN_DISABLE in order to keep
the same prefix others LE scan macros have.

It also fixes le_scan_enable_req function so it uses the LE_SCAN_
ENABLE macro instead of a magic number.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h | 4 ++--
 net/bluetooth/hci_core.c    | 2 +-
 net/bluetooth/hci_event.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 84c37ab..e0512aa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -996,8 +996,8 @@ struct hci_cp_le_set_scan_param {
 	__u8    filter_policy;
 } __packed;
 
-#define LE_SCANNING_DISABLED		0x00
-#define LE_SCANNING_ENABLED		0x01
+#define LE_SCAN_DISABLE			0x00
+#define LE_SCAN_ENABLE			0x01
 #define LE_SCAN_FILTER_DUP_DISABLE	0x00
 #define LE_SCAN_FILTER_DUP_ENABLE	0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9519ce0..43ea7e3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1874,7 +1874,7 @@ static void le_scan_enable_req(struct hci_request *req, unsigned long opt)
 	struct hci_cp_le_set_scan_enable cp;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.enable = 1;
+	cp.enable = LE_SCAN_ENABLE;
 	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7e7fbca..5daf37f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -968,7 +968,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	switch (cp->enable) {
-	case LE_SCANNING_ENABLED:
+	case LE_SCAN_ENABLE:
 		if (status) {
 			hci_dev_lock(hdev);
 			mgmt_start_discovery_failed(hdev, status);
@@ -983,7 +983,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		hci_dev_unlock(hdev);
 		break;
 
-	case LE_SCANNING_DISABLED:
+	case LE_SCAN_DISABLE:
 		if (status) {
 			hci_dev_lock(hdev);
 			mgmt_stop_discovery_failed(hdev, status);
-- 
1.8.1.2

