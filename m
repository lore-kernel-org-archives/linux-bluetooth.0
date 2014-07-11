Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move struct sco_conn into net/bluetooth/sco.c
Date: Fri, 11 Jul 2014 06:19:42 +0200
Message-Id: <1405052384-5981-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There exists no external user of struct sco_conn and thus move
it into the one place that is actually using it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h | 13 -------------
 net/bluetooth/sco.c         | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 7fec7cbd7396..42a0d089d715 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -51,17 +51,4 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
-/* ---- SCO connections ---- */
-struct sco_conn {
-	struct hci_conn	*hcon;
-
-	spinlock_t	lock;
-	struct sock	*sk;
-
-	unsigned int    mtu;
-};
-
-#define sco_conn_lock(c)	spin_lock(&c->lock);
-#define sco_conn_unlock(c)	spin_unlock(&c->lock);
-
 #endif /* __SCO_H */
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c71698642ec6..9868ec7c7dc4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -40,6 +40,19 @@ static struct bt_sock_list sco_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(sco_sk_list.lock)
 };
 
+/* ---- SCO connections ---- */
+struct sco_conn {
+	struct hci_conn	*hcon;
+
+	spinlock_t	lock;
+	struct sock	*sk;
+
+	unsigned int    mtu;
+};
+
+#define sco_conn_lock(c)	spin_lock(&c->lock);
+#define sco_conn_unlock(c)	spin_unlock(&c->lock);
+
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
 static void sco_chan_del(struct sock *sk, int err);
 
-- 
1.9.3

