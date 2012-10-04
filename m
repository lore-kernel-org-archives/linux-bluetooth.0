Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix dereference after NULL check
Date: Thu,  4 Oct 2012 13:45:46 +0300
Message-Id: <1349347546-32523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move code dereferencing possible NULL pointer to the check branch.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e6238eb..0c05d7d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -386,13 +386,14 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		memset(&sec, 0, sizeof(sec));
-		if (chan->conn)
+		if (chan->conn) {
 			sec.level = chan->conn->hcon->sec_level;
-		else
-			sec.level = chan->sec_level;
 
-		if (sk->sk_state == BT_CONNECTED)
-			sec.key_size = chan->conn->hcon->enc_key_size;
+			if (sk->sk_state == BT_CONNECTED)
+				sec.key_size = chan->conn->hcon->enc_key_size;
+		} else {
+			sec.level = chan->sec_level;
+		}
 
 		len = min_t(unsigned int, len, sizeof(sec));
 		if (copy_to_user(optval, (char *) &sec, len))
-- 
1.7.9.5

