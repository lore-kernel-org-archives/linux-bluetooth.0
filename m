Return-Path: <cyrus@holtmann.org>
From: Eder Ruiz Maria <eder.ruiz@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 3/3] gatt: Add support to GATT Write Long Characteristic
Date: Fri, 27 Jul 2012 16:29:36 -0400
Message-Id: <1343420976-19921-3-git-send-email-eder.ruiz@openbossa.org>
In-Reply-To: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
References: <1343420976-19921-1-git-send-email-eder.ruiz@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extending the function gatt_write_char for support GATT Write Long
Characteristics. MTU is checked and if the payload does not fit,
the prepare and execute write are used to do the transaction.
---
 attrib/att.h         |    4 ++
 attrib/gatt.c        |  109 +++++++++++++++++++++++++++++++++++++++++++++++---
 attrib/gatttool.c    |    2 +-
 attrib/interactive.c |    2 +-
 4 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 64d22ca..e7a29cb 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -92,6 +92,10 @@
 #define ATT_CID					4
 #define ATT_PSM					31
 
+/* Flags for Execute Write Request Operation */
+#define ATT_CANCEL_ALL_PREP_WRITES              0x00
+#define ATT_WRITE_ALL_PREP_WRITES               0x01
+
 struct att_data_list {
 	uint16_t num;
 	uint16_t len;
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 6f9a11d..b7eb736 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -520,21 +520,120 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
 	return id;
 }
 
+struct write_long_data {
+	GAttrib *attrib;
+	GAttribResultFunc func;
+	gpointer user_data;
+	guint16 handle;
+	uint16_t offset;
+	uint8_t *value;
+	int vlen;
+};
+
+static guint execute_write(GAttrib *attrib, uint8_t flags,
+				GAttribResultFunc func, gpointer user_data)
+{
+	uint8_t *buf;
+	int buflen;
+	guint16 plen;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+	plen = enc_exec_write_req(flags, buf, buflen);
+	if (plen == 0)
+		return 0;
+
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, func, user_data,
+									NULL);
+}
+
+static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
+			uint8_t *value, int vlen, GAttribResultFunc func,
+			gpointer user_data);
+
+static void prepare_write_cb(guint8 status, const guint8 *rpdu,
+					guint16 rlen, gpointer user_data)
+{
+	struct write_long_data *long_write = user_data;
+
+	if (status != 0) {
+		long_write->func(status, rpdu, rlen, long_write->user_data);
+		return;
+	}
+
+	/* Skip Prepare Write Response PDU header (5 bytes) */
+	long_write->offset += rlen - 5;
+
+	if (long_write->offset == long_write->vlen){
+		execute_write(long_write->attrib, ATT_WRITE_ALL_PREP_WRITES,
+				long_write->func, long_write->user_data);
+		g_free(long_write->value);
+		g_free(long_write);
+
+		return;
+	}
+
+	prepare_write(long_write->attrib, long_write->handle,
+		long_write->offset, long_write->value, long_write->vlen,
+		long_write->func, long_write);
+}
+
+static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
+			uint8_t *value, int vlen, GAttribResultFunc func,
+			gpointer user_data)
+{
+	guint16 plen;
+	int buflen;
+	uint8_t *buf;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+
+	plen = enc_prep_write_req(handle, offset, &value[offset], vlen - offset,
+								buf, buflen);
+	if (plen == 0)
+		return 0;
+
+	return g_attrib_send(attrib, 0, buf[0], buf, plen, prepare_write_cb,
+							user_data, NULL);
+}
+
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			int vlen, GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	int buflen;
 	guint16 plen;
+	struct write_long_data *long_write;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
-	if (func)
-		plen = enc_write_req(handle, value, vlen, buf, buflen);
-	else
-		plen = enc_write_cmd(handle, value, vlen, buf, buflen);
 
-	return g_attrib_send(attrib, 0, buf[0], buf, plen, func,
+	/* Only use Write Request/Command if payload fits on a single transfer,
+	 * including 3 bytes for the header. */
+	if (vlen <= buflen - 3) {
+		if (func)
+			plen = enc_write_req(handle, value, vlen, buf,
+								buflen);
+		else
+			plen = enc_write_cmd(handle, value, vlen, buf,
+								buflen);
+
+		return g_attrib_send(attrib, 0, buf[0], buf, plen, func,
 							user_data, NULL);
+	}
+
+	/* Write Long Characteristic Values */
+	long_write = g_try_new0(struct write_long_data, 1);
+	if (long_write == NULL)
+		return 0;
+
+	long_write->attrib = attrib;
+	long_write->func = func;
+	long_write->user_data = user_data;
+	long_write->handle = handle;
+	long_write->value = g_memdup(value,vlen);
+	long_write->vlen = vlen;
+
+	return prepare_write(attrib, handle, long_write->offset, value, vlen,
+							func, long_write);
 }
 
 guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 1f23522..a11ca9f 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -371,7 +371,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	if (!dec_write_resp(pdu, plen)) {
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
 		g_printerr("Protocol error\n");
 		goto done;
 	}
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 3657798..6cd8bd5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -588,7 +588,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	if (!dec_write_resp(pdu, plen)) {
+	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
 		printf("Protocol error\n");
 		return;
 	}
-- 
1.7.9.5

