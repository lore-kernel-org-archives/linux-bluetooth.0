Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC] gdbus: Process changes upon ObjectManager.GetManagedObjects
Date: Thu,  3 Jan 2013 23:50:34 -0200
Message-Id: <1357264234-20429-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

If ObjectManager.GetManagedObjects is called, we need to flush all
pending signals for interfaces added/removed, otherwise we might answer
the method saying an interface exists but never send a signal when it's
removed.
---

It's an RFC because it's untested. If anyone can write a proper unit test for
this, it would be good. Otherwise I can probably do it in the weekend.

 gdbus/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2b6ae31..3d9ab5f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1108,6 +1108,11 @@ static DBusMessage *get_objects(DBusConnection *connection,
 	if (reply == NULL)
 		return NULL;
 
+	if (data->process_id > 0) {
+		g_source_remove(data->process_id);
+		process_changes(data);
+	}
+
 	dbus_message_iter_init_append(reply, &iter);
 
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-- 
1.8.1

