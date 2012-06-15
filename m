Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Use AUTO_OFF constant in jiffies
Date: Fri, 15 Jun 2012 10:36:42 +0300
Message-Id: <1339745802-8382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
References: <CAJdJm_MtZYC9=nFzchcCR+yZiyGVNCMpXnmPf7D-dKut1UT8BA@mail.gmail.com>
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
index 7dcd349..ccd723e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -142,8 +142,9 @@ enum {
 #define HCI_DISCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_PAIRING_TIMEOUT	msecs_to_jiffies(60000)	/* 60 seconds */
 #define HCI_INIT_TIMEOUT	msecs_to_jiffies(10000)	/* 10 seconds */
-#define HCI_CMD_TIMEOUT		msecs_to_jiffies(1000)	/* 1 seconds */
+#define HCI_CMD_TIMEOUT		msecs_to_jiffies(1000)	/* 1 second */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
+#define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5979452..8b93491 100644
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
@@ -1083,8 +1081,7 @@ static void hci_power_on(struct work_struct *work)
 		return;
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		schedule_delayed_work(&hdev->power_off,
-				      msecs_to_jiffies(AUTO_OFF_TIMEOUT));
+		schedule_delayed_work(&hdev->power_off, HCI_AUTO_OFF_TIMEOUT);
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
-- 
1.7.9.5

