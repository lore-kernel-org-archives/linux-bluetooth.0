Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v0 1/2] gdbus: Add helper function for error-handling
Date: Thu,  3 May 2012 11:44:34 +0200
Message-Id: <1336038275-19591-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The new function is a convenient way to create a D-Bus error message and
automatically free the GError object.
---
 gdbus/gdbus.h  |    4 ++++
 gdbus/object.c |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..485ee01 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -138,6 +138,10 @@ DBusMessage *g_dbus_create_error(DBusMessage *message, const char *name,
 					__attribute__((format(printf, 3, 4)));
 DBusMessage *g_dbus_create_error_valist(DBusMessage *message, const char *name,
 					const char *format, va_list args);
+
+DBusMessage *g_dbus_steal_from_gerror(DBusMessage *message, const char *name,
+						GError **err);
+
 DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...);
 DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
 						int type, va_list args);
diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..c6e5550 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -765,6 +765,17 @@ DBusMessage *g_dbus_create_error(DBusMessage *message, const char *name,
 	return reply;
 }
 
+DBusMessage *g_dbus_steal_from_gerror(DBusMessage *message, const char *name,
+								GError **err)
+{
+	DBusMessage *reply;
+
+	reply = g_dbus_create_error(message, name, "%s", (*err)->message);
+	g_clear_error(err);
+
+	return reply;
+}
+
 DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
 						int type, va_list args)
 {
-- 
1.7.7.6

