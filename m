Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Do not dereference zero sk
Date: Tue, 14 Feb 2012 15:12:57 +0200
Message-Id: <1329225177-31940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1636029..138fe34 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -795,7 +795,7 @@ static void l2cap_sock_kill(struct sock *sk)
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_chan *chan;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -803,6 +803,8 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (!sk)
 		return 0;
 
+	chan = l2cap_pi(sk)->chan;
+
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
 		if (chan->mode == L2CAP_MODE_ERTM)
-- 
1.7.8.3

