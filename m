Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <mail@timomueller.eu>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [PATCHv1 2/2] adapter: Introduce default adapter property
Date: Tue,  3 Dec 2013 16:21:46 +0100
Message-Id: <66f9ec183ae6d6cdc417e9f659a0963b9310ca65.1386078490.git.timo.mueller@bmw-carit.de>
In-Reply-To: <1dc8c4e895c1511d82feaf65e33fdf2c93161e5d.1386078490.git.timo.mueller@bmw-carit.de>
References: <cover.1386078490.git.timo.mueller@bmw-carit.de>
 <1dc8c4e895c1511d82feaf65e33fdf2c93161e5d.1386078490.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1386078490.git.timo.mueller@bmw-carit.de>
References: <cover.1386078490.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

Some plugins choose a default adapter when no specific adapter has
been selected. This information was not exposed in the adapters D-Bus
properties.

With the new property users can find out which adapter is used if no
adapter has been specified. This allows them to change the properties
of the adapter beforehand, e.g. powering the adapter before oob data
is sent.
---
 src/adapter.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 41f7bd6..46174d6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2126,6 +2126,17 @@ static gboolean property_get_modalias(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean property_get_default(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_bool_t is_default = btd_adapter_is_default(adapter);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &is_default);
+
+	return TRUE;
+}
+
 static int device_path_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct btd_device *device = a;
@@ -2193,6 +2204,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "UUIDs", "as", property_get_uuids },
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
+	{ "Default", "b", property_get_default },
 	{ }
 };
 
@@ -5673,6 +5685,9 @@ static int adapter_unregister(struct btd_adapter *adapter)
 			new_default = adapters->data;
 
 		new_default->is_default = true;
+
+		g_dbus_emit_property_changed(dbus_conn, new_default->path,
+				ADAPTER_INTERFACE, "Default");
 	}
 
 	adapter_list = g_list_remove(adapter_list, adapter);
-- 
1.8.3.1

