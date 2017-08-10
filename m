Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 13/14] advertising: Add Appearance property
Date: Thu, 10 Aug 2017 16:32:50 +0300
Message-Id: <20170810133251.23920-13-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With this property applications can select their own appearance to be
advertised, as opposed to just including the adapter's appearance.
---
 doc/advertising-api.txt |  6 ++++++
 src/advertising.c       | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index c9bc9a148..36fe130d9 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -78,6 +78,12 @@ Properties	string Type
 			If this property is available 'local-name' cannot be
 			present in the Includes.
 
+		uint16 Appearance
+
+			Appearance to be used in the advertising report.
+
+			Possible values: as found on GAP Service.
+
 LE Advertising Manager hierarchy
 ================================
 
diff --git a/src/advertising.c b/src/advertising.c
index e45207071..9eb22b9fd 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -62,6 +62,7 @@ struct btd_adv_client {
 	char *owner;
 	char *path;
 	char *name;
+	uint16_t appearance;
 	GDBusClient *client;
 	GDBusProxy *proxy;
 	DBusMessage *reg;
@@ -472,6 +473,22 @@ static bool parse_local_name(DBusMessageIter *iter,
 	return true;
 }
 
+static bool parse_appearance(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return false;
+
+	if (client->flags & MGMT_ADV_FLAG_APPEARANCE) {
+		error("Appearance already included");
+		return false;
+	}
+
+	dbus_message_iter_get_basic(iter, &client->appearance);
+
+	return true;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -483,6 +500,7 @@ static struct adv_parser {
 	{ "ServiceData", parse_service_data },
 	{ "Includes", parse_includes },
 	{ "LocalName", parse_local_name },
+	{ "Appearance", parse_appearance },
 	{ },
 };
 
@@ -562,10 +580,18 @@ static size_t calc_max_adv_len(struct btd_adv_client *client, uint32_t flags)
 static uint8_t *generate_adv_data(struct btd_adv_client *client,
 						uint32_t *flags, size_t *len)
 {
-	if ((*flags & MGMT_ADV_FLAG_APPEARANCE)) {
-		*flags &= ~MGMT_ADV_FLAG_APPEARANCE;
-		/* TODO: Get the appearance from the adaptor once supported. */
-		bt_ad_add_appearance(client->data, 0x0000);
+	if ((*flags & MGMT_ADV_FLAG_APPEARANCE) ||
+					client->appearance != UINT16_MAX) {
+		uint16_t appearance;
+
+		appearance = client->appearance;
+		if (appearance == UINT16_MAX)
+			/* TODO: Get the appearance from the adaptor once
+			 * supported.
+			 */
+			appearance = 0x000;
+
+		bt_ad_add_appearance(client->data, appearance);
 	}
 
 	return bt_ad_generate(client->data, len);
@@ -753,6 +779,7 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 		goto fail;
 
 	client->manager = manager;
+	client->appearance = UINT16_MAX;
 
 	return client;
 
-- 
2.13.4

