Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH -v2 2/2] Bluetooth: Allow L2CAP to increase the security level
Date: Tue,  8 Nov 2011 19:11:26 -0200
Message-Id: <1320786686-1599-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1320786686-1599-1-git-send-email-padovan@profusion.mobi>
References: <1320786686-1599-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Some incomming connections needs to increase the security level by
requesting encryption for example (HID keyboard case). This change allows
the userspace to change it through setsockopt with defer_setup enabled.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_sock.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 664762e..aafcb94 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -623,8 +623,13 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 		chan->sec_level = sec.level;
 
+		if (!chan->conn)
+			break;
+
 		conn = chan->conn;
-		if (conn && chan->scid == L2CAP_CID_LE_DATA) {
+
+		/*change security for LE channels */
+		if (chan->scid == L2CAP_CID_LE_DATA) {
 			if (!conn->hcon->out) {
 				err = -EINVAL;
 				break;
@@ -632,9 +637,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 			if (smp_conn_security(conn, sec.level))
 				break;
-
-			err = 0;
 			sk->sk_state = BT_CONFIG;
+
+		/* or for ACL link, under defer_setup time */
+		} else if (sk->sk_state == BT_CONNECT2 &&
+					bt_sk(sk)->defer_setup) {
+			err = l2cap_chan_check_security(chan);
+		} else {
+			err = -EINVAL;
 		}
 		break;
 
-- 
1.7.6.4

