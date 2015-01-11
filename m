Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Add BUILD_BUG_ON for size of struct sockaddr_l2
Date: Sun, 11 Jan 2015 15:18:19 -0800
Message-Id: <1421018300-14151-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an extra check for ensuring that the size of sockaddr_l2
does not grow larger than sockaddr.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f65caf41953f..20206cd3acbc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1614,6 +1614,8 @@ int __init l2cap_init_sockets(void)
 {
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct sockaddr_l2) > sizeof(struct sockaddr));
+
 	err = proto_register(&l2cap_proto, 0);
 	if (err < 0)
 		return err;
-- 
2.1.0

