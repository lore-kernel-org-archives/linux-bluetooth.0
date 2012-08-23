Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 10/16] audio: Add headset audio properties to MediaTransport
Date: Thu, 23 Aug 2012 16:38:59 +0200
Message-Id: <1345732745-28706-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c   |  220 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 audio/headset.h   |   18 +++++
 audio/transport.c |   94 ++++++++++++++++++++++-
 doc/media-api.txt |   12 +++
 4 files changed, 335 insertions(+), 9 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index aa9d0e7..aa9ceeb 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -85,6 +85,12 @@ struct headset_nrec_callback {
 	void *user_data;
 };
 
+struct headset_gain_callback {
+	unsigned int id;
+	headset_gain_cb cb;
+	void *user_data;
+};
+
 struct connect_cb {
 	unsigned int id;
 	headset_stream_cb_t cb;
@@ -129,6 +135,8 @@ struct headset {
 	char *connection_path;
 	guint watch;
 	GSList *nrec_cbs;
+	GSList *out_gain_cbs;
+	GSList *in_gain_cbs;
 
 	int out_gain;
 	int in_gain;
@@ -338,6 +346,7 @@ static gboolean headset_connection_property_changed(DBusConnection *connection,
 	struct headset *hs = dev->headset;
 	const char *property;
 	DBusMessageIter iter;
+	GSList *l;
 
 	dbus_message_iter_init(message, &iter);
 
@@ -363,12 +372,16 @@ static gboolean headset_connection_property_changed(DBusConnection *connection,
 			return TRUE;
 
 		dbus_message_iter_get_basic(&variant, &dbus_val);
-		DBG("Receive InputGain=%d", dbus_val);
 
 		if (dbus_val > 15)
 			return TRUE;
 
 		hs->in_gain = dbus_val;
+		for (l = hs->in_gain_cbs; l; l = l->next) {
+			struct headset_gain_callback *gain_cb = l->data;
+
+			gain_cb->cb(dev, hs->in_gain, gain_cb->user_data);
+		}
 	} else if (g_str_equal(property, "OutputGain") == TRUE) {
 		DBusMessageIter variant;
 		dbus_uint16_t dbus_val;
@@ -386,12 +399,16 @@ static gboolean headset_connection_property_changed(DBusConnection *connection,
 			return TRUE;
 
 		dbus_message_iter_get_basic(&variant, &dbus_val);
-		DBG("Receive OutputGain=%d", dbus_val);
 
 		if (dbus_val > 15)
 			return TRUE;
 
 		hs->out_gain = dbus_val;
+		for (l = hs->out_gain_cbs; l; l = l->next) {
+			struct headset_gain_callback *gain_cb = l->data;
+
+			gain_cb->cb(dev, hs->out_gain, gain_cb->user_data);
+		}
 	} else if (g_str_equal(property, "NREC") == TRUE) {
 		DBusMessageIter variant;
 
@@ -408,7 +425,12 @@ static gboolean headset_connection_property_changed(DBusConnection *connection,
 			return TRUE;
 
 		dbus_message_iter_get_basic(&variant, &hs->nrec);
-		DBG("Receive NREC=%s", hs->nrec ? "TRUE" : "FALSE");
+
+		for (l = hs->nrec_cbs; l; l = l->next) {
+			struct headset_nrec_callback *nrec_cb = l->data;
+
+			nrec_cb->cb(dev, hs->nrec, nrec_cb->user_data);
+		}
 	} else if (g_str_equal(property, "AudioCodec") == TRUE) {
 		DBusMessageIter variant;
 		char codec;
@@ -971,6 +993,8 @@ static void headset_free(struct audio_device *dev)
 	headset_close_rfcomm(dev);
 
 	g_slist_free_full(hs->nrec_cbs, g_free);
+	g_slist_free_full(hs->out_gain_cbs, g_free);
+	g_slist_free_full(hs->in_gain_cbs, g_free);
 
 	g_free(hs);
 	dev->headset = NULL;
@@ -1069,6 +1093,92 @@ uint32_t headset_config_init(GKeyFile *config)
 	return telephony_get_ag_features();
 }
 
+static void telephony_connection_set_property(struct audio_device *dev,
+				const char *name, int type, const void *value)
+{
+	struct headset *hs = dev->headset;
+	DBusMessage *msg;
+	DBusMessageIter iter, var;
+	const char *str_type;
+
+	if (hs->connection_name == NULL)
+		return;
+
+	if (hs->connection_path == NULL)
+		return;
+
+	switch (type) {
+	case DBUS_TYPE_BOOLEAN:
+		str_type = DBUS_TYPE_BOOLEAN_AS_STRING;
+		break;
+
+	case DBUS_TYPE_UINT16:
+		str_type = DBUS_TYPE_UINT16_AS_STRING;
+		break;
+
+	default:
+		return;
+	}
+
+	msg = dbus_message_new_method_call(hs->connection_name,
+					hs->connection_path,
+					AUDIO_TELEPHONY_CONNECTION_INTERFACE,
+					"SetProperty");
+	if (msg == NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, str_type,
+						&var);
+	dbus_message_iter_append_basic(&var, type, value);
+	dbus_message_iter_close_container(&iter, &var);
+
+	g_dbus_send_message(dev->conn, msg);
+	return;
+}
+
+void headset_set_nrec(struct audio_device *dev, gboolean nrec)
+{
+	struct headset *hs = dev->headset;
+
+	hs->nrec = nrec;
+
+	telephony_connection_set_property(dev, "NREC", DBUS_TYPE_BOOLEAN,
+						&nrec);
+}
+
+void headset_set_inband_ringtone(struct audio_device *dev, gboolean inband)
+{
+	struct headset *hs = dev->headset;
+
+	hs->inband = inband;
+
+	telephony_connection_set_property(dev, "InbandRingtone",
+						DBUS_TYPE_BOOLEAN, &inband);
+}
+
+void headset_set_speaker_gain(struct audio_device *dev, gboolean gain)
+{
+	struct headset *hs = dev->headset;
+
+	hs->out_gain = gain;
+
+	telephony_connection_set_property(dev, "OutputGain", DBUS_TYPE_UINT16,
+						&gain);
+}
+
+void headset_set_microphone_gain(struct audio_device *dev, gboolean gain)
+{
+	struct headset *hs = dev->headset;
+
+	hs->in_gain = gain;
+
+	telephony_connection_set_property(dev, "InputGain", DBUS_TYPE_UINT16,
+						&gain);
+}
+
 static gboolean hs_dc_timeout(struct audio_device *dev)
 {
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
@@ -1456,7 +1566,12 @@ int headset_get_sco_fd(struct audio_device *dev)
 
 gboolean headset_get_nrec(struct audio_device *dev)
 {
-	return TRUE;
+	struct headset *hs = dev->headset;
+
+	if (!hs->tel_dev)
+		return TRUE;
+
+	return hs->nrec;
 }
 
 unsigned int headset_add_nrec_cb(struct audio_device *dev,
@@ -1495,7 +1610,12 @@ gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id)
 
 gboolean headset_get_inband(struct audio_device *dev)
 {
-	return TRUE;
+	struct headset *hs = dev->headset;
+
+	if (!hs->tel_dev)
+		return TRUE;
+
+	return hs->inband;
 }
 
 gboolean headset_get_sco_hci(struct audio_device *dev)
@@ -1503,6 +1623,96 @@ gboolean headset_get_sco_hci(struct audio_device *dev)
 	return sco_hci;
 }
 
+uint16_t headset_get_output_gain(struct audio_device *dev)
+{
+	struct headset *hs = dev->headset;
+
+	if (!hs->tel_dev)
+		return 0;
+
+	return hs->out_gain;
+}
+
+unsigned int headset_add_output_gain_cb(struct audio_device *dev,
+					headset_gain_cb cb, void *user_data)
+{
+	struct headset *hs = dev->headset;
+	struct headset_gain_callback *gain_cb;
+	static unsigned int id = 0;
+
+	gain_cb = g_new(struct headset_gain_callback, 1);
+	gain_cb->cb = cb;
+	gain_cb->user_data = user_data;
+	gain_cb->id = ++id;
+
+	hs->out_gain_cbs = g_slist_prepend(hs->out_gain_cbs, gain_cb);
+
+	return gain_cb->id;
+}
+
+gboolean headset_remove_output_gain_cb(struct audio_device *dev,
+						unsigned int id)
+{
+	struct headset *hs = dev->headset;
+	GSList *l;
+
+	for (l = hs->out_gain_cbs; l != NULL; l = l->next) {
+		struct headset_gain_callback *cb = l->data;
+		if (cb && cb->id == id) {
+			hs->out_gain_cbs = g_slist_remove(hs->out_gain_cbs, cb);
+			g_free(cb);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+uint16_t headset_get_input_gain(struct audio_device *dev)
+{
+	struct headset *hs = dev->headset;
+
+	if (!hs->tel_dev)
+		return 0;
+
+	return hs->in_gain;
+}
+
+unsigned int headset_add_input_gain_cb(struct audio_device *dev,
+					headset_gain_cb cb, void *user_data)
+{
+	struct headset *hs = dev->headset;
+	struct headset_gain_callback *gain_cb;
+	static unsigned int id = 0;
+
+	gain_cb = g_new(struct headset_gain_callback, 1);
+	gain_cb->cb = cb;
+	gain_cb->user_data = user_data;
+	gain_cb->id = ++id;
+
+	hs->in_gain_cbs = g_slist_prepend(hs->in_gain_cbs, gain_cb);
+
+	return gain_cb->id;
+}
+
+gboolean headset_remove_input_gain_cb(struct audio_device *dev,
+						unsigned int id)
+{
+	struct headset *hs = dev->headset;
+	GSList *l;
+
+	for (l = hs->in_gain_cbs; l != NULL; l = l->next) {
+		struct headset_gain_callback *cb = l->data;
+		if (cb && cb->id == id) {
+			hs->in_gain_cbs = g_slist_remove(hs->in_gain_cbs, cb);
+			g_free(cb);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
 void headset_shutdown(struct audio_device *dev)
 {
 	struct pending_connect *p = dev->headset->pending;
diff --git a/audio/headset.h b/audio/headset.h
index c24e225..8cadd68 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -47,6 +47,9 @@ typedef void (*headset_state_cb) (struct audio_device *dev,
 typedef void (*headset_nrec_cb) (struct audio_device *dev,
 					gboolean nrec,
 					void *user_data);
+typedef void (*headset_gain_cb) (struct audio_device *dev,
+					uint16_t gain,
+					void *user_data);
 
 unsigned int headset_add_state_cb(headset_state_cb cb, void *user_data);
 gboolean headset_remove_state_cb(unsigned int id);
@@ -101,6 +104,16 @@ unsigned int headset_add_nrec_cb(struct audio_device *dev,
 gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id);
 gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
+uint16_t headset_get_output_gain(struct audio_device *dev);
+unsigned int headset_add_output_gain_cb(struct audio_device *dev,
+					headset_gain_cb cb, void *user_data);
+gboolean headset_remove_output_gain_cb(struct audio_device *dev,
+						unsigned int id);
+uint16_t headset_get_input_gain(struct audio_device *dev);
+unsigned int headset_add_input_gain_cb(struct audio_device *dev,
+					headset_gain_cb cb, void *user_data);
+gboolean headset_remove_input_gain_cb(struct audio_device *dev,
+						unsigned int id);
 
 gboolean headset_is_active(struct audio_device *dev);
 
@@ -115,3 +128,8 @@ void headset_profile_connection_complete(struct audio_device *dev,
 						const char *connection_name,
 						const char *connection_path);
 void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
+
+void headset_set_nrec(struct audio_device *dev, gboolean nrec);
+void headset_set_inband_ringtone(struct audio_device *dev, gboolean inband);
+void headset_set_speaker_gain(struct audio_device *dev, gboolean gain);
+void headset_set_microphone_gain(struct audio_device *dev, gboolean gain);
diff --git a/audio/transport.c b/audio/transport.c
index 832ad2a..d2a7c0a 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -71,6 +71,8 @@ struct a2dp_transport {
 struct headset_transport {
 	struct audio_device	*device;
 	unsigned int		nrec_id;
+	unsigned int		output_gain_id;
+	unsigned int		input_gain_id;
 };
 
 struct media_transport {
@@ -788,26 +790,57 @@ static int set_property_headset(struct media_transport *transport,
 						const char *property,
 						DBusMessageIter *value)
 {
+	struct headset_transport *headset = transport->data;
+
 	if (g_strcmp0(property, "NREC") == 0) {
 		gboolean nrec;
 
 		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-			return -EINVAL;
+			goto failed;
+
 		dbus_message_iter_get_basic(value, &nrec);
 
-		/* FIXME: set new nrec */
+		headset_set_nrec(headset->device, nrec);
 		return 0;
 	} else if (g_strcmp0(property, "InbandRingtone") == 0) {
 		gboolean inband;
 
 		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-			return -EINVAL;
+			goto failed;
+
 		dbus_message_iter_get_basic(value, &inband);
 
-		/* FIXME: set new inband */
+		headset_set_inband_ringtone(headset->device, inband);
+		return 0;
+	} else if (g_strcmp0(property, "OutputGain") == 0) {
+		uint16_t gain;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			goto failed;
+
+		dbus_message_iter_get_basic(value, &gain);
+
+		if (gain > 15)
+			goto failed;
+
+		headset_set_speaker_gain(headset->device, gain);
+		return 0;
+	} else if (g_strcmp0(property, "InputGain") == 0) {
+		uint16_t gain;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			goto failed;
+
+		dbus_message_iter_get_basic(value, &gain);
+
+		if (gain > 15)
+			goto failed;
+
+		headset_set_microphone_gain(headset->device, gain);
 		return 0;
 	}
 
+failed:
 	return -EINVAL;
 }
 
@@ -880,6 +913,7 @@ static void get_properties_headset(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
 	gboolean nrec, inband;
+	uint16_t output_gain, input_gain;
 	const char *routing;
 
 	nrec = headset_get_nrec(transport->device);
@@ -888,6 +922,12 @@ static void get_properties_headset(struct media_transport *transport,
 	inband = headset_get_inband(transport->device);
 	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
 
+	output_gain = headset_get_output_gain(transport->device);
+	dict_append_entry(dict, "OutputGain", DBUS_TYPE_UINT16, &output_gain);
+
+	input_gain = headset_get_input_gain(transport->device);
+	dict_append_entry(dict, "InputGain", DBUS_TYPE_UINT16, &input_gain);
+
 	routing = headset_get_sco_hci(transport->device) ? "HCI" : "PCM";
 	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
 }
@@ -988,6 +1028,14 @@ static void destroy_headset(void *data)
 	if (headset->nrec_id > 0)
 		headset_remove_nrec_cb(headset->device, headset->nrec_id);
 
+	if (headset->output_gain_id > 0)
+		headset_remove_output_gain_cb(headset->device,
+						headset->output_gain_id);
+
+	if (headset->input_gain_id > 0)
+		headset_remove_input_gain_cb(headset->device,
+						headset->input_gain_id);
+
 	g_free(headset);
 }
 
@@ -1027,6 +1075,38 @@ static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 				DBUS_TYPE_BOOLEAN, &nrec);
 }
 
+static void headset_output_gain_changed(struct audio_device *dev, uint16_t gain,
+							void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	DBG("");
+
+	if (gain > 15)
+		return;
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE,
+				"OutputGain", DBUS_TYPE_UINT16,
+				&gain);
+}
+
+static void headset_input_gain_changed(struct audio_device *dev, uint16_t gain,
+							void *user_data)
+{
+	struct media_transport *transport = user_data;
+
+	DBG("");
+
+	if (gain > 15)
+		return;
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE,
+				"InputGain", DBUS_TYPE_UINT16,
+				&gain);
+}
+
 struct media_transport *media_transport_create(DBusConnection *conn,
 						struct media_endpoint *endpoint,
 						struct audio_device *device,
@@ -1071,6 +1151,12 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		headset->nrec_id = headset_add_nrec_cb(device,
 							headset_nrec_changed,
 							transport);
+		headset->output_gain_id = headset_add_output_gain_cb(device,
+						headset_output_gain_changed,
+						transport);
+		headset->input_gain_id = headset_add_input_gain_cb(device,
+						headset_input_gain_changed,
+						transport);
 
 		transport->resume = resume_headset;
 		transport->suspend = suspend_headset;
diff --git a/doc/media-api.txt b/doc/media-api.txt
index e5eeaa0..f9b0ffa 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -349,3 +349,15 @@ Properties	object Device [readonly]
 			acquired by the sender.
 
 			Possible Values: 0-127
+
+		uint16 OutputGain  [readwrite]
+
+			Optional. The speaker gain when available.
+
+			Possible values: 0-15
+
+		uint16 InputGain  [readwrite]
+
+			Optional. The microphone gain when available.
+
+			Possible values: 0-15
-- 
1.7.9.5

