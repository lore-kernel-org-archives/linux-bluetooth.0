Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 09/14] audio: Send transport path to telephony agent
Date: Wed,  1 Aug 2012 11:08:45 +0200
Message-Id: <1343812131-19395-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the ability to set MediaTransport path to the HSP/HFP agent during
the call of the NewConnection method.
Accept MediaTransport property change from telephony agent in addition
to Media Endpoint.

This allows external program, implementing telephony agent, to change
Noise Reduction/Echo Cancellation (ECNR), Inband ringtone, speaker
and microphone volume settings of the audio system (i.e. Pulse Audio)
through the MediaTransport.
---
 audio/headset.c   |   31 +++++++++++++++++++++++++++++++
 audio/headset.h   |    3 +++
 audio/media.c     |   17 +++++++++++++++++
 audio/telephony.c |   18 ++++++++++++++++++
 audio/telephony.h |    3 +++
 audio/transport.c |   23 +++++++++++++++++++++--
 6 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index ec4db59..fe4e62d 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -109,6 +109,7 @@ struct headset {
 
 	GIOChannel *tmp_rfcomm;
 	const char *connecting_uuid;
+	const char *connecting_transport_path;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -403,6 +404,9 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 
 	hs->connecting_uuid = NULL;
+	telephony_set_media_transport_path(hs->tel_dev,
+						hs->connecting_transport_path);
+	hs->connecting_transport_path = NULL;
 
 	g_io_channel_unref(hs->tmp_rfcomm);
 	hs->tmp_rfcomm = NULL;
@@ -582,6 +586,7 @@ static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 						get_record_cb, device, NULL);
 	if (err < 0) {
 		hs->connecting_uuid = NULL;
+		hs->connecting_transport_path = NULL;
 		return err;
 	}
 
@@ -1137,6 +1142,31 @@ void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid)
 	hs->connecting_uuid = uuid;
 }
 
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path)
+{
+	struct headset *hs = dev->headset;
+
+	DBG("MediaTransport path: %s", path);
+
+	if (hs->tel_dev == NULL) {
+		hs->connecting_transport_path = path;
+		return;
+	}
+
+	telephony_set_media_transport_path(hs->tel_dev, path);
+}
+
+const char *headset_get_telephony_agent_name(struct audio_device *dev)
+{
+	struct headset *hs = dev->headset;
+
+	if (hs == NULL || hs->tel_dev == NULL)
+		return NULL;
+
+	return telephony_get_agent_name(hs->tel_dev);
+}
+
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
@@ -1183,6 +1213,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		}
 
 		dev->headset->connecting_uuid = NULL;
+		dev->headset->connecting_transport_path = NULL;
 
 		headset_close_rfcomm(dev);
 		emit_property_changed(dev->conn, dev->path,
diff --git a/audio/headset.h b/audio/headset.h
index 2915495..a20b587 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -105,3 +105,6 @@ void headset_shutdown(struct audio_device *dev);
 
 void headset_profile_connection_complete(struct audio_device *dev);
 void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path);
+const char *headset_get_telephony_agent_name(struct audio_device *dev);
diff --git a/audio/media.c b/audio/media.c
index ea6d582..c608c41 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -475,6 +475,7 @@ static void headset_state_changed(struct audio_device *dev,
 {
 	struct media_endpoint *endpoint = user_data;
 	struct media_transport *transport;
+	const char *path;
 
 	DBG("");
 
@@ -493,6 +494,13 @@ static void headset_state_changed(struct audio_device *dev,
 	case HEADSET_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
 								dev, NULL);
+
+		transport = find_device_transport(endpoint, dev);
+		if (transport == NULL)
+			break;
+
+		path = media_transport_get_path(transport);
+		headset_set_media_transport_path(dev, path);
 		break;
 	case HEADSET_STATE_CONNECTED:
 		break;
@@ -704,9 +712,18 @@ static gboolean endpoint_init_ag(struct media_endpoint *endpoint, int *err)
 
 	for (l = list; l != NULL; l = l->next) {
 		struct audio_device *dev = l->data;
+		struct media_transport *transport;
+		const char *path;
 
 		set_configuration(endpoint, dev, NULL, 0,
 						headset_setconf_cb, dev, NULL);
+
+		transport = find_device_transport(endpoint, dev);
+		if (transport == NULL)
+			break;
+
+		path = media_transport_get_path(transport);
+		headset_set_media_transport_path(dev, path);
 	}
 
 	g_slist_free(list);
diff --git a/audio/telephony.c b/audio/telephony.c
index 943c3aa..da1797f 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -111,6 +111,8 @@ struct telephony_agent {
  * It represents the connection between telephony agent (name, path and config)
  * and remote device (with its profile version and supported features if they
  * can be retrieved).
+ * If audio is used by profile, Media Transport path is stored to be sent to
+ * telephony agent during NewConnection method call.
  *
  * This is used after authentication completion and remote SDP record retrieval
  * (if supported by profile, i.e. HFP/HSP) until disconnection.
@@ -124,6 +126,7 @@ struct telephony_device {
 	uint16_t		version;	/* remote profile version */
 	uint16_t		features;	/* remote supported features */
 	GIOChannel		*rfcomm;	/* connected RFCOMM channel */
+	const char		*transport_path; /* MediaTransport path */
 	gboolean		pending_sdp;	/* SDP request is pending */
 	DBusPendingCall		*call;		/* D-Bus pending call */
 };
@@ -276,6 +279,10 @@ static gboolean agent_sendfd(struct telephony_device *tel_dev, int fd,
 		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
 							&tel_dev->features);
 
+	if (tel_dev->transport_path != NULL)
+		dict_append_entry(&dict, "Transport", DBUS_TYPE_OBJECT_PATH,
+						&tel_dev->transport_path);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	if (!dbus_connection_send_with_reply(connection, msg,
@@ -450,6 +457,17 @@ void telephony_device_disconnect(struct telephony_device *device)
 	g_free(device);
 }
 
+void telephony_set_media_transport_path(struct telephony_device *device,
+						const char *path)
+{
+	device->transport_path = path;
+}
+
+const char *telephony_get_agent_name(struct telephony_device *device)
+{
+	return device->name;
+}
+
 static sdp_record_t *hsp_ag_record(struct telephony_agent *agent)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
diff --git a/audio/telephony.h b/audio/telephony.h
index 1e20087..42ce580 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -52,6 +52,9 @@ struct telephony_device *telephony_device_connecting(GIOChannel *io,
 					struct audio_device *au_dev,
 					const char *uuid);
 void telephony_device_disconnect(struct telephony_device *device);
+void telephony_set_media_transport_path(struct telephony_device *device,
+						const char *path);
+const char *telephony_get_agent_name(struct telephony_device *device);
 
 gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
 						const char *uuid);
diff --git a/audio/transport.c b/audio/transport.c
index 6d4ad55..7236e43 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -857,6 +857,18 @@ static int set_property_gateway(struct media_transport *transport,
 	return -EINVAL;
 }
 
+static gboolean check_telephony_agent_name(struct media_transport *transport,
+							const char *sender)
+{
+	const char *tel_agent;
+
+	tel_agent = headset_get_telephony_agent_name(transport->device);
+	if (tel_agent != NULL && g_strcmp0(tel_agent, sender) == 0)
+		return TRUE;
+
+	return FALSE;
+}
+
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -865,6 +877,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter value;
 	const char *property, *sender;
 	GSList *l;
+	gboolean sender_ok = FALSE;
 	int err;
 
 	if (!dbus_message_iter_init(msg, &iter))
@@ -888,12 +901,18 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 		struct media_owner *owner = l->data;
 
 		if (g_strcmp0(owner->name, sender) == 0) {
-			err = transport->set_property(transport, property,
-								&value);
+			sender_ok = TRUE;
 			break;
 		}
 	}
 
+	/* Check if Telephony agent does this request */
+	if (!sender_ok)
+		sender_ok = check_telephony_agent_name(transport, sender);
+
+	if (sender_ok)
+		err = transport->set_property(transport, property, &value);
+
 	if (err < 0) {
 		if (err == -EINVAL)
 			return btd_error_invalid_args(msg);
-- 
1.7.9.5

