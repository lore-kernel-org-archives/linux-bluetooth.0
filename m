Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: make L2CAP sockets to inherit parent's priority
Date: Fri,  4 Nov 2011 16:03:49 +0200
Message-Id: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes priority set on a listen socket to be passed when accepting
new connections.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 664762e..5a5d2c6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -968,6 +968,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		struct l2cap_chan *pchan = l2cap_pi(parent)->chan;
 
 		sk->sk_type = parent->sk_type;
+		sk->sk_priority = parent->sk_priority;
 		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
 
 		chan->chan_type = pchan->chan_type;
-- 
1.7.6.4

