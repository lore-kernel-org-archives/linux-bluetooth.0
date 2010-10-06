Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 5/7] Bluetooth: Add LE connection support to L2CAP
Date: Wed,  6 Oct 2010 20:42:13 +0200
Message-Id: <1286390535-27462-6-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add basic LE connection support to L2CAP

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 net/bluetooth/l2cap_core.c    |   32 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index df599dc..41374ad 100644
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
 
@@ -269,6 +272,7 @@ struct l2cap_conn {
 	bdaddr_t	*src;
 
 	unsigned int	mtu;
+	unsigned int	le_mtu;
 
 	__u32		feat_mask;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 07b55c1..1d43280 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -588,6 +588,12 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
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
@@ -646,7 +652,11 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
-	conn->mtu = hcon->hdev->acl_mtu;
+	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
+		conn->mtu = hcon->hdev->le_mtu;
+	else
+		conn->mtu = hcon->hdev->acl_mtu;
+
 	conn->src = &hcon->hdev->bdaddr;
 	conn->dst = &hcon->dst;
 
@@ -962,8 +972,13 @@ static int l2cap_do_connect(struct sock *sk)
 		}
 	}
 
-	hcon = hci_connect(hdev, ACL_LINK, dst,
+	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
+		hcon = hci_connect(hdev, LE_LINK, dst,
+					l2cap_pi(sk)->sec_level, auth_type);
+	else
+		hcon = hci_connect(hdev, ACL_LINK, dst,
 					l2cap_pi(sk)->sec_level, auth_type);
+
 	if (!hcon)
 		goto done;
 
@@ -1014,13 +1029,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
++	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
 	lock_sock(sk);
 
 	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
-			&& !la.l2_psm) {
+			&& !(la.l2_psm || la.la_cid)) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -1062,14 +1077,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	/* PSM must be odd and lsb of upper byte must be 0 */
 	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
-		sk->sk_type != SOCK_RAW) {
+		sk->sk_type != SOCK_RAW && !la.l2_cid) {
 		err = -EINVAL;
 		goto done;
 	}
 
-	/* Set destination address and psm */
+	/* Set destination address and psm or cid */
 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
 	l2cap_pi(sk)->psm = la.l2_psm;
++	l2cap_pi(sk)->dcid = la.l2_cid;
 
 	err = l2cap_do_connect(sk);
 	if (err)
@@ -4380,7 +4396,7 @@ static int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
-	if (hcon->type != ACL_LINK)
++	if (!(hcon->type == ACL_LINK || hcon->type == LE_LINK))
 		return -EINVAL;
 
 	if (!status) {
@@ -4409,7 +4425,7 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	if (hcon->type != ACL_LINK)
++	if (!(hcon->type == ACL_LINK || hcon->type == LE_LINK))
 		return -EINVAL;
 
 	l2cap_conn_del(hcon, bt_err(reason));
-- 
1.7.0.1

