Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v2 5/6] core: adapter: Add FilteredDiscovery property
Date: Thu, 12 Feb 2015 19:50:22 -0800
Message-Id: <1423799423-28986-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
References: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds FilteredDiscovery property, that will be used to
indicate that StartFilteredDiscovery method is running. If
StartDiscovery method is called (it takes precedence), this property
will be set to false.
---
 src/adapter.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index fa4b7ce..cf4cf0a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -186,6 +186,7 @@ struct btd_adapter {
 	char *stored_alias;		/* stored adapter name alias */
 
 	bool discovering;		/* discovering property state */
+	bool filtered_discovery;	/* filtered discovery property state */
 	uint8_t discovery_type;		/* current active discovery type */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
@@ -2337,6 +2338,19 @@ static gboolean property_get_discovering(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_filtered_discovery(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_bool_t filtered_discovery = adapter->filtered_discovery;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							  &filtered_discovery);
+
+	return TRUE;
+}
+
 static gboolean property_get_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2451,6 +2465,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "PairableTimeout", "u", property_get_pairable_timeout,
 					property_set_pairable_timeout },
 	{ "Discovering", "b", property_get_discovering },
+	{ "FilteredDiscovery", "b", property_get_filtered_discovery },
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
-- 
2.2.0.rc0.207.ga3a616c

