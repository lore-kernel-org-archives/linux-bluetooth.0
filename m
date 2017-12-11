Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 2/4] adapter: Add support for LEAddressType property
Date: Mon, 11 Dec 2017 11:38:35 +0100
Message-Id: <20171211103837.25150-2-szymon.janc@codecoup.pl>
In-Reply-To: <20171211103837.25150-1-szymon.janc@codecoup.pl>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 7ac3d20a1..35d9c63c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2539,6 +2539,30 @@ static gboolean property_get_address(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_exists_address_type(const GDBusPropertyTable *property,
+							void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	return (adapter->current_settings & MGMT_SETTING_LE) ? TRUE : FALSE;
+}
+
+static gboolean property_get_address_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *str;
+
+	if (adapter->bdaddr_type == BDADDR_LE_PUBLIC)
+		str = "public";
+	else
+		str = "static";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
 static gboolean property_get_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -3079,6 +3103,8 @@ static const GDBusMethodTable adapter_methods[] = {
 
 static const GDBusPropertyTable adapter_properties[] = {
 	{ "Address", "s", property_get_address },
+	{ "LEAddressType", "s", property_get_address_type, NULL,
+						property_exists_address_type },
 	{ "Name", "s", property_get_name },
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
-- 
2.14.3

