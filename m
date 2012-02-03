Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 10/10] Bluetooth: Remove socket lock check
Date: Fri,  3 Feb 2012 16:36:29 +0200
Message-Id: <1328279789-10870-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify code so that we do not need to check whether socket is locked.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ddac4cb..358975a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -125,15 +125,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
 	if (err)
-		goto done;
+		return err;
 
 	lock_sock(sk);
 
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 			sock_sndtimeo(sk, flags & O_NONBLOCK));
-done:
-	if (sock_owned_by_user(sk))
-		release_sock(sk);
+
+	release_sock(sk);
+
 	return err;
 }
 
-- 
1.7.8.3

