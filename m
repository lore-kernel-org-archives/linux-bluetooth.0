Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v7 8/8] audio: Send transport path to telephony agent
Date: Fri,  6 Jan 2012 16:07:55 +0100
Message-Id: <1325862475-11607-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com>
References: <1325862475-11607-1-git-send-email-frederic.danis@linux.intel.com>
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
 audio/headset.c   |   29 +++++++++++++++++++++++++++++
 audio/headset.h   |    3 +++
 audio/media.c     |    9 ++++++++-
 audio/telephony.c |   19 +++++++++++++++++++
 audio/telephony.h |    2 ++
 audio/transport.c |   14 +++++++++++---
 6 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 6631de3..ba4d91e 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -109,6 +109,7 @@ struct headset {
 	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
 	const char *connecting_uuid;
+	const char *connecting_path;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -408,6 +409,8 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	hs->slc = telephony_device_connecting(chan, dev);
 	hs->connecting_uuid = NULL;
+	telephony_set_media_transport_path(hs->slc, hs->connecting_path);
+	hs->connecting_path = NULL;
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
@@ -539,6 +542,7 @@ failed_not_supported:
 failed:
 	p->svclass = 0;
 	hs->connecting_uuid = NULL;
+	hs->connecting_path = NULL;
 	pending_connect_finalize(dev);
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
@@ -1222,6 +1226,31 @@ const char *headset_get_connecting_uuid(struct audio_device *dev)
 	return hs->connecting_uuid;
 }
 
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path)
+{
+	struct headset *hs = dev->headset;
+
+	DBG("MediaTransport path: %s", path);
+
+	if (hs->slc == NULL) {
+		hs->connecting_path = path;
+		return;
+	}
+
+	telephony_set_media_transport_path(hs->slc, path);
+}
+
+const char *headset_get_telephony_agent_name(struct audio_device *dev)
+{
+	struct headset *hs = dev->headset;
+
+	if (hs == NULL || hs->slc == NULL)
+		return NULL;
+
+	return telephony_get_agent_name(hs->slc);
+}
+
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
diff --git a/audio/headset.h b/audio/headset.h
index f0051fd..259fec5 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -107,3 +107,6 @@ void headset_shutdown(struct audio_device *dev);
 void headset_slc_complete(struct audio_device *dev);
 void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
 const char *headset_get_connecting_uuid(struct audio_device *dev);
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path);
+const char *headset_get_telephony_agent_name(struct audio_device *dev);
diff --git a/audio/media.c b/audio/media.c
index a363b8e..33eb14a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -440,6 +440,7 @@ static void headset_state_changed(struct audio_device *dev,
 					void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	const char *path;
 
 	DBG("");
 
@@ -455,6 +456,8 @@ static void headset_state_changed(struct audio_device *dev,
 	case HEADSET_STATE_CONNECTING:
 		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
 								dev, NULL);
+		path = media_transport_get_path(endpoint->transport);
+		headset_set_media_transport_path(dev, path);
 		break;
 	case HEADSET_STATE_CONNECTED:
 		break;
@@ -669,14 +672,18 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					strcasecmp(uuid, HSP_AG_UUID) == 0) {
 		struct audio_device *dev;
+		const char *t_path;
 
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
 		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
 						AUDIO_HEADSET_INTERFACE, TRUE);
-		if (dev)
+		if (dev) {
 			set_configuration(endpoint, dev, NULL, 0,
 						headset_setconf_cb, dev, NULL);
+			t_path = media_transport_get_path(endpoint->transport);
+			headset_set_media_transport_path(dev, t_path);
+		}
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 					strcasecmp(uuid, HSP_HS_UUID) == 0) {
 		struct audio_device *dev;
diff --git a/audio/telephony.c b/audio/telephony.c
index 0f7a0f1..13aa818 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -65,6 +65,7 @@ struct tel_device {
 	char			*path;		/* agent object path */
 	struct default_agent	*properties;
 	GIOChannel		*rfcomm;
+	const char		*transport_path;
 	uint16_t		version;
 	uint16_t		features;
 };
@@ -218,6 +219,10 @@ static gboolean agent_sendfd(struct tel_device *dev, int fd,
 		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
 							&dev->features);
 
+	if (dev->transport_path != NULL)
+		dict_append_entry(&dict, "Transport", DBUS_TYPE_OBJECT_PATH,
+							&dev->transport_path);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	if (dbus_connection_send_with_reply(connection, msg, &call, -1)
@@ -380,6 +385,20 @@ void telephony_device_disconnected(void *telephony_device)
 	DBG("telephony-dbus: device %p disconnected", telephony_device);
 }
 
+void telephony_set_media_transport_path(void *slc, const char *path)
+{
+	struct tel_device *dev = slc;
+
+	dev->transport_path = path;
+}
+
+const char *telephony_get_agent_name(void *slc)
+{
+	struct tel_device *dev = slc;
+
+	return dev->name;
+}
+
 static sdp_record_t *hsp_hs_record(struct tel_agent * agent)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
diff --git a/audio/telephony.h b/audio/telephony.h
index 4632003..edae417 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -52,6 +52,8 @@ void *telephony_device_connecting(GIOChannel *io, void *telephony_device);
 void telephony_device_connected(void *telephony_device);
 void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
+void telephony_set_media_transport_path(void *slc, const char *path);
+const char *telephony_get_agent_name(void *slc);
 
 void *telephony_agent_by_uuid(void *adapter, const char *uuid);
 
diff --git a/audio/transport.c b/audio/transport.c
index 2f85c39..f970a06 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -833,8 +833,9 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	struct media_transport *transport = data;
 	DBusMessageIter iter;
 	DBusMessageIter value;
-	const char *property, *sender;
+	const char *property, *sender, *tel_agent;
 	GSList *l;
+	gboolean sender_ok = FALSE;
 	int err;
 
 	if (!dbus_message_iter_init(msg, &iter))
@@ -858,12 +859,19 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 		struct media_owner *owner = l->data;
 
 		if (g_strcmp0(owner->name, sender) == 0) {
-			err = transport->set_property(transport, property,
-								&value);
+			sender_ok = TRUE;
 			break;
 		}
 	}
 
+	/* Check if Telephony agent does this request */
+	tel_agent = headset_get_telephony_agent_name(transport->device);
+	if (tel_agent != NULL && g_strcmp0(tel_agent, sender) == 0)
+		sender_ok = TRUE;
+
+	if (sender_ok)
+		err = transport->set_property(transport, property, &value);
+
 	if (err < 0) {
 		if (err == -EINVAL)
 			return btd_error_invalid_args(msg);
-- 
1.7.1

