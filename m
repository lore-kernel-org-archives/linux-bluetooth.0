Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add BUILD_BUG_ON for size of struct sockaddr_hci
Date: Sun, 11 Jan 2015 15:18:17 -0800
Message-Id: <1421018300-14151-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an extra check for ensuring that the size of sockaddr_hci
does not grow larger than sockaddr.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2c245fdf319a..e176a988625e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1230,6 +1230,8 @@ int __init hci_sock_init(void)
 {
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct sockaddr_hci) > sizeof(struct sockaddr));
+
 	err = proto_register(&hci_sk_proto, 0);
 	if (err < 0)
 		return err;
-- 
2.1.0

