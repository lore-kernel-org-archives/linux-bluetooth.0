Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] adapter: Discovery filter discoverable
Date: Mon, 30 Jul 2018 14:14:23 +0300
Message-Id: <20180730111427.29947-2-luiz.dentz@gmail.com>
In-Reply-To: <20180730111427.29947-1-luiz.dentz@gmail.com>
References: <20180730111427.29947-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the discovery filter discoverable and tracks which
clients had enabled it and restores the settings when the last client
enabling it exits.
---
 src/adapter.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f730c1639..ecd2c40ae 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -157,6 +157,7 @@ struct discovery_filter {
 	int16_t rssi;
 	GSList *uuids;
 	bool duplicate;
+	bool discoverable;
 };
 
 struct watch_client {
@@ -219,6 +220,7 @@ struct btd_adapter {
 	uint8_t discovery_type;		/* current active discovery type */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
+	bool discovery_discoverable;	/* discoverable while discovering */
 	GSList *discovery_list;		/* list of discovery clients */
 	GSList *set_filter_list;	/* list of clients that specified
 					 * filter, but don't scan yet
@@ -1842,6 +1844,20 @@ static void discovery_free(void *user_data)
 	g_free(client);
 }
 
+static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
+{
+	if (adapter->discovery_discoverable == enable)
+		return true;
+
+	/* Reset discoverable filter if already set */
+	if (enable && (adapter->current_settings & MGMT_OP_SET_DISCOVERABLE))
+		return true;
+
+	adapter->discovery_discoverable = enable;
+
+	return set_discoverable(adapter, enable, 0);
+}
+
 static void discovery_remove(struct watch_client *client)
 {
 	struct btd_adapter *adapter = client->adapter;
@@ -2090,6 +2106,8 @@ static bool filters_equal(struct mgmt_cp_start_service_discovery *a,
 static int update_discovery_filter(struct btd_adapter *adapter)
 {
 	struct mgmt_cp_start_service_discovery *sd_cp;
+	GSList *l;
+
 
 	DBG("");
 
@@ -2099,6 +2117,18 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 		return -ENOMEM;
 	}
 
+	for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+
+		if (!client->discovery_filter)
+			continue;
+
+		if (client->discovery_filter->discoverable)
+			break;
+	}
+
+	set_discovery_discoverable(adapter, l ? true : false);
+
 	/*
 	 * If filters are equal, then don't update scan, except for when
 	 * starting discovery.
@@ -2130,6 +2160,9 @@ static int discovery_stop(struct watch_client *client)
 		return 0;
 	}
 
+	if (adapter->discovery_discoverable)
+		set_discovery_discoverable(adapter, false);
+
 	/*
 	 * In the idle phase of a discovery, there is no need to stop it
 	 * and so it is enough to send out the signal and just return.
@@ -2224,6 +2257,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 					     adapter->set_filter_list, client);
 		adapter->discovery_list = g_slist_prepend(
 					      adapter->discovery_list, client);
+
 		goto done;
 	}
 
@@ -2348,6 +2382,17 @@ static bool parse_duplicate_data(DBusMessageIter *value,
 	return true;
 }
 
+static bool parse_discoverable(DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(value, &filter->discoverable);
+
+	return true;
+}
+
 struct filter_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
@@ -2357,6 +2402,7 @@ struct filter_parser {
 	{ "Pathloss", parse_pathloss },
 	{ "Transport", parse_transport },
 	{ "DuplicateData", parse_duplicate_data },
+	{ "Discoverable", parse_discoverable },
 	{ }
 };
 
@@ -2396,6 +2442,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->rssi = DISTANCE_VAL_INVALID;
 	(*filter)->type = get_scan_type(adapter);
 	(*filter)->duplicate = false;
+	(*filter)->discoverable = false;
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2441,8 +2488,10 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 		goto invalid_args;
 
 	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
-		" duplicate data: %s ", (*filter)->type, (*filter)->rssi,
-		(*filter)->pathloss, (*filter)->duplicate ? "true" : "false");
+		" duplicate data: %s discoverable %s", (*filter)->type,
+		(*filter)->rssi, (*filter)->pathloss,
+		(*filter)->duplicate ? "true" : "false",
+		(*filter)->discoverable ? "true" : "false");
 
 	return true;
 
@@ -2880,6 +2929,9 @@ static void property_set_discoverable(const GDBusPropertyTable *property,
 		return;
 	}
 
+	/* Reset discovery_discoverable as Discoverable takes precedence */
+	adapter->discovery_discoverable = false;
+
 	property_set_mode(adapter, MGMT_SETTING_DISCOVERABLE, iter, id);
 }
 
-- 
2.17.1

