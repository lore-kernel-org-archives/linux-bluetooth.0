Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH BlueZ] Store LE device address type with primary list
Date: Thu, 19 Apr 2012 17:18:31 +0530
Message-ID: <1334836112-25482-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the address type used for re-creating device from primary
service database.
---
 src/adapter.c |    8 ++++++--
 src/device.c  |    9 +++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 12b6aeb..e51a5ab 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1920,13 +1920,17 @@ static void create_stored_device_from_primary(char *key, char *value,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
 	GSList *services, *uuids, *l;
+	addr_type_t addr_type;
 
 	if (g_slist_find_custom(adapter->devices,
 			key, (GCompareFunc) device_address_cmp))
 		return;
 
-	/* FIXME: Get the correct LE addr type (public/random) */
-	device = device_create(connection, adapter, key, ADDR_TYPE_LE_PUBLIC);
+	sscanf(value, "%d ", &addr_type);
+	/* Increment by 2 (address type and space) */
+	value += 2;
+
+	device = device_create(connection, adapter, key, addr_type);
 	if (!device)
 		return;
 
diff --git a/src/device.c b/src/device.c
index ea6fec2..9c15d28 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1748,14 +1748,19 @@ static void store_services(struct btd_device *device)
 {
 	struct btd_adapter *adapter = device->adapter;
 	bdaddr_t dba, sba;
-	char *str = primary_list_to_string(device->primaries);
+	addr_type_t addr_type;
+	char *primary = primary_list_to_string(device->primaries);
+	/* Allocate extra space for address type, space and \0 */
+	char *str = g_malloc(strlen(primary) + 2 + 1);
 
 	adapter_get_address(adapter, &sba);
-	device_get_address(device, &dba, NULL);
+	device_get_address(device, &dba, &addr_type);
+	sprintf(str, "%d %s", addr_type, primary);
 
 	write_device_services(&sba, &dba, str);
 
 	g_free(str);
+	g_free(primary);
 }
 
 static void attio_connected(gpointer data, gpointer user_data)
-- 
1.7.0.4

