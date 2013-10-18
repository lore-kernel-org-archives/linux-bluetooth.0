Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Use IS_ERR_OR_NULL for checking bt_debugfs
Date: Thu, 17 Oct 2013 17:24:16 -0700
Message-Id: <1382055860-12572-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure to use IS_ERR_OR_NULL for checking the existing of the root
debugfs dentry bt_debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c  | 11 +++++------
 net/bluetooth/rfcomm/core.c | 14 +++++++-------
 net/bluetooth/rfcomm/sock.c | 14 +++++++-------
 net/bluetooth/sco.c         | 13 ++++++-------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8af34d2..763b741 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6833,12 +6833,11 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
-	if (bt_debugfs) {
-		l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
-						    NULL, &l2cap_debugfs_fops);
-		if (!l2cap_debugfs)
-			BT_ERR("Failed to create L2CAP debug file");
-	}
+	if (IS_ERR_OR_NULL(bt_debugfs))
+		return 0;
+
+	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
+					    NULL, &l2cap_debugfs_fops);
 
 	return 0;
 }
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 27e936a..94d06cb 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2154,13 +2154,6 @@ static int __init rfcomm_init(void)
 		goto unregister;
 	}
 
-	if (bt_debugfs) {
-		rfcomm_dlc_debugfs = debugfs_create_file("rfcomm_dlc", 0444,
-				bt_debugfs, NULL, &rfcomm_dlc_debugfs_fops);
-		if (!rfcomm_dlc_debugfs)
-			BT_ERR("Failed to create RFCOMM debug file");
-	}
-
 	err = rfcomm_init_ttys();
 	if (err < 0)
 		goto stop;
@@ -2171,6 +2164,13 @@ static int __init rfcomm_init(void)
 
 	BT_INFO("RFCOMM ver %s", VERSION);
 
+	if (IS_ERR_OR_NULL(bt_debugfs))
+		return 0;
+
+	rfcomm_dlc_debugfs = debugfs_create_file("rfcomm_dlc", 0444,
+						 bt_debugfs, NULL,
+						 &rfcomm_dlc_debugfs_fops);
+
 	return 0;
 
 cleanup:
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index df17276..c4d3d42 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1051,15 +1051,15 @@ int __init rfcomm_init_sockets(void)
 		goto error;
 	}
 
-	if (bt_debugfs) {
-		rfcomm_sock_debugfs = debugfs_create_file("rfcomm", 0444,
-				bt_debugfs, NULL, &rfcomm_sock_debugfs_fops);
-		if (!rfcomm_sock_debugfs)
-			BT_ERR("Failed to create RFCOMM debug file");
-	}
-
 	BT_INFO("RFCOMM socket layer initialized");
 
+	if (IS_ERR_OR_NULL(bt_debugfs))
+		return 0;
+
+	rfcomm_sock_debugfs = debugfs_create_file("rfcomm", 0444,
+						  bt_debugfs, NULL,
+						  &rfcomm_sock_debugfs_fops);
+
 	return 0;
 
 error:
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a92aeba..12a0e51 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1177,15 +1177,14 @@ int __init sco_init(void)
 		goto error;
 	}
 
-	if (bt_debugfs) {
-		sco_debugfs = debugfs_create_file("sco", 0444, bt_debugfs,
-						  NULL, &sco_debugfs_fops);
-		if (!sco_debugfs)
-			BT_ERR("Failed to create SCO debug file");
-	}
-
 	BT_INFO("SCO socket layer initialized");
 
+	if (IS_ERR_OR_NULL(bt_debugfs))
+		return 0;
+
+	sco_debugfs = debugfs_create_file("sco", 0444, bt_debugfs,
+					  NULL, &sco_debugfs_fops);
+
 	return 0;
 
 error:
-- 
1.8.3.1

