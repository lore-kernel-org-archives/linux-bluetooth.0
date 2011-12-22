Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 06/20] Bluetooth: A2MP: AMP manager initialization
Date: Thu, 22 Dec 2011 13:06:12 +0200
Message-Id: <1324551986-29431-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 +++
 net/bluetooth/a2mp.c         |   18 ++++++++++++++++++
 net/bluetooth/l2cap_core.c   |    8 ++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6c160d4..f9526fc 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -36,4 +36,7 @@ struct a2mp_cmd {
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 
+int a2mp_init(void);
+void a2mp_exit(void);
+
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b197cf3..44b0887 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -250,3 +250,21 @@ struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 finished:
 	return mgr;
 }
+
+int a2mp_init(void)
+{
+#if 0
+	a2mp_workqueue = create_singlethread_workqueue("a2mp");
+	if (!a2mp_workqueue)
+		return -EPERM;
+#endif
+	return 0;
+}
+
+void a2mp_exit(void)
+{
+#if 0
+	flush_workqueue(a2mp_workqueue);
+	destroy_workqueue(a2mp_workqueue);
+#endif
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2d42382..0b47063 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -56,6 +56,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <net/bluetooth/a2mp.h>
 
 int disable_ertm;
 
@@ -4787,6 +4788,12 @@ int __init l2cap_init(void)
 			BT_ERR("Failed to create L2CAP debug file");
 	}
 
+	err = a2mp_init();
+	if (err < 0) {
+		BT_ERR("AMP Manager initialization failed");
+		goto error;
+	}
+
 	return 0;
 
 error:
@@ -4796,6 +4803,7 @@ error:
 
 void l2cap_exit(void)
 {
+	a2mp_exit();
 	debugfs_remove(l2cap_debugfs);
 
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
-- 
1.7.4.1

