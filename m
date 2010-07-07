Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Check l2cap pending status before sending l2cap connect request
Date: Wed,  7 Jul 2010 12:05:43 +0300
Message-Id: <1278493543-25290-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Due to race condition in L2CAP state machine L2CAP Connection Request
may be sent twice for SDP with the same source channel id. Problems
reported connecting to Apple products, some carkit, Blackberry phones.

...
2010-06-07 21:18:03.651031 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
2010-06-07 21:18:03.653473 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2010-06-07 21:18:03.653808 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 1
2010-06-07 21:18:03.653869 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
...

Patch uses L2CAP_CONF_CONNECT_PEND flag to mark that L2CAP Connection
Request has been sent already.

Modified version of Ville Tervo patch.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index bb00015..899cca5 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -401,6 +401,11 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
 	l2cap_send_sframe(pi, control);
 }
 
+static inline int l2cap_check_pending(struct sock *sk)
+{
+	return l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND;
+}
+
 static void l2cap_do_start(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -409,12 +414,13 @@ static void l2cap_do_start(struct sock *sk)
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
 
-		if (l2cap_check_security(sk)) {
+		if (l2cap_check_security(sk) && !l2cap_check_pending(sk)) {
 			struct l2cap_conn_req req;
 			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
 
 			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
@@ -464,12 +470,14 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		}
 
 		if (sk->sk_state == BT_CONNECT) {
-			if (l2cap_check_security(sk)) {
+			if (l2cap_check_security(sk) &&
+					!l2cap_check_pending(sk)) {
 				struct l2cap_conn_req req;
 				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 				req.psm  = l2cap_pi(sk)->psm;
 
 				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
@@ -2914,7 +2922,6 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		l2cap_pi(sk)->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-
 		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
@@ -4406,6 +4413,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				req.psm  = l2cap_pi(sk)->psm;
 
 				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
-- 
1.7.0.4

