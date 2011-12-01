Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, frederic.danis@linux.intel.com
Subject: [RFC v2 4/4] audio: Send transport path to telephony agent
Date: Thu,  1 Dec 2011 15:16:30 +0100
Message-Id: <1322748990-14347-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1322748990-14347-1-git-send-email-frederic.danis@linux.intel.com>
References: <1322748990-14347-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c   |   19 +++++++++++++++++++
 audio/headset.h   |    2 ++
 audio/media.c     |    9 ++++++++-
 audio/telephony.c |   12 ++++++++++++
 audio/telephony.h |    1 +
 5 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 5de7ed0..9839ca2 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -109,6 +109,7 @@ struct headset {
 	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
 	void *connecting_agent;
+	const char *connecting_path;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -415,6 +416,8 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	hs->slc = telephony_device_connecting(chan, dev);
 	hs->connecting_agent = NULL;
+	telephony_set_media_transport_path(hs->slc, hs->connecting_path);
+	hs->connecting_path = NULL;
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
@@ -566,6 +569,7 @@ failed_not_supported:
 failed:
 	p->svclass = 0;
 	hs->connecting_agent = NULL;
+	hs->connecting_path = NULL;
 	pending_connect_finalize(dev);
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
@@ -1276,6 +1280,21 @@ void *headset_get_connecting_agent(struct audio_device *dev)
 	return hs->connecting_agent;
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
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
diff --git a/audio/headset.h b/audio/headset.h
index d74a69c..7eac876 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -107,3 +107,5 @@ void headset_shutdown(struct audio_device *dev);
 void headset_slc_complete(struct audio_device *dev);
 void headset_set_connecting_agent(struct audio_device *dev, void *agent);
 void *headset_get_connecting_agent(struct audio_device *dev);
+void headset_set_media_transport_path(struct audio_device *dev,
+							const char *path);
diff --git a/audio/media.c b/audio/media.c
index a2ef437..43ffcc2 100644
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
index 90e8699..416fd97 100644
--- a/audio/telephony.c
+++ b/audio/telephony.c
@@ -65,6 +65,7 @@ struct tel_device {
 	struct tel_agent	*agent;
 	struct audio_device	*au_dev;
 	GIOChannel		*rfcomm;
+	const char		*transport_path;
 	uint16_t		version;
 	uint16_t		features;
 };
@@ -220,6 +221,10 @@ static gboolean agent_sendfd(struct tel_device *dev, int fd,
 		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
 							&dev->features);
 
+	if (dev->transport_path != NULL)
+		dict_append_entry(&dict, "MediaTransportPath", DBUS_TYPE_STRING,
+							&dev->transport_path);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	if (dbus_connection_send_with_reply(connection, msg, &call, -1) == FALSE)
@@ -362,6 +367,13 @@ void telephony_device_disconnected(void *telephony_device)
 	DBG("telephony-dbus: device %p disconnected", telephony_device);
 }
 
+void telephony_set_media_transport_path(void *slc, const char *path)
+{
+	struct tel_device *dev = slc;
+
+	dev->transport_path = path;
+}
+
 gboolean telephony_get_ready_state(void)
 {
 	return find_agent(NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
diff --git a/audio/telephony.h b/audio/telephony.h
index d5d9f65..24afd28 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -52,6 +52,7 @@ void *telephony_device_connecting(GIOChannel *io, void *telephony_device);
 void telephony_device_connected(void *telephony_device);
 void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
+void telephony_set_media_transport_path(void *slc, const char *path);
 
 gboolean telephony_get_ready_state(void);
 uint32_t telephony_get_ag_features(void);
-- 
1.7.1

