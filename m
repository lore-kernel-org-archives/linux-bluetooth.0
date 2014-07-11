Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Move struct sco_pinfo into net/bluetooth/sco.c
Date: Fri, 11 Jul 2014 06:19:41 +0200
Message-Id: <1405052384-5981-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There exists no external user of struct sco_pinfo and sco_pi and
thus move it into the one place that is actually using it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h | 12 ------------
 net/bluetooth/sco.c         | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 2019d1a0996a..7fec7cbd7396 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -64,16 +64,4 @@ struct sco_conn {
 #define sco_conn_lock(c)	spin_lock(&c->lock);
 #define sco_conn_unlock(c)	spin_unlock(&c->lock);
 
-/* ----- SCO socket info ----- */
-#define sco_pi(sk) ((struct sco_pinfo *) sk)
-
-struct sco_pinfo {
-	struct bt_sock	bt;
-	bdaddr_t	src;
-	bdaddr_t	dst;
-	__u32		flags;
-	__u16		setting;
-	struct sco_conn	*conn;
-};
-
 #endif /* __SCO_H */
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c06dbd3938e8..c71698642ec6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -46,6 +46,18 @@ static void sco_chan_del(struct sock *sk, int err);
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
+/* ----- SCO socket info ----- */
+#define sco_pi(sk) ((struct sco_pinfo *) sk)
+
+struct sco_pinfo {
+	struct bt_sock	bt;
+	bdaddr_t	src;
+	bdaddr_t	dst;
+	__u32		flags;
+	__u16		setting;
+	struct sco_conn	*conn;
+};
+
 /* ---- SCO timers ---- */
 static void sco_sock_timeout(unsigned long arg)
 {
-- 
1.9.3

