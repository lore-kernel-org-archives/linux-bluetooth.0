Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/3] MAP: Add MIME drivers
Date: Fri, 12 Aug 2011 16:00:41 +0200
Message-Id: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds drivers for MIME types needed in Message Access Profile. The
target-default driver is also kept to prevent MIME driver selection
mechanism to get to default driver from filesystem.c which would result
in allowing putting files in arbitrary locations when connected to MAP
target.

The any_open() bindings in MIME drivers are going to be successfully
replaced by appropriate calls for specific functionality.
---
 plugins/mas.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 0ef8c81..59ae0c1 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -206,13 +206,11 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 static void *any_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
-	struct mas_session *mas = driver_data;
-
 	DBG("");
 
-	*err = 0;
+	*err = -EINVAL;
 
-	return mas;
+	return NULL;
 }
 
 static ssize_t any_write(void *object, const void *buf, size_t count)
@@ -260,28 +258,102 @@ static struct obex_mime_type_driver mime_map = {
 	.write = any_write,
 };
 
+static struct obex_mime_type_driver mime_message = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/message",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_folder_listing = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-obex/folder-listing",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_msg_listing = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MAP-msg-listing",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_notification_registration = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MAP-NotificationRegistration",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_message_status = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/messageStatus",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver mime_message_update = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MAP-messageUpdate",
+	.open = any_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
+static struct obex_mime_type_driver *map_drivers[] = {
+	&mime_map,
+	&mime_message,
+	&mime_folder_listing,
+	&mime_msg_listing,
+	&mime_notification_registration,
+	&mime_message_status,
+	&mime_message_update,
+	NULL
+};
+
 static int mas_init(void)
 {
 	int err;
+	int i;
 
 	err = messages_init();
 	if (err < 0)
 		return err;
 
-	err = obex_mime_type_driver_register(&mime_map);
-	if (err < 0)
-		goto failed_mime;
+	for (i = 0; map_drivers[i] != NULL; ++i) {
+		err = obex_mime_type_driver_register(map_drivers[i]);
+		if (err < 0)
+			goto failed;
+	}
 
 	err = obex_service_driver_register(&mas);
 	if (err < 0)
-		goto failed_mas_reg;
+		goto failed;
 
 	return 0;
 
-failed_mas_reg:
-	obex_mime_type_driver_unregister(&mime_map);
+failed:
+	for (--i; i >= 0; --i)
+		obex_mime_type_driver_unregister(map_drivers[i]);
 
-failed_mime:
 	messages_exit();
 
 	return err;
@@ -289,8 +361,13 @@ failed_mime:
 
 static void mas_exit(void)
 {
+	int i;
+
 	obex_service_driver_unregister(&mas);
-	obex_mime_type_driver_unregister(&mime_map);
+
+	for (i = 0; map_drivers[i] != NULL; ++i)
+		obex_mime_type_driver_unregister(map_drivers[i]);
+
 	messages_exit();
 }
 
-- 
1.7.4.1

