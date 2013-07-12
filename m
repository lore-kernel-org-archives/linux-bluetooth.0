Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 04/10] transport: Add API to register drivers
Date: Fri, 12 Jul 2013 12:54:37 +0200
Message-Id: <1373626483-2031-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Let plugins define the operations associated to a specific transport
type.
---
 profiles/audio/transport.c | 141 ++++++++++++++++++++++++++++++---------------
 profiles/audio/transport.h |  17 ++++++
 2 files changed, 112 insertions(+), 46 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 9e9efe3..14e4b9b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -96,17 +96,12 @@ struct media_transport {
 	uint16_t		delay;
 	uint16_t		volume;
 	transport_state_t	state;
-	guint			(*resume) (struct media_transport *transport,
-					struct media_owner *owner);
-	guint			(*suspend) (struct media_transport *transport,
-					struct media_owner *owner);
-	void			(*cancel) (struct media_transport *transport,
-								guint id);
-	GDestroyNotify		destroy;
+	struct media_transport_driver *driver;
 	void			*data;
 };
 
 static GSList *transports = NULL;
+static GSList *drivers = NULL;
 
 static const char *state2str(transport_state_t state)
 {
@@ -216,7 +211,7 @@ static void media_owner_remove(struct media_owner *owner)
 					dbus_message_get_member(req->msg));
 
 	if (req->id)
-		transport->cancel(transport, req->id);
+		transport->driver->cancel(transport, req->id);
 
 	owner->pending = NULL;
 	if (req->msg)
@@ -253,7 +248,7 @@ static void media_transport_remove_owner(struct media_transport *transport)
 	media_owner_free(owner);
 
 	if (state_in_use(transport->state))
-		transport->suspend(transport, NULL);
+		transport->driver->suspend(transport, NULL);
 }
 
 static gboolean media_transport_set_fd(struct media_transport *transport,
@@ -344,9 +339,6 @@ static guint resume_a2dp(struct media_transport *transport,
 		return 0;
 	}
 
-	if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
-
 	return id;
 }
 
@@ -451,12 +443,15 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(msg);
-	id = transport->resume(transport, owner);
+	id = transport->driver->resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
 
+	if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
+
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 	media_transport_set_owner(transport, owner);
@@ -482,7 +477,7 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
-	id = transport->resume(transport, owner);
+	id = transport->driver->resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
@@ -522,7 +517,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 	transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
 
-	id = transport->suspend(transport, owner);
+	id = transport->driver->suspend(transport, owner);
 	if (id == 0) {
 		media_transport_remove_owner(transport);
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -714,8 +709,7 @@ static void media_transport_free(void *data)
 	if (transport->owner)
 		media_transport_remove_owner(transport);
 
-	if (transport->destroy != NULL)
-		transport->destroy(transport->data);
+	transport->driver->destroy(transport->data);
 
 	g_free(transport->configuration);
 	g_free(transport->path);
@@ -766,52 +760,92 @@ static void source_state_changed(struct audio_device *dev,
 		transport_update_playing(transport, FALSE);
 }
 
+static void *init_a2dp_source(struct media_transport *transport)
+{
+	struct a2dp_transport *a2dp;
+
+	a2dp = g_new0(struct a2dp_transport, 1);
+	a2dp->sink_watch = sink_add_state_cb(transport->device,
+							sink_state_changed,
+							transport);
+
+	return a2dp;
+}
+
+static void *init_a2dp_sink(struct media_transport *transport)
+{
+	struct a2dp_transport *a2dp;
+
+	a2dp = g_new0(struct a2dp_transport, 1);
+	a2dp->source_watch = source_add_state_cb(transport->device,
+							source_state_changed,
+							transport);
+
+	transport->volume = 127;
+	avrcp_set_volume(transport->device, transport->volume);
+
+	return a2dp;
+}
+
+static struct media_transport_driver a2dp_source_driver = {
+	.uuid = A2DP_SOURCE_UUID,
+	.init = init_a2dp_source,
+	.resume = resume_a2dp,
+	.suspend = suspend_a2dp,
+	.cancel = cancel_a2dp,
+	.destroy = destroy_a2dp
+};
+
+static struct media_transport_driver a2dp_sink_driver = {
+	.uuid = A2DP_SINK_UUID,
+	.init = init_a2dp_sink,
+	.resume = resume_a2dp,
+	.suspend = suspend_a2dp,
+	.cancel = cancel_a2dp,
+	.destroy = destroy_a2dp
+};
+
 struct media_transport *media_transport_create(struct audio_device *device,
 						uint8_t *configuration,
 						size_t size, void *data)
 {
 	struct media_endpoint *endpoint = data;
 	struct media_transport *transport;
+	GSList *l;
 	const char *uuid;
 	static int fd = 0;
 
+	if (drivers == NULL) {
+		media_transport_driver_register(&a2dp_source_driver);
+		media_transport_driver_register(&a2dp_sink_driver);
+	}
+
+	uuid = media_endpoint_get_uuid(endpoint);
+
+	for (l = drivers; l != NULL; l = g_slist_next(l)) {
+		struct media_transport_driver *driver = l->data;
+
+		if (strcasecmp(uuid, driver->uuid) == 0)
+			break;
+	}
+
+	if (l == NULL) {
+		DBG("No driver found for UUID %s", uuid);
+		return NULL;
+	}
+
 	transport = g_new0(struct media_transport, 1);
+	transport->driver = l->data;
 	transport->device = device;
 	transport->endpoint = endpoint;
 	transport->configuration = g_new(uint8_t, size);
 	memcpy(transport->configuration, configuration, size);
 	transport->size = size;
-	transport->path = g_strdup_printf("%s/fd%d",
-				device_get_path(device->btd_dev), fd++);
 	transport->fd = -1;
 	transport->volume = -1;
-
-	uuid = media_endpoint_get_uuid(endpoint);
-	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
-			strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
-		struct a2dp_transport *a2dp;
-
-		a2dp = g_new0(struct a2dp_transport, 1);
-
-		transport->resume = resume_a2dp;
-		transport->suspend = suspend_a2dp;
-		transport->cancel = cancel_a2dp;
-		transport->data = a2dp;
-		transport->destroy = destroy_a2dp;
-
-		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
-			a2dp->sink_watch = sink_add_state_cb(device,
-							sink_state_changed,
-							transport);
-		} else {
-			transport->volume = 127;
-			avrcp_set_volume(device, transport->volume);
-			a2dp->source_watch = source_add_state_cb(device,
-							source_state_changed,
-							transport);
-		}
-	} else
-		goto fail;
+	transport->data = transport->driver->init(transport);
+	transport->path = g_strdup_printf("%s/fd%d",
+				device_get_path(device->btd_dev), fd++);
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				transport->path, MEDIA_TRANSPORT_INTERFACE,
@@ -854,6 +888,11 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 	return transport->device;
 }
 
+void *media_transport_get_data(struct media_transport *transport)
+{
+	return transport->data;
+}
+
 uint16_t media_transport_get_volume(struct media_transport *transport)
 {
 	return transport->volume;
@@ -911,3 +950,13 @@ void media_transport_update_device_volume(struct audio_device *dev,
 			media_transport_update_volume(transport, volume);
 	}
 }
+
+void media_transport_driver_register(struct media_transport_driver *driver)
+{
+	drivers = g_slist_append(drivers, driver);
+}
+
+void media_transport_driver_unregister(struct media_transport_driver *driver)
+{
+	drivers = g_slist_remove(drivers, driver);
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 5e5da20..c276428 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -23,6 +23,19 @@
  */
 
 struct media_transport;
+struct media_owner;
+
+struct media_transport_driver {
+	const char *uuid;
+
+	void *(*init) (struct media_transport *transport);
+	guint (*resume) (struct media_transport *transport,
+						struct media_owner *owner);
+	guint (*suspend) (struct media_transport *transport,
+						struct media_owner *owner);
+	void (*cancel) (struct media_transport *transport, guint id);
+	GDestroyNotify destroy;
+};
 
 struct media_transport *media_transport_create(struct audio_device *device,
 						uint8_t *configuration,
@@ -31,6 +44,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
 struct audio_device *media_transport_get_dev(struct media_transport *transport);
+void *media_transport_get_data(struct media_transport *transport);
 uint16_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
@@ -42,3 +56,6 @@ void transport_get_properties(struct media_transport *transport,
 uint8_t media_transport_get_device_volume(struct audio_device *dev);
 void media_transport_update_device_volume(struct audio_device *dev,
 								uint8_t volume);
+
+void media_transport_driver_register(struct media_transport_driver *driver);
+void media_transport_driver_unregister(struct media_transport_driver *driver);
-- 
1.8.1.4

