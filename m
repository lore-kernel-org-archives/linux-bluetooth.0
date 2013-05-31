Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/14] client/bluetooth-player: Add support for container types to print_iter
Date: Fri, 31 May 2013 13:55:39 +0300
Message-Id: <1369997749-8663-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
References: <1369997749-8663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for container types to print_iter so it can now print
'Track' property properly.
---
 client/bluetooth-player.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/client/bluetooth-player.c b/client/bluetooth-player.c
index 6525cf3..e954be0 100644
--- a/client/bluetooth-player.c
+++ b/client/bluetooth-player.c
@@ -365,6 +365,7 @@ static void print_iter(const char *label, const char *name,
 	dbus_uint16_t valu16;
 	dbus_int16_t vals16;
 	const char *valstr;
+	DBusMessageIter subiter;
 
 	if (iter == NULL) {
 		rl_printf("%s%s is nil\n", label, name);
@@ -397,6 +398,24 @@ static void print_iter(const char *label, const char *name,
 		dbus_message_iter_get_basic(iter, &vals16);
 		rl_printf("%s%s: %d\n", label, name, vals16);
 		break;
+	case DBUS_TYPE_VARIANT:
+		dbus_message_iter_recurse(iter, &subiter);
+		print_iter(label, name, &subiter);
+		break;
+	case DBUS_TYPE_ARRAY:
+		dbus_message_iter_recurse(iter, &subiter);
+		while (dbus_message_iter_get_arg_type(&subiter) !=
+							DBUS_TYPE_INVALID) {
+			print_iter(label, name, &subiter);
+			dbus_message_iter_next(&subiter);
+		}
+		break;
+	case DBUS_TYPE_DICT_ENTRY:
+		dbus_message_iter_recurse(iter, &subiter);
+		dbus_message_iter_get_basic(&subiter, &valstr);
+		dbus_message_iter_next(&subiter);
+		print_iter(label, valstr, &subiter);
+		break;
 	default:
 		rl_printf("%s%s has unsupported type\n", label, name);
 		break;
-- 
1.8.1.4

