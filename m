Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix accepting connect requests for defer_setup
Date: Fri, 10 Jun 2011 13:15:07 +0900
Message-Id: <1307679307-18302-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When authentication completes we shouldn't blindly accept any pending
L2CAP connect requests. If the socket has the defer_setup feature
enabled it should still wait for user space acceptance of the connect
request. The issue only happens for non-SSP connections since with SSP
the L2CAP Connect request may not be sent for non-SDP PSMs before
authentication has completed successfully.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 15e6a53..564e647 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4204,21 +4204,30 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			}
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
-			__u16 result;
+			__u16 res, stat;
 
 			if (!status) {
-				sk->sk_state = BT_CONFIG;
-				result = L2CAP_CR_SUCCESS;
+				if (bt_sk(sk)->defer_setup) {
+					struct sock *parent = bt_sk(sk)->parent;
+					res = L2CAP_CR_PEND;
+					stat = L2CAP_CS_AUTHOR_PEND;
+					parent->sk_data_ready(parent, 0);
+				} else {
+					sk->sk_state = BT_CONFIG;
+					res = L2CAP_CR_SUCCESS;
+					stat = L2CAP_CS_NO_INFO;
+				}
 			} else {
 				sk->sk_state = BT_DISCONN;
 				l2cap_chan_set_timer(chan, HZ / 10);
-				result = L2CAP_CR_SEC_BLOCK;
+				res = L2CAP_CR_SEC_BLOCK;
+				stat = L2CAP_CS_NO_INFO;
 			}
 
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
-			rsp.result = cpu_to_le16(result);
-			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+			rsp.result = cpu_to_le16(res);
+			rsp.status = cpu_to_le16(stat);
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
 							sizeof(rsp), &rsp);
 		}
-- 
1.7.5.3

