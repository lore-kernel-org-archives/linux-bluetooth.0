Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 02:19:15 +0900 (JST)
Message-Id: <20120615.021915.49875839680561982.yamato@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Added /proc/net/sco via bt_procfs_init()
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added /proc/net/sco via bt_procfs_init().

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 net/bluetooth/sco.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cbdd313..4f55867 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1043,6 +1043,13 @@ int __init sco_init(void)
 		goto error;
 	}
 
+	err = bt_procfs_init(THIS_MODULE, &init_net, "sco", &sco_sk_list, NULL);
+	if (err < 0) {
+		BT_ERR("Failed to create SCO proc file");
+		bt_sock_unregister(BTPROTO_SCO);
+		goto error;
+	}
+
 	if (bt_debugfs) {
 		sco_debugfs = debugfs_create_file("sco", 0444,
 					bt_debugfs, NULL, &sco_debugfs_fops);
@@ -1061,6 +1068,8 @@ error:
 
 void __exit sco_exit(void)
 {
+	bt_procfs_cleanup(&init_net, "sco");
+
 	debugfs_remove(sco_debugfs);
 
 	if (bt_sock_unregister(BTPROTO_SCO) < 0)
-- 
1.7.10.2

