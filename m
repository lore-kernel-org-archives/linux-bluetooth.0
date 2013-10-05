Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Bluetooth: Rename AMP status constants and use them
Date: Sat,  5 Oct 2013 11:47:45 -0700
Message-Id: <1380998869-64411-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AMP controller status constants need to be actually used to avoid
crypted hardcoded numbers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 14 +++++++-------
 net/bluetooth/a2mp.c        |  2 +-
 net/bluetooth/hci_core.c    |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 393eabc..9f8d1c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -71,13 +71,13 @@
 #define AMP_TYPE_80211	0x01
 
 /* AMP controller status */
-#define AMP_CTRL_POWERED_DOWN			0x00
-#define AMP_CTRL_BLUETOOTH_ONLY			0x01
-#define AMP_CTRL_NO_CAPACITY			0x02
-#define AMP_CTRL_LOW_CAPACITY			0x03
-#define AMP_CTRL_MEDIUM_CAPACITY		0x04
-#define AMP_CTRL_HIGH_CAPACITY			0x05
-#define AMP_CTRL_FULL_CAPACITY			0x06
+#define AMP_STATUS_POWERED_DOWN			0x00
+#define AMP_STATUS_BLUETOOTH_ONLY		0x01
+#define AMP_STATUS_NO_CAPACITY			0x02
+#define AMP_STATUS_LOW_CAPACITY			0x03
+#define AMP_STATUS_MEDIUM_CAPACITY		0x04
+#define AMP_STATUS_HIGH_CAPACITY		0x05
+#define AMP_STATUS_FULL_CAPACITY		0x06
 
 /* HCI device quirks */
 enum {
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6d62d31..6dfef73 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -79,7 +79,7 @@ static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
 {
 	cl->id = AMP_ID_BREDR;
 	cl->type = AMP_TYPE_BREDR;
-	cl->status = 1;
+	cl->status = AMP_STATUS_BLUETOOTH_ONLY;
 }
 
 /* hci_dev_list shall be locked */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c3c7c12..a8bb9fd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1381,7 +1381,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	}
 
 	/* Controller radio is available but is currently powered down */
-	hdev->amp_status = 0;
+	hdev->amp_status = AMP_STATUS_POWERED_DOWN;
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
-- 
1.8.3.1

