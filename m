Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, brn@deako.com,
        Don Zickus <dzickus@redhat.com>
Subject: [RFC 3/3] core/adapter: Hook le_duplicates into d-bus interface
Date: Tue,  6 Dec 2016 16:40:00 -0500
Message-Id: <1481060400-7088-4-git-send-email-dzickus@redhat.com>
In-Reply-To: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The previous patch provided the management hooks to disable duplicate
device filtering on the adapter.  This patch allows the d-bus
interface to use it with another field in SetDiscoveryFilter()

The new field is:

bool LE_Duplicates

The adapter-api.txt doc has been updated to reflect this.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 client/main.c       |  5 +++++
 doc/adapter-api.txt |  1 +
 src/adapter.c       | 22 ++++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index e1198a8..d74d068 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1153,6 +1153,7 @@ struct set_discovery_filter_args {
 	dbus_int16_t pathloss;
 	char **uuids;
 	size_t uuids_len;
+	bool le_duplicates;
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -1180,6 +1181,10 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
 						&args->transport);
 
+	if (args->le_duplicates)
+		dict_append_entry(&dict, "LE_Duplicates", DBUS_TYPE_BOOLEAN,
+						&args->le_duplicates);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 08de6cd..dc09752 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -58,6 +58,7 @@ Methods		void StartDiscovery()
 			int16	      RSSI	: RSSI threshold value
 			uint16        Pathloss	: Pathloss threshold value
 			string        Transport	: type of scan to run
+			bool          LE_Duplicates : Disable LE Duplicate filtering
 
 			When a remote device is found that advertises any UUID
 			from UUIDs, it will be reported if:
diff --git a/src/adapter.c b/src/adapter.c
index ddf0d11..1e961a1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2220,6 +2220,16 @@ static bool parse_transport(DBusMessageIter *value, uint8_t *transport)
 	return true;
 }
 
+static bool parse_le_duplicates(DBusMessageIter *value, bool *le_duplicates)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(value, le_duplicates);
+
+	return true;
+}
+
 static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
 						struct discovery_filter *filter)
 {
@@ -2235,6 +2245,9 @@ static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
 	if (!strcmp("Transport", key))
 		return parse_transport(value, &filter->type);
 
+	if (!strcmp("LE_Duplicates", key))
+		return parse_le_duplicates(value, &filter->le_duplicates);
+
 	DBG("Unknown key parameter: %s!\n", key);
 	return false;
 }
@@ -2260,6 +2273,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->pathloss = DISTANCE_VAL_INVALID;
 	(*filter)->rssi = DISTANCE_VAL_INVALID;
 	(*filter)->type = get_scan_type(adapter);
+	(*filter)->le_duplicates = false;
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2304,8 +2318,12 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	    (*filter)->rssi != DISTANCE_VAL_INVALID)
 		goto invalid_args;
 
-	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d",
-	    (*filter)->type, (*filter)->rssi, (*filter)->pathloss);
+	/* only allow LE duplicates for type LE */
+	if ((*filter)->le_duplicates && (*filter)->type != SCAN_TYPE_LE)
+		goto invalid_args;
+
+	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d le_duplicates: %d",
+	    (*filter)->type, (*filter)->rssi, (*filter)->pathloss, (*filter)->le_duplicates);
 
 	return true;
 
-- 
1.8.3.1

