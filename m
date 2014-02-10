Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] gdbus: Fix memory leak
Date: Mon, 10 Feb 2014 13:14:56 -0400
Message-Id: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

data->conn and data->path must be destroyed before freeing "data".
---
 gdbus/object.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index b248cbb..13cf9a9 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1253,6 +1253,8 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 
 	if (!dbus_connection_register_object_path(connection, path,
 						&generic_table, data)) {
+		dbus_connection_unref(data->conn);
+		g_free(data->path);
 		g_free(data->introspect);
 		g_free(data);
 		return NULL;
-- 
1.7.9.5

