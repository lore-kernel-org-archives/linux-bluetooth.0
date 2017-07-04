Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] client: Add acquire-notify command
Date: Tue,  4 Jul 2017 18:09:36 +0300
Message-Id: <20170704150937.11701-10-luiz.dentz@gmail.com>
In-Reply-To: <20170704150937.11701-1-luiz.dentz@gmail.com>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds acquire-notify command which uses D-Bus AcquireNotify method
to acquire a file descriptor to read notifications locking the attribute:

[Test peripheral:/service001f/char0020]# acquire-notify
[CHG] Attribute /org/bluez/hci1/dev_56_A0_AA_D0_12_FF/service001f/char0020 NotifyAcquired: yes
AcquireNotify success: fd 7 MTU 65

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x0022
          Data: 0200

[CHG] /org/bluez/hci1/dev_56_A0_AA_D0_12_FF/service001f/char0020 Notification:
  00

> ACL Data RX: Handle 3585 flags 0x02 dlen 8
      ATT: Handle Value Indication (0x1d) len 3
        Handle: 0x0021
          Data: 00
---
 Makefile.tools |   4 +-
 client/gatt.c  | 163 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 client/gatt.h  |   2 +
 client/main.c  |  12 +++++
 4 files changed, 154 insertions(+), 27 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index c0482fb..0fd6dec 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -9,8 +9,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/advertising.c \
 					client/gatt.h client/gatt.c \
 					monitor/uuid.h monitor/uuid.c
-client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
-				-lreadline
+client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
+				@GLIB_LIBS@ @DBUS_LIBS@ -lreadline
 endif
 
 if MONITOR
diff --git a/client/gatt.c b/client/gatt.c
index 2756efd..0533854 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -38,6 +38,7 @@
 #include <glib.h>
 
 #include "src/shared/queue.h"
+#include "src/shared/io.h"
 #include "gdbus/gdbus.h"
 #include "monitor/uuid.h"
 #include "display.h"
@@ -90,9 +91,13 @@ static GList *managers;
 static GList *uuids;
 
 static GDBusProxy *write_proxy;
-static int write_fd = -1;
+static struct io *write_io;
 static uint16_t write_mtu;
 
+static GDBusProxy *notify_proxy;
+static struct io *notify_io;
+static uint16_t notify_mtu;
+
 static void print_service(struct service *service, const char *description)
 {
 	const char *text;
@@ -229,6 +234,22 @@ void gatt_add_characteristic(GDBusProxy *proxy)
 	print_characteristic(proxy, COLORED_NEW);
 }
 
+static void notify_io_destroy(void)
+{
+	io_destroy(notify_io);
+	notify_io = NULL;
+	notify_proxy = NULL;
+	notify_mtu = 0;
+}
+
+static void write_io_destroy(void)
+{
+	io_destroy(write_io);
+	write_io = NULL;
+	write_proxy = NULL;
+	write_mtu = 0;
+}
+
 void gatt_remove_characteristic(GDBusProxy *proxy)
 {
 	GList *l;
@@ -241,14 +262,10 @@ void gatt_remove_characteristic(GDBusProxy *proxy)
 
 	print_characteristic(proxy, COLORED_DEL);
 
-	if (write_proxy == proxy) {
-		write_proxy = NULL;
-		write_mtu = 0;
-		if (write_fd > 0) {
-			close(write_fd);
-			write_fd = -1;
-		}
-	}
+	if (write_proxy == proxy)
+		write_io_destroy();
+	else if (notify_proxy == proxy)
+		notify_io_destroy();
 }
 
 static void print_desc(struct desc *desc, const char *description)
@@ -633,9 +650,9 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 	iov.iov_len = i;
 
 	/* Write using the fd if it has been acquired and fit the MTU */
-	if (proxy == write_proxy && (write_fd > 0 && write_mtu >= i)) {
-		rl_printf("Attempting to write fd %d\n", write_fd);
-		if (writev(write_fd, &iov, 1) < 0) {
+	if (proxy == write_proxy && (write_io && write_mtu >= i)) {
+		rl_printf("Attempting to write fd %d\n", io_get_fd(write_io));
+		if (io_send(write_io, &iov, 1) < 0) {
 			rl_printf("Failed to write: %s", strerror(errno));
 			return;
 		}
@@ -666,9 +683,57 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 						g_dbus_proxy_get_path(proxy));
 }
 
+static bool pipe_read(struct io *io, void *user_data)
+{
+	uint8_t buf[512];
+	int fd = io_get_fd(io);
+	ssize_t bytes_read;
+
+	if (io != notify_io)
+		return true;
+
+	bytes_read = read(fd, buf, sizeof(buf));
+	if (bytes_read < 0)
+		return false;
+
+	rl_printf("[" COLORED_CHG "] %s Notification:\n",
+			g_dbus_proxy_get_path(notify_proxy));
+	rl_hexdump(buf, bytes_read);
+
+	return true;
+}
+
+static bool pipe_hup(struct io *io, void *user_data)
+{
+	rl_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
+
+	if (io == notify_io)
+		notify_io_destroy();
+	else
+		write_io_destroy();
+
+	return false;
+}
+
+static struct io *pipe_io_new(int fd)
+{
+	struct io *io;
+
+	io = io_new(fd);
+
+	io_set_close_on_destroy(io, true);
+
+	io_set_read_handler(io, pipe_read, NULL, NULL);
+
+	io_set_disconnect_handler(io, pipe_hup, NULL, NULL);
+
+	return io;
+}
+
 static void acquire_write_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
+	int fd;
 
 	dbus_error_init(&error);
 
@@ -679,21 +744,19 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
-	if (write_fd > 0) {
-		close(write_fd);
-		write_fd = -1;
-	}
+	if (write_io)
+		write_io_destroy();
 
-	write_mtu = 0;
-
-	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &write_fd,
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
 					DBUS_TYPE_UINT16, &write_mtu,
 					DBUS_TYPE_INVALID) == false)) {
 		rl_printf("Invalid AcquireWrite response\n");
 		return;
 	}
 
-	rl_printf("AcquireWrite success: fd %d MTU %u\n", write_fd, write_mtu);
+	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
+
+	write_io = pipe_io_new(fd);
 }
 
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
@@ -718,15 +781,65 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 
 void gatt_release_write(GDBusProxy *proxy, const char *arg)
 {
-	if (proxy != write_proxy || write_fd < 0) {
+	if (proxy != write_proxy || !write_io) {
 		rl_printf("Write not acquired\n");
 		return;
 	}
 
-	write_proxy = NULL;
-	close(write_fd);
-	write_fd = -1;
-	write_mtu = 0;
+	write_io_destroy();
+}
+
+static void acquire_notify_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+	int fd;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to acquire notify: %s\n", error.name);
+		dbus_error_free(&error);
+		write_proxy = NULL;
+		return;
+	}
+
+	if (notify_io) {
+		io_destroy(notify_io);
+		notify_io = NULL;
+	}
+
+	notify_mtu = 0;
+
+	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_UINT16, &notify_mtu,
+					DBUS_TYPE_INVALID) == false)) {
+		rl_printf("Invalid AcquireWrite response\n");
+		return;
+	}
+
+	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_mtu);
+
+	notify_io = pipe_io_new(fd);
+}
+
+void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
+{
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (strcmp(iface, "org.bluez.GattCharacteristic1")) {
+		rl_printf("Unable to acquire notify: %s not a characteristic\n",
+						g_dbus_proxy_get_path(proxy));
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "AcquireNotify", NULL,
+				acquire_notify_reply, NULL, NULL) == FALSE) {
+		rl_printf("Failed to AcquireNotify\n");
+		return;
+	}
+
+	notify_proxy = proxy;
 }
 
 static void notify_reply(DBusMessage *message, void *user_data)
diff --git a/client/gatt.h b/client/gatt.h
index 6827057..5dba26b 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -41,6 +41,8 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg);
 void gatt_release_write(GDBusProxy *proxy, const char *arg);
 
+void gatt_acquire_notify(GDBusProxy *proxy, const char *arg);
+
 void gatt_add_manager(GDBusProxy *proxy);
 void gatt_remove_manager(GDBusProxy *proxy);
 
diff --git a/client/main.c b/client/main.c
index 7688a23..e0a265d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1819,6 +1819,16 @@ static void cmd_release_write(const char *arg)
 	gatt_release_write(default_attr, arg);
 }
 
+static void cmd_acquire_notify(const char *arg)
+{
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_acquire_notify(default_attr, arg);
+}
+
 static void cmd_notify(const char *arg)
 {
 	dbus_bool_t enable;
@@ -2298,6 +2308,8 @@ static const struct {
 					"Acquire Write file descriptor" },
 	{ "release-write", NULL, cmd_release_write,
 					"Release Write file descriptor" },
+	{ "acquire-notify", NULL, cmd_acquire_notify,
+					"Acquire Notify file descriptor" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
-- 
2.9.4

