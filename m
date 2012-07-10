Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: debug: Print amp_mgr refcnt
Date: Tue, 10 Jul 2012 15:27:46 +0300
Message-Id: <1341923271-14222-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index ec1ef2e..c4e7412 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -503,7 +503,9 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 /* AMP Manager functions */
 void amp_mgr_get(struct amp_mgr *mgr)
 {
-	BT_DBG("mgr %p", mgr);
+	BT_DBG("mgr %p refcnt %d -> %d", mgr,
+	       atomic_read(&mgr->kref.refcount),
+	       atomic_read(&mgr->kref.refcount) + 1);
 
 	kref_get(&mgr->kref);
 }
@@ -519,7 +521,9 @@ static void amp_mgr_destroy(struct kref *kref)
 
 int amp_mgr_put(struct amp_mgr *mgr)
 {
-	BT_DBG("mgr %p", mgr);
+	BT_DBG("mgr %p refcnt %d -> %d", mgr,
+	       atomic_read(&mgr->kref.refcount),
+	       atomic_read(&mgr->kref.refcount) - 1);
 
 	return kref_put(&mgr->kref, &amp_mgr_destroy);
 }
-- 
1.7.9.5

