Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH bluetooth-next] Fixes kernel panic in incomming l2cap connections with defer_setup
Date: Wed, 13 Jul 2011 14:02:26 +0300
Message-Id: <1310554946-765-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

Another fix considering incomming l2cap connections with
defer_setup enabled. In situations when incomming connection is
extracted with l2cap_sock_accept, it's bt_sock info will have
'parent' member zerroed, but 'parent' may be used unconditionally
in l2cap_conn_start() and l2cap_security_cfm() when defer_setup
is enabled.

Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
---
 net/bluetooth/l2cap_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f7f8e2c..2ffa09b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -763,7 +763,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
-					parent->sk_data_ready(parent, 0);
+					if (parent)
+						parent->sk_data_ready(parent, 0);
 
 				} else {
 					l2cap_state_change(chan, BT_CONFIG);
@@ -4150,7 +4151,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					struct sock *parent = bt_sk(sk)->parent;
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-					parent->sk_data_ready(parent, 0);
+					if (parent)
+						parent->sk_data_ready(parent, 0);
 				} else {
 					l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
-- 
1.7.1

