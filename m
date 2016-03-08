Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-database: Don't always wait for response
Date: Tue,  8 Mar 2016 15:18:51 +0200
Message-Id: <1457443131-17895-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1457443131-17895-1-git-send-email-luiz.dentz@gmail.com>
References: <1457443131-17895-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the characterist has set BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP it means
it won't reply to WriteValue and even if it does other Write Commands
can be outstanding which would be blocked waiting the reply of the
previous message.
---
 src/gatt-database.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5244a9d..b8da955 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1965,6 +1965,36 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 	send_read(attrib, chrc->proxy, chrc->pending_reads, id);
 }
 
+static void write_without_response_setup_cb(DBusMessageIter *iter,
+							void *user_data)
+{
+	struct iovec *iov = user_data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&iov->iov_base, iov->iov_len);
+	dbus_message_iter_close_container(iter, &array);
+}
+
+static void send_write_without_response(struct gatt_db_attribute *attrib,
+					GDBusProxy *proxy, unsigned int id,
+					const uint8_t *value, size_t len)
+{
+	struct iovec iov;
+	uint8_t ecode = 0;
+
+	iov.iov_base = (uint8_t *) value;
+	iov.iov_len = len;
+
+	if (!g_dbus_proxy_method_call(proxy, "WriteValue",
+					write_without_response_setup_cb,
+					NULL, &iov, NULL))
+		ecode = BT_ATT_ERROR_UNLIKELY;
+
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
 static void chrc_write_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					const uint8_t *value, size_t len,
@@ -1978,6 +2008,12 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	if (chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP) {
+		send_write_without_response(attrib, chrc->proxy, id, value,
+									len);
+		return;
+	}
+
 	send_write(attrib, chrc->proxy, chrc->pending_writes, id, value, len);
 }
 
-- 
2.5.0

