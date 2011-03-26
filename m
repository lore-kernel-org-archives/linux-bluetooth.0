Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/6] Register Attrib interface when loading device from storage
Date: Fri, 25 Mar 2011 21:01:09 -0300
Message-Id: <1301097673-5262-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301097673-5262-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that the GATT client functionality is being moved to the
core we need to register the interface when the device is created.
---
 attrib/client.c |    3 +--
 attrib/client.h |    2 +-
 src/adapter.c   |    4 ++++
 src/device.c    |    3 +++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 54bdc79..590f33b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1044,12 +1044,11 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 	}
 }
 
-int attrib_client_register(struct btd_device *device, int psm)
+int attrib_client_register(struct btd_device *device, int psm, GSList *primaries)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
 	struct gatt_service *gatt;
-	GSList *primaries = btd_device_get_primaries(device);
 	bdaddr_t sba, dba;
 
 	adapter_get_address(adapter, &sba);
diff --git a/attrib/client.h b/attrib/client.h
index 50e2b5f..2bee84c 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -24,5 +24,5 @@
 
 int attrib_client_init(DBusConnection *conn);
 void attrib_client_exit(void);
-int attrib_client_register(struct btd_device *device, int psm);
+int attrib_client_register(struct btd_device *device, int psm, GSList *primaries);
 void attrib_client_unregister(struct btd_device *device);
diff --git a/src/adapter.c b/src/adapter.c
index 691b963..56105c7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -58,6 +58,7 @@
 #include "storage.h"
 #include "attrib-server.h"
 #include "att.h"
+#include "attrib/client.h"
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -2180,6 +2181,9 @@ static void create_stored_device_from_primary(char *key, char *value,
 		device_add_primary(device, prim);
 	}
 
+	/* FIXME: Need the correct psm */
+	attrib_client_register(device, -1, services);
+
 	device_probe_drivers(device, uuids);
 
 	g_slist_free(services);
diff --git a/src/device.c b/src/device.c
index 771a908..9a3202f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -60,6 +60,7 @@
 #include "sdp-xml.h"
 #include "storage.h"
 #include "btio.h"
+#include "attrib/client.h"
 
 #define DISCONNECT_TIMER	2
 #define DISCOVERY_TIMER		2
@@ -1030,6 +1031,8 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	g_slist_free(device->drivers);
 	device->drivers = NULL;
 
+	attrib_client_unregister(device);
+
 	btd_device_unref(device);
 }
 
-- 
1.7.4.1

