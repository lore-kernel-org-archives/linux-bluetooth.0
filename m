Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/14] adapter: Probe profiles after device creation
Date: Wed, 12 Dec 2012 16:47:54 +0100
Message-Id: <1355327283-1558-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7ab2389..10aacbf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1631,38 +1631,6 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ }
 };
 
-static void create_stored_device_from_profiles(char *key, char *value,
-						void *user_data)
-{
-	char address[18];
-	uint8_t bdaddr_type;
-	struct btd_adapter *adapter = user_data;
-	GSList *list, *uuids = bt_string2list(value);
-	struct btd_device *device;
-
-	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
-		bdaddr_type = BDADDR_BREDR;
-
-	if (g_slist_find_custom(adapter->devices,
-				address, (GCompareFunc) device_address_cmp))
-		return;
-
-	device = device_create(adapter, address, bdaddr_type);
-	if (!device)
-		return;
-
-	device_set_temporary(device, FALSE);
-	adapter->devices = g_slist_append(adapter->devices, device);
-
-	list = device_services_from_record(device, uuids);
-	if (list)
-		device_register_services(device, list, ATT_PSM);
-
-	device_probe_profiles(device, uuids);
-
-	g_slist_free_full(uuids, g_free);
-}
-
 struct adapter_keys {
 	struct btd_adapter *adapter;
 	GSList *keys;
@@ -1846,10 +1814,6 @@ static void load_devices(struct btd_adapter *adapter)
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "profiles");
-	textfile_foreach(filename, create_stored_device_from_profiles,
-								adapter);
-
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primaries");
 	textfile_foreach(filename, create_stored_device_from_primaries,
 								adapter);
@@ -1903,6 +1867,10 @@ static void load_devices(struct btd_adapter *adapter)
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
 
+		l = device_get_uuids(device);
+		if (l)
+			device_probe_profiles(device, l);
+
 device_exist:
 		if (key_info || ltk_info) {
 			device_set_paired(device, TRUE);
-- 
1.7.9.5

