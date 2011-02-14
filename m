Return-Path: <cyrus@holtmann.org>
From: ville.tervo@nokia.com
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH v2] Bluetooth: Use proper timer for hci command timout
Date: Mon, 14 Feb 2011 13:36:12 +0200
Message-Id: <1297683372-28351-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Use proper timer instead of hci command flow control to timeout
failed hci commands. Otherwise stack ends up sending commands
when flow control is used to block new commands.

2010-09-01 18:29:41.592132 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:CF:E1:C7:D7 mode 2 clkoffset 0x0000
2010-09-01 18:29:41.592681 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 0
2010-09-01 18:29:51.022033 < HCI Command: Remote Name Request Cancel (0x01|0x001a) plen 6
    bdaddr 00:16:CF:E1:C7:D7

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci.h      |    3 +++
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |   22 ++++++++++++++++------
 net/bluetooth/hci_event.c        |    6 ++++++
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4bee030..918af32 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -119,6 +119,7 @@ enum {
 #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
 #define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
+#define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
@@ -242,6 +243,8 @@ enum {
 #define HCI_AT_GENERAL_BONDING_MITM	0x05
 
 /* -----  HCI Commands ---- */
+#define HCI_OP_NOP			0x0000
+
 #define HCI_OP_INQUIRY			0x0401
 struct hci_cp_inquiry {
 	__u8     lap[3];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6163bff..51dd73b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -128,7 +128,6 @@ struct hci_dev {
 	unsigned int	acl_pkts;
 	unsigned int	sco_pkts;
 
-	unsigned long	cmd_last_tx;
 	unsigned long	acl_last_tx;
 	unsigned long	sco_last_tx;
 
@@ -138,6 +137,7 @@ struct hci_dev {
 	struct work_struct	power_off;
 	struct timer_list	off_timer;
 
+	struct timer_list	cmd_timer;
 	struct tasklet_struct	cmd_task;
 	struct tasklet_struct	rx_task;
 	struct tasklet_struct	tx_task;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f00322..069c2bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/rfkill.h>
+#include <linux/timer.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -611,6 +612,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Drop last sent command */
 	if (hdev->sent_cmd) {
+		del_timer_sync(&hdev->cmd_timer);
 		kfree_skb(hdev->sent_cmd);
 		hdev->sent_cmd = NULL;
 	}
@@ -1054,6 +1056,16 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+/* HCI command timer function */
+static void hci_cmd_timer(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	BT_ERR("%s command tx timeout", hdev->name);
+	atomic_set(&hdev->cmd_cnt, 1);
+	tasklet_schedule(&hdev->cmd_task);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1100,6 +1112,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
+	setup_timer(&hdev->cmd_timer, hci_cmd_timer, (unsigned long) hdev);
+
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		hdev->reassembly[i] = NULL;
 
@@ -1936,11 +1950,6 @@ static void hci_cmd_task(unsigned long arg)
 
 	BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));
 
-	if (!atomic_read(&hdev->cmd_cnt) && time_after(jiffies, hdev->cmd_last_tx + HZ)) {
-		BT_ERR("%s command tx timeout", hdev->name);
-		atomic_set(&hdev->cmd_cnt, 1);
-	}
-
 	/* Send queued commands */
 	if (atomic_read(&hdev->cmd_cnt)) {
 		skb = skb_dequeue(&hdev->cmd_q);
@@ -1953,7 +1962,8 @@ static void hci_cmd_task(unsigned long arg)
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
-			hdev->cmd_last_tx = jiffies;
+			mod_timer(&hdev->cmd_timer,
+				  jiffies + msecs_to_jiffies(HCI_CMD_TIMEOUT));
 		} else {
 			skb_queue_head(&hdev->cmd_q, skb);
 			tasklet_schedule(&hdev->cmd_task);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cee46cb..3836fd3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1672,6 +1672,9 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		break;
 	}
 
+	if (ev->opcode != HCI_OP_NOP)
+		del_timer(&hdev->cmd_timer);
+
 	if (ev->ncmd) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
@@ -1743,6 +1746,9 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
+	if (ev->opcode != HCI_OP_NOP)
+		del_timer(&hdev->cmd_timer);
+
 	if (ev->ncmd) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
-- 
1.7.1

