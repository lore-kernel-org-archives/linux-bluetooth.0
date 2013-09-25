Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] Bluetooth: Clean up socket locking in l2cap_sock_recvmsg
Date: Wed, 25 Sep 2013 13:26:05 +0300
Message-Id: <1380104770-8022-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch cleans up the locking login in l2cap_sock_recvmsg by pairing
up each lock_sock call with a release_sock call. The function already
has a "done" label that handles releasing the socket and returning from
the function so the fix is rather simple.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ad95b42..c85537c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -805,8 +805,8 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 		pi->chan->state = BT_CONFIG;
 
 		__l2cap_connect_rsp_defer(pi->chan);
-		release_sock(sk);
-		return 0;
+		err = 0;
+		goto done;
 	}
 
 	release_sock(sk);
-- 
1.8.3.1

