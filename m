Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 04/10] Bluetooth: Use chan->state instead of sk->sk_state
Date: Sun, 27 May 2012 22:27:54 -0300
Message-Id: <1338168480-9646-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

These vars are kept in sync so we can use chan->state here.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5947eb1..35e6d7d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1442,21 +1442,17 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
-	lock_sock(sk);
-
-	switch (sk->sk_state) {
+	switch (chan->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
 	case BT_CONFIG:
 		/* Already connecting */
 		err = 0;
-		release_sock(sk);
 		goto done;
 
 	case BT_CONNECTED:
 		/* Already connected */
 		err = -EISCONN;
-		release_sock(sk);
 		goto done;
 
 	case BT_OPEN:
@@ -1466,13 +1462,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	default:
 		err = -EBADFD;
-		release_sock(sk);
 		goto done;
 	}
 
 	/* Set destination address and psm */
+	lock_sock(sk);
 	bacpy(&bt_sk(sk)->dst, dst);
-
 	release_sock(sk);
 
 	chan->psm = psm;
-- 
1.7.10.2

