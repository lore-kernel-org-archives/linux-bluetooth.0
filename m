Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v2] obexd/mas: Handle register notification open
Date: Wed, 29 Oct 2014 18:06:01 +0530
Message-id: <1414586161-11825-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to handle method open for mime_notification_registration
---
 obexd/plugins/mas.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index db40509..61e221d 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -72,6 +72,7 @@ struct mas_session {
 	GObexApparam *inparams;
 	GObexApparam *outparams;
 	gboolean ap_sent;
+	uint8_t notification_status;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -766,6 +767,32 @@ static int any_close(void *obj)
 	return 0;
 }
 
+static void *notification_registration_open(const char *name, int oflag,
+			mode_t mode, void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+	uint8_t status;
+
+	DBG("");
+
+	if (O_RDONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	if (!g_obex_apparam_get_uint8(mas->inparams,
+			MAP_AP_NOTIFICATIONSTATUS, &status)) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	mas->notification_status = status;
+	mas->finished = TRUE;
+	*err = 0;
+
+	return mas;
+}
+
 static struct obex_service_driver mas = {
 	.name = "Message Access server",
 	.service = OBEX_MAS,
@@ -824,7 +851,7 @@ static struct obex_mime_type_driver mime_notification_registration = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/MAP-NotificationRegistration",
-	.open = any_open,
+	.open = notification_registration_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
-- 
1.9.1

