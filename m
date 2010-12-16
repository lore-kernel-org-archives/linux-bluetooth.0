Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] covert more dbus errors to btd_error_*
Date: Thu, 16 Dec 2010 15:58:09 -0200
Message-Id: <1292522289-15173-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292522289-15173-2-git-send-email-padovan@profusion.mobi>
References: <1292522289-15173-1-git-send-email-padovan@profusion.mobi>
 <1292522289-15173-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c |   10 ++--------
 serial/port.c   |    8 +-------
 serial/proxy.c  |   12 ++----------
 src/adapter.c   |   10 ++--------
 4 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index af75f8b..72bf5b6 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1872,14 +1872,8 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 		return btd_error_not_connected(msg);
 
 	err = headset_set_gain(device, gain, type);
-	if (err < 0) {
-		/* Ignore if nothing has changed */
-		if (err == -EALREADY)
-			return dbus_message_new_method_return(msg);
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-						".InvalidArgument",
-						"Must be less than or equal to 15");
-	}
+	if (err < 0)
+		return btd_error_invalid_args(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
diff --git a/serial/port.c b/serial/port.c
index 33450b3..233e317 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -234,12 +234,6 @@ void port_release_all(void)
 	g_slist_free(devices);
 }
 
-static inline DBusMessage *failed(DBusMessage *msg, const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", description);
-}
-
 static void open_notify(int fd, int err, struct serial_port *port)
 {
 	struct serial_device *device = port->device;
@@ -495,7 +489,7 @@ static DBusMessage *port_connect(DBusConnection *conn,
 	}
 
 	if (port->listener_id)
-		return failed(msg, "Port already in use");
+		return btd_error_failed(msg, "Port already in use");
 
 	port->listener_id = g_dbus_add_disconnect_watch(conn,
 						dbus_message_get_sender(msg),
diff --git a/serial/proxy.c b/serial/proxy.c
index 20aea7d..b1ee65e 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -131,12 +131,6 @@ static void proxy_free(struct serial_proxy *prx)
 	g_free(prx);
 }
 
-static inline DBusMessage *failed(DBusMessage *msg, const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", description);
-}
-
 static void add_lang_attr(sdp_record_t *r)
 {
 	sdp_lang_attr_t base_lang;
@@ -551,9 +545,7 @@ static DBusMessage *proxy_enable(DBusConnection *conn,
 	int err;
 
 	err = enable_proxy(prx);
-	if (err == -EALREADY)
-		return failed(msg, "Already enabled");
-	else if (err < 0)
+	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
@@ -565,7 +557,7 @@ static DBusMessage *proxy_disable(DBusConnection *conn,
 	struct serial_proxy *prx = data;
 
 	if (!prx->io)
-		return failed(msg, "Not enabled");
+		return btd_error_failed(msg, "Not enabled");
 
 	/* Remove the watches and unregister the record */
 	disable_proxy(prx);
diff --git a/src/adapter.c b/src/adapter.c
index cd53455..5118306 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -140,12 +140,6 @@ struct btd_adapter {
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
 
-static inline DBusMessage *not_in_progress(DBusMessage *msg, const char *str)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotInProgress",
-								"%s", str);
-}
-
 static int found_device_cmp(const struct remote_dev_info *d1,
 			const struct remote_dev_info *d2)
 {
@@ -1226,7 +1220,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	ba2str(&adapter->bdaddr, srcaddr);
 
 	if (check_address(srcaddr) < 0)
-		return adapter_not_ready(msg);
+		return btd_error_invalid_args(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1505,7 +1499,7 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 
 	device = adapter_find_device(adapter, address);
 	if (!device || !device_is_creating(device, NULL))
-		return not_in_progress(msg, "Device creation not in progress");
+		return btd_error_does_not_exist(msg);
 
 	if (!device_is_creating(device, sender))
 		return btd_error_not_authorized(msg);
-- 
1.7.3.2

