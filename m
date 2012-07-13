Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: s.syam@samsung.com, Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v1 1/2] Bluetooth: Move l2cap_chan_hold/put to l2cap_core.c
Date: Fri, 13 Jul 2012 18:17:54 +0530
Message-id: <1342183675-27612-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactor the code in order to use the l2cap_chan_destroy()
from l2cap_chan_put() under the refcnt protection.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 include/net/bluetooth/l2cap.h |   16 ++--------------
 net/bluetooth/l2cap_core.c    |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e5164ff..d8a6145 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -670,20 +670,8 @@ enum {
 	L2CAP_EV_RECV_FRAME,
 };
 
-static inline void l2cap_chan_hold(struct l2cap_chan *c)
-{
-	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
-
-	atomic_inc(&c->refcnt);
-}
-
-static inline void l2cap_chan_put(struct l2cap_chan *c)
-{
-	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
-
-	if (atomic_dec_and_test(&c->refcnt))
-		kfree(c);
-}
+void l2cap_chan_hold(struct l2cap_chan *c);
+void l2cap_chan_put(struct l2cap_chan *c);
 
 static inline void l2cap_chan_lock(struct l2cap_chan *chan)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9fd0599..552a8ce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -425,6 +425,21 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
+void l2cap_chan_hold(struct l2cap_chan *c)
+{
+	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
+
+	atomic_inc(&c->refcnt);
+}
+
+void l2cap_chan_put(struct l2cap_chan *c)
+{
+	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
+
+	if (atomic_dec_and_test(&c->refcnt))
+		kfree(c);
+}
+
 void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 {
 	chan->fcs  = L2CAP_FCS_CRC16;
-- 
1.7.1

