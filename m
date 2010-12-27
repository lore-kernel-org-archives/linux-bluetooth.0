Return-Path: <cyrus@holtmann.org>
From: David Sterba <dsterba@suse.cz>
To: padovan@profusion.mobi
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@profusion.mobi>
Subject: [PATCH] Bluetooth: l2cap: fix misuse of logical operation in place of bitop
Date: Mon, 27 Dec 2010 19:00:10 +0100
Message-Id: <1293472810-30233-1-git-send-email-dsterba@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

CC: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: João Paulo Rechi Vita <jprvita@profusion.mobi>
Signed-off-by: David Sterba <dsterba@suse.cz>
---
 net/bluetooth/l2cap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index cd8f6ea..bdfdfdc 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1893,8 +1893,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		if (pi->mode == L2CAP_MODE_STREAMING) {
 			l2cap_streaming_send(sk);
 		} else {
-			if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY &&
-					pi->conn_state && L2CAP_CONN_WAIT_F) {
+			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+					(pi->conn_state & L2CAP_CONN_WAIT_F)) {
 				err = len;
 				break;
 			}
-- 
1.7.3.4.626.g73e7b
