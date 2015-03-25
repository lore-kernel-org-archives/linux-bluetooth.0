Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v5 13/13] core/advertising: Add and Remove AD using MGMT
Date: Wed, 25 Mar 2015 16:01:01 -0700
Message-Id: <1427324461-27651-14-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
References: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updates the advertising manager to add and remove the LE Advertising Data
using MGMT interface commands.
---
 src/advertising.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 604f7ac..2fab8d0 100644
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
 #include "src/shared/advertising-data.h"
+#include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
 
@@ -41,6 +43,8 @@
 
 struct btd_advertising_manager {
 	struct btd_adapter *adapter;
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
 	struct queue *adverts;
 };
 
@@ -55,7 +59,7 @@ struct advertisement {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
-	bool published;
+	uint8_t instance;
 	struct advertising_data *data;
 };
 
@@ -125,10 +129,15 @@ static void advertisement_destroy(void *data)
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
 
 	queue_remove(ad->manager->adverts, ad);
 
@@ -350,12 +359,44 @@ fail:
 	return false;
 }
 
+static void add_advertising_callback(uint8_t status, uint16_t length,
+					  const void *param, void *user_data)
+{
+	struct advertisement *ad = user_data;
+	const struct mgmt_rp_add_advertising *rp = param;
+
+	if (status || !param) {
+		error("Failed to set advertising data!");
+		return;
+	}
+
+	ad->instance = rp->instance;
+}
+
 static void refresh_advertisement(struct advertisement *ad)
 {
+	struct mgmt_cp_add_advertising *cp;
+	uint8_t adv_data_len, param_len;
+	uint8_t *adv_data;
+
 	DBG("Refreshing advertisement: %s", ad->path);
-	if (!ad->published) {
-		/* TODO: MGMT API call to update the advertisement */
-	}
+
+	adv_data = advertising_data_generate(ad->data, &adv_data_len);
+
+	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len;
+
+	cp = malloc(param_len);
+
+	cp->instance = ad->instance;
+	cp->flags = 0;
+	cp->duration = 0;
+	cp->timeout = 0;
+	cp->adv_data_len = adv_data_len;
+	memcpy(cp->data, adv_data, adv_data_len);
+
+	mgmt_send(ad->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
+					ad->manager->mgmt_index, param_len, cp,
+					add_advertising_callback, ad, NULL);
 }
 
 static bool parse_advertisement(struct advertisement *ad)
@@ -432,7 +473,7 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 	if (!ad)
 		return NULL;
 
-	ad->published = false;
+	ad->instance = 1;
 
 	ad->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!ad->client)
@@ -571,6 +612,16 @@ advertising_manager_create(struct btd_adapter *adapter)
 
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

