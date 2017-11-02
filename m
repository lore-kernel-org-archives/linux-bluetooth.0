Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/7] advertising: Add implementation of Duration and Timeout
Date: Thu,  2 Nov 2017 16:43:47 +0200
Message-Id: <20171102144352.32353-2-luiz.dentz@gmail.com>
In-Reply-To: <20171102144352.32353-1-luiz.dentz@gmail.com>
References: <20171102144352.32353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of Duration and Timeout property and properly
set them in Add Advertising:

@ MGMT Command: Add Advertising (0x003e) plen 11
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 4
        Timeout: 0
        Advertising data length: 0
        Scan response length: 0
---
 src/advertising.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index d4d95c1c3..31a5fff5c 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -64,6 +64,9 @@ struct btd_adv_client {
 	char *path;
 	char *name;
 	uint16_t appearance;
+	uint16_t duration;
+	uint16_t timeout;
+	unsigned int to_id;
 	GDBusClient *client;
 	GDBusProxy *proxy;
 	DBusMessage *reg;
@@ -97,6 +100,9 @@ static void client_free(void *data)
 {
 	struct btd_adv_client *client = data;
 
+	if (client->to_id > 0)
+		g_source_remove(client->to_id);
+
 	if (client->client) {
 		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
 		g_dbus_client_unref(client->client);
@@ -491,6 +497,48 @@ static bool parse_appearance(DBusMessageIter *iter,
 	return true;
 }
 
+static bool parse_duration(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &client->duration);
+
+	return true;
+}
+
+static gboolean client_timeout(void *user_data)
+{
+	struct btd_adv_client *client = user_data;
+
+	DBG("");
+
+	client->to_id = 0;
+
+	client_release(client);
+	client_remove(client);
+
+	return FALSE;
+}
+
+static bool parse_timeout(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &client->timeout);
+
+	if (client->to_id)
+		g_source_remove(client->to_id);
+
+	client->to_id = g_timeout_add_seconds(client->timeout, client_timeout,
+								client);
+
+	return true;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -503,6 +551,8 @@ static struct adv_parser {
 	{ "Includes", parse_includes },
 	{ "LocalName", parse_local_name },
 	{ "Appearance", parse_appearance },
+	{ "Duration", parse_duration },
+	{ "Timeout", parse_timeout },
 	{ },
 };
 
@@ -611,6 +661,7 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 
 	cp->flags = htobl(flags);
 	cp->instance = client->instance;
+	cp->duration = client->duration;
 	cp->adv_data_len = adv_data_len;
 	cp->scan_rsp_len = scan_rsp_len;
 	memcpy(cp->data, adv_data, adv_data_len);
-- 
2.13.6

