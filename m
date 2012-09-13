Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 1/3] MAP: Add binding to support SetMessageStatus function
Date: Thu, 13 Sep 2012 11:36:19 +0530
Message-id: <1347516379-28342-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add message_set_status_open binding in MIME driver
to support SetMessageStatus function.
---
 plugins/mas.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 1c9199d..f2ff9e6 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -649,6 +649,37 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void *message_set_status_open(const char *name, int oflag, mode_t mode,
+					void *driver_data, size_t *size,
+					int *err)
+
+{
+	struct mas_session *mas = driver_data;
+	uint8_t indicator;
+	uint8_t value;
+
+	DBG("");
+
+	if (oflag == O_RDONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_STATUSINDICATOR,
+					&indicator)) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	if (!g_obex_apparam_get_uint8(mas->inparams, MAP_AP_STATUSVALUE,
+					&value)) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	return mas;
+}
+
 static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
@@ -784,7 +815,7 @@ static struct obex_mime_type_driver mime_message_status = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/messageStatus",
-	.open = any_open,
+	.open = message_set_status_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
-- 
1.7.9.5

