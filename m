Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: debug: Print l2cap refcount
Date: Tue, 10 Jul 2012 15:27:45 +0300
Message-Id: <1341923271-14222-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d80e3f0..dfe9374 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -672,11 +672,17 @@ enum {
 
 static inline void l2cap_chan_hold(struct l2cap_chan *c)
 {
+	BT_DBG("chan %p refcnt %d -> %d", c, atomic_read(&c->refcnt),
+	       atomic_read(&c->refcnt) + 1);
+
 	atomic_inc(&c->refcnt);
 }
 
 static inline void l2cap_chan_put(struct l2cap_chan *c)
 {
+	BT_DBG("chan %p refcnt %d -> %d", c, atomic_read(&c->refcnt),
+	       atomic_read(&c->refcnt) - 1);
+
 	if (atomic_dec_and_test(&c->refcnt))
 		kfree(c);
 }
-- 
1.7.9.5

