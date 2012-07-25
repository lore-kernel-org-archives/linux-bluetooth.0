Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 01:30:12 +0900 (JST)
Message-Id: <20120726.013012.2228722667223437938.yamato@redhat.com>
To: gustavo@padovan.org
Cc: andrei.emeltchenko.news@gmail.com, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 8/8] Added /proc/net/sco via bt_procfs_init()
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20120725003507.GR20029@joana>
References: <20120716.222018.2029110835026223294.yamato@redhat.com>
	<20120725001214.GP20029@joana>
	<20120725003507.GR20029@joana>
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
index 0ef5a78..caa109d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1023,6 +1023,13 @@ int __init sco_init(void)
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
@@ -1041,6 +1048,8 @@ error:
 
 void __exit sco_exit(void)
 {
+	bt_procfs_cleanup(&init_net, "sco");
+
 	debugfs_remove(sco_debugfs);
 
 	if (bt_sock_unregister(BTPROTO_SCO) < 0)
-- 
1.7.10.4

