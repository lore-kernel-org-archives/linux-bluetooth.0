Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/adapter: Fix scan type for filtered discovery
Date: Wed, 29 Jun 2016 13:01:58 +0300
Message-Id: <1467194518-27035-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The default type when using SetDiscoveryFilter shall be based on the
current adapter settings since the ControllerMode may set a different
mode or in case the adapter is single mode the code shall never assume
the adapter is SCAN_TYPE_DUAL by default.
---
 src/adapter.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5499bfc..3742398 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2187,9 +2187,7 @@ static bool parse_transport(DBusMessageIter *value, uint8_t *transport)
 		*transport = SCAN_TYPE_BREDR;
 	else if (!strcmp(transport_str, "le"))
 		*transport = SCAN_TYPE_LE;
-	else if (!strcmp(transport_str, "auto"))
-		*transport = SCAN_TYPE_DUAL;
-	else
+	else if (strcmp(transport_str, "auto"))
 		return false;
 
 	return true;
@@ -2220,8 +2218,9 @@ static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
  * successful, sets *filter to proper value.
  * Returns false on any error, and true on success.
  */
-static bool parse_discovery_filter_dict(struct discovery_filter **filter,
-							DBusMessage *msg)
+static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
+					struct discovery_filter **filter,
+					DBusMessage *msg)
 {
 	DBusMessageIter iter, subiter, dictiter, variantiter;
 	bool is_empty = true;
@@ -2233,7 +2232,7 @@ static bool parse_discovery_filter_dict(struct discovery_filter **filter,
 	(*filter)->uuids = NULL;
 	(*filter)->pathloss = DISTANCE_VAL_INVALID;
 	(*filter)->rssi = DISTANCE_VAL_INVALID;
-	(*filter)->type = SCAN_TYPE_DUAL;
+	(*filter)->type = get_scan_type(adapter);
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2308,7 +2307,7 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 		return btd_error_not_supported(msg);
 
 	/* parse parameters */
-	if (!parse_discovery_filter_dict(&discovery_filter, msg))
+	if (!parse_discovery_filter_dict(adapter, &discovery_filter, msg))
 		return btd_error_invalid_args(msg);
 
 	is_discovering = get_discovery_client(adapter, sender, &client);
-- 
2.7.4

