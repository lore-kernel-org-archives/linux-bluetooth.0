Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Convert auto accept timer to use delayed work
Date: Wed, 16 Oct 2013 18:11:39 +0300
Message-Id: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the entire Bluetooth subsystem runs in workqueues these days there
is no need to use a timer for deferring work.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 14 ++++++--------
 net/bluetooth/hci_event.c        |  3 ++-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d987c79..2504a25 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -341,8 +341,8 @@ struct hci_conn {
 	struct list_head chan_list;
 
 	struct delayed_work disc_work;
+	struct delayed_work auto_accept_work;
 	struct timer_list idle_timer;
-	struct timer_list auto_accept_timer;
 
 	struct device	dev;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ff04b05..8d1f466 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -361,12 +361,12 @@ static void hci_conn_idle(unsigned long arg)
 	hci_conn_enter_sniff_mode(conn);
 }
 
-static void hci_conn_auto_accept(unsigned long arg)
+static void hci_conn_auto_accept(struct work_struct *work)
 {
-	struct hci_conn *conn = (void *) arg;
-	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     auto_accept_work.work);
 
-	hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY, sizeof(conn->dst),
+	hci_send_cmd(conn->hdev, HCI_OP_USER_CONFIRM_REPLY, sizeof(conn->dst),
 		     &conn->dst);
 }
 
@@ -415,9 +415,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	INIT_LIST_HEAD(&conn->chan_list);
 
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
+	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
-	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
-		    (unsigned long) conn);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -441,8 +440,7 @@ int hci_conn_del(struct hci_conn *conn)
 	del_timer(&conn->idle_timer);
 
 	cancel_delayed_work_sync(&conn->disc_work);
-
-	del_timer(&conn->auto_accept_timer);
+	cancel_delayed_work_sync(&conn->auto_accept_work);
 
 	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e71c98f..6c3b193 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3188,7 +3188,8 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 
 		if (hdev->auto_accept_delay > 0) {
 			int delay = msecs_to_jiffies(hdev->auto_accept_delay);
-			mod_timer(&conn->auto_accept_timer, jiffies + delay);
+			queue_delayed_work(conn->hdev->workqueue,
+					   &conn->auto_accept_work, delay);
 			goto unlock;
 		}
 
-- 
1.8.3.1

