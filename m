Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic number from ACL TO
Date: Wed,  4 Jan 2012 16:42:26 +0200
Message-Id: <1325688146-19896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds HCI_ACL_TX_TIMEOUT and clear conversion from msec to jiffies

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5b2fed5..e6dbff2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -130,6 +130,7 @@ enum {
 #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
+#define HCI_ACL_TX_TIMEOUT	(45000)	/* 45 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6d38d80..8f74a52 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2249,7 +2249,8 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
+		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx +
+					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
 
-- 
1.7.4.1

