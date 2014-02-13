Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] Bluetooth: Fix channel check when binding RFCOMM sock
Date: Thu, 13 Feb 2014 15:13:52 +0100
Message-ID: <1392300832-14142-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When binding RFCOMM socket with non-zero channel we're checking if
there is already any other socket which has the same channel number
assigned and then fail. This check does not consider situation where
we have another socket connected to remote device on given channel
number in which case we still should be able to bind local socket.

This patch changes __rfcomm_get_sock_by_addr() to return only sockets
in either BT_BOUND or BT_LISTEN states, also name is updated to better
describe what this function does now.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/rfcomm/sock.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 00573fb..1a59ddd 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -105,13 +105,18 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 }
 
 /* ---- Socket functions ---- */
-static struct sock *__rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
+static struct sock *__rfcomm_get_listen_sock_by_addr(u8 channel, bdaddr_t *src)
 {
 	struct sock *sk = NULL;
 
 	sk_for_each(sk, &rfcomm_sk_list.head) {
-		if (rfcomm_pi(sk)->channel == channel &&
-				!bacmp(&rfcomm_pi(sk)->src, src))
+		if (rfcomm_pi(sk)->channel != channel)
+			continue;
+
+		if (bacmp(&rfcomm_pi(sk)->src, src))
+			continue;
+
+		if (sk->sk_state == BT_BOUND || sk->sk_state == BT_LISTEN)
 			break;
 	}
 
@@ -352,7 +357,8 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 
 	write_lock(&rfcomm_sk_list.lock);
 
-	if (sa->rc_channel && __rfcomm_get_sock_by_addr(sa->rc_channel, &sa->rc_bdaddr)) {
+	if (sa->rc_channel && __rfcomm_get_listen_sock_by_addr(sa->rc_channel,
+							&sa->rc_bdaddr)) {
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
@@ -439,7 +445,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 		write_lock(&rfcomm_sk_list.lock);
 
 		for (channel = 1; channel < 31; channel++)
-			if (!__rfcomm_get_sock_by_addr(channel, src)) {
+			if (!__rfcomm_get_listen_sock_by_addr(channel, src)) {
 				rfcomm_pi(sk)->channel = channel;
 				err = 0;
 				break;
-- 
1.8.5.4

