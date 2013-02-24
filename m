Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 03/16] Bluetooth: hidp: simplify error path in sock-init
Date: Sun, 24 Feb 2013 19:36:53 +0100
Message-Id: <1361731026-7428-4-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We currently print errors twice when doing a "goto error;". Avoid this and
also use labels for each error-condition. We shouldn't mix
"inline-cleanup" and "goto-cleanup" in a single function. It makes
extending the function later just more work.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 5d0f1ca..ca86436 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -281,22 +281,22 @@ int __init hidp_init_sockets(void)
 	err = bt_sock_register(BTPROTO_HIDP, &hidp_sock_family_ops);
 	if (err < 0) {
 		BT_ERR("Can't register HIDP socket");
-		goto error;
+		goto err_proto;
 	}
 
 	err = bt_procfs_init(THIS_MODULE, &init_net, "hidp", &hidp_sk_list, NULL);
 	if (err < 0) {
 		BT_ERR("Failed to create HIDP proc file");
-		bt_sock_unregister(BTPROTO_HIDP);
-		goto error;
+		goto err_sock;
 	}
 
 	BT_INFO("HIDP socket layer initialized");
 
 	return 0;
 
-error:
-	BT_ERR("Can't register HIDP socket");
+err_sock:
+	bt_sock_unregister(BTPROTO_HIDP);
+err_proto:
 	proto_unregister(&hidp_proto);
 	return err;
 }
-- 
1.8.1.4
