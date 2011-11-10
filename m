Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 07/21] Bluetooth: A2MP: AMP manager initialization
Date: Thu, 10 Nov 2011 16:54:14 +0200
Message-Id: <1320936868-7978-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 +++
 net/bluetooth/a2mp.c         |   14 ++++++++++++++
 net/bluetooth/l2cap_core.c   |    8 ++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index a89c506..cba3d0f 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -41,4 +41,7 @@ struct a2mp_work_state_change {
 	struct sock *sk;
 };
 
+int a2mp_init(void);
+void a2mp_exit(void);
+
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 21fae45..6ffdd12 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -302,3 +302,17 @@ struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 finished:
 	return mgr;
 }
+
+int a2mp_init(void)
+{
+	a2mp_workqueue = create_singlethread_workqueue("a2mp");
+	if (!a2mp_workqueue)
+		return -EPERM;
+	return 0;
+}
+
+void a2mp_exit(void)
+{
+	flush_workqueue(a2mp_workqueue);
+	destroy_workqueue(a2mp_workqueue);
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 56b94c0..306b27f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -55,6 +55,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <net/bluetooth/a2mp.h>
 
 int disable_ertm;
 int enable_hs;
@@ -4749,6 +4750,12 @@ int __init l2cap_init(void)
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
@@ -4758,6 +4765,7 @@ error:
 
 void l2cap_exit(void)
 {
+	a2mp_exit();
 	debugfs_remove(l2cap_debugfs);
 
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
-- 
1.7.4.1

