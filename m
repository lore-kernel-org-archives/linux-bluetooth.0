Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Do not check func ready existence
Date: Wed, 30 May 2012 09:55:32 +0300
Message-Id: <1338360932-29940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120529152357.GA4575@joana>
References: <20120529152357.GA4575@joana>
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
index 778c0c8..4f65a32 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -937,8 +937,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 
 	chan->state = BT_CONNECTED;
 
-	if (chan->ops->ready)
-		chan->ops->ready(chan);
+	chan->ops->ready(chan);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
1.7.9.5

