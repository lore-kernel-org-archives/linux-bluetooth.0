Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/6] Add support for re-using the attrib channel
Date: Fri, 25 Mar 2011 21:01:12 -0300
Message-Id: <1301097673-5262-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases, when the device is already connected there's no need
to create another GAttrib instance.

This will allow the Attrib client to use the connection already
estabilished, this will be very useful when we support more
LE profiles.
---
 attrib/client.c |    6 +++++-
 attrib/client.h |    3 ++-
 src/adapter.c   |    3 ++-
 src/device.c    |    2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index acd35f9..28e5704 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1046,7 +1046,8 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 }
 
 int attrib_client_register(DBusConnection *connection,
-		struct btd_device *device, int psm, GSList *primaries)
+					struct btd_device *device, int psm,
+					GAttrib *attrib, GSList *primaries)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
@@ -1065,6 +1066,9 @@ int attrib_client_register(DBusConnection *connection,
 	bacpy(&gatt->dba, &dba);
 	gatt->psm = psm;
 
+	if (attrib)
+		gatt->attrib = g_attrib_ref(attrib);
+
 	register_primaries(gatt, primaries);
 
 	gatt_services = g_slist_append(gatt_services, gatt);
diff --git a/attrib/client.h b/attrib/client.h
index 650b0c1..b4a4ecc 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -23,5 +23,6 @@
  */
 
 int attrib_client_register(DBusConnection *connection,
-		struct btd_device *device, int psm, GSList *primaries);
+					struct btd_device *device, int psm,
+					GAttrib *attrib, GSList *primaries);
 void attrib_client_unregister(struct btd_device *device);
diff --git a/src/adapter.c b/src/adapter.c
index 124252a..0af0877 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -58,6 +58,7 @@
 #include "storage.h"
 #include "attrib-server.h"
 #include "att.h"
+#include "gattrib.h"
 #include "attrib/client.h"
 
 /* Flags Descriptions */
@@ -2182,7 +2183,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 	}
 
 	/* FIXME: Need the correct psm */
-	attrib_client_register(connection, device, -1, services);
+	attrib_client_register(connection, device, -1, NULL, services);
 
 	device_probe_drivers(device, uuids);
 
diff --git a/src/device.c b/src/device.c
index 511c9d0..fa5764e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1548,7 +1548,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_probe_drivers(device, uuids);
 
 	/* FIXME: Need the correct psm */
-	attrib_client_register(req->conn, device, -1, services);
+	attrib_client_register(req->conn, device, -1, req->attrib, services);
 
 	g_slist_free(uuids);
 
-- 
1.7.4.1

