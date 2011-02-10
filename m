Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [bluetooth-next 04/24] Bluetooth: Add LE connection support to L2CAP
Date: Wed,  9 Feb 2011 22:18:04 -0300
Message-Id: <1297300704-30006-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Add basic LE connection support to L2CAP. LE
connection can be created by specifying cid
in struct sockaddr_l2

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/l2cap.h |    3 +++
 net/bluetooth/l2cap_core.c    |   23 +++++++++++++++++++----
 net/bluetooth/l2cap_sock.c    |    7 ++++---
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 75ef0b2..78552a0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -160,6 +160,9 @@ struct l2cap_conn_rsp {
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_LE_DATA	0x0004
+#define L2CAP_CID_LE_SIGNALING	0x0005
+#define L2CAP_CID_SMP		0x0006
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ba7f9da..b322cf5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -595,6 +595,12 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
+		if (conn->hcon->type == LE_LINK) {
+			l2cap_sock_clear_timer(sk);
+			sk->sk_state = BT_CONNECTED;
+			sk->sk_state_change(sk);
+		}
+
 		if (sk->sk_type != SOCK_SEQPACKET &&
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
@@ -653,7 +659,11 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
-	conn->mtu = hcon->hdev->acl_mtu;
+	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
+		conn->mtu = hcon->hdev->le_mtu;
+	else
+		conn->mtu = hcon->hdev->acl_mtu;
+
 	conn->src = &hcon->hdev->bdaddr;
 	conn->dst = &hcon->dst;
 
@@ -760,8 +770,13 @@ int l2cap_do_connect(struct sock *sk)
 
 	auth_type = l2cap_get_auth_type(sk);
 
-	hcon = hci_connect(hdev, ACL_LINK, dst,
+	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
+		hcon = hci_connect(hdev, LE_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
+	else
+		hcon = hci_connect(hdev, ACL_LINK, dst,
+					l2cap_pi(sk)->sec_level, auth_type);
+
 	if (!hcon)
 		goto done;
 
@@ -3522,7 +3537,7 @@ static int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
-	if (hcon->type != ACL_LINK)
+	if (!(hcon->type == ACL_LINK || hcon->type == LE_LINK))
 		return -EINVAL;
 
 	if (!status) {
@@ -3551,7 +3566,7 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	if (hcon->type != ACL_LINK)
+	if (!(hcon->type == ACL_LINK || hcon->type == LE_LINK))
 		return -EINVAL;
 
 	l2cap_conn_del(hcon, bt_err(reason));
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index adf4169..b435e5f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -168,13 +168,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
+	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
 	lock_sock(sk);
 
 	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
-			&& !la.l2_psm) {
+			&& !(la.l2_psm || la.l2_cid)) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -216,7 +216,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	/* PSM must be odd and lsb of upper byte must be 0 */
 	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
-		sk->sk_type != SOCK_RAW) {
+				sk->sk_type != SOCK_RAW && !la.l2_cid) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -224,6 +224,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
 	l2cap_pi(sk)->psm = la.l2_psm;
+	l2cap_pi(sk)->dcid = la.l2_cid;
 
 	err = l2cap_do_connect(sk);
 	if (err)
-- 
1.7.4

