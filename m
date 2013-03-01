Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 07/10] gatt: Track the lifetime of Primary Discovery requests
Date: Fri,  1 Mar 2013 20:22:30 -0300
Message-Id: <1362180153-11133-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the GDestroyNotify facility from g_attrib_send() to properly
end a procedure.
---
 attrib/gatt.c | 73 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 1f6360f..b451917 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -165,6 +165,13 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 	return plen;
 }
 
+static void discover_primary_drop(gpointer user_data)
+{
+	struct discover_primary *dp = user_data;
+
+	discover_primary_unref(dp);
+}
+
 static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 					guint16 iplen, gpointer user_data)
 
@@ -179,12 +186,15 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 
 	if (status) {
 		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
-		goto done;
+		set_error(&dp->err, err);
+		return;
 	}
 
 	ranges = dec_find_by_type_resp(ipdu, iplen);
-	if (ranges == NULL)
-		goto done;
+	if (ranges == NULL) {
+		set_error(&dp->err, ATT_ECODE_IO);
+		return;
+	}
 
 	dp->primaries = g_slist_concat(dp->primaries, ranges);
 
@@ -192,26 +202,20 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	range = last->data;
 
 	if (range->end == 0xffff)
-		goto done;
+		return;
 
 	buf = g_attrib_get_buffer(dp->attrib, &buflen);
 	oplen = encode_discover_primary(range->end + 1, 0xffff, &dp->uuid,
 								buf, buflen);
-
 	if (oplen == 0)
-		goto done;
+		return;
 
 	if (g_attrib_send(dp->attrib, 0, buf, oplen, primary_by_uuid_cb,
-				discover_primary_ref(dp), NULL) == 0) {
-		err = ATT_ECODE_ABORTED;
-		goto done;
+					discover_primary_ref(dp),
+					discover_primary_drop) == 0) {
+		set_error(&dp->err, ATT_ECODE_ABORTED);
+		discover_primary_unref(dp);
 	}
-
-	return;
-
-done:
-	set_error(&dp->err, err);
-	discover_primary_unref(dp);
 }
 
 static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
@@ -219,18 +223,19 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 {
 	struct discover_primary *dp = user_data;
 	struct att_data_list *list;
-	unsigned int i, err;
+	unsigned int i;
 	uint16_t start, end;
 
 	if (status) {
-		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
-		goto done;
+		int err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		set_error(&dp->err, err);
+		return;
 	}
 
 	list = dec_read_by_grp_resp(ipdu, iplen);
 	if (list == NULL) {
-		err = ATT_ECODE_IO;
-		goto done;
+		set_error(&dp->err, ATT_ECODE_IO);
+		return;
 	}
 
 	for (i = 0, end = 0; i < list->num; i++) {
@@ -253,8 +258,8 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		primary = g_try_new0(struct gatt_primary, 1);
 		if (!primary) {
-			err = ATT_ECODE_INSUFF_RESOURCES;
-			goto done;
+			set_error(&dp->err, ATT_ECODE_INSUFF_RESOURCES);
+			return;
 		}
 		primary->range.start = start;
 		primary->range.end = end;
@@ -263,7 +268,6 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	}
 
 	att_data_list_free(list);
-	err = 0;
 
 	if (end != 0xffff) {
 		size_t buflen;
@@ -272,17 +276,12 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 								buf, buflen);
 
 		if (g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
-					discover_primary_ref(dp), NULL) == 0) {
-			err = ATT_ECODE_ABORTED;
-			goto done;
+						discover_primary_ref(dp),
+						discover_primary_drop) == 0) {
+			set_error(&dp->err, ATT_ECODE_ABORTED);
+			discover_primary_unref(dp);
 		}
-
-		return;
 	}
-
-done:
-	set_error(&dp->err, err);
-	discover_primary_unref(dp);
 }
 
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
@@ -293,6 +292,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	GAttribResultFunc cb;
 	guint16 plen;
+	int id;
 
 	plen = encode_discover_primary(0x0001, 0xffff, uuid, buf, buflen);
 	if (plen == 0)
@@ -312,7 +312,14 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	} else
 		cb = primary_all_cb;
 
-	return g_attrib_send(attrib, 0, buf, plen, cb, dp, NULL);
+	id = g_attrib_send(attrib, 0, buf, plen, cb, discover_primary_ref(dp),
+							discover_primary_drop);
+	if (id == 0) {
+		g_attrib_unref(dp->attrib);
+		g_free(dp);
+	}
+
+	return id;
 }
 
 static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
-- 
1.8.1.3

