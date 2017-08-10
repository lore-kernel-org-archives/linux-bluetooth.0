Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 04/14] advertising: Add SupportedIncludes
Date: Thu, 10 Aug 2017 16:32:41 +0300
Message-Id: <20170810133251.23920-4-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds SupportedIncludes so application can detect what the system
can include.
---
 doc/advertising-api.txt |  8 ++++++++
 src/advertising.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index a8a738c0f..c39b5ec55 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -120,3 +120,11 @@ Properties	byte ActiveInstances
 		byte SupportedInstances
 
 			Number of available advertising instances.
+
+		array{string} SupportedIncludes
+
+			List of supported system includes.
+
+			Possible values: "tx-power"
+					 "appearance"
+					 "local-name"
diff --git a/src/advertising.c b/src/advertising.c
index 0d3487cd3..a16c6a560 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -48,6 +48,7 @@ struct btd_adv_manager {
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
 	uint8_t max_ads;
+	uint32_t supported_flags;
 	unsigned int instance_bitmap;
 };
 
@@ -773,11 +774,51 @@ static gboolean get_active_instances(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static struct adv_include {
+	uint8_t flag;
+	const char *name;
+} includes[] = {
+	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
+	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
+	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
+	{ },
+};
+
+static void append_include(struct btd_adv_manager *manager,
+						DBusMessageIter *iter)
+{
+	struct adv_include *inc;
+
+	for (inc = includes; inc && inc->name; inc++) {
+		if (manager->supported_flags & inc->flag)
+			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+								&inc->name);
+	}
+}
+
+static gboolean get_supported_includes(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	append_include(manager, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable properties[] = {
 	{ "ActiveInstances", "y", get_active_instances, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "SupportedInstances", "y", get_instances, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -823,6 +864,7 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 
 	manager->max_adv_len = feat->max_adv_data_len;
 	manager->max_ads = feat->max_instances;
+	manager->supported_flags = feat->supported_flags;
 
 	if (manager->max_ads == 0)
 		return;
-- 
2.13.4

