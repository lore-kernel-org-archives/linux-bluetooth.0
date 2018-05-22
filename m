Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] advertising: Add implementation of DiscoverableTimeout property
Date: Tue, 22 May 2018 12:50:10 +0300
Message-Id: <20180522095011.517-7-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the contents of DiscoverableTimeout property and add
a timeout handler which clears the discoverable when it expires.
---
 src/advertising.c | 122 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 28 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index cba30ada0..444effaab 100644
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
@@ -691,25 +696,6 @@ fail:
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
@@ -843,6 +829,66 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 	return 0;
 }
 
+static gboolean client_discoverable_timeout(void *user_data)
+{
+	struct btd_adv_client *client = user_data;
+
+	DBG("");
+
+	client->disc_to_id = 0;
+
+	bt_ad_clear_flags(client->data);
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
@@ -933,15 +979,35 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	}
 
-	/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C page 2042:
-	 * A device in the broadcast mode shall not set the
-	 * ‘LE General Discoverable Mode’ flag or the
-	 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type as
-	 * defined in [Core Specification Supplement], Part A, Section 1.3.
-	 */
-	if (client->type == AD_TYPE_BROADCAST &&
-				bt_ad_has_flags(client->data)) {
-		error("Broadcast cannot set flags");
+	if (bt_ad_has_flags(client->data)) {
+		/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
+		 * page 2042:
+		 * A device in the broadcast mode shall not set the
+		 * ‘LE General Discoverable Mode’ flag or the
+		 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
+		 * as defined in [Core Specification Supplement], Part A,
+		 * Section 1.3.
+		 */
+		if (client->type == AD_TYPE_BROADCAST) {
+			error("Broadcast cannot set flags");
+			goto fail;
+		}
+
+		/* Set Limited Discoverable if DiscoverableTimeout is set */
+		if (client->disc_to_id && !set_flags(client, 0x01)) {
+			error("Failed to set Limited Discoverable Flag");
+			goto fail;
+		}
+	} else if (client->disc_to_id) {
+		/* Ignore DiscoverableTimeout if not discoverable */
+		g_source_remove(client->disc_to_id);
+		client->disc_to_id = 0;
+		client->discoverable_to = 0;
+	}
+
+	if (client->timeout && client->timeout < client->discoverable_to) {
+		/* DiscoverableTimeout must not be bigger than Timeout */
+		error("DiscoverableTimeout > Timeout");
 		goto fail;
 	}
 
-- 
2.14.3

