Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Add BUILD_BUG_ON for size of struct sockaddr_rc
Date: Sun, 11 Jan 2015 15:18:20 -0800
Message-Id: <1421018300-14151-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an extra check for ensuring that the size of sockaddr_rc
does not grow larger than sockaddr.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/rfcomm/sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2348176401a0..d8a95755a8a8 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1058,6 +1058,8 @@ int __init rfcomm_init_sockets(void)
 {
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct sockaddr_rc) > sizeof(struct sockaddr));
+
 	err = proto_register(&rfcomm_proto, 0);
 	if (err < 0)
 		return err;
-- 
2.1.0

