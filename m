Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 17/27] device: Find services instead of profiles
Date: Fri, 26 Apr 2013 08:17:13 +0200
Message-Id: <1366957043-2383-18-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially replace the former find_connectable_profile() with
find_connectable_service().
---
 src/device.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2e91499..a5301df 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1177,7 +1177,7 @@ static int device_resolve_svc(struct btd_device *dev, DBusMessage *msg)
 		return device_browse_primary(dev, msg, FALSE);
 }
 
-static struct btd_profile *find_connectable_profile(struct btd_device *dev,
+static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
 	GSList *l;
@@ -1190,7 +1190,7 @@ static struct btd_profile *find_connectable_profile(struct btd_device *dev,
 			continue;
 
 		if (strcasecmp(uuid, p->remote_uuid) == 0)
-			return p;
+			return service;
 	}
 
 	return NULL;
@@ -1227,10 +1227,11 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
 	}
 
 	if (uuid) {
-		p = find_connectable_profile(dev, uuid);
-		if (!p)
+		service = find_connectable_service(dev, uuid);
+		if (!service)
 			return btd_error_invalid_args(msg);
 
+		p = btd_service_get_profile(service);
 		dev->pending = g_slist_prepend(dev->pending, p);
 
 		goto start_connect;
@@ -1341,9 +1342,7 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *dev = user_data;
-	struct btd_profile *p;
 	struct btd_service *service;
-	GSList *l;
 	const char *pattern;
 	char *uuid;
 	int err;
@@ -1356,15 +1355,12 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (uuid == NULL)
 		return btd_error_invalid_args(msg);
 
-	p = find_connectable_profile(dev, uuid);
+	service = find_connectable_service(dev, uuid);
 	g_free(uuid);
 
-	if (!p)
+	if (!service)
 		return btd_error_invalid_args(msg);
 
-	l = find_service_with_profile(dev->services, p);
-	service = l->data;
-
 	err = btd_service_disconnect(service);
 	if (err == 0) {
 		dev->disconnect = dbus_message_ref(msg);
-- 
1.8.1.4

