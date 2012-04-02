Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 8/9] audio: Send transport path to telephony agent
Date: Mon,  2 Apr 2012 15:11:22 +0200
Message-Id: <1333372283-10487-9-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333372283-10487-1-git-send-email-frederic.danis@linux.intel.com>
References: <1333372283-10487-1-git-send-email-frederic.danis@linux.intel.com>
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
 audio/transport.c |   23 +++++++++++++++++++++--
 6 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 3b1ca9d..2e85af0 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -109,6 +109,7 @@ struct headset {
 	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
 	const char *connecting_uuid;
+	const char *connecting_path;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -411,6 +412,8 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 						hs->connecting_uuid);
 	hs->slc = telephony_device_connecting(chan, dev, agent);
 	hs->connecting_uuid = NULL;
+	telephony_set_media_transport_path(hs->slc, hs->connecting_path);
+	hs->connecting_path = NULL;
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
@@ -543,6 +546,7 @@ failed_not_supported:
 failed:
 	p->svclass = 0;
 	hs->connecting_uuid = NULL;
+	hs->connecting_path = NULL;
 	pending_connect_finalize(dev);
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
@@ -1135,6 +1139,31 @@ void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid)
 	hs->connecting_uuid = uuid;
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
index 25a6563..6795eeb 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -106,3 +106,6 @@ void headset_shutdown(struct audio_device *dev);
 
 void headset_slc_complete(struct audio_device *dev);
 void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path);
+const char *headset_get_telephony_agent_name(struct audio_device *dev);
diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..58a51fa 100644
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
index 5c68f42..a7b1478 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -66,6 +66,7 @@ struct tel_device {
 	char			*path;		/* agent object path */
 	struct default_agent	*properties;
 	GIOChannel		*rfcomm;
+	const char		*transport_path;
 	uint16_t		version;
 	uint16_t		features;
 };
@@ -235,6 +236,10 @@ static gboolean agent_sendfd(struct tel_device *dev, int fd,
 		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
 							&dev->features);
 
+	if (dev->transport_path != NULL)
+		dict_append_entry(&dict, "Transport", DBUS_TYPE_OBJECT_PATH,
+							&dev->transport_path);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	if (dbus_connection_send_with_reply(connection, msg, &call, -1)
@@ -393,6 +398,20 @@ void telephony_device_disconnected(void *telephony_device)
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
 static sdp_record_t *hsp_ag_record(struct tel_agent * agent)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
diff --git a/audio/telephony.h b/audio/telephony.h
index 6d6a955..95c677e 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -53,6 +53,8 @@ void *telephony_device_connecting(GIOChannel *io, void *telephony_device,
 void telephony_device_connected(void *telephony_device);
 void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
+void telephony_set_media_transport_path(void *slc, const char *path);
+const char *telephony_get_agent_name(void *slc);
 
 void *telephony_agent_by_uuid(void *adapter, const char *uuid);
 
diff --git a/audio/transport.c b/audio/transport.c
index a092ac8..cb6866f 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -828,6 +828,18 @@ static int set_property_gateway(struct media_transport *transport,
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
@@ -836,6 +848,7 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter value;
 	const char *property, *sender;
 	GSList *l;
+	gboolean sender_ok = FALSE;
 	int err;
 
 	if (!dbus_message_iter_init(msg, &iter))
@@ -859,12 +872,18 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
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
1.7.1

