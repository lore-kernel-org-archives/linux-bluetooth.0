Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ 2/3] core/advertising: Parse IncludeTXPower
Date: Thu,  9 Apr 2015 10:37:20 -0700
Message-Id: <1428601041-27353-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428601041-27353-1-git-send-email-jamuraa@chromium.org>
References: <1428601041-27353-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse the IncludeTXPower property of the advertisement object, and
pass the appropriate flag to MGMT if it is set.
---
 src/advertising.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2f8e539..b8d92e8 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -51,6 +51,9 @@ struct btd_advertising {
 #define AD_TYPE_BROADCAST 0
 #define AD_TYPE_PERIPHERAL 1
 
+#define AD_MAX_LENGTH 31U
+#define AD_TX_POWER_LENGTH 2
+
 struct advertisement {
 	struct btd_advertising *manager;
 	char *owner;
@@ -59,6 +62,7 @@ struct advertisement {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
+	bool include_tx_power;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -361,6 +365,22 @@ fail:
 	return false;
 }
 
+static bool parse_advertising_include_tx_power(GDBusProxy *proxy,
+							bool *included)
+{
+	DBusMessageIter iter;
+
+	if (!g_dbus_proxy_get_property(proxy, "IncludeTXPower", &iter))
+		return true;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, included);
+
+	return true;
+}
+
 static void add_advertising_callback(uint8_t status, uint16_t length,
 					  const void *param, void *user_data)
 {
@@ -381,12 +401,16 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
 	uint8_t param_len;
 	uint8_t *adv_data;
 	size_t adv_data_len;
+	uint8_t ad_space_needed = 0;
 
 	DBG("Refreshing advertisement: %s", ad->path);
 
 	adv_data = bt_ad_generate(ad->data, &adv_data_len);
 
-	if (!adv_data) {
+	if (ad->include_tx_power)
+		ad_space_needed += AD_TX_POWER_LENGTH;
+
+	if (!adv_data || (adv_data_len > (AD_MAX_LENGTH - ad_space_needed))) {
 		error("Advertising data couldn't be generated.");
 
 		return g_dbus_create_error(ad->reg, ERROR_INTERFACE
@@ -409,6 +433,9 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
 	if (ad->type == AD_TYPE_PERIPHERAL)
 		cp->flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
 
+	if (ad->include_tx_power)
+		cp->flags |= MGMT_ADV_FLAG_TX_POWER;
+
 	cp->instance = ad->instance;
 	cp->adv_data_len = adv_data_len;
 	memcpy(cp->data, adv_data, adv_data_len);
@@ -457,6 +484,8 @@ static DBusMessage *parse_advertisement(struct advertisement *ad)
 		goto fail;
 	}
 
+	parse_advertising_include_tx_power(ad->proxy, &ad->include_tx_power);
+
 	return refresh_advertisement(ad);
 
 fail:
-- 
2.2.0.rc0.207.ga3a616c

