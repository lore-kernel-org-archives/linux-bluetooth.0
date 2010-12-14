Return-Path: <cyrus@holtmann.org>
From: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Subject: [PATCH] Error should be returned instead of unnecessary dict_append_array()
Date: Tue, 14 Dec 2010 15:20:27 +0100
Message-Id: <1292336427-20380-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there are no adapter up and running, there would be
no elements to be added using dict_append_array(). We
should return DBus error ".DoesNotExist", rather than
appending NULL pointer and zero elements.

On behalf of ST-Ericsson SA
---
 src/manager.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index c8ec7e5..9060180 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -185,12 +185,21 @@ static DBusMessage *get_properties(DBusConnection *conn,
 		array[i] = (char *) adapter_get_path(adapter);
 		i++;
 	}
+
+	if (!i)
+		goto error;
+
 	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
 	g_free(array);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
+
+error:
+	g_free(array);
+	g_free(reply);
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist", "Adapter does not exist");
 }
 
 static GDBusMethodTable manager_methods[] = {
-- 
1.7.0.4

