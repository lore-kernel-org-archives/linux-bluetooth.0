Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/6] Bluetooth: Fix indentation whitespace
Date: Wed, 29 Jun 2011 14:35:20 -0700
Message-Id: <1309383324-12002-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 74de2b7..24c94a3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -223,18 +223,18 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 
 static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, long timeout)
 {
-       BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
+	BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
 
-       if (!mod_timer(timer, jiffies + timeout))
-	       chan_hold(chan);
+	if (!mod_timer(timer, jiffies + timeout))
+		chan_hold(chan);
 }
 
 static void l2cap_clear_timer(struct l2cap_chan *chan, struct timer_list *timer)
 {
-       BT_DBG("chan %p state %d", chan, chan->state);
+	BT_DBG("chan %p state %d", chan, chan->state);
 
-       if (timer_pending(timer) && del_timer(timer))
-	       chan_put(chan);
+	if (timer_pending(timer) && del_timer(timer))
+		chan_put(chan);
 }
 
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
-- 
1.7.5.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

