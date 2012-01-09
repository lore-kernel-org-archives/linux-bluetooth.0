Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] Bluetooth: Make l2cap_clear_timer return if timer was running or not
Date: Mon, 9 Jan 2012 16:19:47 +0100
Message-ID: <1326122391-8438-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/l2cap.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b564142..1ead4c4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -616,11 +616,16 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
 	schedule_delayed_work(work, timeout);
 }
 
-static inline void l2cap_clear_timer(struct l2cap_chan *chan,
+static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 					struct delayed_work *work)
 {
-	if (__cancel_delayed_work(work))
+	bool ret;
+
+	ret = __cancel_delayed_work(work);
+	if (ret)
 		l2cap_chan_put(chan);
+
+	return ret;
 }
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
-- 
on behalf of ST-Ericsson

