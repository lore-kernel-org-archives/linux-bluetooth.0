Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Remove duplicate definitions for advertising event types
Date: Wed, 16 Oct 2013 00:16:51 -0700
Message-Id: <1381907811-33872-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The constants for advertising event types have been defined twice. So
remove one copy of it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aca8944..c8bc7bf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1063,11 +1063,6 @@ struct hci_rp_le_read_local_features {
 
 #define HCI_OP_LE_SET_RANDOM_ADDR	0x2005
 
-#define LE_ADV_IND			0x00
-#define LE_ADV_DIRECT_IND		0x01
-#define LE_ADV_SCAN_IND			0x02
-#define LE_ADV_NONCONN_IND		0x03
-
 #define HCI_OP_LE_SET_ADV_PARAM		0x2006
 struct hci_cp_le_set_adv_param {
 	__le16   min_interval;
@@ -1580,11 +1575,11 @@ struct hci_ev_le_ltk_req {
 } __packed;
 
 /* Advertising report event types */
-#define ADV_IND		0x00
-#define ADV_DIRECT_IND	0x01
-#define ADV_SCAN_IND	0x02
-#define ADV_NONCONN_IND	0x03
-#define ADV_SCAN_RSP	0x04
+#define LE_ADV_IND		0x00
+#define LE_ADV_DIRECT_IND	0x01
+#define LE_ADV_SCAN_IND		0x02
+#define LE_ADV_NONCONN_IND	0x03
+#define LE_ADV_SCAN_RSP		0x04
 
 #define ADDR_LE_DEV_PUBLIC	0x00
 #define ADDR_LE_DEV_RANDOM	0x01
-- 
1.8.3.1

