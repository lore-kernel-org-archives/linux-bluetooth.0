Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 30 Nov 2009 16:18:33 +0100
Message-ID: <a0d5085b0911300718r234612cyd61ab3b1d7bc31a7@mail.gmail.com>
Subject: [PATCH 1/2] A couple of bugs in bluetooth
From: Luiz Pena <carlos.luiz.pena@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have been working on a small home-project in bluez, and I think I might have
stumbled on a couple of bugs. I am not sure they are correct so bear with me if
I am mistaken.

The first one seems to be a race condition. I have not been able to verify if
the BT_CLOSED state is still relevant, but if it is, then it seems we should
hold the lock till after the unlink.


Signed-off-by: Carlos Luiz Pena <carlos.luiz.pena@gmail.com>
---
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8cfb5a8..206fa4e 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -206,8 +206,8 @@ struct sock *bt_accept_dequeue(struct sock
*parent, struct socket *newsock)

 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
-			release_sock(sk);
 			bt_accept_unlink(sk);
+			release_sock(sk);
 			continue;
 		}
