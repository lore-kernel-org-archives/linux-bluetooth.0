Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/10] Fix passing D-Bus connection to g_dbus_remove_watch
Date: Mon,  1 Oct 2012 20:53:34 +0300
Message-Id: <1349114021-19067-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
References: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All it needs now is the id
---
 attrib/client.c                    | 4 ++--
 audio/gateway.c                    | 2 +-
 audio/media.c                      | 9 ++++-----
 audio/telephony-maemo6.c           | 2 +-
 audio/telephony-ofono.c            | 4 ++--
 audio/transport.c                  | 2 +-
 plugins/service.c                  | 4 ++--
 profiles/health/hdp_util.c         | 3 +--
 profiles/heartrate/heartrate.c     | 6 +++---
 profiles/network/connection.c      | 4 ++--
 profiles/network/server.c          | 2 +-
 profiles/thermometer/thermometer.c | 6 +++---
 src/adapter.c                      | 2 +-
 src/agent.c                        | 3 +--
 src/device.c                       | 6 ++----
 src/profile.c                      | 4 ++--
 16 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index ece16bf..c5862fa 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -294,7 +294,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 	remove_attio(gatt);
 }
 
@@ -500,7 +500,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 
 	watcher = l->data;
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 	remove_attio(gatt);
 
 	return dbus_message_new_method_return(msg);
diff --git a/audio/gateway.c b/audio/gateway.c
index 45b25a1..fe17284 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -704,7 +704,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	if (strcmp(gw->agent->path, path) != 0)
 		return btd_error_does_not_exist(msg);
 
-	g_dbus_remove_watch(conn, gw->agent->watch);
+	g_dbus_remove_watch(gw->agent->watch);
 
 	agent_free(gw->agent);
 	gw->agent = NULL;
diff --git a/audio/media.c b/audio/media.c
index c88afc0..5c26035 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -159,7 +159,7 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 	g_slist_free_full(endpoint->transports,
 				(GDestroyNotify) media_transport_destroy);
 
-	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
+	g_dbus_remove_watch(endpoint->watch);
 	g_free(endpoint->capabilities);
 	g_free(endpoint->sender);
 	g_free(endpoint->path);
@@ -966,7 +966,6 @@ static void release_player(struct media_player *mp)
 
 static void media_player_free(gpointer data)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	struct media_player *mp = data;
 	struct media_adapter *adapter = mp->adapter;
 
@@ -975,9 +974,9 @@ static void media_player_free(gpointer data)
 		release_player(mp);
 	}
 
-	g_dbus_remove_watch(conn, mp->watch);
-	g_dbus_remove_watch(conn, mp->property_watch);
-	g_dbus_remove_watch(conn, mp->track_watch);
+	g_dbus_remove_watch(mp->watch);
+	g_dbus_remove_watch(mp->property_watch);
+	g_dbus_remove_watch(mp->track_watch);
 
 	if (mp->track)
 		g_hash_table_unref(mp->track);
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index d000a2a..ef997ca 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -2167,7 +2167,7 @@ int telephony_init(void)
 
 static void remove_watch(gpointer data)
 {
-	g_dbus_remove_watch(btd_get_dbus_connection(), GPOINTER_TO_UINT(data));
+	g_dbus_remove_watch(GPOINTER_TO_UINT(data));
 }
 
 void telephony_exit(void)
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index f962c7e..f87b652 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -657,7 +657,7 @@ static void call_free(void *data)
 	if (vc->status == CALL_STATUS_INCOMING)
 		telephony_calling_stopped_ind();
 
-	g_dbus_remove_watch(btd_get_dbus_connection(), vc->watch);
+	g_dbus_remove_watch(vc->watch);
 	g_free(vc->obj_path);
 	g_free(vc->number);
 	g_free(vc);
@@ -1603,7 +1603,7 @@ int telephony_init(void)
 
 static void remove_watch(gpointer data)
 {
-	g_dbus_remove_watch(btd_get_dbus_connection(), GPOINTER_TO_UINT(data));
+	g_dbus_remove_watch(GPOINTER_TO_UINT(data));
 }
 
 static void pending_free(void *data)
diff --git a/audio/transport.c b/audio/transport.c
index daafff8..4615280 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -320,7 +320,7 @@ static void media_transport_remove(struct media_transport *transport,
 	transport->owners = g_slist_remove(transport->owners, owner);
 
 	if (owner->watch)
-		g_dbus_remove_watch(btd_get_dbus_connection(), owner->watch);
+		g_dbus_remove_watch(owner->watch);
 
 	media_owner_free(owner);
 
diff --git a/plugins/service.c b/plugins/service.c
index 45886ac..f77dd47 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -457,7 +457,7 @@ static int remove_record(const char *sender,
 
 	DBG("listner_id %d", user_record->listener_id);
 
-	g_dbus_remove_watch(conn, user_record->listener_id);
+	g_dbus_remove_watch(user_record->listener_id);
 
 	exit_callback(conn, user_record);
 
@@ -724,7 +724,7 @@ static void path_unregister(void *data)
 
 		next = l->next;
 
-		g_dbus_remove_watch(conn, user_record->listener_id);
+		g_dbus_remove_watch(user_record->listener_id);
 		exit_callback(conn, user_record);
 	}
 
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 3afd715..bbc2ed9 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -1184,8 +1184,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 static void hdp_free_application(struct hdp_application *app)
 {
 	if (app->dbus_watcher > 0)
-		g_dbus_remove_watch(btd_get_dbus_connection(),
-							app->dbus_watcher);
+		g_dbus_remove_watch(app->dbus_watcher);
 
 	g_free(app->oname);
 	g_free(app->description);
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 94d4b8d..8db20dc 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -209,7 +209,7 @@ static void remove_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
 
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 }
 
 static void destroy_heartrate_adapter(gpointer user_data)
@@ -573,7 +573,7 @@ static void watcher_exit_cb(DBusConnection *conn, void *user_data)
 	DBG("heartrate watcher [%s] disconnected", watcher->path);
 
 	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
-	g_dbus_remove_watch(conn, watcher->id);
+	g_dbus_remove_watch(watcher->id);
 
 	if (g_slist_length(hradapter->watchers) == 0)
 		g_slist_foreach(hradapter->devices, disable_measurement, 0);
@@ -629,7 +629,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_does_not_exist(msg);
 
 	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
-	g_dbus_remove_watch(conn, watcher->id);
+	g_dbus_remove_watch(watcher->id);
 
 	if (g_slist_length(hradapter->watchers) == 0)
 		g_slist_foreach(hradapter->devices, disable_measurement, 0);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 7688beb..c19de49 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -129,7 +129,7 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 	nc->dc_id = 0;
 	if (nc->watch) {
-		g_dbus_remove_watch(btd_get_dbus_connection(), nc->watch);
+		g_dbus_remove_watch(nc->watch);
 		nc->watch = 0;
 	}
 
@@ -154,7 +154,7 @@ static void cancel_connection(struct network_conn *nc, const char *err_msg)
 	}
 
 	if (nc->watch) {
-		g_dbus_remove_watch(conn, nc->watch);
+		g_dbus_remove_watch(nc->watch);
 		nc->watch = 0;
 	}
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 6ee4770..06fc456 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -674,7 +674,7 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	g_dbus_remove_watch(conn, ns->watch_id);
+	g_dbus_remove_watch(ns->watch_id);
 
 	server_disconnect(conn, ns);
 
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 3506ba7..f0988a4 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -145,7 +145,7 @@ static void remove_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
 
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 }
 
 static void destroy_char(gpointer user_data)
@@ -820,7 +820,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
@@ -899,7 +899,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+	g_dbus_remove_watch(watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
diff --git a/src/adapter.c b/src/adapter.c
index f11be70..3e62271 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -556,7 +556,7 @@ static void session_free(void *data)
 	struct session_req *req = data;
 
 	if (req->id)
-		g_dbus_remove_watch(btd_get_dbus_connection(), req->id);
+		g_dbus_remove_watch(req->id);
 
 	if (req->msg) {
 		dbus_message_unref(req->msg);
diff --git a/src/agent.c b/src/agent.c
index 8cf37b1..694c641 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -179,8 +179,7 @@ void agent_free(struct agent *agent)
 	}
 
 	if (!agent->exited) {
-		g_dbus_remove_watch(btd_get_dbus_connection(),
-							agent->listener_id);
+		g_dbus_remove_watch(agent->listener_id);
 		agent_release(agent);
 	}
 
diff --git a/src/device.c b/src/device.c
index c41b0c8..35d965e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -179,8 +179,7 @@ static uint16_t uuid_list[] = {
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
-		g_dbus_remove_watch(btd_get_dbus_connection(),
-							req->listener_id);
+		g_dbus_remove_watch(req->listener_id);
 	if (req->msg)
 		dbus_message_unref(req->msg);
 	if (req->device)
@@ -2426,8 +2425,7 @@ static void bonding_request_free(struct bonding_req *bonding)
 		return;
 
 	if (bonding->listener_id)
-		g_dbus_remove_watch(btd_get_dbus_connection(),
-							bonding->listener_id);
+		g_dbus_remove_watch(bonding->listener_id);
 
 	if (bonding->msg)
 		dbus_message_unref(bonding->msg);
diff --git a/src/profile.c b/src/profile.c
index cb0e311..7c71e85 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -847,7 +847,7 @@ DBusMessage *btd_profile_unreg_ext(DBusConnection *conn, DBusMessage *msg,
 	if (!ext)
 		return btd_error_does_not_exist(msg);
 
-	g_dbus_remove_watch(conn, ext->id);
+	g_dbus_remove_watch(ext->id);
 	remove_ext(ext);
 
 	return dbus_message_new_method_return(msg);
@@ -871,7 +871,7 @@ void btd_profile_cleanup(void)
 		if (msg)
 			g_dbus_send_message(conn, msg);
 
-		g_dbus_remove_watch(conn, ext->id);
+		g_dbus_remove_watch(ext->id);
 		remove_ext(ext);
 
 	}
-- 
1.7.11.4

