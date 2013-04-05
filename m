Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 04/11] device: Find services instead of profiles
Date: Fri,  5 Apr 2013 13:45:41 +0200
Message-Id: <1365162348-25541-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1365162348-25541-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially replace the former find_connectable_profile() with
find_connectable_service().
---
 src/device.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0d73ce2..c24c82b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1198,7 +1198,7 @@ static int device_resolve_svc(struct btd_device *dev, DBusMessage *msg)
 		return device_browse_primary(dev, msg, FALSE);
 }
 
-static struct btd_profile *find_connectable_profile(struct btd_device *dev,
+static struct btd_service *find_connectable_service(struct btd_device *dev,
 							const char *uuid)
 {
 	GSList *l;
@@ -1211,7 +1211,7 @@ static struct btd_profile *find_connectable_profile(struct btd_device *dev,
 			continue;
 
 		if (strcasecmp(uuid, p->remote_uuid) == 0)
-			return p;
+			return service;
 	}
 
 	return NULL;
@@ -1248,10 +1248,11 @@ static DBusMessage *connect_profiles(struct btd_device *dev, DBusMessage *msg,
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
@@ -1367,7 +1368,6 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	const char *pattern;
 	char *uuid;
 	int err;
-	GSList *l;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 							DBUS_TYPE_INVALID))
@@ -1377,14 +1377,13 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (uuid == NULL)
 		return btd_error_invalid_args(msg);
 
-	p = find_connectable_profile(dev, uuid);
+	service = find_connectable_service(dev, uuid);
 	g_free(uuid);
 
-	if (!p)
+	if (!service)
 		return btd_error_invalid_args(msg);
 
-	l = g_slist_find_custom(dev->services, p, service_profile_cmp);
-	service = l->data;
+	p = btd_service_get_profile(service);
 
 	if (!p->disconnect)
 		return btd_error_not_supported(msg);
-- 
1.8.1.4

