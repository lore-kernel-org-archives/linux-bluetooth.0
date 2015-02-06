Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] client: Handle attribute notifications
Date: Fri,  6 Feb 2015 13:03:44 +0200
Message-Id: <1423220624-18861-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable printing properties changes to the current selected
attribute.
---
 client/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/client/main.c b/client/main.c
index 57b1201..fbfd8c8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -158,6 +158,7 @@ static void print_iter(const char *label, const char *name,
 	dbus_uint32_t valu32;
 	dbus_uint16_t valu16;
 	dbus_int16_t vals16;
+	unsigned char byte;
 	const char *valstr;
 	DBusMessageIter subiter;
 
@@ -192,6 +193,10 @@ static void print_iter(const char *label, const char *name,
 		dbus_message_iter_get_basic(iter, &vals16);
 		rl_printf("%s%s: %d\n", label, name, vals16);
 		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_basic(iter, &byte);
+		rl_printf("%s%s: 0x%02x\n", label, name, byte);
+		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
 		print_iter(label, name, &subiter);
@@ -494,6 +499,14 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 		print_iter(str, name, iter);
 		g_free(str);
+	} else if (proxy == default_attr) {
+		char *str;
+
+		str = g_strdup_printf("[" COLORED_CHG "] Attribute %s ",
+						g_dbus_proxy_get_path(proxy));
+
+		print_iter(str, name, iter);
+		str = g_strdup("");
 	}
 }
 
-- 
2.1.0

