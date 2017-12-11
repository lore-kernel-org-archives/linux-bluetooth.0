Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 1/3] mesh: Segmentation fails in gatt.c:pipe_write()
Date: Mon, 11 Dec 2017 14:58:37 +0000
Message-Id: <20171211145839.19573-2-sbrown@cortland.com>
In-Reply-To: <20171211145839.19573-1-sbrown@cortland.com>
References: <20171211145839.19573-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

If the first command output in a new connection exceeds 20 bytes,
mesh_gatt_write sets the SAR to FIRST as the write_mtu is initially 0
and the default is GATT_MTU-3 (20).

When pipe_write gets called, a new larger write_mtu has been set, but
the SAR is still set to FIRST. It's assumed that data->gatt_len >
max_len. However, it's not which causes lots of bogus output.

---

At Luiz' suggestion.

1. The WriteValue code has been removed
2. The SAR logic has been moved to pipe_write

It was tested against the zephyr mesh_shell and a small mtu to test the
segmentation logic.
---
 mesh/gatt.c | 141 ++++++++----------------------------------------------------
 1 file changed, 18 insertions(+), 123 deletions(-)

diff --git a/mesh/gatt.c b/mesh/gatt.c
index 197291e67..9116a9de1 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -102,27 +102,6 @@ static void write_data_free(void *user_data)
 	free(data);
 }
 
-static void write_setup(DBusMessageIter *iter, void *user_data)
-{
-	struct write_data *data = user_data;
-	struct iovec *iov = &data->iov;
-	DBusMessageIter array, dict;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
-	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
-						&iov->iov_base, iov->iov_len);
-	dbus_message_iter_close_container(iter, &array);
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-
-	dbus_message_iter_close_container(iter, &dict);
-}
-
 uint16_t mesh_gatt_sar(uint8_t **pkt, uint16_t size)
 {
 	const uint8_t *data = *pkt;
@@ -192,11 +171,12 @@ static bool pipe_write(struct io *io, void *user_data)
 	struct write_data *data = user_data;
 	struct iovec iov[2];
 	uint8_t sar;
-	uint8_t max_len = write_mtu - 4;
+	uint8_t max_len;
 
 	if (data == NULL)
 		return true;
 
+	max_len = write_mtu ? write_mtu - 3 - 1 : GATT_MTU - 3 - 1;
 	print_byte_array("GATT-TX:\t", data->gatt_data, data->gatt_len);
 
 	sar = data->gatt_data[0];
@@ -204,6 +184,14 @@ static bool pipe_write(struct io *io, void *user_data)
 	data->iov.iov_base = data->gatt_data + 1;
 	data->iov.iov_len--;
 
+	sar = data->gatt_data[0] & GATT_TYPE_MASK;
+	data->gatt_len--;
+
+	if (data->gatt_len > max_len) {
+		sar |= GATT_SAR_FIRST;
+		data->iov.iov_len = max_len;
+	}
+
 	iov[0].iov_base = &sar;
 	iov[0].iov_len = sizeof(sar);
 
@@ -245,73 +233,6 @@ static bool pipe_write(struct io *io, void *user_data)
 	}
 }
 
-static void write_reply(DBusMessage *message, void *user_data)
-{
-	struct write_data *data = user_data;
-	struct write_data *tmp;
-	uint8_t *dptr = data->gatt_data;
-	uint8_t max_len = GATT_MTU - 3;
-	uint8_t max_seg = GATT_MTU - 4;
-	DBusError error;
-
-	dbus_error_init(&error);
-
-	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		bt_shell_printf("Failed to write: %s\n", error.name);
-		dbus_error_free(&error);
-		return;
-	}
-
-	if (data == NULL)
-		return;
-
-	switch (data->gatt_data[0] & GATT_SAR_MASK) {
-		case GATT_SAR_FIRST:
-		case GATT_SAR_CONTINUE:
-			tmp = g_new0(struct write_data, 1);
-			if (!data)
-				return;
-
-			*tmp = *data;
-			tmp->gatt_data = g_malloc(data->gatt_len);
-
-			if (!tmp->gatt_data) {
-				g_free(tmp);
-				return;
-			}
-
-			tmp->gatt_data[0] = dptr[0];
-			data = tmp;
-			memcpy(data->gatt_data + 1, dptr + max_len,
-					data->gatt_len - max_seg);
-			data->gatt_len -= max_seg;
-			data->gatt_data[0] &= GATT_TYPE_MASK;
-			data->iov.iov_base = data->gatt_data;
-			if (max_len < data->gatt_len) {
-				data->iov.iov_len = max_len;
-				data->gatt_data[0] |= GATT_SAR_CONTINUE;
-			} else {
-				data->iov.iov_len = data->gatt_len;
-				data->gatt_data[0] |= GATT_SAR_LAST;
-			}
-
-			break;
-
-		default:
-			if(data->cb)
-				data->cb(message, data->user_data);
-			return;
-	}
-
-	if (g_dbus_proxy_method_call(data->proxy, "WriteValue", write_setup,
-				write_reply, data, write_data_free) == FALSE) {
-		bt_shell_printf("Failed to write\n");
-		write_data_free(data);
-		return;
-	}
-
-}
-
 static void write_io_destroy(void)
 {
 	io_destroy(write_io);
@@ -361,12 +282,8 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		dbus_error_free(&error);
-		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
-				write_setup, write_reply, data,
-				write_data_free) == FALSE) {
-			bt_shell_printf("Failed to write\n");
-			write_data_free(data);
-		}
+		bt_shell_printf("Failed to write\n");
+		write_data_free(data);
 		return;
 	}
 
@@ -402,8 +319,6 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 			GDBusReturnFunction cb, void *user_data)
 {
 	struct write_data *data;
-	DBusMessageIter iter;
-	uint8_t max_len;
 
 	if (!buf || !len)
 		return false;
@@ -415,17 +330,11 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 	if (!data)
 		return false;
 
-	max_len = write_mtu ? write_mtu - 3 : GATT_MTU - 3;
-
 	/* TODO: should keep in queue in case we need to cancel write? */
 
 	data->gatt_len = len;
 	data->gatt_data = g_memdup(buf, len);
 	data->gatt_data[0] &= GATT_TYPE_MASK;
-	if (max_len < len) {
-		len = max_len;
-		data->gatt_data[0] |= GATT_SAR_FIRST;
-	}
 	data->iov.iov_base = data->gatt_data;
 	data->iov.iov_len = len;
 	data->proxy = proxy;
@@ -435,27 +344,13 @@ bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
 	if (write_io)
 		return pipe_write(write_io, data);
 
-	if (g_dbus_proxy_get_property(proxy, "WriteAcquired", &iter)) {
-		if (g_dbus_proxy_method_call(proxy, "AcquireWrite",
-					acquire_setup, acquire_write_reply,
-					data, NULL) == FALSE) {
-			bt_shell_printf("Failed to AcquireWrite\n");
-			write_data_free(data);
-			return false;
-		}
-	} else {
-		if (g_dbus_proxy_method_call(data->proxy, "WriteValue",
-				write_setup, write_reply, data,
-				write_data_free) == FALSE) {
-			bt_shell_printf("Failed to write\n");
-			write_data_free(data);
-			return false;
-		}
-		print_byte_array("GATT-TX: ", buf, len);
-		bt_shell_printf("Attempting to write %s\n",
-						g_dbus_proxy_get_path(proxy));
+	if (g_dbus_proxy_method_call(proxy, "AcquireWrite",
+				acquire_setup, acquire_write_reply,
+				data, NULL) == FALSE) {
+		bt_shell_printf("Failed to AcquireWrite\n");
+		write_data_free(data);
+		return false;
 	}
-
 	return true;
 }
 
-- 
2.11.0

