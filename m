Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/7] advertising: Add SupportedFeatures
Date: Fri,  4 Aug 2017 16:22:40 +0300
Message-Id: <20170804132245.30824-2-luiz.dentz@gmail.com>
In-Reply-To: <20170804132245.30824-1-luiz.dentz@gmail.com>
References: <20170804132245.30824-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds SupportedFeatures so application can detect what features
are supported by the system.
---
 doc/advertising-api.txt |  8 ++++++++
 src/advertising.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index cee6878f6..5d2661a71 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -116,3 +116,11 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 Properties	byte AdvertisingInstances
 
 			Number of available advertisement instances.
+
+		array{string} SupportedFeatures
+
+			List of supported features.
+
+			Possible values: "tx-power"
+					 "appearance"
+					 "local-name"
diff --git a/src/advertising.c b/src/advertising.c
index c628f0fd5..a1e497439 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -48,6 +48,7 @@ struct btd_adv_manager {
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
 	uint8_t max_ads;
+	uint32_t supported_flags;
 	unsigned int instance_bitmap;
 };
 
@@ -738,9 +739,50 @@ static gboolean get_instances(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static struct adv_feat {
+	uint8_t flag;
+	const char *name;
+} feats[] = {
+	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
+	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
+	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
+	{ },
+};
+
+static void append_features(struct btd_adv_manager *manager,
+						DBusMessageIter *iter)
+{
+	struct adv_feat *feat;
+
+	for (feat = feats; feat && feat->name; feat++) {
+		if (manager->supported_flags & feat->flag)
+			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+								&feat->name);
+	}
+}
+
+static gboolean get_supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	append_features(manager, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable properties[] = {
 	{ "AdvertisingInstances", "y", get_instances, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
 };
 
 static const GDBusMethodTable methods[] = {
@@ -785,6 +827,7 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 
 	manager->max_adv_len = feat->max_adv_data_len;
 	manager->max_ads = feat->max_instances;
+	manager->supported_flags = feat->supported_flags;
 
 	if (manager->max_ads == 0)
 		return;
-- 
2.13.3

