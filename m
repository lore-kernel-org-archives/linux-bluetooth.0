Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 3/3] shared: Return real address of master dev in hciemu
Date: Thu, 11 Apr 2013 11:24:44 -0400
Message-Id: <1365693884-15423-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Exports master btdev address in hciemu.
---
 src/shared/hciemu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 8cd6548..133f16f 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -49,6 +50,7 @@ struct hciemu {
 	guint master_source;
 	guint client_source;
 	GList *post_command_hooks;
+	char bdaddr_str[18];
 };
 
 struct hciemu_command_hook {
@@ -331,10 +333,15 @@ void hciemu_unref(struct hciemu *hciemu)
 
 const char *hciemu_get_address(struct hciemu *hciemu)
 {
-	if (!hciemu)
+	const uint8_t *addr;
+
+	if (!hciemu || !hciemu->master_dev)
 		return NULL;
 
-	return "00:FA:CE:1E:55:00";
+	addr = btdev_get_bdaddr(hciemu->master_dev);
+	sprintf(hciemu->bdaddr_str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+			addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
+	return hciemu->bdaddr_str;
 }
 
 bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
-- 
1.8.2

