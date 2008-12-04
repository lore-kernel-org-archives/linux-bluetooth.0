Return-Path: <cyrus@holtmann.org>
Message-ID: <4937937C.2020305@nokia.com>
Date: Thu, 04 Dec 2008 10:23:24 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: johan.hedberg@nokia.com, marcel@holtmann.org
Subject: [RFC] Support for getting rfcomm connection information before setting
 up the connection
Content-Type: multipart/mixed;
 boundary="------------070206020406060007070203"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070206020406060007070203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In order to implement HFP profile correctly the gateway needs to know 
address off the the HF device before accepting the connection. Currently 
there is no way to check the address without calling accept(). This 
patch creates a socket option which can be used change the behavior of 
the socket. Server still calls accept() but the actual connection setup 
will be done only after calling recv() for the first time. In between 
the server can use other getsockopts to get the needed information.

I also attached patch against rctest.c as an example how test this feature.

Waiting for comments :)

-- 
Ville



--------------070206020406060007070203
Content-Type: text/x-patch;
 name="0001--BLUETOOTH-Support-for-deferring-rfcomm-connection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001--BLUETOOTH-Support-for-deferring-rfcomm-connection.patc";
 filename*1="h"

>From 746b1179efe09bf4ba5ec0d2b954e2b2c8ab80c5 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Wed, 3 Dec 2008 14:20:55 +0200
Subject: [PATCH] [BLUETOOTH] Support for deferring rfcomm connection

In order to decide if listening rfcomm socket should be accept()ed
the bd_addr of remote device needs to be known. This patch add
a socket option which defines timeout for deferring connection setup.

The connection is actually allowed after reading from socket first
time. Until reading first time writing to socket returns -ENOTCONN.
---
 include/net/bluetooth/bluetooth.h |    4 +
 include/net/bluetooth/rfcomm.h    |    6 ++-
 net/bluetooth/rfcomm/core.c       |   48 ++++++++++++++--
 net/bluetooth/rfcomm/sock.c       |  112 ++++++++++++++++++++++++++-----------
 4 files changed, 131 insertions(+), 39 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6f8418b..1a0fa21 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -53,6 +53,10 @@
 #define SOL_SCO		17
 #define SOL_RFCOMM	18
 
+#define BT_INFORMATION	0x01
+
+#define BT_DEFER_SETUP	0x02
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , __FUNCTION__ , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR  "%s: " fmt "\n" , __FUNCTION__ , ## arg)
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 4dc8d92..eaa1365 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -184,6 +184,7 @@ struct rfcomm_dlc {
 	u8            mscex;
 	u8            out;
 
+	u32           defer_setup;
 	u32           link_mode;
 
 	uint          mtu;
@@ -202,10 +203,11 @@ struct rfcomm_dlc {
 #define RFCOMM_RX_THROTTLED 0
 #define RFCOMM_TX_THROTTLED 1
 #define RFCOMM_TIMED_OUT    2
-#define RFCOMM_MSC_PENDING  3 
+#define RFCOMM_MSC_PENDING  3
 #define RFCOMM_AUTH_PENDING 4
 #define RFCOMM_AUTH_ACCEPT  5
 #define RFCOMM_AUTH_REJECT  6
+#define RFCOMM_DEFER_SETUP  7
 
 /* Scheduling flags and events */
 #define RFCOMM_SCHED_STATE  0
@@ -239,6 +241,7 @@ int  rfcomm_dlc_close(struct rfcomm_dlc *d, int reason);
 int  rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb);
 int  rfcomm_dlc_set_modem_status(struct rfcomm_dlc *d, u8 v24_sig);
 int  rfcomm_dlc_get_modem_status(struct rfcomm_dlc *d, u8 *v24_sig);
+int  rfcomm_dlc_accept_conn(struct rfcomm_dlc *d);
 
 #define rfcomm_dlc_lock(d)     spin_lock(&d->lock)
 #define rfcomm_dlc_unlock(d)   spin_unlock(&d->lock)
@@ -305,6 +308,7 @@ struct rfcomm_pinfo {
 	struct rfcomm_dlc   *dlc;
 	u8     channel;
 	u32    link_mode;
+	u32    defer_setup;
 };
 
 int  rfcomm_init_sockets(void);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ba537fa..7878e3c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -84,6 +84,8 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static void rfcomm_session_del(struct rfcomm_session *s);
 
+static void rfcomm_dlc_accept(struct rfcomm_dlc *d);
+
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
 #define __get_channel(b)  ((b & 0xf8) >> 3)
@@ -228,6 +230,11 @@ static int rfcomm_l2sock_create(struct socket **sock)
 	return err;
 }
 
+static inline u32 rfcomm_defer_setup(struct rfcomm_dlc *d)
+{
+	return d->defer_setup;
+}
+
 static inline int rfcomm_check_link_mode(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
@@ -426,6 +433,7 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 			d, d->state, d->dlci, err, s);
 
 	switch (d->state) {
+	case BT_OPEN:
 	case BT_CONNECTED:
 	case BT_CONFIG:
 	case BT_CONNECT:
@@ -540,6 +548,16 @@ int rfcomm_dlc_get_modem_status(struct rfcomm_dlc *d, u8 *v24_sig)
 	return 0;
 }
 
+
+int rfcomm_dlc_accept_conn(struct rfcomm_dlc *d)
+{
+	if (!d || !d->session || !d->session->sock || !d->session->sock->sk)
+		return -ENOTCONN;
+
+	rfcomm_dlc_accept(d);
+	return 0;
+}
+
 /* ---- RFCOMM sessions ---- */
 static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
 {
@@ -1190,6 +1208,7 @@ static int rfcomm_recv_sabm(struct rfcomm_session *s, u8 dlci)
 {
 	struct rfcomm_dlc *d;
 	u8 channel;
+	u32 defer_to;
 
 	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
 
@@ -1211,8 +1230,14 @@ static int rfcomm_recv_sabm(struct rfcomm_session *s, u8 dlci)
 			if (rfcomm_check_link_mode(d)) {
 				set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
-			} else
-				rfcomm_dlc_accept(d);
+			} else {
+				defer_to = rfcomm_defer_setup(d);
+				if (defer_to) {
+					set_bit(RFCOMM_DEFER_SETUP, &d->flags);
+					rfcomm_dlc_set_timer(d, msecs_to_jiffies(defer_to));
+				} else
+					rfcomm_dlc_accept(d);
+			}
 		}
 		return 0;
 	}
@@ -1227,8 +1252,15 @@ static int rfcomm_recv_sabm(struct rfcomm_session *s, u8 dlci)
 		if (rfcomm_check_link_mode(d)) {
 			set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 			rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
-		} else
-			rfcomm_dlc_accept(d);
+		} else {
+			defer_to = rfcomm_defer_setup(d);
+			if (defer_to) {
+				set_bit(RFCOMM_DEFER_SETUP, &d->flags);
+				rfcomm_dlc_set_timer(d, msecs_to_jiffies(defer_to));
+			} else {
+				rfcomm_dlc_accept(d);
+			}
+		}
 	} else {
 		rfcomm_send_dm(s, dlci);
 	}
@@ -1722,8 +1754,12 @@ static inline void rfcomm_process_dlcs(struct rfcomm_session *s)
 			if (d->out) {
 				rfcomm_send_pn(s, 1, d);
 				rfcomm_dlc_set_timer(d, RFCOMM_CONN_TIMEOUT);
-			} else
-				rfcomm_dlc_accept(d);
+			} else {
+				if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
+					return;
+				else
+					rfcomm_dlc_accept(d);
+			}
 			if (d->link_mode & RFCOMM_LM_SECURE) {
 				struct sock *sk = s->sock->sk;
 				hci_conn_change_link_key(l2cap_pi(sk)->conn->hcon);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8a972b6..9f3f259 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -103,9 +103,10 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 			sock_set_flag(sk, SOCK_ZAPPED);
 			bt_accept_unlink(sk);
 		}
+		parent->sk_state = BT_CLOSED;
 		parent->sk_data_ready(parent, 0);
 	} else {
-		if (d->state == BT_CONNECTED)
+		if (d->state == BT_CONNECTED && d->defer_setup)
 			rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
 		sk->sk_state_change(sk);
 	}
@@ -267,11 +268,14 @@ static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
 	if (parent) {
 		sk->sk_type = parent->sk_type;
 		pi->link_mode = rfcomm_pi(parent)->link_mode;
+		pi->defer_setup = rfcomm_pi(parent)->defer_setup;
 	} else {
 		pi->link_mode = 0;
+		pi->defer_setup = 0;
 	}
 
 	pi->dlc->link_mode = pi->link_mode;
+	pi->dlc->defer_setup = pi->defer_setup;
 }
 
 static struct proto rfcomm_proto = {
@@ -526,7 +530,7 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 
 	newsock->state = SS_CONNECTED;
 
-	BT_DBG("new socket %p", nsk);
+	BT_DBG("new socket %p, sock->state %d", nsk, sk->sk_state);
 
 done:
 	release_sock(sk);
@@ -567,6 +571,9 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
+	if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
+		return -ENOTCONN;
+
 	lock_sock(sk);
 
 	while (len) {
@@ -635,6 +642,7 @@ static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 			       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
 	int err = 0;
 	size_t target, copied = 0;
 	long timeo;
@@ -646,6 +654,9 @@ static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	BT_DBG("sk %p size %d", sk, size);
 
+	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags))
+		return rfcomm_dlc_accept_conn(d);
+
 	lock_sock(sk);
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, size);
@@ -725,20 +736,38 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 
 	lock_sock(sk);
 
-	switch (optname) {
-	case RFCOMM_LM:
-		if (get_user(opt, (u32 __user *) optval)) {
-			err = -EFAULT;
+	if (level == SOL_BLUETOOTH) {
+		switch (optname) {
+		case BT_DEFER_SETUP:
+			if (get_user(opt, (u32 __user *) optval)) {
+				err = -EFAULT;
+				break;
+			}
+
+			rfcomm_pi(sk)->defer_setup = opt;
+			break;
+
+		default:
+			err = -ENOPROTOOPT;
 			break;
 		}
+	} else if (level == SOL_RFCOMM) {
+		switch (optname) {
+		case RFCOMM_LM:
+			if (get_user(opt, (u32 __user *) optval)) {
+				err = -EFAULT;
+				break;
+			}
 
-		rfcomm_pi(sk)->link_mode = opt;
-		break;
+			rfcomm_pi(sk)->link_mode = opt;
+			break;
 
-	default:
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+	} else
 		err = -ENOPROTOOPT;
-		break;
-	}
 
 	release_sock(sk);
 	return err;
@@ -758,33 +787,47 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 
 	lock_sock(sk);
 
-	switch (optname) {
-	case RFCOMM_LM:
-		if (put_user(rfcomm_pi(sk)->link_mode, (u32 __user *) optval))
-			err = -EFAULT;
-		break;
-
-	case RFCOMM_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED) {
-			err = -ENOTCONN;
+	if (level == SOL_RFCOMM) {
+		switch (optname) {
+		case RFCOMM_LM:
+			if (put_user(rfcomm_pi(sk)->link_mode, (u32 __user *) optval))
+				err = -EFAULT;
 			break;
-		}
 
-		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
+		case RFCOMM_CONNINFO:
+			if (sk->sk_state != BT_CONNECTED) {
+				err = -ENOTCONN;
+				break;
+			}
 
-		cinfo.hci_handle = l2cap_pi(l2cap_sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, l2cap_pi(l2cap_sk)->conn->hcon->dev_class, 3);
+			l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
-			err = -EFAULT;
+			cinfo.hci_handle = l2cap_pi(l2cap_sk)->conn->hcon->handle;
+			memcpy(cinfo.dev_class, l2cap_pi(l2cap_sk)->conn->hcon->dev_class, 3);
 
-		break;
+			len = min_t(unsigned int, len, sizeof(cinfo));
+			if (copy_to_user(optval, (char *) &cinfo, len))
+				err = -EFAULT;
 
-	default:
+			break;
+
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+	} else if (level == SOL_BLUETOOTH) {
+		switch (optname) {
+		case BT_DEFER_SETUP:
+			if (put_user(rfcomm_pi(sk)->defer_setup, (u32 __user *) optval))
+				err = -EFAULT;
+			break;
+
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+	} else
 		err = -ENOPROTOOPT;
-		break;
-	}
 
 	release_sock(sk);
 	return err;
@@ -884,7 +927,10 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	bacpy(&bt_sk(sk)->dst, &dst);
 	rfcomm_pi(sk)->channel = channel;
 
-	sk->sk_state = BT_CONFIG;
+	if (rfcomm_pi(sk)->dlc->defer_setup)
+		sk->sk_state = BT_CONNECTED;
+	else
+		sk->sk_state = BT_CONFIG;
 	bt_accept_enqueue(parent, sk);
 
 	/* Accept connection and return socket DLC */
@@ -893,6 +939,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 done:
 	bh_unlock_sock(parent);
+	parent->sk_state_change(parent);
+
 	return result;
 }
 
-- 
1.6.0.4


--------------070206020406060007070203
Content-Type: text/x-patch;
 name="0001-hack-to-test-connection-defer-feature.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-hack-to-test-connection-defer-feature.patch"

>From d6510a66b1df0ff6da1049b8d3a8ba61ccc2cd6f Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Wed, 3 Dec 2008 14:00:56 +0200
Subject: [PATCH] hack to test connection defer feature

---
 test/rctest.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 08620d4..11bc97f 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -81,6 +81,9 @@ static int secure = 0;
 static int socktype = SOCK_STREAM;
 static int linger = 0;
 static int timestamp = 0;
+static int defer_setup = 0;
+
+#define BT_DEFER_SETUP 0x02
 
 static float tv2fl(struct timeval tv)
 {
@@ -231,6 +234,16 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
+	/* Enable deferred connection setup */
+	if (defer_setup > 0) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &defer_setup,
+			       sizeof(defer_setup))) {
+			syslog(LOG_ERR, "Can't enable BT_DEFER_SETUP: %s (%d)",
+							strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
@@ -286,6 +299,14 @@ static void do_listen(void (*handler)(int sk))
 			ba, conn.hci_handle,
 			conn.dev_class[2], conn.dev_class[1], conn.dev_class[0]);
 
+		if (defer_setup > 0) {
+			syslog(LOG_INFO, "Waiting for %d msecs before making connection active",
+					  defer_setup - 1000);
+			usleep((defer_setup - 1000) * 1000);
+			close(nsk);
+			goto error;
+		}
+
 #if 0
 		/* Enable SO_TIMESTAMP */
 		if (timestamp) {
@@ -353,7 +374,7 @@ static void recv_mode(int sk)
 			//uint16_t l;
 			int r;
 
-			if ((r = recv(sk, buf, data_size, 0)) <= 0) {
+			if ((r = recv(sk, buf, data_size, 0)) < 0) {
 				if (r < 0)
 					syslog(LOG_ERR, "Read failed: %s (%d)",
 							strerror(errno), errno);
@@ -510,7 +531,8 @@ static void usage(void)
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
 		"\t[-M] become master\n"
-		"\t[-T] enable timestamps\n");
+		"\t[-T] enable timestamps\n"
+		"\t[-F] deFerrred setup\n");
 }
 
 int main(int argc, char *argv[])
@@ -520,7 +542,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:B:N:MAESL:C:D:T")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnb:i:P:B:N:MAESL:C:D:TF:")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
@@ -614,6 +636,10 @@ int main(int argc, char *argv[])
 			timestamp = 1;
 			break;
 
+		case 'F':
+			defer_setup = atoi(optarg);
+			break;
+
 		default:
 			usage();
 			exit(1);
-- 
1.6.0.4


--------------070206020406060007070203--
