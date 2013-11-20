Return-Path: <cyrus@holtmann.org>
Message-ID: <1384937788.10231.5.camel@nuvo>
Subject: [PATCH] all: Use G_SOURCE_REMOVE/G_SOURCE_CONTINUE macros
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 20 Nov 2013 09:56:28 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Instead of TRUE/FALSE. This makes the source more readable.
---
 attrib/gattrib.c                     |  2 +-
 attrib/gatttool.c                    |  2 +-
 configure.ac                         |  8 ++++++++
 gdbus/mainloop.c                     |  6 +++---
 gdbus/object.c                       |  2 +-
 gdbus/watch.c                        |  2 +-
 gobex/gobex.c                        |  4 ++--
 obexd/client/session.c               |  4 ++--
 obexd/client/transfer.c              |  6 +++---
 obexd/plugins/messages-dummy.c       |  2 +-
 obexd/plugins/messages-tracker.c     |  2 +-
 obexd/plugins/phonebook-dummy.c      |  6 +++---
 plugins/policy.c                     |  6 +++---
 profiles/audio/a2dp.c                | 16 ++++++++--------
 profiles/audio/avctp.c               | 12 ++++++------
 profiles/audio/avdtp.c               | 14 +++++++-------
 profiles/audio/avrcp.c               |  2 +-
 profiles/audio/player.c              |  4 ++--
 profiles/cyclingspeed/cyclingspeed.c |  2 +-
 profiles/health/hdp.c                |  4 ++--
 profiles/health/mcap.c               |  2 +-
 profiles/health/mcap_sync.c          | 18 +++++++++---------
 profiles/input/device.c              | 10 +++++-----
 profiles/network/connection.c        |  2 +-
 profiles/proximity/monitor.c         |  4 ++--
 profiles/sap/server.c                |  4 ++--
 src/adapter.c                        | 20 ++++++++++----------
 src/device.c                         | 16 ++++++++--------
 src/main.c                           |  4 ++--
 src/sdp-client.c                     |  2 +-
 src/shared/hciemu.c                  |  2 +-
 src/shared/tester.c                  | 18 +++++++++---------
 tools/btiotest.c                     |  6 +++---
 unit/test-gdbus-client.c             |  4 ++--
 unit/test-gobex-transfer.c           |  2 +-
 unit/test-gobex.c                    |  4 ++--
 unit/test-sdp.c                      |  2 +-
 37 files changed, 117 insertions(+), 109 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 609b908..4d93902 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -284,7 +284,7 @@ done:
 
 	g_attrib_unref(attrib);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index f211dcd..7ef26aa 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -116,7 +116,7 @@ static gboolean listen_start(gpointer user_data)
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
diff --git a/configure.ac b/configure.ac
index 949846e..5373545 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,14 @@ PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 
+# Remove when glib dep is bumped
+PKG_CHECK_MODULES(SOURCE_CHECK, glib-2.0 >= 2.32,
+			has_source_macro=yes, has_source_macro=no)
+if (test "${has_source_macro}" = "no"); then
+	AC_DEFINE(G_SOURCE_REMOVE, 0, [Macro available from glib 2.32])
+	AC_DEFINE(G_SOURCE_CONTINUE, 1, [Macro available from glib 2.32])
+fi
+
 if (test "${enable_threads}" = "yes"); then
 	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
 	PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >= 2.16, dummy=yes,
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index 099b67f..d00db33 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -77,7 +77,7 @@ static gboolean message_dispatch(void *data)
 
 	dbus_connection_unref(conn);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static inline void queue_dispatch(DBusConnection *conn,
@@ -186,11 +186,11 @@ static gboolean timeout_handler_dispatch(gpointer data)
 
 	/* if not enabled should not be polled by the main loop */
 	if (!dbus_timeout_get_enabled(handler->timeout))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	dbus_timeout_handle(handler->timeout);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void timeout_handler_free(void *data)
diff --git a/gdbus/object.c b/gdbus/object.c
index b248cbb..72c542e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1008,7 +1008,7 @@ static gboolean process_changes(gpointer user_data)
 
 	data->process_id = 0;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void generic_unregister(DBusConnection *connection, void *user_data)
diff --git a/gdbus/watch.c b/gdbus/watch.c
index 0f99f4f..f357cd1 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -599,7 +599,7 @@ static gboolean update_service(void *user_data)
 
 	dbus_connection_unref(conn);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void service_reply(DBusPendingCall *call, void *user_data)
diff --git a/gobex/gobex.c b/gobex/gobex.c
index 8c08b1e..e107c0c 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -253,7 +253,7 @@ static gboolean req_timeout(gpointer user_data)
 	g_error_free(err);
 	pending_pkt_free(p);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean write_stream(GObex *obex, GError **err)
@@ -720,7 +720,7 @@ static gboolean cancel_complete(gpointer user_data)
 
 	pending_pkt_free(p);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 8138b1e..72fcc6d 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -435,7 +435,7 @@ static gboolean connection_complete(gpointer data)
 
 	g_free(cb);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static int session_connect(struct obc_session *session,
@@ -730,7 +730,7 @@ static gboolean session_process(gpointer data)
 
 	session_process_queue(session);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void session_queue(struct pending_request *p)
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 5a8d4f2..54713a9 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -680,13 +680,13 @@ static gboolean report_progress(gpointer data)
 	struct obc_transfer *transfer = data;
 
 	if (transfer->transferred == transfer->progress)
-		return TRUE;
+		return G_SOURCE_CONTINUE;
 
 	transfer->progress = transfer->transferred;
 
 	if (transfer->transferred == transfer->size) {
 		transfer->progress_id = 0;
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	if (transfer->status != TRANSFER_STATUS_ACTIVE)
@@ -695,7 +695,7 @@ static gboolean report_progress(gpointer data)
 	g_dbus_emit_property_changed(transfer->conn, transfer->path,
 					TRANSFER_INTERFACE, "Transferred");
 
-	return TRUE;
+	return G_SOURCE_CONTINUE;
 }
 
 static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index bb0627f..439ea95 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -198,7 +198,7 @@ static gboolean get_folder_listing(void *d)
 	return_folder_listing(fld, list);
 	g_slist_free_full(list, g_free);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 int messages_init(void)
diff --git a/obexd/plugins/messages-tracker.c b/obexd/plugins/messages-tracker.c
index 60f3a80..6df57ad 100644
--- a/obexd/plugins/messages-tracker.c
+++ b/obexd/plugins/messages-tracker.c
@@ -282,7 +282,7 @@ static gboolean async_get_folder_listing(void *s)
 	g_free(path);
 	g_free(session->name);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 int messages_get_folder_listing(void *s, const char *name,
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 6b9d040..ca266ef 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -252,7 +252,7 @@ done:
 
 	g_string_free(buffer, TRUE);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void entry_notify(const char *filename, VObject *v, void *user_data)
@@ -326,7 +326,7 @@ static gboolean create_cache(void *user_data)
 
 	query->ready_cb(query->user_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean read_entry(void *user_data)
@@ -348,7 +348,7 @@ static gboolean read_entry(void *user_data)
 
 	dummy->cb(buffer, count, 1, 0, TRUE, dummy->user_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean is_dir(const char *dir)
diff --git a/plugins/policy.c b/plugins/policy.c
index 0292482..787371f 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -90,7 +90,7 @@ static gboolean policy_connect_ct(gpointer user_data)
 	if (service != NULL)
 		policy_connect(data, service);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void policy_set_ct_timer(struct policy_data *data)
@@ -163,7 +163,7 @@ static gboolean policy_connect_sink(gpointer user_data)
 	if (service != NULL)
 		policy_connect(data, service);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void policy_set_sink_timer(struct policy_data *data)
@@ -272,7 +272,7 @@ static gboolean policy_connect_source(gpointer user_data)
 	if (service != NULL)
 		policy_connect(data, service);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void policy_set_source_timer(struct policy_data *data)
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 29a1593..6689d72 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -224,7 +224,7 @@ static gboolean finalize_config(gpointer data)
 		setup_cb_free(cb);
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean finalize_resume(gpointer data)
@@ -244,7 +244,7 @@ static gboolean finalize_resume(gpointer data)
 		setup_cb_free(cb);
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean finalize_suspend(gpointer data)
@@ -264,7 +264,7 @@ static gboolean finalize_suspend(gpointer data)
 		setup_cb_free(cb);
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void finalize_select(struct a2dp_setup *s)
@@ -384,7 +384,7 @@ static gboolean auto_config(gpointer data)
 
 	/* Check if configuration was aborted */
 	if (setup->sep->stream == NULL)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	if (setup->err != NULL)
 		goto done;
@@ -413,7 +413,7 @@ done:
 
 	setup_unref(setup);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
@@ -727,7 +727,7 @@ static gboolean suspend_timeout(struct a2dp_sep *sep)
 	avdtp_unref(sep->session);
 	sep->session = NULL;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -928,11 +928,11 @@ static gboolean a2dp_reconfigure(gpointer data)
 		goto failed;
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 
 failed:
 	finalize_setup_errno(setup, posix_err, finalize_config, NULL);
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 476f61a..4f688c8 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -299,7 +299,7 @@ static gboolean auto_release(gpointer user_data)
 
 	send_key(session->uinput, session->key.op, 0);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static size_t handle_panel_passthrough(struct avctp *session,
@@ -697,7 +697,7 @@ static gboolean req_timeout(gpointer user_data)
 	if (chan->process_id == 0)
 		chan->process_id = g_idle_add(process_queue, chan);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static int process_control(void *data)
@@ -727,7 +727,7 @@ static gboolean process_queue(void *user_data)
 	chan->process_id = 0;
 
 	if (p != NULL)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	while ((p = g_queue_pop_head(chan->queue))) {
 
@@ -738,12 +738,12 @@ static gboolean process_queue(void *user_data)
 	}
 
 	if (p == NULL)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	chan->p = p;
 	p->timeout = g_timeout_add_seconds(2, req_timeout, chan);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 
 }
 
@@ -1653,7 +1653,7 @@ static gboolean repeat_timeout(gpointer user_data)
 	avctp_passthrough_release(session, session->key.op);
 	avctp_passthrough_press(session, session->key.op);
 
-	return TRUE;
+	return G_SOURCE_CONTINUE;
 }
 
 static void release_pressed(struct avctp *session)
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b7a7d9c..f1815cb 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -627,7 +627,7 @@ static gboolean stream_close_timeout(gpointer user_data)
 
 	close_stream(stream);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean stream_open_timeout(gpointer user_data)
@@ -642,7 +642,7 @@ static gboolean stream_open_timeout(gpointer user_data)
 
 	avdtp_abort(stream->session, stream);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 void avdtp_error_init(struct avdtp_error *err, uint8_t category, int id)
@@ -1178,18 +1178,18 @@ static gboolean disconnect_timeout(gpointer user_data)
 	service = btd_device_get_service(session->device, A2DP_SINK_UUID);
 	if (service && stream_setup) {
 		sink_setup_stream(service, session);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	service = btd_device_get_service(session->device, A2DP_SOURCE_UUID);
 	if (service && stream_setup) {
 		source_setup_stream(service, session);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	connection_lost(session, ETIMEDOUT);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void set_disconnect_timer(struct avdtp *session)
@@ -2667,7 +2667,7 @@ static gboolean request_timeout(gpointer user_data)
 
 	cancel_request(session, ETIMEDOUT);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static int send_req(struct avdtp *session, gboolean priority,
@@ -3298,7 +3298,7 @@ static gboolean process_discover(gpointer data)
 
 	finalize_discovery(session, 0);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cd027c6..b3a1873 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3323,7 +3323,7 @@ static gboolean connect_browsing(gpointer user_data)
 
 	avctp_connect_browsing(session->conn);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void avrcp_connect_browsing(struct avrcp *session)
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 6150c8a..bce72e9 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1306,13 +1306,13 @@ static gboolean process_metadata_changed(void *user_data)
 
 	item = g_hash_table_lookup(mp->track, "Item");
 	if (item == NULL)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					item, MEDIA_ITEM_INTERFACE,
 					"Metadata");
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 void media_player_set_metadata(struct media_player *mp,
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 6ecc985..3ad9e75 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -307,7 +307,7 @@ static gboolean controlpoint_timeout(gpointer user_data)
 	req->csc->pending_req = NULL;
 	g_free(req);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 7b4e799..d7d0699 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1536,12 +1536,12 @@ static gboolean echo_timeout(gpointer data)
 
 	fd = mcap_mdl_get_fd(chan->mdl);
 	if (fd < 0)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	io = g_io_channel_unix_new(fd);
 	g_io_channel_shutdown(io, TRUE, NULL);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void hdp_echo_connect_cb(struct mcap_mdl *mdl, GError *err,
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 6d821f3..37b5789 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -463,7 +463,7 @@ static gboolean wait_response_timer(gpointer data)
 	mcl->mi->mcl_disconnected_cb(mcl, mcl->mi->user_data);
 	mcap_cache_mcl(mcl);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 gboolean mcap_create_mdl(struct mcap_mcl *mcl,
diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index 0d9f17d..aea0202 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -517,15 +517,15 @@ static gboolean sync_send_indication(gpointer user_data)
 	int sent;
 
 	if (!user_data)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	mcl = user_data;
 
 	if (!caps(mcl))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	cmd = g_new0(mcap_md_sync_info_ind, 1);
 
@@ -557,12 +557,12 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 	int delay;
 
 	if (!user_data)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	mcl = user_data;
 
 	if (!mcl->csp->set_data)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	data = mcl->csp->set_data;
 	update = data->update;
@@ -573,17 +573,17 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 
 	if (!caps(mcl)) {
 		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	if (!get_all_clocks(mcl, &btclock, &base_time, &tmstamp)) {
 		send_sync_set_rsp(mcl, MCAP_UNSPECIFIED_ERROR, 0, 0, 0);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	if (get_btrole(mcl) != role) {
 		send_sync_set_rsp(mcl, MCAP_INVALID_OPERATION, 0, 0, 0);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	reset = (new_tmstamp != MCAP_TMSTAMP_DONTSET);
@@ -624,7 +624,7 @@ static gboolean proc_sync_set_req_phase2(gpointer user_data)
 	if (update)
 		sync_send_indication(mcl);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6523161..bd0886e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -668,23 +668,23 @@ static gboolean input_device_auto_reconnect(gpointer user_data)
 	 * or is marked for removal. */
 	if (device_is_temporary(idev->device) ||
 					device_is_connected(idev->device))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	/* Only attempt an auto-reconnect for at most 3 minutes (6 * 30s). */
 	if (idev->reconnect_attempt >= 6)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	/* Check if the profile is already connected. */
 	if (idev->ctrl_io)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	if (is_connected(idev))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	idev->reconnect_attempt++;
 	dev_connect(idev);
 
-	return TRUE;
+	return G_SOURCE_CONTINUE;
 }
 
 static const char * const _reconnect_mode_str[] = {
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 960a1fe..5008ea1 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -354,7 +354,7 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 
 	cancel_connection(nc, -ETIMEDOUT);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static int bnep_connect(struct network_conn *nc)
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index eaa5b0d..a894235 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -304,7 +304,7 @@ static gboolean immediate_timeout(gpointer user_data)
 	monitor->immediateto = 0;
 
 	if (g_strcmp0(monitor->immediatelevel, "none") == 0)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	if (monitor->attrib) {
 		uint8_t value = ALERT_NONE;
@@ -319,7 +319,7 @@ static gboolean immediate_timeout(gpointer user_data)
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
 				PROXIMITY_INTERFACE, "ImmediateAlertLevel");
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void immediate_written(gpointer user_data)
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 63314a7..81a5c58 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -583,7 +583,7 @@ static gboolean guard_timeout(gpointer data)
 	struct sap_connection *conn = server->conn;
 
 	if (!conn)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	DBG("conn %p state %d pr 0x%02x", conn, conn->state,
 						conn->processing_req);
@@ -613,7 +613,7 @@ static gboolean guard_timeout(gpointer data)
 		break;
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void sap_set_connected(struct sap_server *server)
diff --git a/src/adapter.c b/src/adapter.c
index d904a56..80e7903 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -542,7 +542,7 @@ static gboolean pairable_timeout_handler(gpointer user_data)
 
 	set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x00);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void trigger_pairable_timeout(struct btd_adapter *adapter)
@@ -1125,7 +1125,7 @@ static gboolean passive_scanning_timeout(gpointer user_data)
 				adapter->dev_id, sizeof(cp), &cp,
 				passive_scanning_complete, adapter, NULL);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void trigger_passive_scanning(struct btd_adapter *adapter)
@@ -1300,12 +1300,12 @@ static gboolean start_discovery_timeout(gpointer user_data)
 		 */
 		if (adapter->discovery_type == new_type) {
 			if (adapter->discovering)
-				return FALSE;
+				return G_SOURCE_REMOVE;
 
 			adapter->discovering = true;
 			g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
-			return FALSE;
+			return G_SOURCE_REMOVE;
 		}
 
 		/*
@@ -1328,7 +1328,7 @@ static gboolean start_discovery_timeout(gpointer user_data)
 				adapter->dev_id, sizeof(cp), &cp,
 				start_discovery_complete, adapter, NULL);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
@@ -1534,7 +1534,7 @@ static gboolean remove_temp_devices(gpointer user_data)
 			adapter_remove_device(adapter, dev);
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void discovery_destroy(void *user_data)
@@ -2381,7 +2381,7 @@ static gboolean load_ltks_timeout(gpointer user_data)
 	mgmt_cancel(adapter->mgmt, adapter->load_ltks_id);
 	adapter->load_ltks_id = 0;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void load_ltks_complete(uint8_t status, uint16_t length,
@@ -4006,7 +4006,7 @@ static gboolean confirm_name_timeout(gpointer user_data)
 	mgmt_cancel(adapter->mgmt, adapter->confirm_name_id);
 	adapter->confirm_name_id = 0;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void confirm_name_complete(uint8_t status, uint16_t length,
@@ -4412,7 +4412,7 @@ next:
 
 	dbus_error_free(&err);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
@@ -5029,7 +5029,7 @@ static gboolean pair_device_timeout(gpointer user_data)
 
 	adapter_cancel_bonding(adapter, &data->bdaddr, data->addr_type);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void pair_device_complete(uint8_t status, uint16_t length,
diff --git a/src/device.c b/src/device.c
index 82b66e6..183c4bf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -364,7 +364,7 @@ static gboolean store_device_info_cb(gpointer user_data)
 	g_key_file_free(key_file);
 	g_free(uuids);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static bool device_address_is_private(struct btd_device *dev)
@@ -966,7 +966,7 @@ static gboolean do_disconnect(gpointer user_data)
 	btd_adapter_disconnect_device(device->adapter, &device->bdaddr,
 							device->bdaddr_type);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 int device_block(struct btd_device *device, gboolean update_only)
@@ -3680,7 +3680,7 @@ static gboolean start_discovery(gpointer user_data)
 
 	device->discov_timer = 0;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 void device_set_paired(struct btd_device *device, gboolean value)
@@ -3794,7 +3794,7 @@ static gboolean svc_idle_cb(gpointer user_data)
 
 	g_free(cb);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 unsigned int device_wait_for_svc_complete(struct btd_device *dev,
@@ -3867,7 +3867,7 @@ static gboolean device_bonding_retry(gpointer data)
 	int err;
 
 	if (!bonding)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	DBG("retrying bonding");
 	bonding->retry_timer = 0;
@@ -3888,7 +3888,7 @@ static gboolean device_bonding_retry(gpointer data)
 	if (err < 0)
 		device_bonding_complete(device, bonding->status);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 int device_bonding_attempt_retry(struct btd_device *device)
@@ -4381,13 +4381,13 @@ static gboolean notify_attios(gpointer user_data)
 	struct btd_device *device = user_data;
 
 	if (device->attrib == NULL)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	g_slist_foreach(device->attios_offline, attio_connected, device->attrib);
 	device->attios = g_slist_concat(device->attios, device->attios_offline);
 	device->attios_offline = NULL;
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 guint btd_device_add_attio_callback(struct btd_device *device,
diff --git a/src/main.c b/src/main.c
index 91d90b4..d88b1d5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -298,7 +298,7 @@ void btd_exit(void)
 static gboolean quit_eventloop(gpointer user_data)
 {
 	btd_exit();
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
@@ -446,7 +446,7 @@ static gboolean watchdog_callback(gpointer user_data)
 {
 	sd_notify(0, "WATCHDOG=1");
 
-	return TRUE;
+	return G_SOURCE_CONTINUE;
 }
 
 static gboolean parse_debug(const char *key, const char *value,
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 51f3048..35e2bfd 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -59,7 +59,7 @@ static gboolean cached_session_expired(gpointer user_data)
 
 	g_free(cached);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 0ea191f..5cae951 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -284,7 +284,7 @@ static gboolean start_stack(gpointer user_data)
 
 	bthost_start(hciemu->host_stack);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 struct hciemu *hciemu_new(enum hciemu_type type)
diff --git a/src/shared/tester.c b/src/shared/tester.c
index f3edd74..24d5bb9 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -311,7 +311,7 @@ static gboolean teardown_callback(gpointer user_data)
 	print_progress(test->name, COLOR_MAGENTA, "teardown");
 	test->teardown_func(test->test_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean test_timeout(gpointer user_data)
@@ -321,14 +321,14 @@ static gboolean test_timeout(gpointer user_data)
 	test->timeout_id = 0;
 
 	if (!test_current)
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	test->result = TEST_RESULT_TIMED_OUT;
 	print_progress(test->name, COLOR_RED, "test timed out");
 
 	g_idle_add(teardown_callback, test);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void next_test_case(void)
@@ -372,7 +372,7 @@ static gboolean setup_callback(gpointer user_data)
 	print_progress(test->name, COLOR_BLUE, "setup");
 	test->setup_func(test->test_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean run_callback(gpointer user_data)
@@ -384,7 +384,7 @@ static gboolean run_callback(gpointer user_data)
 	print_progress(test->name, COLOR_BLACK, "run");
 	test->test_func(test->test_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean done_callback(gpointer user_data)
@@ -396,7 +396,7 @@ static gboolean done_callback(gpointer user_data)
 	print_progress(test->name, COLOR_BLACK, "done");
 	next_test_case();
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 void tester_pre_setup_complete(void)
@@ -585,7 +585,7 @@ static gboolean start_tester(gpointer user_data)
 
 	next_test_case();
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 struct wait_data {
@@ -605,7 +605,7 @@ static gboolean wait_callback(gpointer user_data)
 	if (wait->seconds > 0) {
 		print_progress(test->name, COLOR_BLACK, "%u seconds left",
 								wait->seconds);
-		return TRUE;
+		return G_SOURCE_CONTINUE;
 	}
 
 	print_progress(test->name, COLOR_BLACK, "waiting done");
@@ -614,7 +614,7 @@ static gboolean wait_callback(gpointer user_data)
 
 	g_free(wait);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 void tester_wait(unsigned int seconds, tester_wait_func_t func,
diff --git a/tools/btiotest.c b/tools/btiotest.c
index a77eba1..562de58 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -96,7 +96,7 @@ static gboolean disconn_timeout(gpointer user_data)
 
 	g_io_channel_shutdown(data->io, TRUE, NULL);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void update_sec_level(struct io_data *data)
@@ -199,7 +199,7 @@ static gboolean confirm_timeout(gpointer user_data)
 	if (data->reject >= 0) {
 		printf("Rejecting connection\n");
 		g_io_channel_shutdown(data->io, TRUE, NULL);
-		return FALSE;
+		return G_SOURCE_REMOVE;
 	}
 
 	printf("Accepting connection\n");
@@ -215,7 +215,7 @@ static gboolean confirm_timeout(gpointer user_data)
 		io_data_unref(data);
 	}
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void confirm_cb(GIOChannel *io, gpointer user_data)
diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 685729a..6353b59 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -715,7 +715,7 @@ static gboolean timeout_test(gpointer user_data)
 
 	g_assert_not_reached();
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gboolean emit_string_change(void *user_data)
@@ -730,7 +730,7 @@ static gboolean emit_string_change(void *user_data)
 	context->timeout_source = g_timeout_add_seconds(2, timeout_test,
 								context);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void proxy_string_changed(GDBusProxy *proxy, void *user_data)
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index ef05047..171e663 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -464,7 +464,7 @@ static gboolean cancel_transfer(gpointer user_data)
 	if (d->id > 0)
 		g_obex_cancel_transfer(d->id, transfer_complete, user_data);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static gssize abort_data(void *buf, gsize len, gpointer user_data)
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 66307c2..cd51009 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -92,13 +92,13 @@ static gboolean timeout(gpointer user_data)
 	GError **err = user_data;
 
 	if (!g_main_loop_is_running(mainloop))
-		return FALSE;
+		return G_SOURCE_REMOVE;
 
 	g_set_error(err, TEST_ERROR, TEST_ERROR_TIMEOUT, "Timed out");
 
 	g_main_loop_quit(mainloop);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void connect_rsp(GObex *obex, GError *err, GObexPacket *rsp,
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 6d699e2..03046d7 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -209,7 +209,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	g_assert(len == pdu_len);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
 }
 
 static void context_increment(struct context *context)
-- 
1.8.4.2


