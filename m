Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] client: Fix no handling dict properly
Date: Wed, 15 Apr 2015 14:44:23 +0300
Message-Id: <1429098268-9695-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

D-Bus dict may contain keys that are not of string type.
---
 client/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index bb67f3d..1e76aef 100644
--- a/client/main.c
+++ b/client/main.c
@@ -162,6 +162,7 @@ static void print_iter(const char *label, const char *name,
 	unsigned char byte;
 	const char *valstr;
 	DBusMessageIter subiter;
+	char *entry;
 
 	if (iter == NULL) {
 		rl_printf("%s%s is nil\n", label, name);
@@ -212,9 +213,14 @@ static void print_iter(const char *label, const char *name,
 		break;
 	case DBUS_TYPE_DICT_ENTRY:
 		dbus_message_iter_recurse(iter, &subiter);
-		dbus_message_iter_get_basic(&subiter, &valstr);
+		entry = g_strconcat(name, " Key", NULL);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
+
+		entry = g_strconcat(name, " Value", NULL);
 		dbus_message_iter_next(&subiter);
-		print_iter(label, valstr, &subiter);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
 		break;
 	default:
 		rl_printf("%s%s has unsupported type\n", label, name);
-- 
2.1.0

