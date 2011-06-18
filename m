Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/3] Bluetooth: Fix not setting the chan state
Date: Fri, 17 Jun 2011 22:46:25 -0300
Message-Id: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection is ready we should set the connection
to CONNECTED so userspace can use it.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 25f31f4..4af61fb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -895,8 +895,7 @@ static void l2cap_chan_ready(struct sock *sk)
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	sk->sk_state = BT_CONNECTED;
-	sk->sk_state_change(sk);
+	l2cap_state_change(chan, BT_CONNECTED);
 
 	if (parent)
 		parent->sk_data_ready(parent, 0);
-- 
1.7.5.4

