Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add more L2CAP convenience callbacks
Date: Fri,  8 Aug 2014 09:37:15 +0300
Message-Id: <1407479838-5652-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In preparation for converting SMP to use l2cap_chan it's useful to add a
few more callback helpers so that smp.c won't need to define all of its
own.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4a51e7596608..a72965f6bc2f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -838,18 +838,43 @@ static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan
 	return NULL;
 }
 
+static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	return -ENOSYS;
+}
+
+static inline struct sk_buff *l2cap_chan_no_alloc_skb(struct l2cap_chan *chan,
+						      unsigned long hdr_len,
+						      unsigned long len, int nb)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline void l2cap_chan_no_teardown(struct l2cap_chan *chan, int err)
 {
 }
 
+static inline void l2cap_chan_no_close(struct l2cap_chan *chan)
+{
+}
+
 static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_state_change(struct l2cap_chan *chan,
+					      int state, int err)
+{
+}
+
 static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
 {
 }
 
+static inline void l2cap_chan_no_suspend(struct l2cap_chan *chan)
+{
+}
+
 static inline void l2cap_chan_no_resume(struct l2cap_chan *chan)
 {
 }
-- 
1.9.3

