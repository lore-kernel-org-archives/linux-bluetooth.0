Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2 3/4] Add MIME driver to MAP plugin
Date: Fri, 11 Mar 2011 08:46:51 +0100
Message-Id: <1299829612-3704-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As procedures when communicating with message backend will be the same
regardless of the actual type in request, there is only one MIME driver,
thus .mimetype is left NULL.
---
 plugins/mas.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index aefd291..a84b8fd 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -33,6 +33,7 @@
 #include "log.h"
 #include "obex.h"
 #include "service.h"
+#include "mimetype.h"
 #include "dbus.h"
 
 #include "messages.h"
@@ -195,6 +196,43 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 	return 0;
 }
 
+static void *any_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	*err = 0;
+
+	return mas;
+}
+
+static ssize_t any_write(void *object, const void *buf, size_t count)
+{
+	DBG("");
+
+	return count;
+}
+
+static ssize_t any_read(void *obj, void *buf, size_t count,
+				uint8_t *hi, unsigned int *flags)
+{
+	DBG("");
+
+	*hi = OBEX_HDR_BODY;
+	*flags = 0;
+
+	return 0;
+}
+
+static int any_close(void *obj)
+{
+	DBG("");
+
+	return 0;
+}
+
 static struct obex_service_driver mas = {
 	.name = "Message Access server",
 	.service = OBEX_MAS,
@@ -209,10 +247,24 @@ static struct obex_service_driver mas = {
 	.disconnect = mas_disconnect,
 };
 
+static struct obex_mime_type_driver mime_map = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = NULL,
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
 static int mas_init(void)
 {
 	int err;
 
+	err = obex_mime_type_driver_register(&mime_map);
+	if (err < 0)
+		goto failed_mime;
+
 	err = obex_service_driver_register(&mas);
 	if (err < 0)
 		goto failed_mas_reg;
@@ -220,12 +272,16 @@ static int mas_init(void)
 	return 0;
 
 failed_mas_reg:
+	obex_mime_type_driver_unregister(&mime_map);
+
+failed_mime:
 	return err;
 }
 
 static void mas_exit(void)
 {
 	obex_service_driver_unregister(&mas);
+	obex_mime_type_driver_unregister(&mime_map);
 }
 
 OBEX_PLUGIN_DEFINE(mas, mas_init, mas_exit)
-- 
1.7.1

