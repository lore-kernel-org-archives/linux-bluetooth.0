Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] advertising: Add implementation of DiscoverableTimeout property
Date: Mon, 21 May 2018 17:07:33 +0300
Message-Id: <20180521140734.10344-8-luiz.dentz@gmail.com>
In-Reply-To: <20180521140734.10344-1-luiz.dentz@gmail.com>
References: <20180521140734.10344-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the contents of DiscoverableTimeout property and add
a timeout handler which clears the discoverable when it expires.
---
 src/advertising.c | 106 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 19 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 1fd114490..2ec9468c4 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -65,7 +65,9 @@ struct btd_adv_client {
 	uint16_t appearance;
 	uint16_t duration;
 	uint16_t timeout;
+	uint16_t discoverable_to;
 	unsigned int to_id;
+	unsigned int disc_to_id;
 	GDBusClient *client;
 	GDBusProxy *proxy;
 	DBusMessage *reg;
@@ -102,6 +104,9 @@ static void client_free(void *data)
 	if (client->to_id > 0)
 		g_source_remove(client->to_id);
 
+	if (client->disc_to_id > 0)
+		g_source_remove(client->disc_to_id);
+
 	if (client->client) {
 		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
 		g_dbus_client_unref(client->client);
@@ -682,25 +687,6 @@ fail:
 	return false;
 }
 
-static struct adv_parser {
-	const char *name;
-	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
-} parsers[] = {
-	{ "Type", parse_type },
-	{ "ServiceUUIDs", parse_service_uuids },
-	{ "SolicitUUIDs", parse_solicit_uuids },
-	{ "ManufacturerData", parse_manufacturer_data },
-	{ "ServiceData", parse_service_data },
-	{ "Includes", parse_includes },
-	{ "LocalName", parse_local_name },
-	{ "Appearance", parse_appearance },
-	{ "Duration", parse_duration },
-	{ "Timeout", parse_timeout },
-	{ "Data", parse_data },
-	{ "Discoverable", parse_discoverable },
-	{ },
-};
-
 static size_t calc_max_adv_len(struct btd_adv_client *client, uint32_t flags)
 {
 	size_t max = client->manager->max_adv_len;
@@ -834,6 +820,68 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 	return 0;
 }
 
+static gboolean client_discoverable_timeout(void *user_data)
+{
+	struct btd_adv_client *client = user_data;
+	uint8_t flags = 0x00;
+
+	DBG("");
+
+	client->disc_to_id = 0;
+
+	if (!bt_ad_add_flags(client->data, &flags, 1))
+		return false;
+
+	refresh_adv(client, NULL);
+
+	return FALSE;
+}
+
+static bool parse_discoverable_timeout(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (!iter) {
+		client->discoverable_to = 0;
+		g_source_remove(client->disc_to_id);
+		client->disc_to_id = 0;
+		return true;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &client->discoverable_to);
+
+	if (client->disc_to_id)
+		g_source_remove(client->disc_to_id);
+
+	client->disc_to_id = g_timeout_add_seconds(client->discoverable_to,
+						client_discoverable_timeout,
+						client);
+
+	return true;
+}
+
+static struct adv_parser {
+	const char *name;
+	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
+} parsers[] = {
+	{ "Type", parse_type },
+	{ "ServiceUUIDs", parse_service_uuids },
+	{ "SolicitUUIDs", parse_solicit_uuids },
+	{ "ManufacturerData", parse_manufacturer_data },
+	{ "ServiceData", parse_service_data },
+	{ "Includes", parse_includes },
+	{ "LocalName", parse_local_name },
+	{ "Appearance", parse_appearance },
+	{ "Duration", parse_duration },
+	{ "Timeout", parse_timeout },
+	{ "Data", parse_data },
+	{ "Discoverable", parse_discoverable },
+	{ "DiscoverableTimeout", parse_discoverable_timeout },
+	{ },
+};
+
 static void properties_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -936,6 +984,26 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	if (client->flags & MGMT_ADV_FLAG_MANAGED_FLAGS) {
+		/* Set Limited Discoverable of DiscoverableTimeout is set */
+		if (client->disc_to_id) {
+			uint8_t flags = 0x01;
+			if (!bt_ad_add_flags(client->data, &flags, 1))
+				goto fail;
+		}
+	} else if (client->disc_to_id) {
+		/* Ignore DiscoverableTimeout if not discoverable */
+		g_source_remove(client->disc_to_id);
+		client->disc_to_id = 0;
+		client->discoverable_to = 0;
+	}
+
+	if (client->timeout < client->discoverable_to) {
+		/* DiscoverableTimeout must not be bigger than Timeout */
+		error("DiscoverableTimeout > Timeout");
+		goto fail;
+	}
+
 	err = refresh_adv(client, add_adv_callback);
 	if (!err)
 		return NULL;
-- 
2.14.3

