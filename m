Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/7] advertising: Add IncludeName property
Date: Fri,  4 Aug 2017 15:21:04 +0300
Message-Id: <20170804122108.26472-3-luiz.dentz@gmail.com>
In-Reply-To: <20170804122108.26472-1-luiz.dentz@gmail.com>
References: <20170804122108.26472-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to include adapter name, or alias, in the scan
response with use of IncludeName property.
---
 doc/advertising-api.txt |  5 +++++
 src/advertising.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 091c1b325..6853f4601 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -66,6 +66,11 @@ Properties	string Type
 			Includes the Tx Power in the advertising packet.
 			If missing, the Tx Power is not included.
 
+		bool IncludeName
+
+			Include adapter Name, or Alias if set, as scan
+			response data.
+
 
 LE Advertising Manager hierarchy
 ================================
diff --git a/src/advertising.c b/src/advertising.c
index a1e497439..7a1b083bc 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -64,6 +64,7 @@ struct btd_adv_client {
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
 	bool include_tx_power;
+	bool include_name;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -412,6 +413,24 @@ static bool parse_include_tx_power(GDBusProxy *proxy, bool *included)
 	return true;
 }
 
+static bool parse_include_name(GDBusProxy *proxy, bool *included)
+{
+	DBusMessageIter iter;
+	dbus_bool_t b;
+
+	if (!g_dbus_proxy_get_property(proxy, "IncludeName", &iter))
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
 static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 {
 	DBusMessage *reply;
@@ -498,6 +517,9 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 	if (client->include_tx_power)
 		flags |= MGMT_ADV_FLAG_TX_POWER;
 
+	if (client->include_name)
+		flags |= MGMT_ADV_FLAG_LOCAL_NAME;
+
 	adv_data = bt_ad_generate(client->data, &adv_data_len);
 
 	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
@@ -574,6 +596,11 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	if (!parse_include_name(client->proxy, &client->include_name)) {
+		error("Property \"IncludeName\" failed to parse");
+		goto fail;
+	}
+
 	return refresh_advertisement(client);
 
 fail:
-- 
2.13.3

