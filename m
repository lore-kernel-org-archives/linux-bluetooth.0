Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/17] Bluetooth: Change LE scanning timeout macros
Date: Thu,  4 Apr 2013 20:20:59 -0300
Message-Id: <1365117675-2202-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Define LE scanning timeout macros in jiffies just like we do for
others timeout macros.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 2 +-
 net/bluetooth/mgmt.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a199d63..0686e42 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1909,7 +1909,7 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 		return err;
 
 	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-			   msecs_to_jiffies(timeout));
+			   timeout);
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03e7e73..c00e8ea 100644
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
-- 
1.8.1.2

