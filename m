Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Comments and style fixes
Date: Fri, 23 Mar 2012 16:31:50 +0200
Message-Id: <1332513110-10507-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332513110-10507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332513110-10507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add comments to timer implementation and style fixes.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9b242c6..35334a0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -622,21 +622,26 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
 }
 
 static inline void l2cap_set_timer(struct l2cap_chan *chan,
-					struct delayed_work *work, long timeout)
+				   struct delayed_work *work, long timeout)
 {
 	BT_DBG("chan %p state %s timeout %ld", chan,
-					state_to_string(chan->state), timeout);
+	       state_to_string(chan->state), timeout);
 
+	/* If delayed work cancelled do not hold(chan)
+	   since it is already done with previous set_timer */
 	if (!cancel_delayed_work(work))
 		l2cap_chan_hold(chan);
+
 	schedule_delayed_work(work, timeout);
 }
 
 static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
-					struct delayed_work *work)
+				     struct delayed_work *work)
 {
 	bool ret;
 
+	/* put(chan) if delayed work cancelled otherwise it
+	   is done in delayed work function */
 	ret = cancel_delayed_work(work);
 	if (ret)
 		l2cap_chan_put(chan);
-- 
1.7.9.1

