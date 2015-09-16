Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] core/adapter: probe profiles after loading ltks
Date: Wed, 16 Sep 2015 13:33:12 -0700
Message-Id: <1442435592-2846-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When bluetoothd starts, it loads devices from storage.

During this process, it loads general info. That includes loading UUIDS,
and letting plugins decide whether they're interested in this device. Then
load_irks call is made to load identity resolving keys into kernel.

If during this process plugin decides it's interested in given device,
they might register device for auto connecting by calling
btd_device_add_attio_callback. This update kernel auto connect list.
update_white_list inside "net/bluetooth/hci_request.c" is called. It uses
hci_find_irk_by_addr to decide whether kernel know irk for given address
and shall not use whitelist. However irks were not loaded yet - they're
loaded by bluetoothd after all devices were initialized (and possibly
added to autoconnect).

Because of that, device public address is added to whitelist (instead of
resolvable private address), and whitelist is used. Even worse, after call
to load_irks, or after manually calling connect, device is still
improperly added to whitelist and will be unable to connect (timeout will
happen).

To fix that bluetoothd must call load_irks before letting plugins enable
autoconnect.
---
 src/adapter.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a920b21..4abeaaa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3457,6 +3457,14 @@ static uint8_t get_le_addr_type(GKeyFile *keyfile)
 	return addr_type;
 }
 
+static void probe_loaded_profiles(struct btd_device *device, gpointer data)
+{
+		GSList *list = btd_device_get_uuids(device);
+
+		if (list)
+			device_probe_profiles(device, list);
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char dirname[PATH_MAX];
@@ -3465,6 +3473,7 @@ static void load_devices(struct btd_adapter *adapter)
 	GSList *ltks = NULL;
 	GSList *irks = NULL;
 	GSList *params = NULL;
+	GSList *added_devices = NULL;
 	DIR *dir;
 	struct dirent *entry;
 
@@ -3534,9 +3543,7 @@ static void load_devices(struct btd_adapter *adapter)
 
 		/* TODO: register services from pre-loaded list of primaries */
 
-		list = btd_device_get_uuids(device);
-		if (list)
-			device_probe_profiles(device, list);
+		added_devices = g_slist_append(added_devices, device);
 
 device_exist:
 		if (key_info) {
@@ -3564,6 +3571,10 @@ free:
 	g_slist_free_full(irks, g_free);
 	load_conn_params(adapter, params);
 	g_slist_free_full(params, g_free);
+
+	g_slist_foreach(added_devices, (GFunc)probe_loaded_profiles, NULL);
+	g_slist_free(added_devices);
+
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
-- 
2.5.0

