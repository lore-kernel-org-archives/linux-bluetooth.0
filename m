Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] adapter-api: Rename ResetData to DuplicateData filter
Date: Tue, 29 Aug 2017 15:56:50 +0300
Message-Id: <20170829125652.4344-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since essencially what this filter would be doing is disable duplicate
for data use it instead of ResetData.

Also inline the documentation of each filter option to make it easier to
read what each option does.
---
 doc/adapter-api.txt | 92 +++++++++++++++++++++++++++++++++--------------------
 src/adapter.c       | 32 +++++++++----------
 src/device.c        |  8 ++---
 src/device.h        |  5 +--
 4 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index c2898694d..d852aa6b9 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -54,30 +54,64 @@ Methods		void StartDiscovery()
 			Parameters that may be set in the filter dictionary
 			include the following:
 
-			array{string} UUIDs	: filtered service UUIDs
-			int16	      RSSI	: RSSI threshold value
-			uint16        Pathloss	: Pathloss threshold value
-			string        Transport	: type of scan to run
-			bool          ResetData : Reset advertisement data
-
-			When a remote device is found that advertises any UUID
-			from UUIDs, it will be reported if:
-			- Pathloss and RSSI are both empty,
-			- only Pathloss param is set, device advertise TX pwer,
-			  and computed pathloss is less than Pathloss param,
-			- only RSSI param is set, and received RSSI is higher
-			  than RSSI param,
-
-			Transport parameter determines the type of scan:
-				"auto"	- interleaved scan, default value
-				"bredr"	- BR/EDR inquiry
-				"le"	- LE scan only
-
-			If "le" or "bredr" Transport is requested, and the
-			controller doesn't support it, org.bluez.Error.Failed
-			error will be returned. If "auto" transport is
-			requested, scan will use LE, BREDR, or both, depending
-			on what's currently enabled on the controller.
+			array{string} UUIDs
+
+				Filter by service UUIDs, empty means match
+				_any_ UUID.
+
+				When a remote device is found that advertises
+				any UUID from UUIDs, it will be reported if:
+				- Pathloss and RSSI are both empty.
+				- only Pathloss param is set, device advertise
+				  TX pwer, and computed pathloss is less than
+				  Pathloss param.
+				- only RSSI param is set, and received RSSI is
+				  higher than RSSI param.
+
+			int16 RSSI
+
+				RSSI threshold value.
+
+				PropertiesChanged signals will be emitted
+				for already existing Device objects, with
+				updated RSSI value. If one or more discovery
+				filters have been set, the RSSI delta-threshold,
+				that is imposed by StartDiscovery by default,
+				will not be applied.
+
+			uint16 Pathloss
+
+				Pathloss threshold value.
+
+				PropertiesChanged signals will be emitted
+				for already existing Device objects, with
+				updated Pathloss value.
+
+			string Transport (Default "auto")
+
+				Transport parameter determines the type of
+				scan.
+
+				Possible values:
+					"auto"	- interleaved scan
+					"bredr"	- BR/EDR inquiry
+					"le"	- LE scan only
+
+				If "le" or "bredr" Transport is requested,
+				and the controller doesn't support it,
+				org.bluez.Error.Failed error will be returned.
+				If "auto" transport is requested, scan will use
+				LE, BREDR, or both, depending on what's
+				currently enabled on the controller.
+
+			bool DuplicateData (Default: true)
+
+				Disables duplicate detection of advertisement
+				data.
+
+				When enabled PropertiesChanged signals will be
+				generated for either ManufacturerData and
+				ServiceData everytime they are discovered.
 
 			When discovery filter is set, Device objects will be
 			created as new devices with matching criteria are
@@ -85,16 +119,6 @@ Methods		void StartDiscovery()
 			discoverable which enables listening to
 			non-connectable and non-discoverable devices.
 
-			PropertiesChanged signals will be emitted
-			for already existing Device objects, with updated RSSI
-			value. If one or more discovery filters have been set,
-			the RSSI delta-threshold, that is imposed by
-			StartDiscovery by default, will not be applied.
-
-			If ResetData is enabled PropertiesChanged signals will
-			be generated for either ManufacturerData and ServiceData
-			everytime they are discovered.
-
 			When multiple clients call SetDiscoveryFilter, their
 			filters are internally merged, and notifications about
 			new devices are sent to all clients. Therefore, each
diff --git a/src/adapter.c b/src/adapter.c
index 01860515d..a571b1870 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -155,7 +155,7 @@ struct discovery_filter {
 	uint16_t pathloss;
 	int16_t rssi;
 	GSList *uuids;
-	bool reset;
+	bool duplicate;
 };
 
 struct watch_client {
@@ -2216,13 +2216,13 @@ static bool parse_transport(DBusMessageIter *value,
 	return true;
 }
 
-static bool parse_reset_data(DBusMessageIter *value,
+static bool parse_duplicate_data(DBusMessageIter *value,
 					struct discovery_filter *filter)
 {
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(value, &filter->reset);
+	dbus_message_iter_get_basic(value, &filter->duplicate);
 
 	return true;
 }
@@ -2235,7 +2235,7 @@ struct filter_parser {
 	{ "RSSI", parse_rssi },
 	{ "Pathloss", parse_pathloss },
 	{ "Transport", parse_transport },
-	{ "ResetData", parse_reset_data },
+	{ "DuplicateData", parse_duplicate_data },
 	{ }
 };
 
@@ -2274,7 +2274,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->pathloss = DISTANCE_VAL_INVALID;
 	(*filter)->rssi = DISTANCE_VAL_INVALID;
 	(*filter)->type = get_scan_type(adapter);
-	(*filter)->reset = false;
+	(*filter)->duplicate = false;
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2320,8 +2320,8 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 		goto invalid_args;
 
 	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
-		" reset data: %s ", (*filter)->type, (*filter)->rssi,
-		(*filter)->pathloss, (*filter)->reset ? "true" : "false");
+		" duplicate data: %s ", (*filter)->type, (*filter)->rssi,
+		(*filter)->pathloss, (*filter)->duplicate ? "true" : "false");
 
 	return true;
 
@@ -5618,15 +5618,15 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 	return got_match;
 }
 
-static void filter_reset_data(void *data, void *user_data)
+static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct watch_client *client = data;
-	bool *reset = user_data;
+	bool *duplicate = user_data;
 
-	if (*reset || !client->discovery_filter)
+	if (*duplicate || !client->discovery_filter)
 		return;
 
-	*reset = client->discovery_filter->reset;
+	*duplicate = client->discovery_filter->duplicate;
 }
 
 static void update_found_devices(struct btd_adapter *adapter,
@@ -5640,7 +5640,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	struct eir_data eir_data;
 	bool name_known, discoverable;
 	char addr[18];
-	bool reset = false;
+	bool duplicate = false;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	eir_parse(&eir_data, data, data_len);
@@ -5741,16 +5741,16 @@ static void update_found_devices(struct btd_adapter *adapter,
 	device_add_eir_uuids(dev, eir_data.services);
 
 	if (adapter->discovery_list)
-		g_slist_foreach(adapter->discovery_list, filter_reset_data,
-								&reset);
+		g_slist_foreach(adapter->discovery_list, filter_duplicate_data,
+								&duplicate);
 
 	if (eir_data.msd_list) {
-		device_set_manufacturer_data(dev, eir_data.msd_list, reset);
+		device_set_manufacturer_data(dev, eir_data.msd_list, duplicate);
 		adapter_msd_notify(adapter, dev, eir_data.msd_list);
 	}
 
 	if (eir_data.sd_list)
-		device_set_service_data(dev, eir_data.sd_list, reset);
+		device_set_service_data(dev, eir_data.sd_list, duplicate);
 
 	if (bdaddr_type != BDADDR_BREDR)
 		device_set_flags(dev, eir_data.flags);
diff --git a/src/device.c b/src/device.c
index 516958e0b..fd7a64134 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1624,9 +1624,9 @@ static void add_manufacturer_data(void *data, void *user_data)
 }
 
 void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
-								bool reset)
+								bool duplicate)
 {
-	if (reset)
+	if (duplicate)
 		bt_ad_clear_manufacturer_data(dev->ad);
 
 	g_slist_foreach(list, add_manufacturer_data, dev);
@@ -1649,9 +1649,9 @@ static void add_service_data(void *data, void *user_data)
 }
 
 void device_set_service_data(struct btd_device *dev, GSList *list,
-							bool reset)
+							bool duplicate)
 {
-	if (reset)
+	if (duplicate)
 		bt_ad_clear_service_data(dev->ad);
 
 	g_slist_foreach(list, add_service_data, dev);
diff --git a/src/device.h b/src/device.h
index 5f56918ed..850561729 100644
--- a/src/device.h
+++ b/src/device.h
@@ -77,8 +77,9 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
 void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
-								bool reset);
-void device_set_service_data(struct btd_device *dev, GSList *list, bool reset);
+							bool duplicate);
+void device_set_service_data(struct btd_device *dev, GSList *list,
+							bool duplicate);
 void device_probe_profile(gpointer a, gpointer b);
 void device_remove_profile(gpointer a, gpointer b);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
-- 
2.13.5

