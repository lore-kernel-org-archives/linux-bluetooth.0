Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 11/14] advertising: Add LocalName property
Date: Thu, 10 Aug 2017 16:32:48 +0300
Message-Id: <20170810133251.23920-11-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With this property applications can select their own local name to be
advertised, as opposed to just including the adapter's name.
---
 doc/advertising-api.txt |  9 +++++++++
 src/advertising.c       | 29 +++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 65f1331a9..c9bc9a148 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -69,6 +69,15 @@ Properties	string Type
 			Possible values: as found on
 					LEAdvertisingManager.SupportedIncludes
 
+		string LocalName
+
+			Local name to be used in the advertising report. If the
+			string is too big to fit into the packet it will be
+			truncated.
+
+			If this property is available 'local-name' cannot be
+			present in the Includes.
+
 LE Advertising Manager hierarchy
 ================================
 
diff --git a/src/advertising.c b/src/advertising.c
index 61b17e400..e45207071 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -61,6 +61,7 @@ struct btd_adv_client {
 	struct btd_adv_manager *manager;
 	char *owner;
 	char *path;
+	char *name;
 	GDBusClient *client;
 	GDBusProxy *proxy;
 	DBusMessage *reg;
@@ -114,6 +115,7 @@ static void client_free(void *data)
 	if (client->path)
 		g_free(client->path);
 
+	free(client->name);
 	free(client);
 }
 
@@ -450,6 +452,26 @@ static bool parse_includes(DBusMessageIter *iter,
 	return true;
 }
 
+static bool parse_local_name(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	const char *name;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return false;
+
+	if (client->flags & MGMT_ADV_FLAG_LOCAL_NAME) {
+		error("Local name already included");
+		return false;
+	}
+
+	dbus_message_iter_get_basic(iter, &name);
+
+	client->name = strdup(name);
+
+	return true;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -460,6 +482,7 @@ static struct adv_parser {
 	{ "ManufacturerData", parse_manufacturer_data },
 	{ "ServiceData", parse_service_data },
 	{ "Includes", parse_includes },
+	{ "LocalName", parse_local_name },
 	{ },
 };
 
@@ -554,14 +577,16 @@ static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
 	struct btd_adv_manager *manager = client->manager;
 	const char *name;
 
-	if (!(*flags & MGMT_ADV_FLAG_LOCAL_NAME)) {
+	if (!(*flags & MGMT_ADV_FLAG_LOCAL_NAME) && !client->name) {
 		*len = 0;
 		return NULL;
 	}
 
 	*flags &= ~MGMT_ADV_FLAG_LOCAL_NAME;
 
-	name = btd_adapter_get_name(manager->adapter);
+	name = client->name;
+	if (!name)
+		name = btd_adapter_get_name(manager->adapter);
 
 	bt_ad_add_name(client->scan, name);
 
-- 
2.13.4

