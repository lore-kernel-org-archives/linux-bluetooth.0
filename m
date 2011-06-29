Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 3/6] Bluetooth: ERTM timeouts need to be converted to jiffies
Date: Wed, 29 Jun 2011 14:35:21 -0700
Message-Id: <1309383324-12002-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM timeouts are defined in milliseconds, but need to be converted
to jiffies when passed to mod_timer().

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 24c94a3..da6f532 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -225,7 +225,7 @@ static void l2cap_set_timer(struct l2cap_chan *chan, struct timer_list *timer, l
 {
 	BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
 
-	if (!mod_timer(timer, jiffies + timeout))
+	if (!mod_timer(timer, jiffies + msecs_to_jiffies(timeout)))
 		chan_hold(chan);
 }
 
-- 
1.7.5.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

