Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow change security level on ATT_CID in slave role
Date: Fri, 13 Jun 2014 14:08:22 +0200
Message-Id: <1402661302-26674-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kernel supports SMP Security Request so don't block increasing security
when we are slave.

Signed-off-by: Marcin Kraglak <marcin.kraglak@tieto.com>
---
 net/bluetooth/l2cap_sock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6ab2822..55215eb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -787,11 +787,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		/*change security for LE channels */
 		if (chan->scid == L2CAP_CID_ATT) {
-			if (!conn->hcon->out) {
-				err = -EINVAL;
-				break;
-			}
-
 			if (smp_conn_security(conn->hcon, sec.level))
 				break;
 			sk->sk_state = BT_CONFIG;
-- 
1.9.3

