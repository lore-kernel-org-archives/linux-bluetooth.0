Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 04/22] Bluetooth: A2MP: Create amp_mgr global list
Date: Fri, 24 Aug 2012 17:00:03 +0300
Message-Id: <1345816821-32331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create amp_mgr_list global list which will be used by different
hci devices to find amp_mgr.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    8 ++++++++
 net/bluetooth/a2mp.c         |   29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6a76e0a..e56d656 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -20,11 +20,15 @@
 #define A2MP_FEAT_EXT	0x8000
 
 struct amp_mgr {
+	struct list_head	list;
 	struct l2cap_conn	*l2cap_conn;
 	struct l2cap_chan	*a2mp_chan;
 	struct kref		kref;
 	__u8			ident;
 	__u8			handle;
+	enum {
+		READ_LOC_AMP_INFO,
+	} state;
 	unsigned long		flags;
 };
 
@@ -118,9 +122,13 @@ struct a2mp_physlink_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
 #define A2MP_STATUS_SECURITY_VIOLATION		0x06
 
+extern struct list_head amp_mgr_list;
+extern struct mutex amp_mgr_list_lock;
+
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
+struct amp_mgr *amp_mgr_lookup_by_state(u8 state);
 
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 44ef201..81d72be 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -17,6 +17,10 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+/* Global AMP Manager list */
+LIST_HEAD(amp_mgr_list);
+DEFINE_MUTEX(amp_mgr_list_lock);
+
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 {
@@ -518,6 +522,10 @@ static void amp_mgr_destroy(struct kref *kref)
 
 	BT_DBG("mgr %p", mgr);
 
+	mutex_lock(&amp_mgr_list_lock);
+	list_del(&mgr->list);
+	mutex_unlock(&amp_mgr_list_lock);
+
 	kfree(mgr);
 }
 
@@ -552,6 +560,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 
 	conn->hcon->amp_mgr = mgr;
 
+	mutex_lock(&amp_mgr_list_lock);
+	list_add(&mgr->list, &amp_mgr_list);
+	mutex_unlock(&amp_mgr_list_lock);
+
 	kref_init(&mgr->kref);
 
 	return mgr;
@@ -572,3 +584,20 @@ struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 
 	return mgr->a2mp_chan;
 }
+
+struct amp_mgr *amp_mgr_lookup_by_state(u8 state)
+{
+	struct amp_mgr *mgr;
+
+	mutex_lock(&amp_mgr_list_lock);
+	list_for_each_entry(mgr, &amp_mgr_list, list) {
+		if (mgr->state == state) {
+			amp_mgr_get(mgr);
+			mutex_unlock(&amp_mgr_list_lock);
+			return mgr;
+		}
+	}
+	mutex_unlock(&amp_mgr_list_lock);
+
+	return NULL;
+}
-- 
1.7.9.5

