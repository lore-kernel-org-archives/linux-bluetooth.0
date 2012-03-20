Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Simplify L2CAP timer logic
Date: Tue, 20 Mar 2012 14:51:08 +0200
Message-Id: <1332247868-32396-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Simplify L2CAP timers logic. Previous logic was hard to understand.
Now we always hold(chan) when setting up timer and put(chan) only
if work pending and we successfully cancel delayed work.

If delayed work is executing it will put(chan) itself.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9b242c6..e4b2fe7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -621,29 +621,30 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
 	mutex_unlock(&chan->lock);
 }
 
-static inline void l2cap_set_timer(struct l2cap_chan *chan,
-					struct delayed_work *work, long timeout)
-{
-	BT_DBG("chan %p state %s timeout %ld", chan,
-					state_to_string(chan->state), timeout);
-
-	if (!cancel_delayed_work(work))
-		l2cap_chan_hold(chan);
-	schedule_delayed_work(work, timeout);
-}
-
 static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
-					struct delayed_work *work)
+				     struct delayed_work *work)
 {
 	bool ret;
 
-	ret = cancel_delayed_work(work);
+	ret = (delayed_work_pending(work) && cancel_delayed_work(work));
 	if (ret)
 		l2cap_chan_put(chan);
 
 	return ret;
 }
 
+static inline void l2cap_set_timer(struct l2cap_chan *chan,
+				   struct delayed_work *work, long timeout)
+{
+	BT_DBG("chan %p state %s timeout %ld", chan,
+	       state_to_string(chan->state), timeout);
+
+	l2cap_clear_timer(chan, work);
+
+	l2cap_chan_hold(chan);
+	schedule_delayed_work(work, timeout);
+}
+
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
-- 
1.7.9.1

