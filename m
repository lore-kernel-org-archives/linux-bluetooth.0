Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 11/16] Bluetooth: l2cap: add l2cap_sock_get_hci_conn() helper
Date: Sun, 24 Feb 2013 19:37:01 +0100
Message-Id: <1361731026-7428-12-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Many sub-modules like HIDP get l2cap sockets as input from user-space but
need access to the hci_conn to properly track the connection. This helper
returns a reference to the current hci_conn of a given l2cap-socket. If
the socket is not connected, NULL is returned.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_sock.c    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ae6210e..17d0940 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -788,6 +788,7 @@ extern bool disable_ertm;
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 bool is_l2cap_socket(struct socket *s);
+struct hci_conn *l2cap_sock_get_hci_conn(struct socket *s);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 598b167..f69f604 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -49,6 +49,27 @@ bool is_l2cap_socket(struct socket *s)
 }
 EXPORT_SYMBOL(is_l2cap_socket);
 
+struct hci_conn *l2cap_sock_get_hci_conn(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct hci_conn *hcon;
+
+	l2cap_chan_lock(chan);
+
+	if (chan->conn) {
+		hcon = chan->conn->hcon;
+		hci_conn_get(hcon);
+	} else {
+		hcon = NULL;
+	}
+
+	l2cap_chan_unlock(chan);
+
+	return hcon;
+}
+EXPORT_SYMBOL(l2cap_sock_get_hci_conn);
+
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
-- 
1.8.1.4
