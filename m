Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: debug: Print l2cap_chan refcount
Date: Wed, 11 Jul 2012 14:43:34 +0300
Message-Id: <1342007015-9265-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120710183333.GC13847@joana>
References: <20120710183333.GC13847@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d80e3f0..e5164ff 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -672,11 +672,15 @@ enum {
 
 static inline void l2cap_chan_hold(struct l2cap_chan *c)
 {
+	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
+
 	atomic_inc(&c->refcnt);
 }
 
 static inline void l2cap_chan_put(struct l2cap_chan *c)
 {
+	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
+
 	if (atomic_dec_and_test(&c->refcnt))
 		kfree(c);
 }
-- 
1.7.9.5

