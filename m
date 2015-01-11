Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4 v2] Bluetooth: Add BUILD_BUG_ON for size of struct sockaddr_sco
Date: Sun, 11 Jan 2015 15:21:06 -0800
Message-Id: <1421018466-16513-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an extra check for ensuring that the size of sockaddr_sco
does not grow larger than sockaddr.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/sco.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 30e5ea3f1ad3..07ec7d23b843 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1184,6 +1184,8 @@ int __init sco_init(void)
 {
 	int err;
 
+	BUILD_BUG_ON(sizeof(struct sockaddr_sco) > sizeof(struct sockaddr));
+
 	err = proto_register(&sco_proto, 0);
 	if (err < 0)
 		return err;
-- 
2.1.0

