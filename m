Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 03/34] Bluetooth: Make ertm_init available
Date: Thu, 19 Jan 2012 11:19:52 +0200
Message-Id: <1326964823-26747-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function l2cap_ertm_init will be used for initialization
fixed A2MP channel.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 18242ea..60092cb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -845,5 +845,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
+void l2cap_ertm_init(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5ace149..e36aaab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1998,7 +1998,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 }
 
-static inline void l2cap_ertm_init(struct l2cap_chan *chan)
+void l2cap_ertm_init(struct l2cap_chan *chan)
 {
 	chan->expected_ack_seq = 0;
 	chan->unacked_frames = 0;
-- 
1.7.4.1

