Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 06/30] Bluetooth: Timers fixes
Date: Thu, 15 Mar 2012 14:29:57 +0200
Message-Id: <1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d9c668c..1a5c9e6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -624,29 +624,30 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
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
 					struct delayed_work *work)
 {
 	bool ret;
 
-	ret = cancel_delayed_work(work);
+	ret = (delayed_work_pending(work) && cancel_delayed_work(work));
 	if (ret)
 		l2cap_chan_put(chan);
 
 	return ret;
 }
 
+static inline void l2cap_set_timer(struct l2cap_chan *chan,
+					struct delayed_work *work, long timeout)
+{
+	BT_DBG("chan %p state %s timeout %ld", chan,
+					state_to_string(chan->state), timeout);
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

