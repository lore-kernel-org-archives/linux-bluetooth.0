Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/2] Bluetooth: Prevent sk freeing in tasklet using refcount
Date: Wed, 26 May 2010 17:21:34 +0300
Message-Id: <1274883694-18120-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Socket sk may be freed in tasklet while still be in use in krfcommd
process. Use refcount to mark sk as used.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 794f2b7..bf762d6 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1724,6 +1724,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	sock_hold(sk);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
@@ -1808,6 +1809,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 done:
 	release_sock(sk);
+	sock_put(sk);
 	return err;
 }
 
-- 
1.7.0.4

