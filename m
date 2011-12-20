Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/3] Bluetooth: convert security timer to delayed_work
Date: Tue, 20 Dec 2011 10:57:27 -0200
Message-Id: <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

This one also needs to run in process context

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   12 ++++++------
 net/bluetooth/smp.c           |    7 ++++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e199c2f..fc481d1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -532,7 +532,7 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
-	struct timer_list security_timer;
+	struct delayed_work  security_timer;
 	struct smp_chan *smp_chan;
 
 	struct list_head chan_l;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5978d69..d006455 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1032,7 +1032,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		cancel_delayed_work_sync(&conn->info_work);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
-		del_timer(&conn->security_timer);
+		cancel_delayed_work_sync(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
@@ -1040,9 +1040,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	kfree(conn);
 }
 
-static void security_timeout(unsigned long arg)
+static void security_timeout(struct work_struct *work)
 {
-	struct l2cap_conn *conn = (void *) arg;
+	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
+						security_timer.work);
 
 	l2cap_conn_del(conn->hcon, ETIMEDOUT);
 }
@@ -1086,8 +1087,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	INIT_LIST_HEAD(&conn->chan_l);
 
 	if (hcon->type == LE_LINK)
-		setup_timer(&conn->security_timer, security_timeout,
-						(unsigned long) conn);
+		INIT_DELAYED_WORK(&conn->security_timer, security_timeout);
 	else
 		INIT_DELAYED_WORK(&conn->info_work, l2cap_info_timeout);
 
@@ -4519,7 +4519,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	if (hcon->type == LE_LINK) {
 		smp_distribute_keys(conn, 0);
-		del_timer(&conn->security_timer);
+		cancel_delayed_work_sync(&conn->security_timer);
 	}
 
 	rcu_read_lock();
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0b96737..0ee2905 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -184,7 +184,8 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	skb->priority = HCI_PRIO_MAX;
 	hci_send_acl(conn->hchan, skb, 0);
 
-	mod_timer(&conn->security_timer, jiffies +
+	cancel_delayed_work_sync(&conn->security_timer);
+	schedule_delayed_work(&conn->security_timer,
 					msecs_to_jiffies(SMP_TIMEOUT));
 }
 
@@ -240,7 +241,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
-	del_timer(&conn->security_timer);
+	cancel_delayed_work_sync(&conn->security_timer);
 	smp_chan_destroy(conn);
 }
 
@@ -800,7 +801,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 	if (conn->hcon->out || force) {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
-		del_timer(&conn->security_timer);
+		cancel_delayed_work_sync(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
-- 
1.7.6.4

