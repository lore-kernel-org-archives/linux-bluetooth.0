Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ 2/5] Add get Link Loss Alert Level
Date: Tue, 26 Jul 2011 13:53:13 -0300
Message-Id: <1311699196-16472-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

---
 proximity/monitor.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 50594f7..7ec1b4c 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -26,8 +26,10 @@
 #include <config.h>
 #endif
 
+#include <stdint.h>
 #include <gdbus.h>
 
+#include "dbus-common.h"
 #include "error.h"
 #include "log.h"
 
@@ -61,7 +63,28 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	return dbus_message_new_method_return(msg);
+	struct monitor *monitor = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "LinkLossAlertLevel",
+			DBUS_TYPE_STRING, &monitor->linklosslevel);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 
 static DBusMessage *set_property(DBusConnection *conn,
-- 
1.7.6

