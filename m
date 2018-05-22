Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/8] advertising: Add implementation of Discoverable property
Date: Tue, 22 May 2018 12:50:06 +0300
Message-Id: <20180522095011.517-3-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the contents of Discoverable property and add it to AD data
directly using bt_ad_add_flags.
---
 src/advertising.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index b087b48b7..cba30ada0 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -641,6 +641,56 @@ fail:
 	return false;
 }
 
+static bool set_flags(struct btd_adv_client *client, uint8_t flags)
+{
+	if (!flags) {
+		bt_ad_clear_flags(client->data);
+		return true;
+	}
+
+	/* Set BR/EDR Not Supported for LE only */
+	if (!btd_adapter_get_bredr(client->manager->adapter))
+		flags |= 0x04;
+
+	if (!bt_ad_add_flags(client->data, &flags, 1))
+		return false;
+
+	return true;
+}
+
+static bool parse_discoverable(DBusMessageIter *iter,
+				struct btd_adv_client *client)
+{
+	uint8_t flags;
+	dbus_bool_t discoverable;
+
+	if (!iter) {
+		bt_ad_clear_flags(client->data);
+		return true;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &discoverable);
+
+	if (discoverable)
+		flags = 0x02;
+	else
+		flags = 0x00;
+
+	if (!set_flags(client , flags))
+		goto fail;
+
+	DBG("Adding Flags 0x%02x", flags);
+
+	return true;
+
+fail:
+	bt_ad_clear_flags(client->data);
+	return false;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -656,6 +706,7 @@ static struct adv_parser {
 	{ "Duration", parse_duration },
 	{ "Timeout", parse_timeout },
 	{ "Data", parse_data },
+	{ "Discoverable", parse_discoverable },
 	{ },
 };
 
@@ -737,7 +788,8 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 	if (client->type == AD_TYPE_PERIPHERAL) {
 		flags = MGMT_ADV_FLAG_CONNECTABLE;
 
-		if (btd_adapter_get_discoverable(client->manager->adapter))
+		if (btd_adapter_get_discoverable(client->manager->adapter) &&
+				!(bt_ad_has_flags(client->data)))
 			flags |= MGMT_ADV_FLAG_DISCOV;
 	}
 
@@ -881,6 +933,18 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	}
 
+	/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C page 2042:
+	 * A device in the broadcast mode shall not set the
+	 * ‘LE General Discoverable Mode’ flag or the
+	 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type as
+	 * defined in [Core Specification Supplement], Part A, Section 1.3.
+	 */
+	if (client->type == AD_TYPE_BROADCAST &&
+				bt_ad_has_flags(client->data)) {
+		error("Broadcast cannot set flags");
+		goto fail;
+	}
+
 	err = refresh_adv(client, add_adv_callback);
 	if (!err)
 		return NULL;
-- 
2.14.3

