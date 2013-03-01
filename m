Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 09/10] gatt: Add lifetime tracking for Discover Characteristics requests
Date: Fri,  1 Mar 2013 20:22:32 -0300
Message-Id: <1362180153-11133-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the GDestroyNotify facility from g_attrib_send() to properly
end a procedure.
---
 attrib/gatt.c | 64 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index ef3ffff..7091d9f 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -65,9 +65,11 @@ struct included_uuid_query {
 
 struct discover_char {
 	GAttrib *attrib;
+	int refs;
 	bt_uuid_t *uuid;
 	uint16_t end;
 	GSList *characteristics;
+	int err;
 	gatt_cb_t cb;
 	void *user_data;
 };
@@ -121,8 +123,20 @@ static void isd_unref(struct included_discovery *isd)
 	g_free(isd);
 }
 
-static void discover_char_free(struct discover_char *dc)
+static struct discover_char *discover_char_ref(struct discover_char *dc)
+{
+	g_atomic_int_inc(&dc->refs);
+
+	return dc;
+}
+
+static void discover_char_unref(struct discover_char *dc)
 {
+	if (g_atomic_int_dec_and_test(&dc->refs) == FALSE)
+		return;
+
+	dc->cb(dc->characteristics, dc->err, dc->user_data);
+
 	g_slist_free_full(dc->characteristics, g_free);
 	g_attrib_unref(dc->attrib);
 	g_free(dc->uuid);
@@ -494,12 +508,19 @@ unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
 	return find_included(isd, start);
 }
 
+static void discover_char_drop(gpointer user_data)
+{
+	struct discover_char *dc = user_data;
+
+	discover_char_unref(dc);
+}
+
 static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 							gpointer user_data)
 {
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
-	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
+	unsigned int i;
 	size_t buflen;
 	uint8_t *buf;
 	guint16 oplen;
@@ -507,14 +528,14 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	uint16_t last = 0;
 
 	if (status) {
-		err = status;
-		goto done;
+		set_error(&dc->err, status);
+		return;
 	}
 
 	list = dec_read_by_type_resp(ipdu, iplen);
 	if (list == NULL) {
-		err = ATT_ECODE_IO;
-		goto done;
+		set_error(&dc->err, ATT_ECODE_IO);
+		return;
 	}
 
 	for (i = 0; i < list->num; i++) {
@@ -535,8 +556,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		chars = g_try_new0(struct gatt_char, 1);
 		if (!chars) {
-			err = ATT_ECODE_INSUFF_RESOURCES;
-			goto done;
+			set_error(&dc->err, ATT_ECODE_INSUFF_RESOURCES);
+			return;
 		}
 
 		chars->handle = last;
@@ -560,17 +581,13 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		if (oplen == 0)
 			return;
 
-		g_attrib_send(dc->attrib, 0, buf, oplen, char_discovered_cb,
-								dc, NULL);
-
-		return;
+		if (g_attrib_send(dc->attrib, 0, buf, oplen, char_discovered_cb,
+						discover_char_ref(dc),
+						discover_char_drop) == 0) {
+			set_error(&dc->err, ATT_ECODE_ABORTED);
+			discover_char_unref(dc);
+		}
 	}
-
-done:
-	err = (dc->characteristics ? 0 : err);
-
-	dc->cb(dc->characteristics, err, dc->user_data);
-	discover_char_free(dc);
 }
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -582,6 +599,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	struct discover_char *dc;
 	bt_uuid_t type_uuid;
 	guint16 plen;
+	int id;
 
 	bt_uuid16_create(&type_uuid, GATT_CHARAC_UUID);
 
@@ -599,8 +617,14 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->end = end;
 	dc->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
-	return g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
-								dc, NULL);
+	id = g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
+				discover_char_ref(dc), discover_char_drop);
+	if (id == 0) {
+		g_attrib_unref(dc->attrib);
+		g_free(dc->uuid);
+	}
+
+	return id;
 }
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-- 
1.8.1.3

