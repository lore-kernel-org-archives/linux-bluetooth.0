Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/9] advertising: Add Data implementation
Date: Wed,  2 May 2018 12:24:38 +0300
Message-Id: <20180502092442.10567-5-luiz.dentz@gmail.com>
In-Reply-To: <20180502092442.10567-1-luiz.dentz@gmail.com>
References: <20180502092442.10567-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the support for Data property.
---
 src/advertising.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 0cb6eac3a..441d0a235 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -583,6 +583,64 @@ static bool parse_timeout(DBusMessageIter *iter,
 	return true;
 }
 
+static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *client)
+{
+	DBusMessageIter entries;
+
+	if (!iter) {
+		bt_ad_clear_data(client->data);
+		return true;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(iter, &entries);
+
+	bt_ad_clear_data(client->data);
+
+	while (dbus_message_iter_get_arg_type(&entries)
+						== DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry, array;
+		uint8_t type;
+		uint8_t *data;
+		int len;
+
+		dbus_message_iter_recurse(&entries, &entry);
+		dbus_message_iter_get_basic(&entry, &type);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto fail;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&value, &array);
+
+		if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_BYTE)
+			goto fail;
+
+		dbus_message_iter_get_fixed_array(&array, &data, &len);
+
+		DBG("Adding Data for type 0x%02x len %u", type, len);
+
+		if (!bt_ad_add_data(client->data, type, data, len))
+			goto fail;
+
+		dbus_message_iter_next(&entries);
+	}
+
+	return true;
+
+fail:
+	bt_ad_clear_data(client->data);
+	return false;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -597,6 +655,7 @@ static struct adv_parser {
 	{ "Appearance", parse_appearance },
 	{ "Duration", parse_duration },
 	{ "Timeout", parse_timeout },
+	{ "Data", parse_data },
 	{ },
 };
 
-- 
2.14.3

