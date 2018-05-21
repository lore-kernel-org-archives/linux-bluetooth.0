Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] advertising: Add implementation of Discoverable property
Date: Mon, 21 May 2018 17:07:29 +0300
Message-Id: <20180521140734.10344-4-luiz.dentz@gmail.com>
In-Reply-To: <20180521140734.10344-1-luiz.dentz@gmail.com>
References: <20180521140734.10344-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the contents of Discoverable property and add it to AD data
directly using bt_ad_add_flags.
---
 src/advertising.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index b087b48b7..1fd114490 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -641,6 +641,47 @@ fail:
 	return false;
 }
 
+static void clear_flags(struct btd_adv_client *client)
+{
+	bt_ad_clear_flags(client->data);
+	client->flags &= ~MGMT_ADV_FLAG_MANAGED_FLAGS;
+}
+
+static bool parse_discoverable(DBusMessageIter *iter,
+				struct btd_adv_client *client)
+{
+	uint8_t flags;
+	dbus_bool_t discoverable;
+
+	if (!iter) {
+		clear_flags(client);
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
+	DBG("Adding Flags 0x%02x", flags);
+
+	if (!bt_ad_add_flags(client->data, &flags, 1))
+		goto fail;
+
+	client->flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+	return true;
+
+fail:
+	clear_flags(client);
+	return false;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -656,6 +697,7 @@ static struct adv_parser {
 	{ "Duration", parse_duration },
 	{ "Timeout", parse_timeout },
 	{ "Data", parse_data },
+	{ "Discoverable", parse_discoverable },
 	{ },
 };
 
@@ -737,11 +779,12 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
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
@@ -881,6 +924,18 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	}
 
+	/* BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C page 2042:
+	 * A device in the broadcast mode shall not set the
+	 * ‘LE General Discoverable Mode’ flag or the
+	 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type as
+	 * defined in [Core Specification Supplement], Part A, Section 1.3.
+	 */
+	if (client->type == AD_TYPE_BROADCAST &&
+				client->flags & MGMT_ADV_FLAG_MANAGED_FLAGS) {
+		error("Broadcast cannot set flags");
+		goto fail;
+	}
+
 	err = refresh_adv(client, add_adv_callback);
 	if (!err)
 		return NULL;
-- 
2.14.3

