Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 05/10] core: Remove Appearance characteristic read
Date: Thu, 16 Aug 2012 17:13:06 -0300
Message-Id: <1345147991-31320-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the Appearance characteristic read from the core.
Appearance characteristic is now being read by the GAP/GATT plugin.
---
 src/device.c |   56 +-------------------------------------------------------
 1 files changed, 1 insertions(+), 55 deletions(-)

diff --git a/src/device.c b/src/device.c
index f781298..aeb2a86 100644
--- a/src/device.c
+++ b/src/device.c
@@ -69,8 +69,6 @@
 
 #define AUTO_CONNECTION_INTERVAL	5 /* Next connection attempt */
 
-#define APPEARANCE_CHR_UUID 0x2a01
-
 struct btd_disconnect_data {
 	guint id;
 	disconnect_watch watch;
@@ -1832,51 +1830,10 @@ done:
 	return FALSE;
 }
 
-static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct btd_device *device = user_data;
-	struct btd_adapter *adapter = device->adapter;
-	struct att_data_list *list =  NULL;
-	uint16_t app;
-	bdaddr_t src;
-	uint8_t *atval;
-
-	if (status != 0) {
-		DBG("Read characteristics by UUID failed: %s\n",
-							att_ecode2str(status));
-		goto done;
-	}
-
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		goto done;
-
-	if (list->len != 4) {
-		DBG("Appearance value: invalid data");
-		goto done;
-	}
-
-	/* A device shall have only one instance of the
-	Appearance characteristic. */
-	atval = list->data[0] + 2; /* skip handle value */
-	app = att_get_u16(atval);
-
-	adapter_get_address(adapter, &src);
-	write_remote_appearance(&src, &device->bdaddr, device->bdaddr_type,
-									app);
-
-done:
-	att_data_list_free(list);
-	if (device->attios == NULL && device->attios_offline == NULL)
-		attio_cleanup(device);
-}
-
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
-	struct gatt_primary *gap_prim = NULL;
 	GSList *l, *uuids = NULL;
 
 	if (status) {
@@ -1894,24 +1851,13 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 
-		if (strcmp(prim->uuid, GAP_UUID) == 0)
-			gap_prim = prim;
-
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
-	if (gap_prim) {
-		/* Read appearance characteristic */
-		bt_uuid_t uuid;
-
-		bt_uuid16_create(&uuid, APPEARANCE_CHR_UUID);
-
-		gatt_read_char_by_uuid(device->attrib, gap_prim->range.start,
-			gap_prim->range.end, &uuid, appearance_cb, device);
-	} else if (device->attios == NULL && device->attios_offline == NULL)
+	if (device->attios == NULL && device->attios_offline == NULL)
 		attio_cleanup(device);
 
 	g_slist_free(uuids);
-- 
1.7.8.6

