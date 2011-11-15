Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 16/16] pbap: remove dependency on openobex
Date: Tue, 15 Nov 2011 15:28:07 +0200
Message-Id: <1321363687-32490-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/pbap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 7de1dff..0f07c46 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -36,9 +36,9 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
+#include <gobex.h>
 
 #include "obexd.h"
 #include "plugin.h"
@@ -976,7 +976,7 @@ static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 	if (!obj->buffer && !obj->aparams)
 		return -EAGAIN;
 
-	*hi = OBEX_HDR_APPARAM;
+	*hi = G_OBEX_HDR_APPARAM;
 
 	if (pbap->params->maxlistcount == 0 || obj->firstpacket) {
 		obj->firstpacket = FALSE;
@@ -1028,7 +1028,7 @@ static ssize_t vobject_list_get_next_header(void *object, void *buf, size_t mtu,
 	if (!pbap->cache.valid)
 		return -EAGAIN;
 
-	*hi = OBEX_HDR_APPARAM;
+	*hi = G_OBEX_HDR_APPARAM;
 
 	if (pbap->params->maxlistcount == 0)
 		return array_read(obj->aparams, buf, mtu);
-- 
1.7.7.1

