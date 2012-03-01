Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update L2CAP timeout constants to use msecs_to_jiffies
Date: Thu,  1 Mar 2012 14:25:33 -0800
Message-Id: <1330640733-29448-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP timeout constants are always used in form of jiffies. So just
include the conversion from msecs in the define itself. This has the
advantage of making the code where the timeout is used more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |   10 +++++-----
 net/bluetooth/l2cap_core.c    |   18 ++++++------------
 net/bluetooth/l2cap_sock.c    |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3732a48..e4669d0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -45,11 +45,11 @@
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 
-#define L2CAP_DISC_TIMEOUT             (100)
-#define L2CAP_DISC_REJ_TIMEOUT         (5000)  /*  5 seconds */
-#define L2CAP_ENC_TIMEOUT              (5000)  /*  5 seconds */
-#define L2CAP_CONN_TIMEOUT             (40000) /* 40 seconds */
-#define L2CAP_INFO_TIMEOUT             (4000)  /*  4 seconds */
+#define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
+#define L2CAP_DISC_REJ_TIMEOUT		msecs_to_jiffies(5000)
+#define L2CAP_ENC_TIMEOUT		msecs_to_jiffies(5000)
+#define L2CAP_CONN_TIMEOUT		msecs_to_jiffies(40000)
+#define L2CAP_INFO_TIMEOUT		msecs_to_jiffies(4000)
 
 /* L2CAP socket address */
 struct sockaddr_l2 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bc8d558..0b1aabf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -700,8 +700,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_timer,
-					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
+		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
 
 		l2cap_send_cmd(conn, conn->info_ident,
 					L2CAP_INFO_REQ, sizeof(req), &req);
@@ -2741,8 +2740,7 @@ sendresp:
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_timer,
-					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
+		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
 
 		l2cap_send_cmd(conn, conn->info_ident,
 					L2CAP_INFO_REQ, sizeof(info), &info);
@@ -3028,8 +3026,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	default:
 		l2cap_chan_set_err(chan, ECONNRESET);
 
-		__set_chan_timer(chan,
-				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
+		__set_chan_timer(chan, L2CAP_DISC_REJ_TIMEOUT);
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
@@ -4539,8 +4536,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
 			__clear_chan_timer(chan);
-			__set_chan_timer(chan,
-					msecs_to_jiffies(L2CAP_ENC_TIMEOUT));
+			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
@@ -4598,8 +4594,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_send_conn_req(chan);
 			} else {
 				__clear_chan_timer(chan);
-				__set_chan_timer(chan,
-					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct sock *sk = chan->sk;
@@ -4622,8 +4617,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				}
 			} else {
 				__l2cap_state_change(chan, BT_DISCONN);
-				__set_chan_timer(chan,
-					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 52c94c7..3da56c5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1039,7 +1039,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = l2cap_sock_destruct;
-	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
+	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
-- 
1.7.7.6

