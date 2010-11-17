Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/6] Add an extra parameter in the discovery primary to specify the UUID
Date: Wed, 17 Nov 2010 16:09:45 -0200
Message-Id: <1290017386-23969-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Extends discover primary function to perform discover by UUID. UUID
parameter defines which procedure will be executed: Discover All
Primary Services or Discover Primary Service by Service UUID.
---
 attrib/client.c   |    8 ++++----
 attrib/gatt.c     |   37 ++++++++++++++++++++++++++++++-------
 attrib/gatt.h     |    4 ++--
 attrib/gatttool.c |    6 ++++--
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 955e623..a851a74 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -363,8 +363,8 @@ static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 		return;
 	}
 
-	atid = gatt_discover_primary(gatt->attrib, 0x0001, 0xffff, primary_cb,
-									gatt);
+	atid = gatt_discover_primary(gatt->attrib, 0x0001, 0xffff, NULL,
+							primary_cb, gatt);
 	if (atid == 0)
 		goto fail;
 
@@ -1311,8 +1311,8 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	 * the Error Code is set to Attribute Not Found.
 	 */
 	gatt->attrib = g_attrib_ref(gatt->attrib);
-	gatt->atid = gatt_discover_primary(gatt->attrib,
-				end + 1, 0xffff, primary_cb, gatt);
+	gatt->atid = gatt_discover_primary(gatt->attrib, end + 1, 0xffff, NULL,
+							primary_cb, gatt);
 done:
 	g_attrib_unref(gatt->attrib);
 }
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 24ec990..2c87daf 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -31,21 +31,44 @@
 #include "gattrib.h"
 #include "gatt.h"
 
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
-		uint16_t end, GAttribResultFunc func, gpointer user_data)
+guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
+		uuid_t *uuid, GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_MTU];
-	uuid_t uuid;
+	uuid_t prim;
 	guint16 plen;
+	uint8_t op;
+
+	sdp_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
+
+	if (uuid == NULL) {
+
+		/* Discover all primary services */
+		op = ATT_OP_READ_BY_GROUP_REQ;
+		plen = enc_read_by_grp_req(start, end, &prim, pdu, sizeof(pdu));
+	} else {
+		const void *value;
+		int vlen;
 
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+		/* Discover primary service by service UUID */
+		op = ATT_OP_FIND_BY_TYPE_REQ;
+
+		if (uuid->type == SDP_UUID16) {
+			value = &uuid->value.uuid16;
+			vlen = sizeof(uuid->value.uuid16);
+		} else {
+			value = &uuid->value.uuid128;
+			vlen = sizeof(uuid->value.uuid128);
+		}
+
+		plen = enc_find_by_type_req(start, end, &prim, value, vlen,
+							pdu, sizeof(pdu));
+	}
 
-	plen = enc_read_by_grp_req(start, end, &uuid, pdu, sizeof(pdu));
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, ATT_OP_READ_BY_GROUP_REQ,
-					pdu, plen, func, user_data, NULL);
+	return g_attrib_send(attrib, op, pdu, plen, func, user_data, NULL);
 }
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index f1599c2..4e7d88b 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -24,8 +24,8 @@
 
 #define GATT_CID 4
 
-guint gatt_discover_primary(GAttrib *attrib, uint16_t start,
-		uint16_t end, GAttribResultFunc func, gpointer user_data);
+guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
+		uuid_t *uuid, GAttribResultFunc func, gpointer user_data);
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index b9f5138..ac9745d 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -191,7 +191,8 @@ static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	 * Read by Group Type Request until Error Response is received and
 	 * the Error Code is set to Attribute Not Found.
 	 */
-	gatt_discover_primary(attrib, end + 1, opt_end, primary_cb, attrib);
+	gatt_discover_primary(attrib, end + 1, opt_end, NULL, primary_cb,
+								attrib);
 
 	return;
 
@@ -250,7 +251,8 @@ static gboolean primary(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
-	gatt_discover_primary(attrib, opt_start, opt_end, primary_cb, attrib);
+	gatt_discover_primary(attrib, opt_start, opt_end, NULL, primary_cb,
+								attrib);
 
 	return FALSE;
 }
-- 
1.7.3.2

