Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: debug: Print amp_mgr refcnt
Date: Wed, 11 Jul 2012 14:43:35 +0300
Message-Id: <1342007015-9265-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342007015-9265-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20120710183333.GC13847@joana>
 <1342007015-9265-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index fb93250..4ff0bf3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -501,7 +501,7 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 /* AMP Manager functions */
 void amp_mgr_get(struct amp_mgr *mgr)
 {
-	BT_DBG("mgr %p", mgr);
+	BT_DBG("mgr %p orig refcnt %d", mgr, atomic_read(&mgr->kref.refcount));
 
 	kref_get(&mgr->kref);
 }
@@ -517,7 +517,7 @@ static void amp_mgr_destroy(struct kref *kref)
 
 int amp_mgr_put(struct amp_mgr *mgr)
 {
-	BT_DBG("mgr %p", mgr);
+	BT_DBG("mgr %p orig refcnt %d", mgr, atomic_read(&mgr->kref.refcount));
 
 	return kref_put(&mgr->kref, &amp_mgr_destroy);
 }
-- 
1.7.9.5

