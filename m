Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 09/18] Bluetooth: l2cap: add l2cap_sock_get_hci_conn() helper
Date: Tue,  2 Apr 2013 18:08:29 +0200
Message-Id: <1364918918-2336-10-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
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
index db6694f..f0f9875 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -788,6 +788,7 @@ extern bool disable_ertm;
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 bool l2cap_is_socket(struct socket *sock);
+struct hci_conn *l2cap_sock_get_hci_conn(struct socket *sock);
 
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 461e8bc..75de59f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -49,6 +49,27 @@ bool l2cap_is_socket(struct socket *sock)
 }
 EXPORT_SYMBOL(l2cap_is_socket);
 
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
1.8.2
