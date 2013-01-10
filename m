Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 08/16] Bluetooth: Improving locking in l2cap_conn_start()
Date: Thu, 10 Jan 2013 05:47:45 -0200
Message-Id: <1357804073-31582-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
References: <1357804073-31582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Since we don't read bt_sk(sk) in here anymore we can remove the lock from
the block and only use it when calling l2cap_state_change().

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4cc49f3..110a702 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1252,7 +1252,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
-				lock_sock(sk);
 				if (test_bit(CONN_DEFER_SETUP,
 					     &chan->conn_state)) {
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
@@ -1260,11 +1259,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					chan->ops->defer(chan);
 
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
-				release_sock(sk);
 			} else {
 				rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 				rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
@@ -6393,12 +6391,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
 		} else if (chan->state == BT_CONNECT2) {
-			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			lock_sock(sk);
-
 			if (!status) {
 				if (test_bit(CONN_DEFER_SETUP,
 					     &chan->conn_state)) {
@@ -6406,19 +6401,17 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					stat = L2CAP_CS_AUTHOR_PEND;
 					chan->ops->defer(chan);
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
 				}
 			} else {
-				__l2cap_state_change(chan, BT_DISCONN);
+				l2cap_state_change(chan, BT_DISCONN);
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
 
-			release_sock(sk);
-
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(res);
-- 
1.8.0.2

