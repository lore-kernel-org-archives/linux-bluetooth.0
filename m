Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: correct debug output
Date: Mon, 31 Oct 2011 16:17:21 +0200
Message-Id: <1320070641-19126-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

l2cap_set_timer function prints sk instead of chan pointer.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ded2068..c496e3e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -220,7 +220,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 
 static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, long timeout)
 {
-	BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
+	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
 
 	if (!mod_timer(timer, jiffies + msecs_to_jiffies(timeout)))
 		chan_hold(chan);
-- 
1.7.4.1

