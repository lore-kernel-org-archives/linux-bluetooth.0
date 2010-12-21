Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 11/18] Remove duplicated code for discovering GATT services
Date: Tue, 21 Dec 2010 19:26:33 -0200
Message-Id: <1292966800-6264-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Most of this functionality was moved to src/device.c. Since that move
this code doesn't work. Some ugly hack were added to avoid breaking
the build.
---
 attrib/client.c |  101 ++----------------------------------------------------
 1 files changed, 4 insertions(+), 97 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index dbfe5d3..9fcaaf8 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -60,7 +60,6 @@ struct gatt_service {
 	GSList *primary;
 	GAttrib *attrib;
 	int psm;
-	guint atid;
 	gboolean listen;
 };
 
@@ -309,9 +308,6 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	}
 }
 
-static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data);
-
 static void attrib_destroy(gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
@@ -330,7 +326,6 @@ static void attrib_disconnect(gpointer user_data)
 static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
-	guint atid;
 
 	if (gerr) {
 		error("%s", gerr->message);
@@ -351,13 +346,6 @@ static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 		return;
 	}
 
-	atid = gatt_discover_primary(gatt->attrib, 0x0001, 0xffff, NULL,
-							primary_cb, gatt);
-	if (atid == 0)
-		goto fail;
-
-	gatt->atid = atid;
-
 	return;
 fail:
 	g_attrib_unref(gatt->attrib);
@@ -1173,91 +1161,6 @@ static void discover_all_char(gpointer data, gpointer user_data)
 						char_discovered_cb, qchr);
 }
 
-static void primary_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-	struct att_data_list *list;
-	unsigned int i;
-	uint16_t end, start;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
-		if (gatt->primary == NULL)
-			goto done;
-
-		register_primary(gatt);
-
-		g_slist_foreach(gatt->primary, discover_all_char, gatt);
-		goto done;
-	}
-
-	if (status != 0) {
-		error("Discover all primary services failed: %s",
-						att_ecode2str(status));
-		goto done;
-	}
-
-	list = dec_read_by_grp_resp(pdu, plen);
-	if (list == NULL) {
-		error("Protocol error");
-		goto done;
-	}
-
-	DBG("Read by Group Type Response received");
-
-	for (i = 0, end = 0; i < list->num; i++) {
-		struct primary *prim;
-		uint8_t *info = list->data[i];
-
-		/* Each element contains: attribute handle, end group handle
-		 * and attribute value */
-		start = att_get_u16(info);
-		end = att_get_u16(&info[2]);
-
-		prim = g_new0(struct primary, 1);
-		prim->gatt = gatt;
-		prim->start = start;
-		prim->end = end;
-
-		if (list->len == 6) {
-			sdp_uuid16_create(&prim->uuid,
-					att_get_u16(&info[4]));
-
-		} else if (list->len == 20) {
-			/* FIXME: endianness */
-			sdp_uuid128_create(&prim->uuid, &info[4]);
-		} else {
-			DBG("ATT: Invalid Length field");
-			g_free(prim);
-			att_data_list_free(list);
-			goto done;
-		}
-
-		prim->path = g_strdup_printf("%s/service%04x", gatt->path,
-								prim->start);
-
-		gatt->primary = g_slist_append(gatt->primary, prim);
-	}
-
-	att_data_list_free(list);
-
-	if (end == 0) {
-		DBG("ATT: Invalid PDU format");
-		goto done;
-	}
-
-	/*
-	 * Discover all primary services sub-procedure shall send another
-	 * Read by Group Type Request until Error Response is received and
-	 * the Error Code is set to Attribute Not Found.
-	 */
-	gatt->attrib = g_attrib_ref(gatt->attrib);
-	gatt->atid = gatt_discover_primary(gatt->attrib, end + 1, 0xffff, NULL,
-							primary_cb, gatt);
-done:
-	g_attrib_unref(gatt->attrib);
-}
-
 int attrib_client_register(struct btd_device *device, int psm)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -1279,6 +1182,10 @@ int attrib_client_register(struct btd_device *device, int psm)
 	if (load_primary_services(gatt))
 		DBG("Primary services loaded");
 
+	/* FIXME: just to avoid breaking the build */
+	if (FALSE)
+		discover_all_char(NULL, NULL);
+
 	gatt_services = g_slist_append(gatt_services, gatt);
 
 	return 0;
-- 
1.7.3.4

