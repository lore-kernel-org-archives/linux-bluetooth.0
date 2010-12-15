Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] add btd_error_not_ready()
Date: Wed, 15 Dec 2010 20:07:02 -0200
Message-Id: <1292450823-17640-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292450823-17640-2-git-send-email-padovan@profusion.mobi>
References: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
 <1292450823-17640-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c |    3 +--
 src/adapter.c   |   16 +++++-----------
 src/error.c     |    6 ++++++
 src/error.h     |    1 +
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 55bdc61..be14d3b 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1696,8 +1696,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_already_connected(msg);
 
 	if (hs->hfp_handle && !ag.telephony_ready)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
-					"Telephony subsystem not ready");
+		return btd_error_not_ready(msg);
 
 	device->auto_connect = FALSE;
 
diff --git a/src/adapter.c b/src/adapter.c
index 73c8a9b..f0e1d36 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -140,12 +140,6 @@ struct btd_adapter {
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
 
-static inline DBusMessage *adapter_not_ready(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
-			"Adapter is not ready");
-}
-
 static inline DBusMessage *not_in_progress(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotInProgress",
@@ -554,7 +548,7 @@ static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (adapter->scan_mode == SCAN_DISABLED)
-		return adapter_not_ready(msg);
+		return btd_error_not_ready(msg);
 
 	if (pairable == adapter->pairable)
 		goto done;
@@ -1166,7 +1160,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	int err;
 
 	if (!adapter->up)
-		return adapter_not_ready(msg);
+		return btd_error_not_ready(msg);
 
 	req = find_session(adapter->disc_sessions, sender);
 	if (req) {
@@ -1198,7 +1192,7 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 
 	if (!adapter->up)
-		return adapter_not_ready(msg);
+		return btd_error_not_ready(msg);
 
 	req = find_session(adapter->disc_sessions, sender);
 	if (!req)
@@ -1575,7 +1569,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (!adapter->up)
-		return adapter_not_ready(msg);
+		return btd_error_not_ready(msg);
 
 	if (adapter_find_device(adapter, address))
 		return btd_error_already_exists(msg);
@@ -1652,7 +1646,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (!adapter->up)
-		return adapter_not_ready(msg);
+		return btd_error_not_ready(msg);
 
 	sender = dbus_message_get_sender(msg);
 	if (adapter->agent &&
diff --git a/src/error.c b/src/error.c
index 7d3afd4..8ee79b8 100644
--- a/src/error.c
+++ b/src/error.c
@@ -103,6 +103,12 @@ DBusMessage *btd_error_agent_not_assigned(DBusMessage *msg)
 					"Agent Not Assigned");
 }
 
+DBusMessage *btd_error_not_ready(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotReady",
+					"Resource Not Ready");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
diff --git a/src/error.h b/src/error.h
index b8c06ce..6cd3cbf 100644
--- a/src/error.h
+++ b/src/error.h
@@ -39,4 +39,5 @@ DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
 DBusMessage *btd_error_agent_not_assigned(DBusMessage *msg);
+DBusMessage *btd_error_not_ready(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
-- 
1.7.3.2

