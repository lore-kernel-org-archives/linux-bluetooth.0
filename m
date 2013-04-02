Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2 01/18] Bluetooth: hidp: remove redundant error message
Date: Tue,  2 Apr 2013 18:08:21 +0200
Message-Id: <1364918918-2336-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We print this error twice in the first error-path so remove it. One error
message is enough.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/hidp/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 82a829d..20ebd4f 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -296,7 +296,6 @@ int __init hidp_init_sockets(void)
 	return 0;
 
 error:
-	BT_ERR("Can't register HIDP socket");
 	proto_unregister(&hidp_proto);
 	return err;
 }
-- 
1.8.2
