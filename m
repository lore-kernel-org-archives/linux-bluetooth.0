Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use AUTO_OFF constant in jiffies
Date: Thu, 14 Jun 2012 10:45:45 +0300
Message-Id: <1339659945-28094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move AUTO_OFF_TIMEOUT to other constants changing name to
HCI_AUTO_OFF_TIMEOUT and convert to jiffies.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    3 ++-
 net/bluetooth/hci_core.c    |    5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3d1ad2c..a7b334e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -153,8 +153,9 @@ enum {
 #define HCI_DISCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 2 seconds */
 #define HCI_PAIRING_TIMEOUT	msecs_to_jiffies(60000)	/* 60 seconds */
 #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
-#define HCI_CMD_TIMEOUT		msecs_to_jiffies(1000)	/* 1 seconds */
+#define HCI_CMD_TIMEOUT		msecs_to_jiffies(1000)	/* 1 second */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
+#define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4375d1..d36de9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -33,8 +33,6 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#define AUTO_OFF_TIMEOUT 2000
-
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
@@ -1085,8 +1083,7 @@ static void hci_power_on(struct work_struct *work)
 		return;
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		schedule_delayed_work(&hdev->power_off,
-				      msecs_to_jiffies(AUTO_OFF_TIMEOUT));
+		schedule_delayed_work(&hdev->power_off, HCI_AUTO_OFF_TIMEOUT);
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
-- 
1.7.9.5

