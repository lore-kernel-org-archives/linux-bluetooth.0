Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/2] Bluetooth: report the right security level in getsockopt
Date: Mon,  7 May 2012 03:07:26 -0300
Message-Id: <1336370846-7979-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
References: <1336370846-7979-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During a security level elevation we need to keep track of the current
security level of a connection until the new one is not confirmed.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap_sock.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 85dbe64..86abad1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -379,7 +379,10 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		memset(&sec, 0, sizeof(sec));
-		sec.level = chan->sec_level;
+		if (chan->conn)
+			sec.level = chan->conn->hcon->sec_level;
+		else
+			sec.level = chan->sec_level;
 
 		if (sk->sk_state == BT_CONNECTED)
 			sec.key_size = chan->conn->hcon->enc_key_size;
-- 
1.7.10

