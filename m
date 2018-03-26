Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] client: Attempt to convert the device path to address
Date: Mon, 26 Mar 2018 16:33:04 +0300
Message-Id: <20180326133304.14531-4-luiz.dentz@gmail.com>
In-Reply-To: <20180326133304.14531-1-luiz.dentz@gmail.com>
References: <20180326133304.14531-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Printing the object path is not only long but it also may change.
---
 client/gatt.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index cbf7adf57..7103c4f83 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1415,6 +1415,20 @@ static const GDBusPropertyTable chrc_properties[] = {
 	{ }
 };
 
+static const char *path_to_address(const char *path)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *address = path;
+
+	proxy = bt_shell_get_env(path);
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter))
+		dbus_message_iter_get_basic(&iter, &address);
+
+	return address;
+}
+
 static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
 						char **device, char **link)
 {
@@ -1539,8 +1553,8 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("ReadValue: %s offset %u link %s\n", device, offset,
-								link);
+	bt_shell_printf("ReadValue: %s offset %u link %s\n",
+			path_to_address(device), offset, link);
 
 	if (chrc->authorization_req && offset == 0)
 		chrc->authorized = false;
@@ -1722,7 +1736,8 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("AcquireWrite: %s link %s\n", device, link);
+	bt_shell_printf("AcquireWrite: %s link %s\n", path_to_address(device),
+									link);
 
 	reply = chrc_create_pipe(chrc, msg);
 
@@ -1753,7 +1768,8 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("AcquireNotify: %s link %s\n", device, link);
+	bt_shell_printf("AcquireNotify: %s link %s\n", path_to_address(device),
+									link);
 
 	reply = chrc_create_pipe(chrc, msg);
 
@@ -1961,8 +1977,8 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("ReadValue: %s offset %u link %s\n", device, offset,
-								link);
+	bt_shell_printf("ReadValue: %s offset %u link %s\n",
+			path_to_address(device), offset, link);
 
 	if (offset > desc->value_len)
 		return g_dbus_create_error(msg, "org.bluez.Error.InvalidOffset",
@@ -1993,8 +2009,8 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("WriteValue: %s offset %u link %s\n", device, offset,
-								link);
+	bt_shell_printf("WriteValue: %s offset %u link %s\n",
+			path_to_address(device), offset, link);
 
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
 
-- 
2.14.3

