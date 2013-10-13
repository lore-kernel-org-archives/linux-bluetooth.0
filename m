Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use SCO addresses from HCI connection directly
Date: Sun, 13 Oct 2013 10:15:22 -0700
Message-Id: <1381684522-35575-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of storing a pointer to the addresses for the HCI device
and HCI connection, use them directly. With the recent changes
to address tracking of HCI connections, this becomes simple.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/sco.h |  3 ---
 net/bluetooth/sco.c         | 20 ++++++++------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index e252a31..94703a2 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -55,9 +55,6 @@ struct sco_conninfo {
 struct sco_conn {
 	struct hci_conn	*hcon;
 
-	bdaddr_t	*dst;
-	bdaddr_t	*src;
-
 	spinlock_t	lock;
 	struct sock	*sk;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 96bd388..2cc8f42 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -92,9 +92,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
 
-	conn->src = &hdev->bdaddr;
-	conn->dst = &hcon->dst;
-
 	if (hdev->sco_mtu > 0)
 		conn->mtu = hdev->sco_mtu;
 	else
@@ -156,16 +153,14 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 
 static int sco_connect(struct sock *sk)
 {
-	bdaddr_t *src = &bt_sk(sk)->src;
-	bdaddr_t *dst = &bt_sk(sk)->dst;
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
 	int err, type;
 
-	BT_DBG("%pMR -> %pMR", src, dst);
+	BT_DBG("%pMR -> %pMR", &bt_sk(sk)->src, &bt_sk(sk)->dst);
 
-	hdev = hci_get_route(dst, src);
+	hdev = hci_get_route(&bt_sk(sk)->dst, &bt_sk(sk)->src);
 	if (!hdev)
 		return -EHOSTUNREACH;
 
@@ -182,7 +177,8 @@ static int sco_connect(struct sock *sk)
 		goto done;
 	}
 
-	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
+	hcon = hci_connect_sco(hdev, type, &bt_sk(sk)->dst,
+			       sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
@@ -196,7 +192,7 @@ static int sco_connect(struct sock *sk)
 	}
 
 	/* Update source addr of the socket */
-	bacpy(src, conn->src);
+	bacpy(&bt_sk(sk)->src, &hcon->src);
 
 	err = sco_chan_add(conn, sk, NULL);
 	if (err)
@@ -999,7 +995,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 	} else {
 		sco_conn_lock(conn);
 
-		parent = sco_get_sock_listen(conn->src);
+		parent = sco_get_sock_listen(&conn->hcon->src);
 		if (!parent) {
 			sco_conn_unlock(conn);
 			return;
@@ -1017,8 +1013,8 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 		sco_sock_init(sk, parent);
 
-		bacpy(&bt_sk(sk)->src, conn->src);
-		bacpy(&bt_sk(sk)->dst, conn->dst);
+		bacpy(&bt_sk(sk)->src, &conn->hcon->src);
+		bacpy(&bt_sk(sk)->dst, &conn->hcon->dst);
 
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
-- 
1.8.3.1

