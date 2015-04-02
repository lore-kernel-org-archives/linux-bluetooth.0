Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v9 11/12] gdbus: Add g_dbus_get_flags function
Date: Thu,  2 Apr 2015 11:59:27 -0700
Message-Id: <1428001168-32822-12-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The g_dbus_get_flags function enables detection of when the
G_DBUS_FLAG_ENABLE_EXPERIMENTAL is set.
---
 gdbus/gdbus.h  | 1 +
 gdbus/object.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 9814838..d99c254 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -216,6 +216,7 @@ struct GDBusSecurityTable {
 	.flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL
 
 void g_dbus_set_flags(int flags);
+int g_dbus_get_flags(void);
 
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
diff --git a/gdbus/object.c b/gdbus/object.c
index 4d5a64c..b62c062 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1816,3 +1816,8 @@ void g_dbus_set_flags(int flags)
 {
 	global_flags = flags;
 }
+
+int g_dbus_get_flags(void)
+{
+	return global_flags;
+}
-- 
2.2.0.rc0.207.ga3a616c

