Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 05/16] Bluetooth: Add l2cap_chan_lock
Date: Fri, 17 Feb 2012 15:44:01 +0200
Message-Id: <1329486252-25252-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Channel lock will be used to lock L2CAP channels which are locked
currently by socket locks.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |   11 +++++++++++
 net/bluetooth/l2cap_core.c    |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bbb0e21..d6d8ec8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -497,6 +497,7 @@ struct l2cap_chan {
 
 	void		*data;
 	struct l2cap_ops *ops;
+	struct mutex		lock;
 };
 
 struct l2cap_ops {
@@ -609,6 +610,16 @@ static inline void l2cap_chan_put(struct l2cap_chan *c)
 		kfree(c);
 }
 
+static inline void l2cap_chan_lock(struct l2cap_chan *chan)
+{
+	mutex_lock(&chan->lock);
+}
+
+static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
+{
+	mutex_unlock(&chan->lock);
+}
+
 static inline void l2cap_set_timer(struct l2cap_chan *chan,
 					struct delayed_work *work, long timeout)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 90e29ac..98e116b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -247,6 +247,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 	if (!chan)
 		return NULL;
 
+	mutex_init(&chan->lock);
+
 	chan->sk = sk;
 
 	write_lock(&chan_list_lock);
-- 
1.7.9

