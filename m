Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 17/18] Add GetProperties method the Service Interface
Date: Tue, 21 Dec 2010 19:26:39 -0200
Message-Id: <1292966800-6264-18-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now this interface just includes the path that each characteristic
is registered at.
---
 attrib/client.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index e717eaa..10bbf7d 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -941,12 +941,51 @@ static DBusMessage *discover_char(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *prim_get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct primary *prim = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	GSList *l;
+	char **chars;
+	int i;
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
+	chars = g_new0(char *, g_slist_length(prim->chars) + 1);
+
+	for (i = 0, l = prim->chars; l; l = l->next, i++) {
+		struct characteristic *chr = l->data;
+		chars[i] = chr->path;
+	}
+
+	dict_append_array(&dict, "Characteristics", DBUS_TYPE_OBJECT_PATH,
+								&chars, i);
+	g_free(chars);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
 static GDBusMethodTable prim_methods[] = {
 	{ "Discover",		"",	"",		discover_char	},
 	{ "RegisterCharacteristicsWatcher",	"o", "",
 						register_watcher	},
 	{ "UnregisterCharacteristicsWatcher",	"o", "",
 						unregister_watcher	},
+	{ "GetProperties",	"",	"a{sv}",prim_get_properties	},
 	{ }
 };
 
-- 
1.7.3.4

