Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 3/6] core/advertising: Parse IncludeTXPower
Date: Tue, 14 Apr 2015 15:06:58 -0700
Message-Id: <1429049221-21984-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the IncludeTXPower property of the advertisement object, and
pass the appropriate flag to MGMT if it is set.

Uses MGMT Read Advertising Features Command to determine the maximum
length allowed.
---
 src/advertising.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 78178f2..8e803cb 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -46,6 +46,7 @@ struct btd_advertising {
 	struct queue *ads;
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
+	uint8_t max_adv_len;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -59,6 +60,7 @@ struct advertisement {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
+	bool include_tx_power;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -372,6 +374,25 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_include_tx_power(GDBusProxy *proxy,
+							bool *included)
+{
+	DBusMessageIter iter;
+	dbus_bool_t b;
+
+	if (!g_dbus_proxy_get_property(proxy, "IncludeTXPower", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &b);
+
+	*included = b;
+
+	return true;
+}
+
 static void add_advertising_callback(uint8_t status, uint16_t length,
 					  const void *param, void *user_data)
 {
@@ -386,19 +407,47 @@ static void add_advertising_callback(uint8_t status, uint16_t length,
 	ad->instance = rp->instance;
 }
 
+static size_t calc_max_adv_len(struct advertisement *ad, uint32_t flags)
+{
+	size_t max = ad->manager->max_adv_len;
+
+	/*
+	 * Flags which reduce the amount of space available for advertising.
+	 * See doc/mgmt-api.txt
+	 */
+	if (flags & MGMT_ADV_FLAG_TX_POWER)
+		max -= 3;
+
+	if (flags & (MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV |
+						MGMT_ADV_FLAG_MANAGED_FLAGS))
+		max -= 3;
+
+	if (flags & MGMT_ADV_FLAG_APPEARANCE)
+		max -= 4;
+
+	return max;
+}
+
 static DBusMessage *refresh_advertisement(struct advertisement *ad)
 {
 	struct mgmt_cp_add_advertising *cp;
 	uint8_t param_len;
 	uint8_t *adv_data;
 	size_t adv_data_len;
+	uint32_t flags = 0;
 
 	DBG("Refreshing advertisement: %s", ad->path);
 
+	if (ad->type == AD_TYPE_PERIPHERAL)
+		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
+
+	if (ad->include_tx_power)
+		flags |= MGMT_ADV_FLAG_TX_POWER;
+
 	adv_data = bt_ad_generate(ad->data, &adv_data_len);
 
-	if (!adv_data) {
-		error("Advertising data couldn't be generated.");
+	if (!adv_data || (adv_data_len > calc_max_adv_len(ad, flags))) {
+		error("Advertising data too long or couldn't be generated.");
 
 		return g_dbus_create_error(ad->reg, ERROR_INTERFACE
 						".InvalidLength",
@@ -417,9 +466,7 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
 		return btd_error_failed(ad->reg, "Failed");
 	}
 
-	if (ad->type == AD_TYPE_PERIPHERAL)
-		cp->flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
-
+	cp->flags = flags;
 	cp->instance = ad->instance;
 	cp->adv_data_len = adv_data_len;
 	memcpy(cp->data, adv_data, adv_data_len);
@@ -468,6 +515,12 @@ static DBusMessage *parse_advertisement(struct advertisement *ad)
 		goto fail;
 	}
 
+	if (!parse_advertising_include_tx_power(ad->proxy,
+						&ad->include_tx_power)) {
+		error("Property \"IncludeTXPower\" failed to parse");
+		goto fail;
+	}
+
 	return refresh_advertisement(ad);
 
 fail:
@@ -651,6 +704,26 @@ static void advertising_manager_destroy(void *user_data)
 	free(manager);
 }
 
+static void read_adv_features_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_advertising *manager = user_data;
+	const struct mgmt_rp_read_adv_features *feat = param;
+
+	if (status || !param) {
+		error("Failed to read advertising features: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*feat)) {
+		error("Wrong size of read adv features response");
+		return;
+	}
+
+	manager->max_adv_len = feat->max_adv_data_len;
+}
+
 static struct btd_advertising *
 advertising_manager_create(struct btd_adapter *adapter)
 {
@@ -672,6 +745,14 @@ advertising_manager_create(struct btd_adapter *adapter)
 
 	manager->mgmt_index = btd_adapter_get_index(adapter);
 
+	if (!mgmt_send(manager->mgmt, MGMT_OP_READ_ADV_FEATURES,
+				manager->mgmt_index, 0, NULL,
+				read_adv_features_callback, manager, NULL)) {
+		error("Failed to read advertising features");
+		advertising_manager_destroy(manager);
+		return NULL;
+	}
+
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						LE_ADVERTISING_MGR_IFACE,
-- 
2.2.0.rc0.207.ga3a616c

