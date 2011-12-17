Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 03/22] Bluetooth: Use delayed_work for connection timeout
Date: Sat, 17 Dec 2011 19:29:23 -0200
Message-Id: <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Bluetooth rx task runs now in a workqueue, so it a good approach run any
timer that share locking with process context code also in a workqueue.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    8 +++++---
 net/bluetooth/hci_conn.c         |    9 +++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7dbe59..d915908 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -297,7 +297,7 @@ struct hci_conn {
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
 
-	struct timer_list disc_timer;
+	struct delayed_work disc_work;
 	struct timer_list idle_timer;
 	struct timer_list auto_accept_timer;
 
@@ -517,7 +517,7 @@ void hci_conn_put_device(struct hci_conn *conn);
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
 	atomic_inc(&conn->refcnt);
-	del_timer(&conn->disc_timer);
+	cancel_delayed_work_sync(&conn->disc_work);
 }
 
 static inline void hci_conn_put(struct hci_conn *conn)
@@ -536,7 +536,9 @@ static inline void hci_conn_put(struct hci_conn *conn)
 		} else {
 			timeo = msecs_to_jiffies(10);
 		}
-		mod_timer(&conn->disc_timer, jiffies + timeo);
+		cancel_delayed_work_sync(&conn->disc_work);
+		queue_delayed_work(conn->hdev->workqueue,
+					&conn->disc_work, jiffies + timeo);
 	}
 }
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d45783d..7d88a61 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -275,9 +275,10 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	}
 }
 
-static void hci_conn_timeout(unsigned long arg)
+static void hci_conn_timeout(struct work_struct *work)
 {
-	struct hci_conn *conn = (void *) arg;
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+							disc_work.work);
 	struct hci_dev *hdev = conn->hdev;
 	__u8 reason;
 
@@ -412,7 +413,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	INIT_LIST_HEAD(&conn->chan_list);;
 
-	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
+	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
 	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
 							(unsigned long) conn);
@@ -444,7 +445,7 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->idle_timer);
 
-	del_timer(&conn->disc_timer);
+	cancel_delayed_work_sync(&conn->disc_work);
 
 	del_timer(&conn->auto_accept_timer);
 
-- 
1.7.6.4

