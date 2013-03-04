Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 2/6] GATT: remove glib basic data types usage
Date: Mon,  4 Mar 2013 16:58:46 -0400
Message-Id: <1362430730-19580-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c | 159 ++++++++++++++++++++++++++++++----------------------------
 attrib/gatt.h |  41 +++++++--------
 2 files changed, 103 insertions(+), 97 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 44d3eb6..9a2d909 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -107,11 +107,11 @@ static void discover_char_free(struct discover_char *dc)
 	g_free(dc);
 }
 
-static guint16 encode_discover_primary(uint16_t start, uint16_t end,
+static uint16_t encode_discover_primary(uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, uint8_t *pdu, size_t len)
 {
 	bt_uuid_t prim;
-	guint16 plen;
+	uint16_t plen;
 
 	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
@@ -143,15 +143,15 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 	return plen;
 }
 
-static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
-					guint16 iplen, gpointer user_data)
+static void primary_by_uuid_cb(uint8_t status, const uint8_t *ipdu,
+						uint16_t iplen, void *user_data)
 
 {
 	struct discover_primary *dp = user_data;
 	GSList *ranges, *last;
 	struct att_range *range;
 	uint8_t *buf;
-	guint16 oplen;
+	uint16_t oplen;
 	int err = 0;
 	size_t buflen;
 
@@ -187,8 +187,8 @@ done:
 	discover_primary_free(dp);
 }
 
-static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
-							gpointer user_data)
+static void primary_all_cb(uint8_t status, const uint8_t *ipdu, uint16_t iplen,
+								void *user_data)
 {
 	struct discover_primary *dp = user_data;
 	struct att_data_list *list;
@@ -241,7 +241,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	if (end != 0xffff) {
 		size_t buflen;
 		uint8_t *buf = g_attrib_get_buffer(dp->attrib, &buflen);
-		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
+		uint16_t oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
 		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
@@ -255,14 +255,14 @@ done:
 	discover_primary_free(dp);
 }
 
-guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
-							gpointer user_data)
+unsigned int gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid,
+						gatt_cb_t func, void *user_data)
 {
 	struct discover_primary *dp;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	GAttribResultFunc cb;
-	guint16 plen;
+	uint16_t plen;
 
 	plen = encode_discover_primary(0x0001, 0xffff, uuid, buf, buflen);
 	if (plen == 0)
@@ -286,7 +286,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 }
 
 static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
-					uint16_t len, gpointer user_data)
+						uint16_t len, void *user_data)
 {
 	struct included_uuid_query *query = user_data;
 	struct included_discovery *isd = query->isd;
@@ -321,13 +321,13 @@ done:
 	g_free(query);
 }
 
-static guint resolve_included_uuid(struct included_discovery *isd,
-					struct gatt_included *incl)
+static unsigned int resolve_included_uuid(struct included_discovery *isd,
+						struct gatt_included *incl)
 {
 	struct included_uuid_query *query;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
-	guint16 oplen = enc_read_req(incl->range.start, buf, buflen);
+	uint16_t oplen = enc_read_req(incl->range.start, buf, buflen);
 
 	query = g_new0(struct included_uuid_query, 1);
 	query->isd = isd_ref(isd);
@@ -337,7 +337,7 @@ static guint resolve_included_uuid(struct included_discovery *isd,
 				resolve_included_uuid_cb, query, NULL);
 }
 
-static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
+static struct gatt_included *included_from_buf(const uint8_t *buf, size_t len)
 {
 	struct gatt_included *incl = g_new0(struct gatt_included, 1);
 
@@ -357,14 +357,15 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 }
 
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
-							gpointer user_data);
+							void *user_data);
 
-static guint find_included(struct included_discovery *isd, uint16_t start)
+static unsigned int find_included(struct included_discovery *isd,
+								uint16_t start)
 {
 	bt_uuid_t uuid;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
-	guint16 oplen;
+	uint16_t oplen;
 
 	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	oplen = enc_read_by_type_req(start, isd->end_handle, &uuid,
@@ -375,7 +376,7 @@ static guint find_included(struct included_discovery *isd, uint16_t start)
 }
 
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
-							gpointer user_data)
+								void *user_data)
 {
 	struct included_discovery *isd = user_data;
 	uint16_t last_handle = isd->end_handle;
@@ -429,7 +430,7 @@ done:
 }
 
 unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
-					gatt_cb_t func, gpointer user_data)
+						gatt_cb_t func, void *user_data)
 {
 	struct included_discovery *isd;
 
@@ -442,15 +443,15 @@ unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
 	return find_included(isd, start);
 }
 
-static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
-							gpointer user_data)
+static void char_discovered_cb(uint8_t status, const uint8_t *ipdu,
+						uint16_t iplen, void *user_data)
 {
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
 	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
 	size_t buflen;
 	uint8_t *buf;
-	guint16 oplen;
+	uint16_t oplen;
 	bt_uuid_t uuid;
 	uint16_t last = 0;
 
@@ -521,15 +522,15 @@ done:
 	discover_char_free(dc);
 }
 
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+unsigned int gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
+						void *user_data)
 {
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	struct discover_char *dc;
 	bt_uuid_t type_uuid;
-	guint16 plen;
+	uint16_t plen;
 
 	bt_uuid16_create(&type_uuid, GATT_CHARAC_UUID);
 
@@ -551,13 +552,13 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 								dc, NULL);
 }
 
-guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-					bt_uuid_t *uuid, GAttribResultFunc func,
-					gpointer user_data)
+unsigned int gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start,
+					uint16_t end, bt_uuid_t *uuid,
+					GAttribResultFunc func, void *user_data)
 {
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
-	guint16 plen;
+	uint16_t plen;
 
 	plen = enc_read_by_type_req(start, end, uuid, buf, buflen);
 	if (plen == 0)
@@ -569,15 +570,15 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 struct read_long_data {
 	GAttrib *attrib;
 	GAttribResultFunc func;
-	gpointer user_data;
-	guint8 *buffer;
-	guint16 size;
-	guint16 handle;
-	guint id;
-	gint ref;
+	void *user_data;
+	uint8_t *buffer;
+	uint16_t size;
+	uint16_t handle;
+	unsigned int id;
+	int ref;
 };
 
-static void read_long_destroy(gpointer user_data)
+static void read_long_destroy(void *user_data)
 {
 	struct read_long_data *long_read = user_data;
 
@@ -590,15 +591,15 @@ static void read_long_destroy(gpointer user_data)
 	g_free(long_read);
 }
 
-static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
-							gpointer user_data)
+static void read_blob_helper(uint8_t status, const uint8_t *rpdu, uint16_t rlen,
+								void *user_data)
 {
 	struct read_long_data *long_read = user_data;
 	uint8_t *buf;
 	size_t buflen;
-	guint8 *tmp;
-	guint16 plen;
-	guint id;
+	uint8_t *tmp;
+	uint16_t plen;
+	unsigned int id;
 
 	if (status != 0 || rlen == 1) {
 		status = 0;
@@ -637,14 +638,14 @@ done:
 							long_read->user_data);
 }
 
-static void read_char_helper(guint8 status, const guint8 *rpdu,
-					guint16 rlen, gpointer user_data)
+static void read_char_helper(uint8_t status, const uint8_t *rpdu, uint16_t rlen,
+								void *user_data)
 {
 	struct read_long_data *long_read = user_data;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(long_read->attrib, &buflen);
-	guint16 plen;
-	guint id;
+	uint16_t plen;
+	unsigned int id;
 
 	if (status != 0 || rlen < buflen)
 		goto done;
@@ -672,13 +673,13 @@ done:
 	long_read->func(status, rpdu, rlen, long_read->user_data);
 }
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data)
+unsigned int gatt_read_char(GAttrib *attrib, uint16_t handle,
+					GAttribResultFunc func, void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
-	guint id;
+	uint16_t plen;
+	unsigned int id;
 	struct read_long_data *long_read;
 
 	long_read = g_try_new0(struct read_long_data, 1);
@@ -708,19 +709,19 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 struct write_long_data {
 	GAttrib *attrib;
 	GAttribResultFunc func;
-	gpointer user_data;
-	guint16 handle;
+	void *user_data;
+	uint16_t handle;
 	uint16_t offset;
 	uint8_t *value;
 	size_t vlen;
 };
 
-static guint execute_write(GAttrib *attrib, uint8_t flags,
-				GAttribResultFunc func, gpointer user_data)
+static unsigned int execute_write(GAttrib *attrib, uint8_t flags,
+					GAttribResultFunc func, void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_exec_write_req(flags, buf, buflen);
@@ -730,12 +731,13 @@ static guint execute_write(GAttrib *attrib, uint8_t flags,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data);
+static unsigned int prepare_write(GAttrib *attrib, uint16_t handle,
+					uint16_t offset, uint8_t *value,
+					size_t vlen, GAttribResultFunc func,
+					void *user_data);
 
-static void prepare_write_cb(guint8 status, const guint8 *rpdu,
-					guint16 rlen, gpointer user_data)
+static void prepare_write_cb(uint8_t status, const uint8_t *rpdu,
+					uint16_t rlen, void *user_data)
 {
 	struct write_long_data *long_write = user_data;
 
@@ -761,11 +763,12 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu,
 		long_write->func, long_write);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data)
+static unsigned int prepare_write(GAttrib *attrib, uint16_t handle,
+					uint16_t offset, uint8_t *value,
+					size_t vlen, GAttribResultFunc func,
+					void *user_data)
 {
-	guint16 plen;
+	uint16_t plen;
 	size_t buflen;
 	uint8_t *buf;
 
@@ -780,12 +783,13 @@ static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
 							user_data, NULL);
 }
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
-			size_t vlen, GAttribResultFunc func, gpointer user_data)
+unsigned int gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+					size_t vlen, GAttribResultFunc func,
+					void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 	struct write_long_data *long_write;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
@@ -820,24 +824,24 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 							func, long_write);
 }
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
-							gpointer user_data)
+unsigned int gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+					GAttribResultFunc func, void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_mtu_req(mtu, buf, buflen);
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
+unsigned int gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+					GAttribResultFunc func, void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_find_info_req(start, end, buf, buflen);
@@ -847,12 +851,13 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data)
+unsigned int gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value,
+						int vlen, GDestroyNotify notify,
+						void *user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_write_cmd(handle, value, vlen, buf, buflen);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 305b4c6..be38400 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -53,7 +53,7 @@
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
-typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
+typedef void (*gatt_cb_t) (GSList *l, uint8_t status, void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
@@ -74,35 +74,36 @@ struct gatt_char {
 	uint16_t value_handle;
 };
 
-guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
-							gpointer user_data);
+unsigned int gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid,
+					gatt_cb_t func, void *user_data);
 
 unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
-					gatt_cb_t func, gpointer user_data);
+					gatt_cb_t func, void *user_data);
 
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
-					bt_uuid_t *uuid, gatt_cb_t func,
-					gpointer user_data);
+unsigned int gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						void *user_data);
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data);
+unsigned int gatt_read_char(GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, void *user_data);
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+unsigned int gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
-					gpointer user_data);
+					void *user_data);
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
+unsigned int gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+				GAttribResultFunc func, void *user_data);
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data);
+unsigned int gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value,
+						int vlen, GDestroyNotify notify,
+						void *user_data);
 
-guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-				bt_uuid_t *uuid, GAttribResultFunc func,
-				gpointer user_data);
+unsigned int gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start,
+				uint16_t end, bt_uuid_t *uuid,
+				GAttribResultFunc func, void *user_data);
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
-							gpointer user_data);
+unsigned int gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+				GAttribResultFunc func, void *user_data);
 
 gboolean gatt_parse_record(const sdp_record_t *rec,
 					uuid_t *prim_uuid, uint16_t *psm,
-- 
1.8.1.4

