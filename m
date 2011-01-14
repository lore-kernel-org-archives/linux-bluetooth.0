Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v0 1/2] gdbus: invaldate_parent_data: walk the whole path down
Date: Fri, 14 Jan 2011 16:14:20 +0100
Message-Id: <1295018061-5849-2-git-send-email-wagi@monom.org>
In-Reply-To: <1295018061-5849-1-git-send-email-wagi@monom.org>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Assume there is only one object registerd at "/". If we add a new
object at "/foo/bar" the introspection of "/" has to be updated. A new
node has to be added at "/".

invalidate_parent_data stops invaldating the whole path because the
boolean return value of dbus_connection_get_object_path_data is used
wrong.

If we get a TRUE just go on down in the path, if FALSE is return
dbus_connection_get_object_path_data has run out of memory.
---
 gdbus/object.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index afa904e..49006ec 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -475,12 +475,13 @@ static void invalidate_parent_data(DBusConnection *conn, const char *child_path)
 	if (!strlen(parent_path))
 		goto done;
 
-	if (!dbus_connection_get_object_path_data(conn, parent_path,
-							(void *) &data)) {
-		invalidate_parent_data(conn, parent_path);
+	if (dbus_connection_get_object_path_data(conn, parent_path,
+							(void *) &data) == FALSE) {
 		goto done;
 	}
 
+	invalidate_parent_data(conn, parent_path);
+
 	if (data == NULL)
 		goto done;
 
-- 
1.7.3.4

