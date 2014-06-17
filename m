Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/gatt: Set security level if user requested
Date: Tue, 17 Jun 2014 15:31:11 +0200
Message-Id: <1403011871-8354-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set security level if user requested. It is used when frameworks receives
INSUFFICIENT_ENCRYPTION or INSUFFICIENT_AUTHENTICATIONS errors on read/write
requests and tries to elevate security.
---
 android/gatt.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 9531577..b958167 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2731,6 +2731,52 @@ static int get_sec_level(struct gatt_device *dev)
 	return sec_level;
 }
 
+static bool set_security(struct gatt_device *device, int security)
+{
+	int req_sec_level, sec_level;
+	GError *gerr = NULL;
+	GIOChannel *io;
+
+	if (security < HAL_AUTHENTICATION_NONE ||
+					security > HAL_AUTHENTICATION_MITM) {
+		error("gatt: Invalid security value: %d", security);
+		return false;
+	}
+
+	switch (security) {
+	case HAL_AUTHENTICATION_MITM:
+		req_sec_level = BT_SECURITY_HIGH;
+		break;
+	case HAL_AUTHENTICATION_NO_MITM:
+		req_sec_level = BT_SECURITY_MEDIUM;
+		break;
+	case HAL_AUTHENTICATION_NONE:
+		req_sec_level = BT_SECURITY_LOW;
+		break;
+	}
+
+	sec_level = get_sec_level(device);
+	if (sec_level < 0)
+		return false;
+
+	if (req_sec_level <= sec_level)
+		return true;
+
+	io = g_attrib_get_channel(device->attrib);
+	if (!io)
+		return false;
+
+	bt_io_set(io, &gerr, BT_IO_OPT_SEC_LEVEL, req_sec_level,
+							BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s\n", gerr->message);
+		g_error_free(gerr);
+		return false;
+	}
+
+	return true;
+}
+
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
@@ -2771,6 +2817,13 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	if (!set_security(conn->device, cmd->auth_req)) {
+		error("gatt: Failed to set security %d", cmd->auth_req);
+		status = HAL_STATUS_FAILED;
+		free(cb_data);
+		goto failed;
+	}
+
 	if (!gatt_read_char(conn->device->attrib, ch->ch.value_handle,
 						read_char_cb, cb_data)) {
 		error("gatt: Cannot read characteristic with inst_id: %d",
@@ -2898,6 +2951,12 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		}
 	}
 
+	if (!set_security(conn->device, cmd->auth_req)) {
+		error("gatt: Failed to set security %d", cmd->auth_req);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	switch (cmd->write_type) {
 	case GATT_WRITE_TYPE_NO_RESPONSE:
 		res = gatt_write_cmd(conn->device->attrib, ch->ch.value_handle,
@@ -3099,6 +3158,13 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
+	if (!set_security(conn->device, cmd->auth_req)) {
+		error("gatt: Failed to set security %d", cmd->auth_req);
+		status = HAL_STATUS_FAILED;
+		free(cb_data);
+		goto failed;
+	}
+
 	if (!gatt_read_char(conn->device->attrib, descr->handle, read_desc_cb,
 								cb_data)) {
 		free(cb_data);
@@ -3224,6 +3290,12 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		}
 	}
 
+	if (!set_security(conn->device, cmd->auth_req)) {
+		error("gatt: Failed to set security %d", cmd->auth_req);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
 	switch (cmd->write_type) {
 	case GATT_WRITE_TYPE_NO_RESPONSE:
 		res = gatt_write_cmd(conn->device->attrib, descr->handle,
-- 
1.9.3

