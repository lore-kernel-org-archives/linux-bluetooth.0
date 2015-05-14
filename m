Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v1] Bluetooth: Fix potential NULL dereference
Date: Thu, 14 May 2015 12:58:08 +0530
Message-id: <1431588488-16666-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

addr can be NULL and it should not be dereferenced before NULL checking.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/rfcomm/sock.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 825e8fb..f9e9a81 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -334,16 +334,19 @@ static int rfcomm_sock_create(struct net *net, struct socket *sock,
 
 static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
-	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
+	struct sockaddr_rc sa;
 	struct sock *sk = sock->sk;
-	int chan = sa->rc_channel;
-	int err = 0;
-
-	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
+	int len, err = 0;
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	memset(&sa, 0, sizeof(sa));
+	len = min_t(unsigned int, sizeof(sa), addr_len);
+	memcpy(&sa, addr, len);
+
+	BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -358,12 +361,13 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 
 	write_lock(&rfcomm_sk_list.lock);
 
-	if (chan && __rfcomm_get_listen_sock_by_addr(chan, &sa->rc_bdaddr)) {
+	if (sa.rc_channel &&
+	    __rfcomm_get_listen_sock_by_addr(sa.rc_channel, &sa.rc_bdaddr)) {
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
-		bacpy(&rfcomm_pi(sk)->src, &sa->rc_bdaddr);
-		rfcomm_pi(sk)->channel = chan;
+		bacpy(&rfcomm_pi(sk)->src, &sa.rc_bdaddr);
+		rfcomm_pi(sk)->channel = sa.rc_channel;
 		sk->sk_state = BT_BOUND;
 	}
 
-- 
1.7.9.5

