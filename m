Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jul 2012 14:04:01 +0900 (JST)
Message-Id: <20120711.140401.1493578767541672738.yamato@redhat.com>
To: andrei.emeltchenko.news@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] bluetooth: Added /proc/net/rfcomm via
 bt_procfs_init()
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
 net/bluetooth/rfcomm/sock.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 7e1e596..260821a 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1033,8 +1033,17 @@ int __init rfcomm_init_sockets(void)
 		return err;
 
 	err = bt_sock_register(BTPROTO_RFCOMM, &rfcomm_sock_family_ops);
-	if (err < 0)
+	if (err < 0) {
+		BT_ERR("RFCOMM socket layer registration failed");
+		goto error;
+	}
+
+	err = bt_procfs_init(THIS_MODULE, &init_net, "rfcomm", &rfcomm_sk_list, NULL);
+	if (err < 0) {
+		BT_ERR("Failed to create RFCOMM proc file");
+		bt_sock_unregister(BTPROTO_RFCOMM);
 		goto error;
+	}
 
 	if (bt_debugfs) {
 		rfcomm_sock_debugfs = debugfs_create_file("rfcomm", 0444,
@@ -1048,13 +1057,14 @@ int __init rfcomm_init_sockets(void)
 	return 0;
 
 error:
-	BT_ERR("RFCOMM socket layer registration failed");
 	proto_unregister(&rfcomm_proto);
 	return err;
 }
 
 void __exit rfcomm_cleanup_sockets(void)
 {
+	bt_procfs_cleanup(&init_net, "rfcomm");
+
 	debugfs_remove(rfcomm_sock_debugfs);
 
 	if (bt_sock_unregister(BTPROTO_RFCOMM) < 0)
-- 
1.7.10.4

