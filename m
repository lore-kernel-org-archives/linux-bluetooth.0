Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/10] client: Add release-write command
Date: Mon,  3 Jul 2017 15:11:44 +0300
Message-Id: <20170703121148.24299-7-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds release-write command which closes an existing fd unlocking
the attribute:

[Test peripheral:/service001f/char0020]# release-write
[CHG] Attribute /org/bluez/hci1/dev_00_1B_DC_07_31_88/service001f/char0020 WriteLocked: no
---
 client/gatt.c | 13 +++++++++++++
 client/gatt.h |  1 +
 client/main.c | 12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index e6f37ae..2756efd 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -716,6 +716,19 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
 	write_proxy = proxy;
 }
 
+void gatt_release_write(GDBusProxy *proxy, const char *arg)
+{
+	if (proxy != write_proxy || write_fd < 0) {
+		rl_printf("Write not acquired\n");
+		return;
+	}
+
+	write_proxy = NULL;
+	close(write_fd);
+	write_fd = -1;
+	write_mtu = 0;
+}
+
 static void notify_reply(DBusMessage *message, void *user_data)
 {
 	bool enable = GPOINTER_TO_UINT(user_data);
diff --git a/client/gatt.h b/client/gatt.h
index 713d34f..6827057 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -39,6 +39,7 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg);
 void gatt_notify_attribute(GDBusProxy *proxy, bool enable);
 
 void gatt_acquire_write(GDBusProxy *proxy, const char *arg);
+void gatt_release_write(GDBusProxy *proxy, const char *arg);
 
 void gatt_add_manager(GDBusProxy *proxy);
 void gatt_remove_manager(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index 79f61a1..7688a23 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1809,6 +1809,16 @@ static void cmd_acquire_write(const char *arg)
 	gatt_acquire_write(default_attr, arg);
 }
 
+static void cmd_release_write(const char *arg)
+{
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_release_write(default_attr, arg);
+}
+
 static void cmd_notify(const char *arg)
 {
 	dbus_bool_t enable;
@@ -2286,6 +2296,8 @@ static const struct {
 						"Write attribute value" },
 	{ "acquire-write", NULL, cmd_acquire_write,
 					"Acquire Write file descriptor" },
+	{ "release-write", NULL, cmd_release_write,
+					"Release Write file descriptor" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
-- 
2.9.4

