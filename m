Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/3] Bluetooth: Nove l2cap_{set,clear}_timer to l2cap.h
Date: Tue, 20 Dec 2011 10:57:26 -0200
Message-Id: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It is the only place where it is used.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   15 +++++++++++++++
 net/bluetooth/l2cap_core.c    |   14 --------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c0d168a..e199c2f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -595,6 +595,21 @@ enum {
 	FLAG_EFS_ENABLE,
 };
 
+static inline void l2cap_set_timer(struct l2cap_chan *chan,
+					struct delayed_work *work, long timeout)
+{
+	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
+
+	cancel_delayed_work_sync(work);
+
+	schedule_delayed_work(work, timeout);
+}
+
+static inline void l2cap_clear_timer(struct delayed_work *work)
+{
+	cancel_delayed_work_sync(work);
+}
+
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(&c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ffa2f6b..5978d69 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -228,20 +228,6 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void l2cap_set_timer(struct l2cap_chan *chan, struct delayed_work *work, long timeout)
-{
-	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
-
-	cancel_delayed_work_sync(work);
-
-	schedule_delayed_work(work, timeout);
-}
-
-static void l2cap_clear_timer(struct delayed_work *work)
-{
-	cancel_delayed_work_sync(work);
-}
-
 static char *state_to_string(int state)
 {
 	switch(state) {
-- 
1.7.6.4

