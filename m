Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] Bluetooth: Use miliseconds for L2CAP channel timeouts
Date: Thu, 20 Oct 2011 09:17:06 +0200
Message-ID: <1319095026-12517-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Timers set by __set_chan_timer() should use miliseconds instead of
jiffies. Commit 942ecc9c4643db5ce071562e0a23f99464d6b461 updated
l2cap_set_timer() so it expects timeout to be specified in msecs
instead of jiffies. This makes timeouts unreliable when CONFIG_HZ
is not set to 1000.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/l2cap.h |    7 +++++--
 net/bluetooth/l2cap_core.c    |   16 ++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fddc82a..b6cb549 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -45,8 +45,11 @@
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 
-#define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
-#define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
+#define L2CAP_DISC_TIMEOUT		(100)
+#define L2CAP_DISC_REJ_TIMEOUT		(5000)  /*  5 seconds */
+#define L2CAP_ENC_TIMEOUT		(5000)  /*  5 seconds */
+#define L2CAP_CONN_TIMEOUT		(40000) /* 40 seconds */
+#define L2CAP_INFO_TIMEOUT		(4000)  /*  4 seconds */
 
 /* L2CAP socket address */
 struct sockaddr_l2 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bda6da7..36a33e8e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -252,7 +252,7 @@ static void l2cap_chan_timeout(unsigned long arg)
 
 	if (sock_owned_by_user(sk)) {
 		/* sk is owned by user. Try again later */
-		__set_chan_timer(chan, HZ / 5);
+		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		bh_unlock_sock(sk);
 		chan_put(chan);
 		return;
@@ -2671,7 +2671,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		if (sock_owned_by_user(sk)) {
 			l2cap_state_change(chan, BT_DISCONN);
 			__clear_chan_timer(chan);
-			__set_chan_timer(chan, HZ / 5);
+			__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			break;
 		}
 
@@ -2844,7 +2844,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	default:
 		sk->sk_err = ECONNRESET;
-		__set_chan_timer(chan, HZ * 5);
+		__set_chan_timer(chan, L2CAP_DISC_REJ_TIMEOUT);
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
@@ -2901,7 +2901,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	if (sock_owned_by_user(sk)) {
 		l2cap_state_change(chan, BT_DISCONN);
 		__clear_chan_timer(chan);
-		__set_chan_timer(chan, HZ / 5);
+		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -2935,7 +2935,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	if (sock_owned_by_user(sk)) {
 		l2cap_state_change(chan,BT_DISCONN);
 		__clear_chan_timer(chan);
-		__set_chan_timer(chan, HZ / 5);
+		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		bh_unlock_sock(sk);
 		return 0;
 	}
@@ -4185,7 +4185,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
 			__clear_chan_timer(chan);
-			__set_chan_timer(chan, HZ * 5);
+			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
@@ -4253,7 +4253,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					L2CAP_CONN_REQ, sizeof(req), &req);
 			} else {
 				__clear_chan_timer(chan);
-				__set_chan_timer(chan, HZ / 10);
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -4273,7 +4273,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				}
 			} else {
 				l2cap_state_change(chan, BT_DISCONN);
-				__set_chan_timer(chan, HZ / 10);
+				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
-- 
on behalf of ST-Ericsson

