Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 03/10] android/client: Add complex GATT type formating
Date: Thu, 31 Oct 2013 11:45:08 +0100
Message-ID: <1383216315-30627-4-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds formating for complex types in GATT.
---
 android/client/if-gatt.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 8f3dc3c..db5494c 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -30,30 +30,129 @@ const btgatt_interface_t *if_gatt = NULL;
 #define MAX_READ_PARAMS_STR_LEN (MAX_SRVC_ID_STR_LEN + MAX_CHAR_ID_STR_LEN \
 		+ MAX_UUID_STR_LEN + MAX_HEX_VAL_STR_LEN + 80)
 
+/* Gatt uses little endian uuid */
+static const char GATT_BASE_UUID[] = {
+	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+/*
+ * converts gatt uuid to string
+ * buf should be at least 39 bytes
+ *
+ * This function formats 16, 32 and 128 bits uuid
+ *
+ * returns string representation of uuid
+ */
 static char *gatt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
 {
+	int shift = 0;
+	int i = 16;
+	int limit = 0;
+	int j = 0;
+
+	/* for bluetooth uuid only 32 bits */
+	if (0 == memcmp(&uuid->uu, &GATT_BASE_UUID,
+						sizeof(bt_uuid_t) - 4)) {
+		limit = 12;
+		/* make it 16 bits */
+		if (uuid->uu[15] == 0 && uuid->uu[14] == 0)
+			i = 14;
+	}
+
+	while (i-- > limit) {
+		if (i == 11 || i == 9 || i == 7 || i == 5) {
+			buf[j * 2 + shift] = '-';
+			shift++;
+		}
+
+		sprintf(buf + j * 2 + shift, "%02x", uuid->uu[i]);
+		++j;
+	}
+
 	return buf;
 }
 
+/* char_id formating function */
 static char *btgatt_char_id_t2str(const btgatt_char_id_t *char_id, char *buf)
 {
+	char uuid_buf[MAX_UUID_STR_LEN];
+
+	sprintf(buf, "{%s,%d}", gatt_uuid_t2str(&char_id->uuid, uuid_buf),
+							char_id->inst_id);
 	return buf;
 }
 
+/* service_id formating function */
 static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
 {
+	char uuid_buf[MAX_UUID_STR_LEN];
+
+	sprintf(buf, "{%s,%d,%d}", gatt_uuid_t2str(&srvc_id->id.uuid, uuid_buf),
+				srvc_id->id.inst_id, srvc_id->is_primary);
+	return buf;
+}
+
+/* Converts array of uint8_t to string representation */
+static char *array2str(const uint8_t *v, int size, char *buf, int out_size)
+{
+	int limit = size;
+	int i;
+
+	if (out_size > 0) {
+		*buf = '\0';
+		if (size >= 2 * out_size)
+			limit = (out_size - 2) / 2;
+
+		for (i = 0; i < limit; ++i)
+			sprintf(buf + 2 * i, "%02x", v[i]);
+
+		/* output buffer not enough to hold whole field fill with ...*/
+		if (limit < size)
+			sprintf(buf + 2 * i, "...");
+	}
+
 	return buf;
 }
 
+/* Converts btgatt_notify_params_t to string */
 static char *btgatt_notify_params_t2str(const btgatt_notify_params_t *data,
 								char *buf)
 {
+	char addr[MAX_ADDR_STR_LEN];
+	char srvc_id[MAX_SRVC_ID_STR_LEN];
+	char char_id[MAX_CHAR_ID_STR_LEN];
+	char value[MAX_HEX_VAL_STR_LEN];
+
+	sprintf(buf, "{bda=%s, srvc_id=%s, char_id=%s, val=%s, is_notify=%u}",
+		bt_bdaddr_t2str(&data->bda, addr),
+		btgatt_srvc_id_t2str(&data->srvc_id, srvc_id),
+		btgatt_char_id_t2str(&data->char_id, char_id),
+		array2str(data->value, data->len, value, sizeof(value)),
+							data->is_notify);
 	return buf;
 }
 
+static char *btgatt_unformatted_value_t2str(const btgatt_unformatted_value_t *v,
+							char *buf, int size)
+{
+	return array2str(v->value, v->len, buf, size);
+}
+
 static char *btgatt_read_params_t2str(const btgatt_read_params_t *data,
 								char *buf)
 {
+	char srvc_id[MAX_SRVC_ID_STR_LEN];
+	char char_id[MAX_CHAR_ID_STR_LEN];
+	char descr_id[MAX_UUID_STR_LEN];
+	char value[MAX_HEX_VAL_STR_LEN];
+
+	sprintf(buf, "{srvc_id=%s, char_id=%s, descr_id=%s, val=%s value_type=%d, status=%d}",
+		btgatt_srvc_id_t2str(&data->srvc_id, srvc_id),
+		btgatt_char_id_t2str(&data->char_id, char_id),
+		gatt_uuid_t2str(&data->descr_id, descr_id),
+		btgatt_unformatted_value_t2str(&data->value, value, 100),
+		data->value_type, data->status);
 	return buf;
 }
 
-- 
1.7.9.5

