Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4316C4A0.1070100@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------040809070104060404090309"
Subject: [Bluez-devel] [PATCH] LM_AUTH and LM_ENCRYPT support for outgoing sockets
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 01 Sep 2005 11:06:40 +0200

This is a multi-part message in MIME format.
--------------040809070104060404090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The following patch adds supports of LM_AUTH and LM_ENCRYPT flags for outgoing L2CAP and RFCOMM sockets.

Fred

-- 
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


--------------040809070104060404090309
Content-Type: text/plain;
 name="patch-2.6.12.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.12.5"

diff -ruN linux-2.6.12.5/include/net/bluetooth/bluetooth.h linux-2.6.12.5-fda/include/net/bluetooth/bluetooth.h
--- linux-2.6.12.5/include/net/bluetooth/bluetooth.h	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/include/net/bluetooth/bluetooth.h	2005-08-25 10:43:47.000000000 +0200
@@ -73,6 +73,7 @@
 	BT_LISTEN,
 	BT_CONNECT,
 	BT_CONNECT2,
+	BT_CONNECT3,
 	BT_CONFIG,
 	BT_DISCONN,
 	BT_CLOSED
diff -ruN linux-2.6.12.5/include/net/bluetooth/rfcomm.h linux-2.6.12.5-fda/include/net/bluetooth/rfcomm.h
--- linux-2.6.12.5/include/net/bluetooth/rfcomm.h	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/include/net/bluetooth/rfcomm.h	2005-08-25 10:44:46.000000000 +0200
@@ -226,7 +226,7 @@
 /* ---- RFCOMM DLCs (channels) ---- */
 struct rfcomm_dlc *rfcomm_dlc_alloc(int prio);
 void rfcomm_dlc_free(struct rfcomm_dlc *d);
-int  rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel);
+int  rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel, u32 lm);
 int  rfcomm_dlc_close(struct rfcomm_dlc *d, int reason);
 int  rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb);
 int  rfcomm_dlc_set_modem_status(struct rfcomm_dlc *d, u8 v24_sig);
diff -ruN linux-2.6.12.5/net/bluetooth/l2cap.c linux-2.6.12.5-fda/net/bluetooth/l2cap.c
--- linux-2.6.12.5/net/bluetooth/l2cap.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/net/bluetooth/l2cap.c	2005-08-25 10:57:25.000000000 +0200
@@ -498,6 +498,17 @@
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
+		if ((l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
+				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
+			sk->sk_state = BT_CONNECT3;
+			if (!hci_conn_encrypt(conn->hcon))
+				goto done;
+		} else if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH) {
+			sk->sk_state = BT_CONNECT3;
+			if (!hci_conn_auth(conn->hcon))
+				goto done;
+		}
+
 		if (sk->sk_type == SOCK_SEQPACKET) {
 			struct l2cap_conn_req req;
 			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
@@ -1091,6 +1102,17 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
+		if ((l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
+				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
+			sk->sk_state = BT_CONNECT3;
+			if (!hci_conn_encrypt(conn->hcon))
+				goto done;
+		} else if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH) {
+			sk->sk_state = BT_CONNECT3;
+			if (!hci_conn_auth(conn->hcon))
+				goto done;
+		}
+
 		if (sk->sk_type != SOCK_SEQPACKET) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
@@ -1103,6 +1125,7 @@
 			l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 		}
 
+done:
 		bh_unlock_sock(sk);
 	}
 
@@ -1972,28 +1995,47 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_state != BT_CONNECT2 ||
+		if ((sk->sk_state != BT_CONNECT2 && sk->sk_state != BT_CONNECT3) ||
 				(l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
 				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
 			bh_unlock_sock(sk);
 			continue;
 		}
 
-		if (!status) {
-			sk->sk_state = BT_CONFIG;
-			result = 0;
-		} else {
-			sk->sk_state = BT_DISCONN;
-			l2cap_sock_set_timer(sk, HZ/10);
-			result = L2CAP_CR_SEC_BLOCK;
-		}
+		if (sk->sk_state == BT_CONNECT2) {
+			if (!status) {
+				sk->sk_state = BT_CONFIG;
+				result = 0;
+			} else {
+				sk->sk_state = BT_DISCONN;
+				l2cap_sock_set_timer(sk, HZ/10);
+				result = L2CAP_CR_SEC_BLOCK;
+			}
 
-		rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = __cpu_to_le16(result);
-		rsp.status = __cpu_to_le16(0);
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+			rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.result = __cpu_to_le16(result);
+			rsp.status = __cpu_to_le16(0);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+		} else if (sk->sk_state == BT_CONNECT3) {
+			if (status) {
+				l2cap_chan_del(sk, ECONNREFUSED);
+				continue;
+			}
+
+			if (sk->sk_type == SOCK_SEQPACKET) {
+				struct l2cap_conn_req req;
+				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+				req.psm  = l2cap_pi(sk)->psm;
+				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+						L2CAP_CONN_REQ, sizeof(req), &req);
+			} else {
+				l2cap_sock_clear_timer(sk);
+				sk->sk_state = BT_CONNECTED;
+			}
+		}
 
 		bh_unlock_sock(sk);
 	}
@@ -2021,29 +2063,48 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_state != BT_CONNECT2) {
+		if (sk->sk_state != BT_CONNECT2 && sk->sk_state != BT_CONNECT3) {
 			bh_unlock_sock(sk);
 			continue;
 		}
 
-		if (!status) {
-			sk->sk_state = BT_CONFIG;
-			result = 0;
-		} else {
-			sk->sk_state = BT_DISCONN;
-			l2cap_sock_set_timer(sk, HZ/10);
-			result = L2CAP_CR_SEC_BLOCK;
-		}
+		if (sk->sk_state == BT_CONNECT2) {
+			if (!status) {
+				sk->sk_state = BT_CONFIG;
+				result = 0;
+			} else {
+				sk->sk_state = BT_DISCONN;
+				l2cap_sock_set_timer(sk, HZ/10);
+				result = L2CAP_CR_SEC_BLOCK;
+			}
 
-		rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = __cpu_to_le16(result);
-		rsp.status = __cpu_to_le16(0);
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+			rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.result = __cpu_to_le16(result);
+			rsp.status = __cpu_to_le16(0);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+			if (l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)
+				hci_conn_change_link_key(hcon);
+		} else if (sk->sk_state == BT_CONNECT3) {
+			if (status) {
+				l2cap_chan_del(sk, ECONNREFUSED);
+				continue;
+			}
 
-		if (l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)
-			hci_conn_change_link_key(hcon);
+			if (sk->sk_type == SOCK_SEQPACKET) {
+				struct l2cap_conn_req req;
+				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+				req.psm  = l2cap_pi(sk)->psm;
+				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+						L2CAP_CONN_REQ, sizeof(req), &req);
+			} else {
+				l2cap_sock_clear_timer(sk);
+				sk->sk_state = BT_CONNECTED;
+			}
+		}
 
 		bh_unlock_sock(sk);
 	}
diff -ruN linux-2.6.12.5/net/bluetooth/rfcomm/core.c linux-2.6.12.5-fda/net/bluetooth/rfcomm/core.c
--- linux-2.6.12.5/net/bluetooth/rfcomm/core.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/net/bluetooth/rfcomm/core.c	2005-08-25 11:01:16.000000000 +0200
@@ -86,7 +86,7 @@
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err);
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, u32 lm, int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static void rfcomm_session_del(struct rfcomm_session *s);
 
@@ -299,7 +299,7 @@
 	return NULL;
 }
 
-static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
+static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel, u32 lm)
 {
 	struct rfcomm_session *s;
 	int err = 0;
@@ -316,7 +316,7 @@
 
 	s = rfcomm_session_get(src, dst);
 	if (!s) {
-		s = rfcomm_session_create(src, dst, &err);
+		s = rfcomm_session_create(src, dst, lm, &err);
 		if (!s)
 			return err;
 	}
@@ -345,13 +345,13 @@
 	return 0;
 }
 
-int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel)
+int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel, u32 lm)
 {
 	int r;
 
 	rfcomm_lock();
 
-	r = __rfcomm_dlc_open(d, src, dst, channel);
+	r = __rfcomm_dlc_open(d, src, dst, channel, lm);
 
 	rfcomm_unlock();
 	return r;
@@ -568,7 +568,7 @@
 	rfcomm_session_put(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err)
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, u32 lm, int *err)
 {
 	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
@@ -592,6 +592,12 @@
 	sk = sock->sk;
 	lock_sock(sk);
 	l2cap_pi(sk)->imtu = RFCOMM_MAX_L2CAP_MTU;
+	if (lm & RFCOMM_LM_AUTH)
+		l2cap_pi(sk)->link_mode |= L2CAP_LM_AUTH;
+	if (lm & RFCOMM_LM_ENCRYPT)
+		l2cap_pi(sk)->link_mode |= L2CAP_LM_ENCRYPT;
+	if (lm & RFCOMM_LM_SECURE)
+		l2cap_pi(sk)->link_mode |= L2CAP_LM_SECURE;
 	release_sock(sk);
 
 	s = rfcomm_session_add(sock, BT_BOUND);
diff -ruN linux-2.6.12.5/net/bluetooth/rfcomm/sock.c linux-2.6.12.5-fda/net/bluetooth/rfcomm/sock.c
--- linux-2.6.12.5/net/bluetooth/rfcomm/sock.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/net/bluetooth/rfcomm/sock.c	2005-08-25 11:02:15.000000000 +0200
@@ -405,7 +405,7 @@
 	bacpy(&bt_sk(sk)->dst, &sa->rc_bdaddr);
 	rfcomm_pi(sk)->channel = sa->rc_channel;
 
-	err = rfcomm_dlc_open(d, &bt_sk(sk)->src, &sa->rc_bdaddr, sa->rc_channel);
+	err = rfcomm_dlc_open(d, &bt_sk(sk)->src, &sa->rc_bdaddr, sa->rc_channel, rfcomm_pi(sk)->link_mode);
 	if (!err)
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 				sock_sndtimeo(sk, flags & O_NONBLOCK));
diff -ruN linux-2.6.12.5/net/bluetooth/rfcomm/tty.c linux-2.6.12.5-fda/net/bluetooth/rfcomm/tty.c
--- linux-2.6.12.5/net/bluetooth/rfcomm/tty.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/net/bluetooth/rfcomm/tty.c	2005-08-25 11:03:03.000000000 +0200
@@ -591,7 +591,7 @@
 	rfcomm_dlc_unlock(dlc);
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
-	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
+	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel, 0);
 	if (err < 0)
 		return err;
 

--------------040809070104060404090309--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
