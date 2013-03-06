Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Change LE scanning timeout macros
Date: Wed,  6 Mar 2013 16:10:58 -0300
Message-Id: <1362597059-4102-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
References: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Define LE scanning timeout macros in jiffies just like we do for
others timeout macros.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de1d2f4..ef22261 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -109,8 +109,8 @@ static const u16 mgmt_events[] = {
 #define LE_SCAN_TYPE			0x01
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
-#define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
-#define LE_SCAN_TIMEOUT_BREDR_LE	5120	/* TGAP(100)/2 */
+#define LE_SCAN_TIMEOUT_LE_ONLY		msecs_to_jiffies(10240)
+#define LE_SCAN_TIMEOUT_BREDR_LE	msecs_to_jiffies(5120)
 
 #define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
 #define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
@@ -2438,12 +2438,12 @@ static void enable_le_scan_complete(struct hci_dev *hdev, u8 status)
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   msecs_to_jiffies(LE_SCAN_TIMEOUT_LE_ONLY));
+				   LE_SCAN_TIMEOUT_LE_ONLY);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   msecs_to_jiffies(LE_SCAN_TIMEOUT_BREDR_LE));
+				   LE_SCAN_TIMEOUT_BREDR_LE);
 		break;
 	default:
 		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
-- 
1.8.1.2

