Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/5] attrib/gatt: Fix for search searvices
Date: Mon, 15 Dec 2014 10:59:07 +0100
Message-Id: <1418637547-20848-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds means to reuse att request id for GATT operations
which might need more then one ATT req for complete reguest. Meaning
discover primary\included services and discover
characteristics/descriptors

This is needed for user of gattib, to make sure that att request id he
holds is valid during whole gatt operation.

So far, it could happen that gattrib did additional ATT request without
user knowledge which leads to situation that user had outdated att
request id.

Note that request id is used by the user for canceling request.
---
 attrib/gatt.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b4be25a..aafd3f7 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -41,6 +41,7 @@
 struct discover_primary {
 	int ref;
 	GAttrib *attrib;
+	unsigned int id;
 	bt_uuid_t uuid;
 	GSList *primaries;
 	gatt_cb_t cb;
@@ -50,6 +51,7 @@ struct discover_primary {
 /* Used for the Included Services Discovery (ISD) procedure */
 struct included_discovery {
 	GAttrib		*attrib;
+	unsigned int	id;
 	int		refs;
 	int		err;
 	uint16_t	end_handle;
@@ -66,6 +68,7 @@ struct included_uuid_query {
 struct discover_char {
 	int ref;
 	GAttrib *attrib;
+	unsigned int id;
 	bt_uuid_t *uuid;
 	uint16_t end;
 	GSList *characteristics;
@@ -76,6 +79,7 @@ struct discover_char {
 struct discover_desc {
 	int ref;
 	GAttrib *attrib;
+	unsigned int id;
 	bt_uuid_t *uuid;
 	uint16_t end;
 	GSList *descriptors;
@@ -258,7 +262,7 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (oplen == 0)
 		goto done;
 
-	g_attrib_send(dp->attrib, 0, buf, oplen, primary_by_uuid_cb,
+	g_attrib_send(dp->attrib, dp->id, buf, oplen, primary_by_uuid_cb,
 			discover_primary_ref(dp), discover_primary_unref);
 	return;
 
@@ -327,7 +331,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
-		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
+		g_attrib_send(dp->attrib, dp->id, buf, oplen, primary_all_cb,
 						discover_primary_ref(dp),
 						discover_primary_unref);
 
@@ -365,9 +369,11 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	} else
 		cb = primary_all_cb;
 
-	return g_attrib_send(attrib, 0, buf, plen, cb,
+	dp->id = g_attrib_send(attrib, 0, buf, plen, cb,
 					discover_primary_ref(dp),
 					discover_primary_unref);
+
+	return dp->id;
 }
 
 static void resolve_included_uuid_cb(uint8_t status, const uint8_t *pdu,
@@ -422,7 +428,7 @@ static guint resolve_included_uuid(struct included_discovery *isd,
 	query->isd = isd_ref(isd);
 	query->included = incl;
 
-	return g_attrib_send(isd->attrib, 0, buf, oplen,
+	return g_attrib_send(isd->attrib, query->isd->id, buf, oplen,
 				resolve_included_uuid_cb, query,
 				inc_query_free);
 }
@@ -459,8 +465,17 @@ static guint find_included(struct included_discovery *isd, uint16_t start)
 	oplen = enc_read_by_type_req(start, isd->end_handle, &uuid,
 							buf, buflen);
 
-	return g_attrib_send(isd->attrib, 0, buf, oplen, find_included_cb,
+	/* If id != 0 it means we are in the middle of include search */
+	if (isd->id)
+		return g_attrib_send(isd->attrib, isd->id, buf, oplen,
+				find_included_cb, isd_ref(isd),
+				(GDestroyNotify) isd_unref);
+
+	/* This is first call from the gattrib user */
+	isd->id = g_attrib_send(isd->attrib, 0, buf, oplen, find_included_cb,
 				isd_ref(isd), (GDestroyNotify) isd_unref);
+
+	return isd->id;
 }
 
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
@@ -599,8 +614,9 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		if (oplen == 0)
 			return;
 
-		g_attrib_send(dc->attrib, 0, buf, oplen, char_discovered_cb,
-				discover_char_ref(dc), discover_char_unref);
+		g_attrib_send(dc->attrib, dc->id, buf, oplen,
+				char_discovered_cb, discover_char_ref(dc),
+				discover_char_unref);
 
 		return;
 	}
@@ -636,8 +652,10 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->end = end;
 	dc->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
-	return g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
+	dc->id = g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
 				discover_char_ref(dc), discover_char_unref);
+
+	return dc->id;
 }
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -1017,8 +1035,9 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 		if (oplen == 0)
 			return;
 
-		g_attrib_send(dd->attrib, 0, buf, oplen, desc_discovered_cb,
-				discover_desc_ref(dd), discover_desc_unref);
+		g_attrib_send(dd->attrib, dd->id, buf, oplen,
+				desc_discovered_cb, discover_desc_ref(dd),
+				discover_desc_unref);
 
 		return;
 	}
@@ -1051,8 +1070,10 @@ guint gatt_discover_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 	dd->end = end;
 	dd->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
-	return g_attrib_send(attrib, 0, buf, plen, desc_discovered_cb,
+	dd->id = g_attrib_send(attrib, 0, buf, plen, desc_discovered_cb,
 				discover_desc_ref(dd), discover_desc_unref);
+
+	return dd->id;
 }
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, const uint8_t *value,
-- 
1.8.4

