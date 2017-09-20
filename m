Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/10] client: Rework variables for AcquireWrite/AcquireNotify
Date: Wed, 20 Sep 2017 10:44:09 +0300
Message-Id: <20170920074417.30435-3-luiz.dentz@gmail.com>
In-Reply-To: <20170920074417.30435-1-luiz.dentz@gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This creates a struct with necessary fields which is easier to reset.
---
 client/gatt.c | 80 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 753038303..ab74aa695 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -90,13 +90,14 @@ static GList *descriptors;
 static GList *managers;
 static GList *uuids;
 
-static GDBusProxy *write_proxy;
-static struct io *write_io;
-static uint16_t write_mtu;
+struct pipe_io {
+	GDBusProxy *proxy;
+	struct io *io;
+	uint16_t mtu;
+};
 
-static GDBusProxy *notify_proxy;
-static struct io *notify_io;
-static uint16_t notify_mtu;
+static struct pipe_io write_io;
+static struct pipe_io notify_io;
 
 static void print_service(struct service *service, const char *description)
 {
@@ -236,18 +237,14 @@ void gatt_add_characteristic(GDBusProxy *proxy)
 
 static void notify_io_destroy(void)
 {
-	io_destroy(notify_io);
-	notify_io = NULL;
-	notify_proxy = NULL;
-	notify_mtu = 0;
+	io_destroy(notify_io.io);
+	memset(&notify_io, 0, sizeof(notify_io));
 }
 
 static void write_io_destroy(void)
 {
-	io_destroy(write_io);
-	write_io = NULL;
-	write_proxy = NULL;
-	write_mtu = 0;
+	io_destroy(write_io.io);
+	memset(&write_io, 0, sizeof(write_io));
 }
 
 void gatt_remove_characteristic(GDBusProxy *proxy)
@@ -262,9 +259,9 @@ void gatt_remove_characteristic(GDBusProxy *proxy)
 
 	print_characteristic(proxy, COLORED_DEL);
 
-	if (write_proxy == proxy)
+	if (write_io.proxy == proxy)
 		write_io_destroy();
-	else if (notify_proxy == proxy)
+	else if (notify_io.proxy == proxy)
 		notify_io_destroy();
 }
 
@@ -650,9 +647,10 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 	iov.iov_len = i;
 
 	/* Write using the fd if it has been acquired and fit the MTU */
-	if (proxy == write_proxy && (write_io && write_mtu >= i)) {
-		rl_printf("Attempting to write fd %d\n", io_get_fd(write_io));
-		if (io_send(write_io, &iov, 1) < 0) {
+	if (proxy == write_io.proxy && (write_io.io && write_io.mtu >= i)) {
+		rl_printf("Attempting to write fd %d\n",
+						io_get_fd(write_io.io));
+		if (io_send(write_io.io, &iov, 1) < 0) {
 			rl_printf("Failed to write: %s", strerror(errno));
 			return;
 		}
@@ -689,7 +687,7 @@ static bool pipe_read(struct io *io, void *user_data)
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
 
-	if (io != notify_io)
+	if (io != notify_io.io)
 		return true;
 
 	bytes_read = read(fd, buf, sizeof(buf));
@@ -697,7 +695,7 @@ static bool pipe_read(struct io *io, void *user_data)
 		return false;
 
 	rl_printf("[" COLORED_CHG "] %s Notification:\n",
-			g_dbus_proxy_get_path(notify_proxy));
+			g_dbus_proxy_get_path(notify_io.proxy));
 	rl_hexdump(buf, bytes_read);
 
 	return true;
@@ -705,9 +703,9 @@ static bool pipe_read(struct io *io, void *user_data)
 
 static bool pipe_hup(struct io *io, void *user_data)
 {
-	rl_printf("%s closed\n", io == notify_io ? "Notify" : "Write");
+	rl_printf("%s closed\n", io == notify_io.io ? "Notify" : "Write");
 
-	if (io == notify_io)
+	if (io == notify_io.io)
 		notify_io_destroy();
 	else
 		write_io_destroy();
@@ -740,23 +738,23 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		rl_printf("Failed to acquire write: %s\n", error.name);
 		dbus_error_free(&error);
-		write_proxy = NULL;
+		write_io.proxy = NULL;
 		return;
 	}
 
-	if (write_io)
+	if (write_io.io)
 		write_io_destroy();
 
 	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
-					DBUS_TYPE_UINT16, &write_mtu,
+					DBUS_TYPE_UINT16, &write_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
 		rl_printf("Invalid AcquireWrite response\n");
 		return;
 	}
 
-	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_mtu);
+	rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_io.mtu);
 
-	write_io = pipe_io_new(fd);
+	write_io.io = pipe_io_new(fd);
 }
 
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
@@ -776,12 +774,12 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	write_proxy = proxy;
+	write_io.proxy = proxy;
 }
 
 void gatt_release_write(GDBusProxy *proxy, const char *arg)
 {
-	if (proxy != write_proxy || !write_io) {
+	if (proxy != write_io.proxy || !write_io.io) {
 		rl_printf("Write not acquired\n");
 		return;
 	}
@@ -799,27 +797,27 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
 		rl_printf("Failed to acquire notify: %s\n", error.name);
 		dbus_error_free(&error);
-		write_proxy = NULL;
+		write_io.proxy = NULL;
 		return;
 	}
 
-	if (notify_io) {
-		io_destroy(notify_io);
-		notify_io = NULL;
+	if (notify_io.io) {
+		io_destroy(notify_io.io);
+		notify_io.io = NULL;
 	}
 
-	notify_mtu = 0;
+	notify_io.mtu = 0;
 
 	if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd,
-					DBUS_TYPE_UINT16, &notify_mtu,
+					DBUS_TYPE_UINT16, &notify_io.mtu,
 					DBUS_TYPE_INVALID) == false)) {
 		rl_printf("Invalid AcquireNotify response\n");
 		return;
 	}
 
-	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_mtu);
+	rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_io.mtu);
 
-	notify_io = pipe_io_new(fd);
+	notify_io.io = pipe_io_new(fd);
 }
 
 void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
@@ -839,13 +837,13 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	notify_proxy = proxy;
+	notify_io.proxy = proxy;
 }
 
 void gatt_release_notify(GDBusProxy *proxy, const char *arg)
 {
-	if (proxy != notify_proxy || !notify_io) {
-		rl_printf("Write not acquired\n");
+	if (proxy != notify_io.proxy || !notify_io.io) {
+		rl_printf("Notify not acquired\n");
 		return;
 	}
 
-- 
2.13.5

