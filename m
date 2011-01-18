Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Add proper tracking mechanism to NREC
Date: Tue, 18 Jan 2011 12:00:15 +0200
Message-Id: <1295344815-1404-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

NREC may change during the connections so it has to be tracked in order
to signal changes to applications.
---
 audio/headset.c   |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/headset.h   |    6 +++++
 audio/transport.c |   17 ++++++++++++++
 3 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 53a594d..62596c4 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -109,6 +109,12 @@ struct headset_state_callback {
 	unsigned int id;
 };
 
+struct headset_nrec_callback {
+	unsigned int id;
+	headset_nrec_cb cb;
+	void *user_data;
+};
+
 struct connect_cb {
 	unsigned int id;
 	headset_stream_cb_t cb;
@@ -137,6 +143,7 @@ struct headset_slc {
 	gboolean inband_ring;
 	gboolean nrec;
 	gboolean nrec_req;
+	GSList *nrec_cbs;
 
 	int sp_gain;
 	int mic_gain;
@@ -1096,8 +1103,17 @@ int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err)
 	struct headset *hs = device->headset;
 	struct headset_slc *slc = hs->slc;
 
-	if (err == CME_ERROR_NONE)
+	if (err == CME_ERROR_NONE) {
+		GSList *l;
+
+		for (l = slc->nrec_cbs; l; l = l->next) {
+			struct headset_nrec_callback *nrec_cb = l->data;
+
+			nrec_cb->cb(device, slc->nrec_req, nrec_cb->user_data);
+		}
+
 		slc->nrec = hs->slc->nrec_req;
+	}
 
 	return telephony_generic_rsp(telephony_device, err);
 }
@@ -2102,6 +2118,9 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}
 
+	g_slist_foreach(hs->slc->nrec_cbs, (GFunc) g_free, NULL);
+	g_slist_free(hs->slc->nrec_cbs);
+
 	g_free(hs->slc);
 	hs->slc = NULL;
 
@@ -2638,6 +2657,47 @@ gboolean headset_get_nrec(struct audio_device *dev)
 	return hs->slc->nrec;
 }
 
+unsigned int headset_add_nrec_cb(struct audio_device *dev,
+					headset_nrec_cb cb, void *user_data)
+{
+	struct headset *hs = dev->headset;
+	struct headset_nrec_callback *nrec_cb;
+	static unsigned int id = 0;
+
+	if (!hs->slc)
+		return 0;
+
+	nrec_cb = g_new(struct headset_nrec_callback, 1);
+	nrec_cb->cb = cb;
+	nrec_cb->user_data = user_data;
+	nrec_cb->id = ++id;
+
+	hs->slc->nrec_cbs = g_slist_prepend(hs->slc->nrec_cbs, nrec_cb);
+
+	return nrec_cb->id;
+}
+
+gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id)
+{
+	struct headset *hs = dev->headset;
+	GSList *l;
+
+	if (!hs->slc)
+		return FALSE;
+
+	for (l = hs->slc->nrec_cbs; l != NULL; l = l->next) {
+		struct headset_nrec_callback *cb = l->data;
+		if (cb && cb->id == id) {
+			hs->slc->nrec_cbs = g_slist_remove(hs->slc->nrec_cbs,
+									cb);
+			g_free(cb);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
 gboolean headset_get_inband(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
diff --git a/audio/headset.h b/audio/headset.h
index 29dc02c..7ce88c8 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -44,6 +44,9 @@ typedef void (*headset_state_cb) (struct audio_device *dev,
 					headset_state_t old_state,
 					headset_state_t new_state,
 					void *user_data);
+typedef void (*headset_nrec_cb) (struct audio_device *dev,
+					gboolean nrec,
+					void *user_data);
 
 unsigned int headset_add_state_cb(headset_state_cb cb, void *user_data);
 gboolean headset_remove_state_cb(unsigned int id);
@@ -90,6 +93,9 @@ int headset_get_channel(struct audio_device *dev);
 
 int headset_get_sco_fd(struct audio_device *dev);
 gboolean headset_get_nrec(struct audio_device *dev);
+unsigned int headset_add_nrec_cb(struct audio_device *dev,
+					headset_nrec_cb cb, void *user_data);
+gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id);
 gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
 
diff --git a/audio/transport.c b/audio/transport.c
index b5a9e48..e2c8237 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -76,6 +76,7 @@ struct media_transport {
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
 	uint16_t		delay;		/* Transport delay (a2dp only) */
+	unsigned int		nrec_id;	/* Transport nrec watch (headset only) */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -685,6 +686,9 @@ static void media_transport_free(void *data)
 	if (transport->session)
 		avdtp_unref(transport->session);
 
+	if (transport->nrec_id)
+		headset_remove_nrec_cb(transport->device, transport->nrec_id);
+
 	if (transport->conn)
 		dbus_connection_unref(transport->conn);
 
@@ -693,6 +697,16 @@ static void media_transport_free(void *data)
 	g_free(transport);
 }
 
+static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
+							void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE, "NREC",
+				DBUS_TYPE_BOOLEAN, &nrec);
+}
+
 struct media_transport *media_transport_create(DBusConnection *conn,
 						struct media_endpoint *endpoint,
 						struct audio_device *device,
@@ -728,6 +742,9 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->cancel = cancel_headset;
 		transport->get_properties = get_properties_headset;
 		transport->set_property = set_property_headset;
+		transport->nrec_id = headset_add_nrec_cb(device,
+							headset_nrec_changed,
+							transport);
 	} else
 		goto fail;
 
-- 
1.7.1

