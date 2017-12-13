Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/4] adapter: Add support for AddressType property
Date: Wed, 13 Dec 2017 14:36:36 +0100
Message-Id: <20171213133638.25852-2-szymon.janc@codecoup.pl>
In-Reply-To: <20171213133638.25852-1-szymon.janc@codecoup.pl>
References: <20171213133638.25852-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 7ac3d20a1..0a25ae27e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2539,6 +2539,23 @@ static gboolean property_get_address(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_address_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *str;
+
+	if ((adapter->current_settings & MGMT_SETTING_LE) &&
+				(adapter->bdaddr_type == BDADDR_LE_RANDOM))
+		str = "random";
+	else
+		str = "public";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
 static gboolean property_get_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -3079,6 +3096,7 @@ static const GDBusMethodTable adapter_methods[] = {
 
 static const GDBusPropertyTable adapter_properties[] = {
 	{ "Address", "s", property_get_address },
+	{ "AddressType", "s", property_get_address_type },
 	{ "Name", "s", property_get_name },
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
-- 
2.14.3

