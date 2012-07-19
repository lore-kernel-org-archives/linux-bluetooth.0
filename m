Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH] Bluetooth: Fix socket not getting freed if l2cap channel
 create fails
Date: Thu, 19 Jul 2012 12:54:04 +0530
Message-id: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If l2cap_chan_create() fails then it will return from l2cap_sock_kill
since zapped flag of sk is reset.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/l2cap_sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 79350d1..419857d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1174,7 +1174,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 
 	chan = l2cap_chan_create();
 	if (!chan) {
-		l2cap_sock_kill(sk);
+		sk_free(sk);
 		return NULL;
 	}
 
-- 
1.7.1

