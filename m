Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] client: Add acquire-write command
Date: Tue,  4 Jul 2017 18:09:32 +0300
Message-Id: <20170704150937.11701-6-luiz.dentz@gmail.com>
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds acquire-write command which uses D-Bus AcquireWrite methods
to acquire a file descriptor to write to locking the attribute:

[Test peripheral:/service001f/char0020]# acquire-write
[CHG] Attribute /org/bluez/hci1/dev_00_1B_DC_07_31_88/service001f/char0020 WriteAcquired: yes
AcquireWrite success: fd 7 MTU 65
[Test peripheral:/service001f/char0020]# write 00
Attempting to write fd 7

< ACL Data TX: Handle 3585 flags 0x00 dlen 8
      ATT: Write Command (0x52) len 3
        Handle: 0x0021
          Data: 00
---
 client/gatt.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 12 ++++++++++
 3 files changed, 87 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 8a4491a..e6f37ae 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -89,6 +89,10 @@ static GList *descriptors;
 static GList *managers;
 static GList *uuids;
 
+static GDBusProxy *write_proxy;
+static int write_fd = -1;
+static uint16_t write_mtu;
+
 static void print_service(struct service *service, const char *description)
 {
 	const char *text;
@@ -236,6 +240,15 @@ void gatt_remove_characteristic(GDBusProxy *proxy)
 	characteristics = g_list_delete_link(characteristics, l);
 
 	print_characteristic(proxy, COLORED_DEL);
+
+	if (write_proxy == proxy) {
+		write_proxy = NULL;
+		write_mtu = 0;
+		if (write_fd > 0) {
+			close(write_fd);
+			write_fd = -1;
+		}
+	}
 }
 
 static void print_desc(struct desc *desc, const char *description)
@@ -619,6 +632,16 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 	iov.iov_base = value;
 	iov.iov_len = i;
 
+	/* Write using the fd if it has been acquired and fit the MTU */
+	if (proxy == write_proxy && (write_fd > 0 && write_mtu >= i)) {
+		rl_printf("Attempting to write fd %d\n", write_fd);
+		if (writev(write_fd, &iov, 1) < 0) {
+			rl_printf("Failed to write: %s", strerror(errno));
+			return;
+		}
+		return;
+	}
+
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
 					write_reply, &iov, NULL) == FALSE) {
 		rl_printf("Failed to write\n");
@@ -643,6 +666,56 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 						g_dbus_proxy_get_path(proxy));
 }
 
+static void acquire_write_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to acquire write: %s\n", error.name);
+		dbus_error_free(&error);
+		write_proxy = NULL;
+		return;
+	}
+
+	if (write_fd > 0) {
+		close(write_fd);
+		write_fd = -1;
+	}
+
+	write_mtu = 0;
+
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &write_fd,
+					DBUS_TYPE_UINT16, &write_mtu,
+					DBUS_TYPE_INVALID) == false)) {
+		rl_printf("Invalid AcquireWrite response\n");
+		return;
+	}
+
+	rl_printf("AcquireWrite success: fd %d MTU %u\n", write_fd, write_mtu);
+}
+
+void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
+		rl_printf("Unable to acquire write: %s not a characteristic\n",
+						g_dbus_proxy_get_path(proxy));
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "AcquireWrite", NULL,
+				acquire_write_reply, NULL, NULL) == FALSE) {
+		rl_printf("Failed to AcquireWrite\n");
+		return;
+	}
+
+	write_proxy = proxy;
+}
+
 static void notify_reply(DBusMessage *message, void *user_data)
 {
 	bool enable = GPOINTER_TO_UINT(user_data);
diff --git a/client/gatt.h b/client/gatt.h
index 8031a46..713d34f 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -38,6 +38,8 @@ void gatt_read_attribute(GDBusProxy *proxy);
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
 
+void gatt_acquire_write(GDBusProxy *proxy, const char *arg);
+
 void gatt_add_manager(GDBusProxy *proxy);
 void gatt_remove_manager(GDBusProxy *proxy);
 
diff --git a/client/main.c b/client/main.c
index 3af533e..79f61a1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1799,6 +1799,16 @@ static void cmd_write(const char *arg)
 	gatt_write_attribute(default_attr, arg);
 }
 
+static void cmd_acquire_write(const char *arg)
+{
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_acquire_write(default_attr, arg);
+}
+
 static void cmd_notify(const char *arg)
 {
 	dbus_bool_t enable;
@@ -2274,6 +2284,8 @@ static const struct {
 	{ "read",         NULL,       cmd_read, "Read attribute value" },
 	{ "write",        "<data=[xx xx ...]>", cmd_write,
 						"Write attribute value" },
+	{ "acquire-write", NULL, cmd_acquire_write,
+					"Acquire Write file descriptor" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
-- 
2.9.4

