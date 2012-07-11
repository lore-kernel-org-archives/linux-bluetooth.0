Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 14:04:23 +0900 (JST)
Message-Id: <20120711.140423.1598510269265721139.yamato@redhat.com>
To: andrei.emeltchenko.news@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] bluetooth: Added /proc/net/sco via bt_procfs_init()
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20120711.135831.1712662939552441872.yamato@redhat.com>
References: <20120629.020253.963694178693689545.yamato@redhat.com>
	<20120710140400.GA15795@aemeltch-MOBL1>
	<20120711.135831.1712662939552441872.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 net/bluetooth/sco.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 40bbe25..85efd9f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1026,6 +1026,13 @@ int __init sco_init(void)
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
 		sco_debugfs = debugfs_create_file("sco", 0444, bt_debugfs,
 						  NULL, &sco_debugfs_fops);
@@ -1044,6 +1051,8 @@ error:
 
 void __exit sco_exit(void)
 {
+	bt_procfs_cleanup(&init_net, "sco");
+
 	debugfs_remove(sco_debugfs);
 
 	if (bt_sock_unregister(BTPROTO_SCO) < 0)
-- 
1.7.10.4

