Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 07/20] Bluetooth: A2MP: AMP manager initialization
Date: Wed,  2 Nov 2011 16:02:35 +0200
Message-Id: <1320242568-372-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index 9827cec..aafaf09 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -44,4 +44,7 @@ struct a2mp_work_state_change {
 	struct sock *sk;
 };
 
+int a2mp_init(void);
+void a2mp_exit(void);
+
 #endif /* __A2MP_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 190827f..afb01e8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -277,3 +277,17 @@ struct amp_mgr *create_amp_mgr(struct l2cap_conn *conn)
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
index 1a1fe2d..8b930ca 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -55,6 +55,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/smp.h>
+#include <net/bluetooth/a2mp.h>
 
 int disable_ertm;
 int enable_hs;
@@ -4621,6 +4622,12 @@ int __init l2cap_init(void)
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
@@ -4630,6 +4637,7 @@ error:
 
 void l2cap_exit(void)
 {
+	a2mp_exit();
 	debugfs_remove(l2cap_debugfs);
 
 	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
-- 
1.7.4.1

