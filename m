Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Do not check func ready existence
Date: Tue, 29 May 2012 10:11:00 +0300
Message-Id: <1338275460-16370-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338239783-26599-3-git-send-email-gustavo@padovan.org>
References: <1338239783-26599-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Functions will be always defined and in case not implemented as
dummy __no_func.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2e984ec..6399e3f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -957,8 +957,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 
 	chan->state = BT_CONNECTED;
 
-	if (chan->ops->ready)
-		chan->ops->ready(chan);
+	chan->ops->ready(chan);
 }
 
 static void l2cap_choose_conn(struct l2cap_chan *chan)
-- 
1.7.9.5

