Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Convert idle timer to use delayed work
Date: Wed, 16 Oct 2013 18:11:40 +0300
Message-Id: <1381936300-18629-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com>
References: <1381936300-18629-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There is no need to use a timer since the entire Bluetooth subsystem
runs using workqueues these days.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++--
 net/bluetooth/hci_conn.c         | 22 +++++++---------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2504a25..07c2da4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -342,7 +342,7 @@ struct hci_conn {
 
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
-	struct timer_list idle_timer;
+	struct delayed_work idle_work;
 
 	struct device	dev;
 
@@ -651,7 +651,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 		switch (conn->type) {
 		case ACL_LINK:
 		case LE_LINK:
-			del_timer(&conn->idle_timer);
+			cancel_delayed_work(&conn->idle_work);
 			if (conn->state == BT_CONNECTED) {
 				timeo = conn->disc_timeout;
 				if (!conn->out)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8d1f466..4e72650 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -317,8 +317,10 @@ static void hci_conn_timeout(struct work_struct *work)
 }
 
 /* Enter sniff mode */
-static void hci_conn_enter_sniff_mode(struct hci_conn *conn)
+static void hci_conn_idle(struct work_struct *work)
 {
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     idle_work.work);
 	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("hcon %p mode %d", conn, conn->mode);
@@ -352,15 +354,6 @@ static void hci_conn_enter_sniff_mode(struct hci_conn *conn)
 	}
 }
 
-static void hci_conn_idle(unsigned long arg)
-{
-	struct hci_conn *conn = (void *) arg;
-
-	BT_DBG("hcon %p mode %d", conn, conn->mode);
-
-	hci_conn_enter_sniff_mode(conn);
-}
-
 static void hci_conn_auto_accept(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
@@ -416,7 +409,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
-	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
+	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -437,10 +430,9 @@ int hci_conn_del(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
-	del_timer(&conn->idle_timer);
-
 	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
+	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
@@ -920,8 +912,8 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
 timer:
 	if (hdev->idle_timeout > 0)
-		mod_timer(&conn->idle_timer,
-			  jiffies + msecs_to_jiffies(hdev->idle_timeout));
+		queue_delayed_work(hdev->workqueue, &conn->idle_work,
+				   msecs_to_jiffies(hdev->idle_timeout));
 }
 
 /* Drop all connection on the device */
-- 
1.8.3.1

