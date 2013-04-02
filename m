Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 14/18] attrib: Simplify prepare_write()
Date: Tue,  2 Apr 2013 12:51:01 -0400
Message-Id: <1364921465-31182-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All parameters can be retrieved from struct write_long_data fields,
therefore there is no need to pass them separately.
---
 attrib/gatt.c |   29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index f629fcf..5835e83 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -777,9 +777,7 @@ static guint execute_write(GAttrib *attrib, uint8_t flags,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data);
+static guint prepare_write(struct write_long_data *long_write);
 
 static void prepare_write_cb(guint8 status, const guint8 *rpdu, guint16 rlen,
 							gpointer user_data)
@@ -803,28 +801,26 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu, guint16 rlen,
 		return;
 	}
 
-	prepare_write(long_write->attrib, long_write->handle,
-			long_write->offset, long_write->value, long_write->vlen,
-			long_write->func, long_write);
+	prepare_write(long_write);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data)
+static guint prepare_write(struct write_long_data *long_write)
 {
+	GAttrib *attrib = long_write->attrib;
+	uint16_t handle = long_write->handle;
+	uint16_t offset = long_write->offset;
+	uint8_t *buf, *value = long_write->value + offset;
+	size_t buflen, vlen = long_write->vlen - offset;
 	guint16 plen;
-	size_t buflen;
-	uint8_t *buf;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 
-	plen = enc_prep_write_req(handle, offset, &value[offset], vlen - offset,
-								buf, buflen);
+	plen = enc_prep_write_req(handle, offset, value, vlen, buf, buflen);
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf, plen, prepare_write_cb,
-							user_data, NULL);
+	return g_attrib_send(attrib, 0, buf, plen, prepare_write_cb, long_write,
+									NULL);
 }
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
@@ -861,8 +857,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 	long_write->value = g_memdup(value, vlen);
 	long_write->vlen = vlen;
 
-	return prepare_write(attrib, handle, long_write->offset, value, vlen,
-							func, long_write);
+	return prepare_write(long_write);
 }
 
 struct gatt_exchange_mtu_data {
-- 
1.7.9.5

