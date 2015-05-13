Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH] Bluetooth: Fix potential NULL dereference
Date: Wed, 13 May 2015 17:44:06 +0530
Message-id: <1431519246-8136-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

addr can be NULL and it should not be dereferenced before NULL checking.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/rfcomm/sock.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 825e8fb..e576374 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -336,14 +336,16 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 {
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
-	int chan = sa->rc_channel;
+	int chan;
 	int err = 0;
 
-	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
-
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
+
+	chan = sa->rc_channel;
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
-- 
1.7.9.5

