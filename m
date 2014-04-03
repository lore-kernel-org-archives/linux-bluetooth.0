Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] client: Add support for printing property of array type
Date: Thu,  3 Apr 2014 23:57:58 +0200
Message-Id: <1396562278-30114-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to print UUIDs in user friendly fasion. Only string type
support is needed.

[CHG] Device XX:XX:XX:XX:XX:XX UUIDs:
        00000002-0000-1000-8000-0002ee000002
        00001101-0000-1000-8000-00805f9b34fb
        00001103-0000-1000-8000-00805f9b34fb
        00001104-0000-1000-8000-00805f9b34fb
        00001105-0000-1000-8000-00805f9b34fb

instead of:

[CHG] Device XX:XX:XX:XX:XX:XX UUIDs has unsupported type
---
 client/main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/client/main.c b/client/main.c
index 5791e95..5a9d41a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <signal.h>
 #include <sys/signalfd.h>
 
@@ -153,6 +154,8 @@ static void print_iter(const char *label, const char *name,
 	dbus_uint16_t valu16;
 	dbus_int16_t vals16;
 	const char *valstr;
+	DBusMessageIter subiter;
+	int type;
 
 	if (iter == NULL) {
 		rl_printf("%s%s is nil\n", label, name);
@@ -185,6 +188,24 @@ static void print_iter(const char *label, const char *name,
 		dbus_message_iter_get_basic(iter, &vals16);
 		rl_printf("%s%s: %d\n", label, name, vals16);
 		break;
+	case DBUS_TYPE_ARRAY:
+		dbus_message_iter_recurse(iter, &subiter);
+		rl_printf("%s%s:\n", label, name);
+
+		do {
+			type = dbus_message_iter_get_arg_type(&subiter);
+			if (type == DBUS_TYPE_INVALID)
+				break;
+
+			if (type == DBUS_TYPE_STRING) {
+				dbus_message_iter_get_basic(&subiter, &valstr);
+				rl_printf("\t%s\n", valstr);
+			}
+
+			dbus_message_iter_next(&subiter);
+		} while(true);
+
+		break;
 	default:
 		rl_printf("%s%s has unsupported type\n", label, name);
 		break;
-- 
1.9.1

