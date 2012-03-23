Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 02/26] Bluetooth: Lock sk only if exist in state_change
Date: Fri, 23 Mar 2012 18:13:42 +0200
Message-Id: <1332519246-16656-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In L2CAP state_change lock sk only when we are dealing with
sockets. In A2MP we do not have sk so this will crash.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5b9a667..6e801bb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -212,9 +212,13 @@ static inline void l2cap_state_change(struct l2cap_chan *chan, int state, int er
 {
 	struct sock *sk = chan->sk;
 
-	lock_sock(sk);
+	if (sk)
+		lock_sock(sk);
+
 	__l2cap_state_change(chan, state, err);
-	release_sock(sk);
+
+	if (sk)
+		release_sock(sk);
 }
 
 void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
-- 
1.7.9.1

