Return-Path: <cyrus@holtmann.org>
From: ext-tommi.keisala@nokia.com
To: linux-bluetooth@vger.kernel.org
Cc: Tommi Keisala <ext-tommi.keisala@nokia.com>
Subject: [PATCH] Fix crash when GetProperties req is received before any adapters are set up
Date: Fri, 22 Oct 2010 13:32:38 +0300
Message-Id: <1287743558-17002-2-git-send-email-ext-tommi.keisala@nokia.com>
In-Reply-To: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
References: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tommi Keisala <ext-tommi.keisala@nokia.com>

This patch avoids a crash when org.bluez.Manager GetProperties request is
received and there is not yet any adapters ready. Happens often for example
when bluetoothd and ofonod is started next ot each other.

Signed-off-by: Tommi Keisala <ext-tommi.keisala@nokia.com>
---
 src/manager.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index aff069c..8967691 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -184,6 +184,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	GSList *list;
 	char **array;
 	int i;
+	int n_elements;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -197,6 +198,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	array = g_new0(char *, g_slist_length(adapters) + 1);
+	n_elements = 0;
 	for (i = 0, list = adapters; list; list = list->next, i++) {
 		struct btd_adapter *adapter = list->data;
 
@@ -204,8 +206,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 			continue;
 
 		array[i] = (char *) adapter_get_path(adapter);
+		n_elements++;
 	}
-	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
+	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array,
+			n_elements);
 	g_free(array);
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.0.4

