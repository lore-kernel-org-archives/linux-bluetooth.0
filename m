Return-Path: <cyrus@holtmann.org>
Message-ID: <496895AB.4050902@nokia.com>
Date: Sat, 10 Jan 2009 14:33:47 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: ext Nick Pelly <npelly@google.com>, marcel@holtmann.org,
        johan.hedberg@nokia.com
Subject: [RFC] Some kernel changes
Content-Type: multipart/mixed;
 boundary="------------050304060302080609040701"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050304060302080609040701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


Here is set of unclean patches for discussion. These are still untested 
and contain issues, but I would like to know if we should continue with 
these or change something radically. Also commit messages are somewhat 
misleading in some places.

Basically idea is to implement connection rejection support for l2cap 
and rfcomm sockets. IOW possibility to check initiator bd-address and 
ask for authorization before accepting connection.

Other goal is to fix encryption and authentication levels to fulfill 2.1 
requirements.

-- 
Ville

--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0001-Support-for-deferring-rfcomm-connection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Support-for-deferring-rfcomm-connection.patch"

>From 954d3e82ee5e0a8a440021a80d763922bd5d0e55 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Thu, 18 Dec 2008 16:43:33 +0200
Subject: [PATCH 1/7] Support for deferring rfcomm connection

In order to decide if listening rfcomm socket should be accept()ed
the bd_addr of remote device needs to be known. This patch add
a socket option which defines timeout for deferring connection setup.

The connection is actually allowed after reading from socket first
time. Until reading first time writing to socket returns -ENOTCONN.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/bluetooth.h |    4 +
 include/net/bluetooth/rfcomm.h    |    6 ++-
 net/bluetooth/rfcomm/core.c       |   48 ++++++++++++++--
 net/bluetooth/rfcomm/sock.c       |  111 ++++++++++++++++++++++++++-----------
 4 files changed, 130 insertions(+), 39 deletions(-)

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
index 8a972b6..0ffe813 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -105,7 +105,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		}
 		parent->sk_data_ready(parent, 0);
 	} else {
-		if (d->state == BT_CONNECTED)
+		if (d->state == BT_CONNECTED && d->defer_setup)
 			rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
 		sk->sk_state_change(sk);
 	}
@@ -267,11 +267,14 @@ static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
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
@@ -526,7 +529,7 @@ static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int f
 
 	newsock->state = SS_CONNECTED;
 
-	BT_DBG("new socket %p", nsk);
+	BT_DBG("new socket %p, sock->state %d", nsk, sk->sk_state);
 
 done:
 	release_sock(sk);
@@ -567,6 +570,9 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
+	if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
+		return -ENOTCONN;
+
 	lock_sock(sk);
 
 	while (len) {
@@ -635,6 +641,7 @@ static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 			       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
 	int err = 0;
 	size_t target, copied = 0;
 	long timeo;
@@ -646,6 +653,9 @@ static int rfcomm_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	BT_DBG("sk %p size %d", sk, size);
 
+	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags))
+		return rfcomm_dlc_accept_conn(d);
+
 	lock_sock(sk);
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, size);
@@ -725,20 +735,38 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 
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
@@ -758,33 +786,47 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 
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
@@ -884,7 +926,10 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	bacpy(&bt_sk(sk)->dst, &dst);
 	rfcomm_pi(sk)->channel = channel;
 
-	sk->sk_state = BT_CONFIG;
+	if (rfcomm_pi(sk)->dlc->defer_setup)
+		sk->sk_state = BT_CONNECTED;
+	else
+		sk->sk_state = BT_CONFIG;
 	bt_accept_enqueue(parent, sk);
 
 	/* Accept connection and return socket DLC */
@@ -893,6 +938,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 done:
 	bh_unlock_sock(parent);
+	parent->sk_state_change(parent);
+
 	return result;
 }
 
-- 
1.6.0.4


--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0002-bluetooth-Introduce-security-levels.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-bluetooth-Introduce-security-levels.patch"

>From 0b28c2c7d0fa9df936995019522f887e9d743ef2 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Mon, 22 Dec 2008 15:22:23 +0200
Subject: [PATCH 2/7] bluetooth: Introduce security levels

This patch introduces security levels for RFCOMM sockets.
---
 include/net/bluetooth/bluetooth.h |    9 +++++++++
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/l2cap.h     |    2 ++
 include/net/bluetooth/rfcomm.h    |    2 ++
 net/bluetooth/rfcomm/core.c       |   36 ++++++++++++++++++++++++++++++++----
 net/bluetooth/rfcomm/sock.c       |   34 +++++++++++++++++++++++++++++++++-
 6 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1a0fa21..b5af61c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -57,6 +57,15 @@
 
 #define BT_DEFER_SETUP	0x02
 
+#define BT_SECURITY	0x03
+struct bt_security {
+	__u8 level;
+};
+#define BT_SECURITY_SDP		0
+#define BT_SECURITY_LOW		1
+#define BT_SECURITY_MEDIUM	2
+#define BT_SECURITY_HIGH	3
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_DBG(fmt, arg...)  printk(KERN_INFO "%s: " fmt "\n" , __FUNCTION__ , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR  "%s: " fmt "\n" , __FUNCTION__ , ## arg)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 019cd93..419c518 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -169,6 +169,7 @@ struct hci_conn {
 	__u16            link_policy;
 	__u32		 link_mode;
 	__u8             auth_type;
+	__u8		 seclevel;
 	__u8             power_save;
 	unsigned long	 pend;
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 73e115b..a178778 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -234,10 +234,12 @@ struct l2cap_pinfo {
 	__u16		dcid;
 	__u16		scid;
 
+	__u8		seclevel;
 	__u16		imtu;
 	__u16		omtu;
 	__u16		flush_to;
 
+	__u32		defer_setup;
 	__u32		link_mode;
 
 	__u8		conf_req[64];
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index eaa1365..7161def 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -186,6 +186,7 @@ struct rfcomm_dlc {
 
 	u32           defer_setup;
 	u32           link_mode;
+	u8            seclevel;
 
 	uint          mtu;
 	uint          cfc;
@@ -309,6 +310,7 @@ struct rfcomm_pinfo {
 	u8     channel;
 	u32    link_mode;
 	u32    defer_setup;
+	u8     seclevel;
 };
 
 int  rfcomm_init_sockets(void);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7878e3c..f0cd6ee 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -239,6 +239,20 @@ static inline int rfcomm_check_link_mode(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 
+	if (d->seclevel == BT_SECURITY_HIGH)
+		if (!hci_conn_auth(l2cap_pi(sk)->conn->hcon))
+			return 1;
+
+	if (d->seclevel == BT_SECURITY_MEDIUM)
+		if (!hci_conn_encrypt(l2cap_pi(sk)->conn->hcon))
+			return 1;
+
+	if (d->seclevel == BT_SECURITY_LOW)
+		if (l2cap_pi(sk)->conn->hcon->hdev->ssp_mode > 0 &&
+				l2cap_pi(sk)->conn->hcon->ssp_mode > 0)
+			if (!hci_conn_encrypt(l2cap_pi(sk)->conn->hcon))
+				return 1;
+
 	if (d->link_mode & (RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE)) {
 		if (!hci_conn_encrypt(l2cap_pi(sk)->conn->hcon))
 			return 1;
@@ -2007,17 +2021,21 @@ static void rfcomm_auth_cfm(struct hci_conn *conn, u8 status)
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
 
+		if (d->seclevel == BT_SECURITY_HIGH ||
+		    d->seclevel == BT_SECURITY_MEDIUM)
+			continue;
+
 		if ((d->link_mode & (RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE)) &&
-				!(conn->link_mode & HCI_LM_ENCRYPT) && !status)
+				(conn->link_mode & HCI_LM_ENCRYPT) && !status)
 			continue;
 
 		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
 			continue;
 
-		if (!status)
-			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
-		else
+		if (status)
 			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
+		else
+			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
 	}
 
 	rfcomm_session_put(s);
@@ -2030,6 +2048,7 @@ static void rfcomm_encrypt_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 	struct rfcomm_session *s;
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
+	int sec;
 
 	BT_DBG("conn %p status 0x%02x encrypt 0x%02x", conn, status, encrypt);
 
@@ -2041,6 +2060,15 @@ static void rfcomm_encrypt_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
+		sec = d->seclevel;
+	
+		if ((sec == BT_SECURITY_HIGH || sec == BT_SECURITY_MEDIUM) &&
+					(d->state == BT_CONNECTED ||
+						d->state == BT_CONFIG) &&
+						!status && encrypt == 0x00) {
+			__rfcomm_dlc_close(d, ECONNREFUSED);
+			continue;
+		}
 
 		if ((d->link_mode & (RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE)) &&
 					(d->state == BT_CONNECTED ||
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 0ffe813..cb4f7ba 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -268,13 +268,16 @@ static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		pi->link_mode = rfcomm_pi(parent)->link_mode;
 		pi->defer_setup = rfcomm_pi(parent)->defer_setup;
+		pi->seclevel = rfcomm_pi(parent)->seclevel;
 	} else {
 		pi->link_mode = 0;
 		pi->defer_setup = 0;
+		pi->seclevel = BT_SECURITY_LOW;
 	}
 
 	pi->dlc->link_mode = pi->link_mode;
 	pi->dlc->defer_setup = pi->defer_setup;
+	pi->dlc->seclevel = pi->seclevel;
 }
 
 static struct proto rfcomm_proto = {
@@ -415,6 +418,7 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	rfcomm_pi(sk)->channel = sa->rc_channel;
 
 	d->link_mode = rfcomm_pi(sk)->link_mode;
+	d->link_mode = rfcomm_pi(sk)->seclevel;
 
 	err = rfcomm_dlc_open(d, &bt_sk(sk)->src, &sa->rc_bdaddr, sa->rc_channel);
 	if (!err)
@@ -728,7 +732,8 @@ out:
 static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
-	int err = 0;
+	struct bt_security sec;
+	int len, err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -737,6 +742,23 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 
 	if (level == SOL_BLUETOOTH) {
 		switch (optname) {
+		case BT_SECURITY:
+			sec.level = BT_SECURITY_LOW;
+
+			len = min_t(unsigned int, sizeof(sec), optlen);
+			if (copy_from_user((char *) &sec, optval, len)) {
+				err = -EFAULT;
+				break;
+			}
+
+			if (sec.level > 3) {
+				err = -EINVAL;
+				break;
+			}
+
+			rfcomm_pi(sk)->seclevel = sec.level;
+			break;
+
 		case BT_DEFER_SETUP:
 			if (get_user(opt, (u32 __user *) optval)) {
 				err = -EFAULT;
@@ -775,6 +797,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
+	struct bt_security sec;
 	struct sock *l2cap_sk;
 	struct rfcomm_conninfo cinfo;
 	int len, err = 0;
@@ -816,6 +839,15 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 		}
 	} else if (level == SOL_BLUETOOTH) {
 		switch (optname) {
+		case BT_SECURITY:
+			sec.level = rfcomm_pi(sk)->seclevel;
+
+			len = min_t(unsigned int, len, sizeof(sec));
+			if (copy_to_user(optval, (char *) &sec, len))
+				err = -EFAULT;
+
+			break;
+
 		case BT_DEFER_SETUP:
 			if (put_user(rfcomm_pi(sk)->defer_setup, (u32 __user *) optval))
 				err = -EFAULT;
-- 
1.6.0.4


--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0004-bluetooth-l2cap-seclevel.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="0004-bluetooth-l2cap-seclevel.patch"

>From d72c9195905214020408d989eca902330d3c19f0 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Mon, 29 Dec 2008 13:56:30 +0200
Subject: [PATCH 4/7] bluetooth: l2cap seclevel

This patch introduces preliminary l2cap seclevel support.
---
 net/bluetooth/l2cap.c |  130 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 98 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9610a9c..6a643f7 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -83,6 +83,9 @@ static void l2cap_sock_timeout(unsigned long arg)
 	bh_lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT &&
+			(l2cap_pi(sk)->seclevel == BT_SECURITY_HIGH))
+		reason = ECONNREFUSED;
+	else if (sk->sk_state == BT_CONNECT &&
 			(l2cap_pi(sk)->link_mode & (L2CAP_LM_AUTH |
 					L2CAP_LM_ENCRYPT | L2CAP_LM_SECURE)))
 		reason = ECONNREFUSED;
@@ -268,10 +271,16 @@ static inline int l2cap_check_link_mode(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 
+	if (l2cap_pi(sk)->seclevel == BT_SECURITY_MEDIUM)
+		return hci_conn_encrypt(conn->hcon);
+
 	if ((l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
 				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE))
 		return hci_conn_encrypt(conn->hcon);
 
+	if (l2cap_pi(sk)->seclevel == BT_SECURITY_HIGH)
+		return hci_conn_auth(conn->hcon);
+
 	if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH)
 		return hci_conn_auth(conn->hcon);
 
@@ -790,18 +799,32 @@ static int l2cap_do_connect(struct sock *sk)
 
 	err = -ENOMEM;
 
-	if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH ||
-			l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT ||
+	auth_type = 0;
+	switch (l2cap_pi(sk)->seclevel) {
+	case BT_SECURITY_HIGH:
+		auth_type = HCI_AT_GENERAL_BONDING_MITM;
+		break;
+	case BT_SECURITY_MEDIUM:
+	case BT_SECURITY_LOW:
+		auth_type = HCI_AT_GENERAL_BONDING;
+		break;
+	case BT_SECURITY_SDP:
+		auth_type = HCI_AT_NO_BONDING;
+		break;
+	default:
+		if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH ||
+				l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT ||
 				l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE) {
-		if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001))
-			auth_type = HCI_AT_NO_BONDING_MITM;
-		else
-			auth_type = HCI_AT_GENERAL_BONDING_MITM;
-	} else {
-		if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001))
-			auth_type = HCI_AT_NO_BONDING;
-		else
-			auth_type = HCI_AT_GENERAL_BONDING;
+			if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001))
+				auth_type = HCI_AT_NO_BONDING_MITM;
+			else
+				auth_type = HCI_AT_GENERAL_BONDING_MITM;
+		} else {
+			if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001))
+				auth_type = HCI_AT_NO_BONDING;
+			else
+				auth_type = HCI_AT_GENERAL_BONDING;
+		}
 	}
 
 	hcon = hci_connect(hdev, ACL_LINK, dst, auth_type);
@@ -1115,6 +1138,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_options opts;
+	struct bt_security sec;
 	int err = 0, len;
 	u32 opt;
 
@@ -1122,36 +1146,61 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	lock_sock(sk);
 
-	switch (optname) {
-	case L2CAP_OPTIONS:
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = L2CAP_MODE_BASIC;
+	if (level== SOL_BLUETOOTH) {
+		switch (optname) {
+		case BT_SECURITY:
+			sec.level = BT_SECURITY_LOW;
+			len = min_t(unsigned int, sizeof(sec), optlen);
+			if (copy_from_user((char *) &sec, optval, len)) {
+				err = -EFAULT;
+				break;
+			}
 
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_user((char *) &opts, optval, len)) {
-			err = -EFAULT;
+			if (sec.level > BT_SECURITY_HIGH) {
+				err = -EINVAL;
+				break;
+			}
+
+			l2cap_pi(sk)->seclevel = sec.level;
 			break;
 		}
 
-		l2cap_pi(sk)->imtu  = opts.imtu;
-		l2cap_pi(sk)->omtu  = opts.omtu;
-		break;
+		default:
+			err = -ENOPROTOOPT;
+			break;
+	} else if (level = SOL_L2CAP) {
+		switch (optname) {
+		case L2CAP_OPTIONS:
+			opts.imtu     = l2cap_pi(sk)->imtu;
+			opts.omtu     = l2cap_pi(sk)->omtu;
+			opts.flush_to = l2cap_pi(sk)->flush_to;
+			opts.mode     = L2CAP_MODE_BASIC;
+
+			len = min_t(unsigned int, sizeof(opts), optlen);
+			if (copy_from_user((char *) &opts, optval, len)) {
+				err = -EFAULT;
+				break;
+			}
 
-	case L2CAP_LM:
-		if (get_user(opt, (u32 __user *) optval)) {
-			err = -EFAULT;
+			l2cap_pi(sk)->imtu  = opts.imtu;
+			l2cap_pi(sk)->omtu  = opts.omtu;
 			break;
-		}
 
-		l2cap_pi(sk)->link_mode = opt;
-		break;
+		case L2CAP_LM:
+			if (get_user(opt, (u32 __user *) optval)) {
+				err = -EFAULT;
+				break;
+			}
 
-	default:
+			l2cap_pi(sk)->link_mode = opt;
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
@@ -2209,6 +2258,13 @@ static int l2cap_auth_cfm(struct hci_conn *hcon, u8 status)
 
 		bh_lock_sock(sk);
 
+		if (pi->seclevel == BT_SECURITY_HIGH &&
+			!(hcon->link_mode & HCI_LM_ENCRYPT) &&
+			!status) {
+			bh_unlock_sock(sk);
+			continue;
+		}
+
 		if ((pi->link_mode & (L2CAP_LM_ENCRYPT | L2CAP_LM_SECURE)) &&
 					!(hcon->link_mode & HCI_LM_ENCRYPT) &&
 								!status) {
@@ -2279,6 +2335,16 @@ static int l2cap_encrypt_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		bh_lock_sock(sk);
 
+		if ((pi->seclevel == BT_SECURITY_HIGH || pi->seclevel == BT_SECURITY_MEDIUM ||
+					pi->seclevel == BT_SECURITY_LOW) &&
+					(sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG) &&
+					!status && encrypt == 0x00) {
+			__l2cap_sock_close(sk, ECONNREFUSED);
+			bh_unlock_sock(sk);
+			continue;
+		}
+
+
 		if ((pi->link_mode & (L2CAP_LM_ENCRYPT | L2CAP_LM_SECURE)) &&
 					(sk->sk_state == BT_CONNECTED ||
 						sk->sk_state == BT_CONFIG) &&
-- 
1.6.0.4


--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0005-Compilation-fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="0005-Compilation-fix.patch"

>From 8220b7c1cac4fb3dd0e645d557c1828a7eb20345 Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Mon, 5 Jan 2009 16:12:09 +0200
Subject: [PATCH 5/7] Compilation fix

---
 net/bluetooth/l2cap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6a643f7..4fc5925 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1146,7 +1146,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	lock_sock(sk);
 
-	if (level== SOL_BLUETOOTH) {
+	if (level == SOL_BLUETOOTH) {
 		switch (optname) {
 		case BT_SECURITY:
 			sec.level = BT_SECURITY_LOW;
@@ -1163,12 +1163,12 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 			l2cap_pi(sk)->seclevel = sec.level;
 			break;
-		}
 
 		default:
 			err = -ENOPROTOOPT;
 			break;
-	} else if (level = SOL_L2CAP) {
+		}
+	} else if (level == SOL_L2CAP) {
 		switch (optname) {
 		case L2CAP_OPTIONS:
 			opts.imtu     = l2cap_pi(sk)->imtu;
-- 
1.6.0.4


--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0006--BLUETOOTH-Pause-rfcomm-TX-if-encryption-is-dropped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0006--BLUETOOTH-Pause-rfcomm-TX-if-encryption-is-dropped.pat";
 filename*1="ch"

>From 7d9f27632bc4482b7c30e9b0088c979ebbb0ff4b Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Wed, 7 Jan 2009 16:36:20 +0200
Subject: [PATCH 6/7] [BLUETOOTH] Pause rfcomm TX if encryption is dropped

Role switch is not possible with pre 2.1 devices if encryption
is enabled. With this patch TX is halted instead of disconnecting
the links if the other end disables encryption.
---
 net/bluetooth/rfcomm/core.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f0cd6ee..76ab491 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2061,19 +2061,37 @@ static void rfcomm_encrypt_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 	list_for_each_safe(p, n, &s->dlcs) {
 		d = list_entry(p, struct rfcomm_dlc, list);
 		sec = d->seclevel;
-	
+
+		if ((sec == BT_SECURITY_HIGH || sec == BT_SECURITY_MEDIUM) &&
+					d->state == BT_CONNECTED &&
+					!status && encrypt == 0x00) {
+			clear_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+			clear_bit(RFCOMM_AUTH_REJECT, &d->flags);
+			set_bit(RFCOMM_AUTH_PENDING, &d->flags);
+			rfcomm_dlc_set_timer(d, RFCOMM_CONN_TIMEOUT);
+			continue;
+		}
+
 		if ((sec == BT_SECURITY_HIGH || sec == BT_SECURITY_MEDIUM) &&
-					(d->state == BT_CONNECTED ||
-						d->state == BT_CONFIG) &&
-						!status && encrypt == 0x00) {
+					d->state == BT_CONFIG &&
+					!status && encrypt == 0x00) {
 			__rfcomm_dlc_close(d, ECONNREFUSED);
 			continue;
 		}
 
 		if ((d->link_mode & (RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE)) &&
-					(d->state == BT_CONNECTED ||
-						d->state == BT_CONFIG) &&
-						!status && encrypt == 0x00) {
+					d->state == BT_CONNECTED &&
+					!status && encrypt == 0x00) {
+			clear_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
+			clear_bit(RFCOMM_AUTH_REJECT, &d->flags);
+			set_bit(RFCOMM_AUTH_PENDING, &d->flags);
+			rfcomm_dlc_set_timer(d, RFCOMM_CONN_TIMEOUT);
+			continue;
+		}
+
+		if ((d->link_mode & (RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE)) &&
+					d->state == BT_CONFIG &&
+					!status && encrypt == 0x00) {
 			__rfcomm_dlc_close(d, ECONNREFUSED);
 			continue;
 		}
-- 
1.6.0.4


--------------050304060302080609040701
Content-Type: text/x-patch;
 name="0007--BLUETOOTH-Preliminary-l2cap-connection-rejection-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0007--BLUETOOTH-Preliminary-l2cap-connection-rejection-s.pat";
 filename*1="ch"

>From 8e4cca7a6b962b46021921ddef1d101b76bfb96b Mon Sep 17 00:00:00 2001
From: Ville Tervo <ville.tervo@nokia.com>
Date: Sat, 10 Jan 2009 13:53:49 +0200
Subject: [PATCH 7/7] [BLUETOOTH] Preliminary l2cap connection rejection support

This is preliminary and untested version of l2cap
connection rejection.
---
 include/net/bluetooth/bluetooth.h |    1 +
 net/bluetooth/af_bluetooth.c      |    3 +-
 net/bluetooth/l2cap.c             |  156 ++++++++++++++++++++++++++++++-------
 3 files changed, 130 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b5af61c..72f7869 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -78,6 +78,7 @@ enum {
 	BT_LISTEN,
 	BT_CONNECT,
 	BT_CONNECT2,
+	BT_DEFERRED,
 	BT_CONFIG,
 	BT_DISCONN,
 	BT_CLOSED
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index f6348e0..7547c03 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -223,7 +223,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 			continue;
 		}
 
-		if (sk->sk_state == BT_CONNECTED || !newsock) {
+		if (sk->sk_state == BT_DEFERRED || sk->sk_state == BT_CONNECTED
+		    || !newsock) {
 			bt_accept_unlink(sk);
 			if (newsock)
 				sock_graft(sk, newsock);
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 4fc5925..2745570 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -321,6 +321,53 @@ static inline int l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16
 	return hci_send_acl(conn->hcon, skb, 0);
 }
 
+static void l2cap_accept_connection(struct sock *sk)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_conn *conn = pi->conn;
+	struct l2cap_conn_rsp rsp;
+	int result, status = L2CAP_CS_NO_INFO;
+
+	hci_conn_hold(conn->hcon);
+	pi->defer_setup = 0;
+
+	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
+		if (l2cap_check_link_mode(sk)) {
+			sk->sk_state = BT_CONFIG;
+			result = L2CAP_CR_SUCCESS;
+			status = L2CAP_CS_NO_INFO;
+		} else {
+			sk->sk_state = BT_CONNECT2;
+			result = L2CAP_CR_PEND;
+			status = L2CAP_CS_AUTHEN_PEND;
+		}
+	} else {
+		sk->sk_state = BT_CONNECT2;
+		result = L2CAP_CR_PEND;
+		status = L2CAP_CS_NO_INFO;
+	}
+
+	rsp.scid   = cpu_to_le16(pi->dcid);
+	rsp.dcid   = cpu_to_le16(pi->scid);
+	rsp.result = cpu_to_le16(result);
+	rsp.status = cpu_to_le16(status);
+	l2cap_send_cmd(conn, pi->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
+		struct l2cap_info_req info;
+		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
+
+		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
+		conn->info_ident = l2cap_get_ident(conn);
+
+		mod_timer(&conn->info_timer, jiffies +
+					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
+
+		l2cap_send_cmd(conn, conn->info_ident,
+					L2CAP_INFO_REQ, sizeof(info), &info);
+	}
+}
+
 static void l2cap_do_start(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -1119,6 +1166,9 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	if (l2cap_pi(sk)->defer_setup)
+		return -ENOTCONN;
+
 	/* Check outgoing MTU */
 	if (sk->sk_type != SOCK_RAW && len > l2cap_pi(sk)->omtu)
 		return -EINVAL;
@@ -1134,6 +1184,19 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	return err;
 }
 
+static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+
+	if (pi->defer_setup) {
+		l2cap_accept_connection(sk);
+		return 0;
+	}
+
+	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
+}
+
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
@@ -1148,6 +1211,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	if (level == SOL_BLUETOOTH) {
 		switch (optname) {
+		case BT_DEFER_SETUP:
+			if (get_user(opt, (u32 __user *) optval)) {
+				err = -EFAULT;
+				break;
+			}
+
+			l2cap_pi(sk)->defer_setup = opt;
+			break;
 		case BT_SECURITY:
 			sec.level = BT_SECURITY_LOW;
 			len = min_t(unsigned int, sizeof(sec), optlen);
@@ -1211,6 +1282,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	struct sock *sk = sock->sk;
 	struct l2cap_options opts;
 	struct l2cap_conninfo cinfo;
+	struct bt_security sec;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -1220,43 +1292,65 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 	lock_sock(sk);
 
-	switch (optname) {
-	case L2CAP_OPTIONS:
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = L2CAP_MODE_BASIC;
+	if (level == SOL_L2CAP) {
+		switch (optname) {
+		case L2CAP_OPTIONS:
+			opts.imtu     = l2cap_pi(sk)->imtu;
+			opts.omtu     = l2cap_pi(sk)->omtu;
+			opts.flush_to = l2cap_pi(sk)->flush_to;
+			opts.mode     = L2CAP_MODE_BASIC;
+
+			len = min_t(unsigned int, len, sizeof(opts));
+			if (copy_to_user(optval, (char *) &opts, len))
+				err = -EFAULT;
 
-		len = min_t(unsigned int, len, sizeof(opts));
-		if (copy_to_user(optval, (char *) &opts, len))
-			err = -EFAULT;
+			break;
 
-		break;
+		case L2CAP_LM:
+			if (put_user(l2cap_pi(sk)->link_mode, (u32 __user *) optval))
+				err = -EFAULT;
+			break;
 
-	case L2CAP_LM:
-		if (put_user(l2cap_pi(sk)->link_mode, (u32 __user *) optval))
-			err = -EFAULT;
-		break;
+		case L2CAP_CONNINFO:
+			if (sk->sk_state != BT_CONNECTED) {
+				err = -ENOTCONN;
+				break;
+			}
+
+			cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
+			memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
+
+			len = min_t(unsigned int, len, sizeof(cinfo));
+			if (copy_to_user(optval, (char *) &cinfo, len))
+				err = -EFAULT;
 
-	case L2CAP_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED) {
-			err = -ENOTCONN;
 			break;
-		}
 
-		cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
+		default:
+			err = -ENOPROTOOPT;
+			break;
+		}
+	} else if (level == SOL_BLUETOOTH) {
+		switch (optname) {
+		case BT_SECURITY:
+			sec.level = l2cap_pi(sk)->seclevel;
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *) &cinfo, len))
-			err = -EFAULT;
+			len = min_t(unsigned int, len, sizeof(sec));
+			if (copy_to_user(optval, (char *) &sec, len))
+				err = -EFAULT;
+			break;
 
-		break;
+		case BT_DEFER_SETUP:
+			if (put_user(l2cap_pi(sk)->defer_setup, (u32 __user *) optval))
+				err = -EFAULT;
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
@@ -1675,7 +1769,11 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	l2cap_pi(sk)->ident = cmd->ident;
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
+	if (l2cap_pi(parent)->defer_setup) {
+		sk->sk_state = BT_DEFERRED;
+		result = L2CAP_CR_PEND;
+		status = L2CAP_CS_AUTHOR_PEND;
+	} else if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
 		if (l2cap_check_link_mode(sk)) {
 			sk->sk_state = BT_CONFIG;
 			result = L2CAP_CR_SUCCESS;
@@ -2518,7 +2616,7 @@ static const struct proto_ops l2cap_sock_ops = {
 	.accept		= l2cap_sock_accept,
 	.getname	= l2cap_sock_getname,
 	.sendmsg	= l2cap_sock_sendmsg,
-	.recvmsg	= bt_sock_recvmsg,
+	.recvmsg	= l2cap_sock_recvmsg,
 	.poll		= bt_sock_poll,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
-- 
1.6.0.4


--------------050304060302080609040701--
