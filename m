Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 01/18] attrib: Avoid passing raw PDU to Exchange MTU callback
Date: Tue,  2 Apr 2013 12:50:48 -0400
Message-Id: <1364921465-31182-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By centralizing the PDU parsing and validation internally to GATT API,
the callbacks become simpler.
---
 attrib/gatt.c        |   32 ++++++++++++++++++++++++++++++--
 attrib/gatt.h        |    6 ++++--
 attrib/interactive.c |   10 +---------
 profiles/gatt/gas.c  |   11 ++---------
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 8b15569..024d148 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -823,16 +823,44 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 							func, long_write);
 }
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
+struct gatt_exchange_mtu_data {
+	gatt_exchange_mtu_cb_t func;
+	void *user_data;
+};
+
+static void gatt_exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct gatt_exchange_mtu_data *data = user_data;
+	uint16_t rmtu = 0;
+
+	if (status != 0)
+		goto done;
+
+	if (dec_mtu_resp(pdu, plen, &rmtu) == 0)
+		status = ATT_ECODE_IO;
+
+done:
+	data->func(status, rmtu, data->user_data);
+}
+
+guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+				gatt_exchange_mtu_cb_t func, void *user_data)
+{
+	struct gatt_exchange_mtu_data *data;
 	uint8_t *buf;
 	size_t buflen;
 	guint16 plen;
 
+	data = g_new0(struct gatt_exchange_mtu_data, 1);
+	data->func = func;
+	data->user_data = user_data;
+
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_mtu_req(mtu, buf, buflen);
-	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
+
+	return g_attrib_send(attrib, 0, buf, plen, gatt_exchange_mtu_cb, data,
+									g_free);
 }
 
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 305b4c6..691be80 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -54,6 +54,8 @@
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
 typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
+typedef void (*gatt_exchange_mtu_cb_t) (uint8_t status, uint16_t mtu,
+							void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
@@ -101,8 +103,8 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, GAttribResultFunc func,
 				gpointer user_data);
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
-							gpointer user_data);
+guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+				gatt_exchange_mtu_cb_t func, void *user_data);
 
 gboolean gatt_parse_record(const sdp_record_t *rec,
 					uuid_t *prim_uuid, uint16_t *psm,
diff --git a/attrib/interactive.c b/attrib/interactive.c
index d6fc89c..e1af871 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -729,22 +729,14 @@ static void cmd_sec_level(int argcp, char **argvp)
 	}
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void exchange_mtu_cb(uint8_t status, uint16_t mtu, void *user_data)
 {
-	uint16_t mtu;
-
 	if (status != 0) {
 		printf("Exchange MTU Request failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
-	if (!dec_mtu_resp(pdu, plen, &mtu)) {
-		printf("Protocol error\n");
-		return;
-	}
-
 	mtu = MIN(mtu, opt_mtu);
 	/* Set new value for MTU in client */
 	if (g_attrib_set_mtu(attrib, mtu))
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index bc8dbb5..9ff89b0 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -288,23 +288,16 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void exchange_mtu_cb(uint8_t status, uint16_t mtu, void *user_data)
 {
 	struct gas *gas = user_data;
-	uint16_t rmtu;
 
 	if (status) {
 		error("MTU exchange: %s", att_ecode2str(status));
 		return;
 	}
 
-	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
-		error("MTU exchange: protocol error");
-		return;
-	}
-
-	gas->mtu = MIN(rmtu, gas->mtu);
+	gas->mtu = MIN(mtu, gas->mtu);
 	if (g_attrib_set_mtu(gas->attrib, gas->mtu))
 		DBG("MTU exchange succeeded: %d", gas->mtu);
 	else
-- 
1.7.9.5

