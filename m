Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/17] Bluetooth: Add LE scan type macros
Date: Thu,  4 Apr 2013 20:21:00 -0300
Message-Id: <1365117675-2202-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macros for active and passive LE scan type values.
The LE_SCAN_PASSIVE was also defined since it will be used in future
by LE connection routine and GAP Observer Role support.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h | 3 +++
 net/bluetooth/mgmt.c        | 7 +++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b330892..3f4266b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -984,6 +984,9 @@ struct hci_cp_le_set_adv_data {
 
 #define HCI_OP_LE_SET_ADV_ENABLE	0x200a
 
+#define LE_SCAN_PASSIVE			0x00
+#define LE_SCAN_ACTIVE			0x01
+
 #define HCI_OP_LE_SET_SCAN_PARAM	0x200b
 struct hci_cp_le_set_scan_param {
 	__u8    type;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c00e8ea..411117b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,7 +106,6 @@ static const u16 mgmt_events[] = {
  * These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
  */
-#define LE_SCAN_TYPE			0x01
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		msecs_to_jiffies(10240)
@@ -2703,7 +2702,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT,
 				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
 		break;
 
@@ -2715,8 +2714,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SCAN_WIN,
-				  LE_SCAN_TIMEOUT_BREDR_LE);
+		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT,
+				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_BREDR_LE);
 		break;
 
 	default:
-- 
1.8.1.2

