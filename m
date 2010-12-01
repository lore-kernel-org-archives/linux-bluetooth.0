Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/5] Bluetooth: clean up sco code
Date: Wed,  1 Dec 2010 16:58:22 +0200
Message-Id: <1291215506-11398-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Do not use assignments in IF condition, remove extra spaces

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/sco.h |    8 ++++----
 net/bluetooth/sco.c         |   22 +++++++++++++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index e28a2a7..ea5c664 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -55,11 +55,11 @@ struct sco_conninfo {
 struct sco_conn {
 	struct hci_conn	*hcon;
 
-	bdaddr_t 	*dst;
-	bdaddr_t 	*src;
-	
+	bdaddr_t	*dst;
+	bdaddr_t	*src;
+
 	spinlock_t	lock;
-	struct sock 	*sk;
+	struct sock	*sk;
 
 	unsigned int    mtu;
 };
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 66b9e5c..960c6d1 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -44,7 +44,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -52,7 +52,7 @@
 
 #define VERSION "0.6"
 
-static int disable_esco = 0;
+static int disable_esco;
 
 static const struct proto_ops sco_sock_ops;
 
@@ -138,16 +138,17 @@ static inline struct sock *sco_chan_get(struct sco_conn *conn)
 
 static int sco_conn_del(struct hci_conn *hcon, int err)
 {
-	struct sco_conn *conn;
+	struct sco_conn *conn = hcon->sco_data;
 	struct sock *sk;
 
-	if (!(conn = hcon->sco_data))
+	if (!conn)
 		return 0;
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
 	/* Kill socket */
-	if ((sk = sco_chan_get(conn))) {
+	sk = sco_chan_get(conn);
+	if (sk) {
 		bh_lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
@@ -185,7 +186,8 @@ static int sco_connect(struct sock *sk)
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
-	if (!(hdev = hci_get_route(dst, src)))
+	hdev = hci_get_route(dst, src);
+	if (!hdev)
 		return -EHOSTUNREACH;
 
 	hci_dev_lock_bh(hdev);
@@ -510,7 +512,8 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &sa->sco_bdaddr);
 
-	if ((err = sco_connect(sk)))
+	err = sco_connect(sk);
+	if (err)
 		goto done;
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
@@ -828,13 +831,14 @@ static void sco_chan_del(struct sock *sk, int err)
 
 static void sco_conn_ready(struct sco_conn *conn)
 {
-	struct sock *parent, *sk;
+	struct sock *parent;
+	struct sock *sk = conn->sk;
 
 	BT_DBG("conn %p", conn);
 
 	sco_conn_lock(conn);
 
-	if ((sk = conn->sk)) {
+	if (sk) {
 		sco_sock_clear_timer(sk);
 		bh_lock_sock(sk);
 		sk->sk_state = BT_CONNECTED;
-- 
1.7.1

