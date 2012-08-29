Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Add parameters to get message in map module
Date: Wed, 29 Aug 2012 11:39:50 +0200
Message-Id: <1346233190-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GetMessage function needs attachment and charset application params
---
 client/map.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/client/map.c b/client/map.c
index 4f07fcb..fa27c21 100644
--- a/client/map.c
+++ b/client/map.c
@@ -29,6 +29,8 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include <gobex/gobex-apparam.h>
+
 #include "dbus.h"
 #include "log.h"
 
@@ -36,6 +38,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "map_ap.h"
 
 #define OBEX_MAS_UUID \
 	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
@@ -258,6 +261,9 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	struct map_msg *msg = user_data;
 	struct obc_transfer *transfer;
 	const char *target_file;
+	GObexApparam *apparam;
+	guint8 buf[6];
+	gsize len;
 	GError *err = NULL;
 	DBusMessage *reply;
 
@@ -272,6 +278,14 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT, 0);
+	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET, 1);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+
+	obc_transfer_set_params(transfer, buf, len);
+
+	g_obex_apparam_free(apparam);
+
 	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
 		goto fail;
 
-- 
1.7.9.5

