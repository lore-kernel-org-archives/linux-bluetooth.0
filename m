Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add timeout field to mgmt_set_discoverable
Date: Fri,  4 Nov 2011 00:17:46 +0200
Message-Id: <1320358667-21086-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
References: <1320358667-21086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Based on the revised mgmt API set_discoverable has a timeout parameter
to specify how long the adapter will remain discoverable. A value of 0
means "indefinitively".

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 include/net/bluetooth/mgmt.h     |    4 ++++
 net/bluetooth/hci_core.c         |   25 +++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    5 +++++
 net/bluetooth/mgmt.c             |    5 ++++-
 5 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f97792c..5079598 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -196,6 +196,9 @@ struct hci_dev {
 	struct work_struct	power_off;
 	struct timer_list	off_timer;
 
+	__u16			discov_timeout;
+	struct delayed_work	discov_off;
+
 	struct timer_list	cmd_timer;
 	struct tasklet_struct	cmd_task;
 	struct tasklet_struct	rx_task;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3062fd3..b5320aa 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -69,6 +69,10 @@ struct mgmt_mode {
 #define MGMT_OP_SET_POWERED		0x0005
 
 #define MGMT_OP_SET_DISCOVERABLE	0x0006
+struct mgmt_cp_set_discoverable {
+	__u8 val;
+	__u16 timeout;
+} __packed;
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b7f6b5b..0c75770 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -595,6 +595,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	tasklet_kill(&hdev->rx_task);
 	tasklet_kill(&hdev->tx_task);
 
+	if (hdev->discov_timeout > 0) {
+		cancel_delayed_work_sync(&hdev->discov_off);
+		hdev->discov_timeout = 0;
+	}
+
 	hci_dev_lock_bh(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
@@ -968,6 +973,24 @@ void hci_del_off_timer(struct hci_dev *hdev)
 	del_timer(&hdev->off_timer);
 }
 
+static void hci_discov_off(struct work_struct *work)
+{
+	struct hci_dev *hdev;
+	u8 scan = SCAN_PAGE;
+
+	hdev = container_of(work, struct hci_dev, discov_off.work);
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock_bh(hdev);
+
+	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
+
+	hdev->discov_timeout = 0;
+
+	hci_dev_unlock_bh(hdev);
+}
+
 int hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
@@ -1485,6 +1508,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
 
+	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
+
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 	atomic_set(&hdev->promisc, 0);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8c81a75..dd24d6e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -296,6 +296,11 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		set_bit(HCI_ISCAN, &hdev->flags);
 		if (!old_iscan)
 			mgmt_discoverable(hdev->id, 1);
+		if (hdev->discov_timeout > 0) {
+			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
+									to);
+		}
 	} else if (old_iscan)
 		mgmt_discoverable(hdev->id, 0);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 747366a..efcde95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -348,7 +348,7 @@ failed:
 static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 									u16 len)
 {
-	struct mgmt_mode *cp;
+	struct mgmt_cp_set_discoverable *cp;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	u8 scan;
@@ -399,6 +399,9 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
+	if (cp->val)
+		hdev->discov_timeout = get_unaligned_le16(&cp->timeout);
+
 failed:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
-- 
1.7.7.1

