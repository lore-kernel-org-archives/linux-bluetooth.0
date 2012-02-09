Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0] Bluetooth: Remove extra chan_put
Date: Thu,  9 Feb 2012 15:06:17 +0200
Message-Id: <1328792777-25914-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Removing l2cap_chan_put since in this function we use l2cap_chan_close
and ops->close which use l2cap_chan_put.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
I am not sure that I have checked all possible cases, so I am sending
this as RFC.

 net/bluetooth/l2cap_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1a6b3c..7db6d7f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -274,7 +274,6 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	release_sock(sk);
 
 	chan->ops->close(chan->data);
-	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk)
-- 
1.7.8.3

