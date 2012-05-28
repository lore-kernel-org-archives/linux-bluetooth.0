Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 06/10] Bluetooth: Create DEFER_SETUP flag in conf_state
Date: Sun, 27 May 2012 22:27:56 -0300
Message-Id: <1338168480-9646-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Remove another socket usage from l2cap_core.c

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   12 ++++++------
 net/bluetooth/l2cap_sock.c    |    8 ++++++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c5726c2..0ea4cf1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -601,6 +601,7 @@ enum {
 	CONF_LOC_CONF_PEND,
 	CONF_REM_CONF_PEND,
 	CONF_NOT_COMPLETE,
+	CONF_DEFER_SETUP,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d64c836..d0c1ebe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -569,7 +569,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
 
-			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
+			if (test_bit(CONF_DEFER_SETUP, &chan->conf_state))
 				result = L2CAP_CR_SEC_BLOCK;
 			else
 				result = L2CAP_CR_BAD_PSM;
@@ -1056,8 +1056,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (l2cap_chan_check_security(chan)) {
 				lock_sock(sk);
-				if (test_bit(BT_SK_DEFER_SETUP,
-					     &bt_sk(sk)->flags)) {
+				if (test_bit(CONF_DEFER_SETUP,
+					     &chan->conf_state)) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
@@ -3377,7 +3377,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
-			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+			if (test_bit(CONF_DEFER_SETUP, &chan->conf_state)) {
 				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
@@ -5407,8 +5407,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			lock_sock(sk);
 
 			if (!status) {
-				if (test_bit(BT_SK_DEFER_SETUP,
-					     &bt_sk(sk)->flags)) {
+				if (test_bit(CONF_DEFER_SETUP,
+					     &chan->conf_state)) {
 					struct sock *parent = bt_sk(sk)->parent;
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d856cc8..a421a4e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -623,10 +623,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			break;
 		}
 
-		if (opt)
+		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-		else
+			set_bit(CONF_DEFER_SETUP, &chan->conf_state);
+		} else {
 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+			clear_bit(CONF_DEFER_SETUP, &chan->conf_state);
+		}
+
 		break;
 
 	case BT_FLUSHABLE:
-- 
1.7.10.2

