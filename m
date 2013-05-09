Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 09/26] audio: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:39 -0300
Message-Id: <1368073016-28434-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate and prefer this one
over stdint.h.
---
 profiles/audio/a2dp.c      |  5 +++--
 profiles/audio/avctp.c     | 12 ++++++------
 profiles/audio/avdtp.c     | 24 ++++++++++++------------
 profiles/audio/avrcp.c     |  2 +-
 profiles/audio/control.c   |  2 +-
 profiles/audio/device.c    |  5 +++--
 profiles/audio/manager.c   |  2 +-
 profiles/audio/media.c     | 12 ++++++------
 profiles/audio/player.c    |  3 +--
 profiles/audio/sink.c      |  4 ++--
 profiles/audio/source.c    |  4 ++--
 profiles/audio/transport.c | 34 ++++++++++++++++++----------------
 12 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 215f4db..14e7686 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <errno.h>
 
@@ -62,7 +63,7 @@ struct a2dp_sep {
 	struct avdtp_local_sep *lsep;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
-	guint suspend_timer;
+	unsigned int suspend_timer;
 	gboolean delay_reporting;
 	gboolean locked;
 	gboolean suspending;
@@ -77,7 +78,7 @@ struct a2dp_setup_cb {
 	a2dp_config_cb_t config_cb;
 	a2dp_stream_cb_t resume_cb;
 	a2dp_stream_cb_t suspend_cb;
-	guint source_id;
+	unsigned int source_id;
 	void *user_data;
 	unsigned int id;
 };
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 21aeb6f..6260098 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -27,8 +27,8 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
-#include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
@@ -149,7 +149,7 @@ typedef int (*avctp_process_cb) (void *data);
 struct avctp_pending_req {
 	struct avctp_channel *chan;
 	uint8_t transaction;
-	guint timeout;
+	unsigned int timeout;
 	avctp_process_cb process;
 	void *data;
 	GDestroyNotify destroy;
@@ -159,7 +159,7 @@ struct avctp_channel {
 	struct avctp *session;
 	GIOChannel *io;
 	uint8_t transaction;
-	guint watch;
+	unsigned int watch;
 	uint16_t imtu;
 	uint16_t omtu;
 	uint8_t *buffer;
@@ -167,13 +167,13 @@ struct avctp_channel {
 	struct avctp_pending_req *p;
 	GQueue *queue;
 	GSList *processed;
-	guint process_id;
+	unsigned int process_id;
 	GDestroyNotify destroy;
 };
 
 struct key_pressed {
 	uint8_t op;
-	guint timer;
+	unsigned int timer;
 };
 
 struct avctp {
@@ -184,7 +184,7 @@ struct avctp {
 
 	int uinput;
 
-	guint auth_id;
+	unsigned int auth_id;
 	unsigned int passthrough_id;
 	unsigned int unit_id;
 	unsigned int subunit_id;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index bd73572..9e5a9a5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -26,9 +26,9 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
@@ -314,7 +314,7 @@ struct pending_req {
 	void *data;
 	size_t data_size;
 	struct avdtp_stream *stream; /* Set if the request targeted a stream */
-	guint timeout;
+	unsigned int timeout;
 	gboolean collided;
 };
 
@@ -370,13 +370,13 @@ struct avdtp_stream {
 	GSList *caps;
 	GSList *callbacks;
 	struct avdtp_service_capability *codec;
-	guint io_id;		/* Transport GSource ID */
-	guint timer;		/* Waiting for other side to close or open
-				 * the transport channel */
-	gboolean open_acp;	/* If we are in ACT role for Open */
-	gboolean close_int;	/* If we are in INT role for Close */
-	gboolean abort_int;	/* If we are in INT role for Abort */
-	guint start_timer;	/* Wait START command timer */
+	unsigned int io_id;		/* Transport GSource ID */
+	unsigned int timer;		/* Waiting for other side to close or
+					 * open the transport channel */
+	gboolean open_acp;		/* If we are in ACT role for Open */
+	gboolean close_int;		/* If we are in INT role for Close */
+	gboolean abort_int;		/* If we are in INT role for Abort */
+	unsigned int start_timer;	/* Wait START command timer */
 	gboolean delay_reporting;
 	uint16_t delay;		/* AVDTP 1.3 Delay Reporting feature */
 	gboolean starting;	/* only valid while sep state == OPEN */
@@ -397,10 +397,10 @@ struct avdtp {
 	/* True if the entire device is being disconnected */
 	gboolean device_disconnect;
 
-	guint auth_id;
+	unsigned int auth_id;
 
 	GIOChannel *io;
-	guint io_id;
+	unsigned int io_id;
 
 	GSList *seps; /* Elements of type struct avdtp_remote_sep * */
 
@@ -423,7 +423,7 @@ struct avdtp {
 
 	struct pending_req *req;
 
-	guint dc_timer;
+	unsigned int dc_timer;
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b7de051..69cf8c4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -28,7 +28,7 @@
 #endif
 
 #include <stdlib.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index cdba385..64d85f5 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -28,7 +28,7 @@
 #endif
 
 #include <stdlib.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <errno.h>
 #include <unistd.h>
 #include <assert.h>
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 3fa49ad..216aa37 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -64,8 +65,8 @@ struct dev_priv {
 	sink_state_t sink_state;
 	avctp_state_t avctp_state;
 
-	guint control_timer;
-	guint dc_id;
+	unsigned int control_timer;
+	unsigned int dc_id;
 
 	gboolean disconnecting;
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 15226e4..60c68fd 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -32,7 +32,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <sys/stat.h>
 #include <dirent.h>
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index cab79b5..c8cdf93 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -79,9 +79,9 @@ struct media_endpoint {
 	uint8_t			codec;		/* Endpoint codec */
 	uint8_t			*capabilities;	/* Endpoint property capabilities */
 	size_t			size;		/* Endpoint capabilities size */
-	guint			hs_watch;
-	guint			ag_watch;
-	guint			watch;
+	unsigned int			hs_watch;
+	unsigned int			ag_watch;
+	unsigned int			watch;
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
@@ -94,9 +94,9 @@ struct media_player {
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
-	guint			watch;
-	guint			properties_watch;
-	guint			track_watch;
+	unsigned int			watch;
+	unsigned int			properties_watch;
+	unsigned int			track_watch;
 	char			*status;
 	uint32_t		position;
 	uint32_t		duration;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e08e373..40d21ec 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -27,7 +27,6 @@
 #endif
 
 #include <stdlib.h>
-#include <stdint.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -87,7 +86,7 @@ struct media_player {
 	char			*status;
 	uint32_t		position;
 	GTimer			*progress;
-	guint			process_id;
+	unsigned int			process_id;
 	struct player_callback	*cb;
 	GSList			*pending;
 	GSList			*folders;
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 3969417..ce700ce 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -26,7 +26,7 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 
@@ -60,7 +60,7 @@ struct sink {
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint retry_id;
+	unsigned int retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
 	sink_state_t state;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 226c372..24cadf4 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -27,7 +27,7 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 
@@ -61,7 +61,7 @@ struct source {
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	unsigned int cb_id;
-	guint retry_id;
+	unsigned int retry_id;
 	avdtp_session_state_t session_state;
 	avdtp_state_t stream_state;
 	source_state_t state;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f585c3a..84a961e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 
 #include <glib.h>
@@ -67,14 +68,14 @@ static char *str_state[] = {
 
 struct media_request {
 	DBusMessage		*msg;
-	guint			id;
+	unsigned int			id;
 };
 
 struct media_owner {
 	struct media_transport	*transport;
 	struct media_request	*pending;
 	char			*name;
-	guint			watch;
+	unsigned int			watch;
 };
 
 struct a2dp_transport {
@@ -94,15 +95,15 @@ struct media_transport {
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
 	transport_state_t	state;
-	guint			hs_watch;
-	guint			source_watch;
-	guint			sink_watch;
-	guint			(*resume) (struct media_transport *transport,
+	unsigned int		hs_watch;
+	unsigned int		source_watch;
+	unsigned int		sink_watch;
+	unsigned int		(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
-	guint			(*suspend) (struct media_transport *transport,
+	unsigned int		(*suspend) (struct media_transport *transport,
 					struct media_owner *owner);
 	void			(*cancel) (struct media_transport *transport,
-								guint id);
+							unsigned int id);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -180,7 +181,8 @@ void media_transport_destroy(struct media_transport *transport)
 	g_free(path);
 }
 
-static struct media_request *media_request_create(DBusMessage *msg, guint id)
+static struct media_request *media_request_create(DBusMessage *msg,
+							unsigned int id)
 {
 	struct media_request *req;
 
@@ -323,13 +325,13 @@ fail:
 	media_transport_remove_owner(transport);
 }
 
-static guint resume_a2dp(struct media_transport *transport,
+static unsigned int resume_a2dp(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
-	guint id;
+	unsigned int id;
 
 	if (a2dp->session == NULL) {
 		a2dp->session = avdtp_get(transport->device);
@@ -377,7 +379,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	media_transport_remove_owner(transport);
 }
 
-static guint suspend_a2dp(struct media_transport *transport,
+static unsigned int suspend_a2dp(struct media_transport *transport,
 						struct media_owner *owner)
 {
 	struct a2dp_transport *a2dp = transport->data;
@@ -394,7 +396,7 @@ static guint suspend_a2dp(struct media_transport *transport,
 	return 0;
 }
 
-static void cancel_a2dp(struct media_transport *transport, guint id)
+static void cancel_a2dp(struct media_transport *transport, unsigned int id)
 {
 	a2dp_cancel(transport->device, id);
 }
@@ -449,7 +451,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	struct media_request *req;
-	guint id;
+	unsigned int id;
 
 	if (transport->owner != NULL)
 		return btd_error_not_authorized(msg);
@@ -477,7 +479,7 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	struct media_owner *owner;
 	struct media_request *req;
-	guint id;
+	unsigned int id;
 
 	if (transport->owner != NULL)
 		return btd_error_not_authorized(msg);
@@ -509,7 +511,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	struct media_owner *owner = transport->owner;
 	const char *sender;
 	struct media_request *req;
-	guint id;
+	unsigned int id;
 
 	sender = dbus_message_get_sender(msg);
 
-- 
1.8.2.2

