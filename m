Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Fix memory leaks due to chan refcnt
Date: Fri, 23 Mar 2012 09:42:15 +0200
Message-Id: <1332488535-10605-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When we queue delayed work we hold(chan) and delayed work
shall put(chan) after execution.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9c86d73..887aea0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1308,6 +1308,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 		return;
 	}
 
@@ -1316,6 +1317,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 }
 
 static void l2cap_retrans_timeout(struct work_struct *work)
@@ -1335,6 +1337,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
 
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 }
 
 static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
-- 
1.7.9.1

