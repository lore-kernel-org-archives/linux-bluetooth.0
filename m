Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v8 09/10] core/advertising: Add and Remove AD using MGMT
Date: Wed,  1 Apr 2015 14:10:01 -0700
Message-Id: <1427922602-6253-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
References: <1427922602-6253-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updates the advertising manager to add and remove the LE Advertising Data
using MGMT interface commands.
---
 src/advertising.c | 104 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 16 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 74b9cbd..300f440 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -26,6 +26,7 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/bluetooth.h"
+#include "lib/mgmt.h"
 #include "lib/sdp.h"
 
 #include "adapter.h"
@@ -33,6 +34,7 @@
 #include "error.h"
 #include "log.h"
 #include "src/shared/ad.h"
+#include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
@@ -42,6 +44,8 @@
 struct btd_advertising {
 	struct btd_adapter *adapter;
 	struct queue *ads;
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -56,6 +60,7 @@ struct advertisement {
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
 	struct bt_ad *data;
+	uint8_t instance;
 };
 
 static bool match_advertisement_path(const void *a, const void *b)
@@ -123,10 +128,15 @@ static void advertisement_destroy(void *data)
 static void advertisement_remove(void *data)
 {
 	struct advertisement *ad = data;
+	struct mgmt_cp_remove_advertising cp;
 
 	g_dbus_client_set_disconnect_watch(ad->client, NULL, NULL);
 
-	/* TODO: mgmt API call to remove advert */
+	cp.instance = ad->instance;
+
+	mgmt_send(ad->manager->mgmt, MGMT_OP_REMOVE_ADVERTISING,
+			ad->manager->mgmt_index, sizeof(cp), &cp, NULL, NULL,
+			NULL);
 
 	queue_remove(ad->manager->ads, ad);
 
@@ -351,43 +361,90 @@ fail:
 	return false;
 }
 
-static void refresh_advertisement(struct advertisement *ad)
+static void add_advertising_callback(uint8_t status, uint16_t length,
+					  const void *param, void *user_data)
+{
+	struct advertisement *ad = user_data;
+	const struct mgmt_rp_add_advertising *rp = param;
+
+	if (status || !param) {
+		error("Failed to add advertising MGMT");
+		return;
+	}
+
+	ad->instance = rp->instance;
+}
+
+static DBusMessage *refresh_advertisement(struct advertisement *ad)
 {
+	struct mgmt_cp_add_advertising *cp;
+	uint8_t adv_data_len, param_len;
+	uint8_t *adv_data;
+
 	DBG("Refreshing advertisement: %s", ad->path);
+
+	adv_data = bt_ad_generate(ad->data, &adv_data_len);
+
+	if (!adv_data) {
+		error("Advertising data couldn't be generated.");
+
+		return g_dbus_create_error(ad->reg, ERROR_INTERFACE
+						".InvalidLength",
+						"Advertising data too long.");
+	}
+
+	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len;
+
+	cp = malloc0(param_len);
+
+	if (!cp) {
+		error("Couldn't allocate for MGMT!");
+
+		return btd_error_failed(ad->reg, "Failed");
+	}
+
+	cp->instance = ad->instance;
+	cp->adv_data_len = adv_data_len;
+	memcpy(cp->data, adv_data, adv_data_len);
+
+	mgmt_send(ad->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
+					ad->manager->mgmt_index, param_len, cp,
+					add_advertising_callback, ad, NULL);
+
+	return NULL;
 }
 
-static bool parse_advertisement(struct advertisement *ad)
+static DBusMessage *parse_advertisement(struct advertisement *ad)
 {
 	if (!parse_advertising_type(ad->proxy, &ad->type)) {
 		error("Failed to read \"Type\" property of advertisement");
-		return false;
+		goto fail;
 	}
 
 	if (!parse_advertising_service_uuids(ad->proxy, ad->data)) {
 		error("Property \"ServiceUUIDs\" failed to parse");
-		return false;
+		goto fail;
 	}
 
 	if (!parse_advertising_solicit_uuids(ad->proxy, ad->data)) {
 		error("Property \"SolicitUUIDs\" failed to parse");
-		return false;
+		goto fail;
 	}
 
 	if (!parse_advertising_manufacturer_data(ad->proxy, ad->data)) {
 		error("Property \"ManufacturerData\" failed to parse");
-		return false;
+		goto fail;
 	}
 
 	if (!parse_advertising_service_data(ad->proxy, ad->data)) {
 		error("Property \"ServiceData\" failed to parse");
-		return false;
+		goto fail;
 	}
 
-	/* TODO: parse the rest of the properties */
+	return refresh_advertisement(ad);
 
-	refresh_advertisement(ad);
-
-	return true;
+fail:
+	return btd_error_failed(ad->reg, "Failed to parse advertisement.");
 }
 
 static void advertisement_proxy_added(GDBusProxy *proxy, void *data)
@@ -395,11 +452,14 @@ static void advertisement_proxy_added(GDBusProxy *proxy, void *data)
 	struct advertisement *ad = data;
 	DBusMessage *reply;
 
-	if (!parse_advertisement(ad)) {
-		error("Failed to parse advertisement");
+	reply = parse_advertisement(ad);
+
+	if (reply) {
+		/* Failed to publish for some reason, remove. */
+		queue_remove(ad->manager->ads, ad);
+
+		g_idle_add(advertisement_free_idle_cb, ad);
 
-		reply = btd_error_failed(ad->reg,
-					"Failed to register advertisement");
 		goto done;
 	}
 
@@ -430,6 +490,8 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 	if (!ad)
 		return NULL;
 
+	ad->instance = 1;
+
 	ad->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!ad->client)
 		goto fail;
@@ -567,6 +629,16 @@ advertising_manager_create(struct btd_adapter *adapter)
 
 	manager->adapter = adapter;
 
+	manager->mgmt = mgmt_new_default();
+
+	if (!manager->mgmt) {
+		error("Failed to access management interface");
+		free(manager);
+		return NULL;
+	}
+
+	manager->mgmt_index = btd_adapter_get_index(adapter);
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						LE_ADVERTISING_MGR_IFACE,
-- 
2.2.0.rc0.207.ga3a616c

