Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2] Bluetooth: Fix not setting the chan state
Date: Mon, 20 Jun 2011 18:53:18 -0300
Message-Id: <1308606798-7370-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection is ready we should set the connection
to CONNECTED so userspace can use it.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 700d01e..b1e2570 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -895,7 +895,7 @@ static void l2cap_chan_ready(struct sock *sk)
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	sk->sk_state = BT_CONNECTED;
+	l2cap_state_change(chan, BT_CONNECTED);
 	sk->sk_state_change(sk);
 
 	if (parent)
-- 
1.7.5.4

