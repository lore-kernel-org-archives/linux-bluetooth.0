Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] advertising: Add implementation of Flags property
Date: Mon,  7 May 2018 19:14:01 +0300
Message-Id: <20180507161403.14181-3-luiz.dentz@gmail.com>
In-Reply-To: <20180507161403.14181-1-luiz.dentz@gmail.com>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the contents of Flags property and add it to AD data
directly using bt_ad_add_flags.
---
 src/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 441d0a235..202b6eec5 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -641,6 +641,43 @@ fail:
 	return false;
 }
 
+static bool parse_flags(DBusMessageIter *iter, struct btd_adv_client *client)
+{
+	DBusMessageIter array;
+	uint8_t *flags;
+	int len;
+
+	if (!iter) {
+		bt_ad_clear_flags(client->data);
+		client->flags &= ~MGMT_ADV_FLAG_MANAGED_FLAGS;
+		return true;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+		goto fail;
+
+	dbus_message_iter_get_fixed_array(&array, &flags, &len);
+
+	if (!bt_ad_add_flags(client->data, flags, len))
+		goto fail;
+
+	DBG("Adding Flags 0x%02x", flags[0]);
+
+	client->flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+	return true;
+
+fail:
+	bt_ad_clear_flags(client->data);
+	client->flags &= ~MGMT_ADV_FLAG_MANAGED_FLAGS;
+	return false;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -656,6 +693,7 @@ static struct adv_parser {
 	{ "Duration", parse_duration },
 	{ "Timeout", parse_timeout },
 	{ "Data", parse_data },
+	{ "Flags", parse_flags },
 	{ },
 };
 
@@ -737,11 +775,12 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 	if (client->type == AD_TYPE_PERIPHERAL) {
 		flags = MGMT_ADV_FLAG_CONNECTABLE;
 
-		if (btd_adapter_get_discoverable(client->manager->adapter))
+		if (btd_adapter_get_discoverable(client->manager->adapter) &&
+				!(client->flags & MGMT_ADV_FLAG_MANAGED_FLAGS))
 			flags |= MGMT_ADV_FLAG_DISCOV;
 	}
 
-	flags |= client->flags;
+	flags |= client->flags & ~MGMT_ADV_FLAG_MANAGED_FLAGS;
 
 	adv_data = generate_adv_data(client, &flags, &adv_data_len);
 	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
-- 
2.14.3

