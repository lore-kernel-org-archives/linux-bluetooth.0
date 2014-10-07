Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 4/6] obexd/mas: Add support for providing MASInstance Info as
 response
Date: Tue, 07 Oct 2014 09:36:54 +0530
Message-id: <1412654816-14971-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/plugins/mas.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index fb97fe3..f9ccab7 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -660,6 +660,56 @@ static void *message_set_status_open(const char *name, int oflag, mode_t mode,
 	return mas;
 }
 
+static void get_mas_instance_info_cb(void *session, int err, uint16_t size,
+					const char *name, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	DBG("");
+
+	if (err < 0 && err != -EAGAIN) {
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+		return;
+	}
+
+	g_string_append(mas->buffer, name);
+
+	mas->finished = TRUE;
+	mas->outparams = NULL;
+
+	if (err != -EAGAIN)
+		obex_object_set_io_flags(mas, G_IO_IN, err);
+
+}
+
+static void *mas_instance_info_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+	uint16_t mas_instance_id = -1;
+
+	DBG("name %s ", name);
+
+	if (oflag != O_RDONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	g_obex_apparam_get_uint16(mas->inparams, MAP_AP_MASINSTANCEID, &mas_instance_id);
+
+	DBG("mas-instance-id : %d", mas_instance_id);
+
+	mas->buffer = g_string_new("");
+
+	*err = messages_get_mas_instance_info(mas->backend_data, mas_instance_id,
+			get_mas_instance_info_cb, mas);
+	if (*err < 0)
+		return NULL;
+	else
+		return mas;
+}
+
+
 static ssize_t any_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
@@ -812,6 +862,17 @@ static struct obex_mime_type_driver mime_message_update = {
 	.write = any_write,
 };
 
+static struct obex_mime_type_driver mime_mas_instance_info = {
+	.target = MAS_TARGET,
+	.target_size = TARGET_SIZE,
+	.mimetype = "x-bt/MASInstanceInformation",
+	.get_next_header = any_get_next_header,
+	.open = mas_instance_info_open,
+	.close = any_close,
+	.read = any_read,
+	.write = any_write,
+};
+
 static struct obex_mime_type_driver *map_drivers[] = {
 	&mime_map,
 	&mime_message,
@@ -820,6 +881,7 @@ static struct obex_mime_type_driver *map_drivers[] = {
 	&mime_notification_registration,
 	&mime_message_status,
 	&mime_message_update,
+	&mime_mas_instance_info,
 	NULL
 };
 
-- 
1.9.1

