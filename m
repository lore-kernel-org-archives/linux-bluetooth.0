Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/10] client: Add release-notify command
Date: Mon,  3 Jul 2017 15:11:48 +0300
Message-Id: <20170703121148.24299-11-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds release-notify command which closes an existing fd unlocking
the attribute:

[Test peripheral:/service001f/char0020]# release-notify
[CHG] Attribute /org/bluez/hci1/dev_69_16_5B_9A_06_CD/service001f/char0020 NotifyLocked: no
---
 client/gatt.c | 10 ++++++++++
 client/gatt.h |  1 +
 client/main.c | 12 ++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 0533854..33e8936 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -842,6 +842,16 @@ void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
 	notify_proxy = proxy;
 }
 
+void gatt_release_notify(GDBusProxy *proxy, const char *arg)
+{
+	if (proxy != notify_proxy || !notify_io) {
+		rl_printf("Write not acquired\n");
+		return;
+	}
+
+	notify_io_destroy();
+}
+
 static void notify_reply(DBusMessage *message, void *user_data)
 {
 	bool enable = GPOINTER_TO_UINT(user_data);
diff --git a/client/gatt.h b/client/gatt.h
index 5dba26b..9bab429 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -42,6 +42,7 @@ void gatt_acquire_write(GDBusProxy *proxy, const char *arg);
 void gatt_release_write(GDBusProxy *proxy, const char *arg);
 
 void gatt_acquire_notify(GDBusProxy *proxy, const char *arg);
+void gatt_release_notify(GDBusProxy *proxy, const char *arg);
 
 void gatt_add_manager(GDBusProxy *proxy);
 void gatt_remove_manager(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index e0a265d..8f75f0e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1829,6 +1829,16 @@ static void cmd_acquire_notify(const char *arg)
 	gatt_acquire_notify(default_attr, arg);
 }
 
+static void cmd_release_notify(const char *arg)
+{
+	if (!default_attr) {
+		rl_printf("No attribute selected\n");
+		return;
+	}
+
+	gatt_release_notify(default_attr, arg);
+}
+
 static void cmd_notify(const char *arg)
 {
 	dbus_bool_t enable;
@@ -2310,6 +2320,8 @@ static const struct {
 					"Release Write file descriptor" },
 	{ "acquire-notify", NULL, cmd_acquire_notify,
 					"Acquire Notify file descriptor" },
+	{ "release-notify", NULL, cmd_release_notify,
+					"Release Notify file descriptor" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
-- 
2.9.4

