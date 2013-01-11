Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] gdbus: Add g_dbus_proxy_get_client function
Date: Fri, 11 Jan 2013 13:50:13 +0200
Message-Id: <1357905018-23237-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is convenient as some callbacks don't provide the client which
the proxy belongs.
---
 gdbus/client.c | 8 ++++++++
 gdbus/gdbus.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index ea56023..3c5784b 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -478,6 +478,14 @@ const char *g_dbus_proxy_get_interface(GDBusProxy *proxy)
 	return proxy->interface;
 }
 
+GDBusClient *g_dbus_proxy_get_client(GDBusProxy *proxy)
+{
+	if (proxy == NULL)
+		return NULL;
+
+	return proxy->client;
+}
+
 gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
                                                         DBusMessageIter *iter)
 {
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 77bd069..83e41c7 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -313,6 +313,7 @@ void g_dbus_proxy_unref(GDBusProxy *proxy);
 
 const char *g_dbus_proxy_get_path(GDBusProxy *proxy);
 const char *g_dbus_proxy_get_interface(GDBusProxy *proxy);
+GDBusClient *g_dbus_proxy_get_client(GDBusProxy *proxy);
 
 gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 							DBusMessageIter *iter);
-- 
1.8.0.1

