Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Store SCO address information in its own socket structure
Date: Sun, 13 Oct 2013 10:34:01 -0700
Message-Id: <1381685643-57066-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address information of SCO sockets should be stored in its own
socket structure. Trying to generalize them is not helpful since
different transports have different address types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h |  2 ++
 net/bluetooth/sco.c         | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 94703a2..2019d1a 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -69,6 +69,8 @@ struct sco_conn {
 
 struct sco_pinfo {
 	struct bt_sock	bt;
+	bdaddr_t	src;
+	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
 	struct sco_conn	*conn;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2cc8f42..a92aeba 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -158,9 +158,9 @@ static int sco_connect(struct sock *sk)
 	struct hci_dev  *hdev;
 	int err, type;
 
-	BT_DBG("%pMR -> %pMR", &bt_sk(sk)->src, &bt_sk(sk)->dst);
+	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
 
-	hdev = hci_get_route(&bt_sk(sk)->dst, &bt_sk(sk)->src);
+	hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -177,7 +177,7 @@ static int sco_connect(struct sock *sk)
 		goto done;
 	}
 
-	hcon = hci_connect_sco(hdev, type, &bt_sk(sk)->dst,
+	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
 			       sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
@@ -192,7 +192,7 @@ static int sco_connect(struct sock *sk)
 	}
 
 	/* Update source addr of the socket */
-	bacpy(&bt_sk(sk)->src, &hcon->src);
+	bacpy(&sco_pi(sk)->src, &hcon->src);
 
 	err = sco_chan_add(conn, sk, NULL);
 	if (err)
@@ -266,7 +266,7 @@ static struct sock *__sco_get_sock_listen_by_addr(bdaddr_t *ba)
 		if (sk->sk_state != BT_LISTEN)
 			continue;
 
-		if (!bacmp(&bt_sk(sk)->src, ba))
+		if (!bacmp(&sco_pi(sk)->src, ba))
 			return sk;
 	}
 
@@ -287,11 +287,11 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 			continue;
 
 		/* Exact match. */
-		if (!bacmp(&bt_sk(sk)->src, src))
+		if (!bacmp(&sco_pi(sk)->src, src))
 			break;
 
 		/* Closest match */
-		if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+		if (!bacmp(&sco_pi(sk)->src, BDADDR_ANY))
 			sk1 = sk;
 	}
 
@@ -471,7 +471,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 		goto done;
 	}
 
-	bacpy(&bt_sk(sk)->src, &sa->sco_bdaddr);
+	bacpy(&sco_pi(sk)->src, &sa->sco_bdaddr);
 
 	sk->sk_state = BT_BOUND;
 
@@ -501,7 +501,7 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr *addr, int alen
 	lock_sock(sk);
 
 	/* Set destination address and psm */
-	bacpy(&bt_sk(sk)->dst, &sa->sco_bdaddr);
+	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 
 	err = sco_connect(sk);
 	if (err)
@@ -518,7 +518,7 @@ done:
 static int sco_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
-	bdaddr_t *src = &bt_sk(sk)->src;
+	bdaddr_t *src = &sco_pi(sk)->src;
 	int err = 0;
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
@@ -622,9 +622,9 @@ static int sco_sock_getname(struct socket *sock, struct sockaddr *addr, int *len
 	*len = sizeof(struct sockaddr_sco);
 
 	if (peer)
-		bacpy(&sa->sco_bdaddr, &bt_sk(sk)->dst);
+		bacpy(&sa->sco_bdaddr, &sco_pi(sk)->dst);
 	else
-		bacpy(&sa->sco_bdaddr, &bt_sk(sk)->src);
+		bacpy(&sa->sco_bdaddr, &sco_pi(sk)->src);
 
 	return 0;
 }
@@ -1013,8 +1013,8 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 		sco_sock_init(sk, parent);
 
-		bacpy(&bt_sk(sk)->src, &conn->hcon->src);
-		bacpy(&bt_sk(sk)->dst, &conn->hcon->dst);
+		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
+		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
@@ -1047,8 +1047,8 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		if (sk->sk_state != BT_LISTEN)
 			continue;
 
-		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr) ||
-		    !bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
+		if (!bacmp(&sco_pi(sk)->src, &hdev->bdaddr) ||
+		    !bacmp(&sco_pi(sk)->src, BDADDR_ANY)) {
 			lm |= HCI_LM_ACCEPT;
 
 			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
@@ -1107,8 +1107,8 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 	read_lock(&sco_sk_list.lock);
 
 	sk_for_each(sk, &sco_sk_list.head) {
-		seq_printf(f, "%pMR %pMR %d\n", &bt_sk(sk)->src,
-			   &bt_sk(sk)->dst, sk->sk_state);
+		seq_printf(f, "%pMR %pMR %d\n", &sco_pi(sk)->src,
+			   &sco_pi(sk)->dst, sk->sk_state);
 	}
 
 	read_unlock(&sco_sk_list.lock);
-- 
1.8.3.1

