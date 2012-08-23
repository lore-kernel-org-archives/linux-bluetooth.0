Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 09/16] audio: Add org.bluez.Telephony interface
Date: Thu, 23 Aug 2012 16:38:58 +0200
Message-Id: <1345732745-28706-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new interface will simplify BlueZ code by focusing on the
Bluetooth communication part and by letting the external application
(i.e. oFono) take charge of the Telephony tasks (AT parsing and modem
specific code, which can be removed from BlueZ code). So, it becomes
simpler, easier to maintain and debug.

Telephony application will have to register an agent using this new
interface.

Update headset code to use this new interface.
---
 Makefile.am       |    3 +-
 audio/headset.c   |  221 ++++++++++++++----
 audio/headset.h   |    5 +
 audio/manager.c   |   13 +-
 audio/telephony.c |  666 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/telephony.h |   14 ++
 6 files changed, 877 insertions(+), 45 deletions(-)
 create mode 100644 audio/telephony.c

diff --git a/Makefile.am b/Makefile.am
index 7054910..73d2579 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -148,7 +148,8 @@ builtin_sources += audio/main.c \
 			audio/avdtp.h audio/avdtp.c \
 			audio/media.h audio/media.c \
 			audio/transport.h audio/transport.c \
-			audio/telephony.h audio/a2dp-codecs.h
+			audio/telephony.h audio/telephony.c \
+			audio/a2dp-codecs.h
 endif
 
 if SAPPLUGIN
diff --git a/audio/headset.c b/audio/headset.c
index ded13ca..aa9d0e7 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -42,6 +42,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -62,14 +63,6 @@
 
 #define DC_TIMEOUT 3
 
-static struct {
-	gboolean telephony_ready;	/* Telephony plugin initialized */
-	uint32_t features;		/* HFP AG features */
-} ag = {
-	.telephony_ready = FALSE,
-	.features = 0,
-};
-
 static gboolean sco_hci = TRUE;
 
 static char *str_state[] = {
@@ -114,8 +107,8 @@ struct headset {
 
 	int rfcomm_ch;
 
-	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
+	const char *connecting_uuid;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -131,7 +124,16 @@ struct headset {
 	struct pending_connect *pending;
 
 	headset_lock_t lock;
+	struct telephony_device *tel_dev;
+	char *connection_name;
+	char *connection_path;
+	guint watch;
 	GSList *nrec_cbs;
+
+	int out_gain;
+	int in_gain;
+	gboolean nrec;
+	gboolean inband;
 };
 
 static GSList *headset_callbacks = NULL;
@@ -263,7 +265,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			pending_connect_finalize(dev);
 		}
 
-		if (hs->rfcomm)
+		if (hs->tel_dev)
 			headset_set_state(dev, HEADSET_STATE_CONNECTED);
 		else
 			headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
@@ -329,12 +331,124 @@ static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
 	return 0;
 }
 
-static void hfp_slc_complete(struct audio_device *dev)
+static gboolean headset_connection_property_changed(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct audio_device *dev = user_data;
+	struct headset *hs = dev->headset;
+	const char *property;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+
+	if (g_str_equal(property, "InputGain") == TRUE) {
+		DBusMessageIter variant;
+		dbus_uint16_t dbus_val;
+
+		if (!dbus_message_iter_next(&iter))
+			return TRUE;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+			return TRUE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		if (dbus_message_iter_get_arg_type(&variant) !=
+							DBUS_TYPE_UINT16)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &dbus_val);
+		DBG("Receive InputGain=%d", dbus_val);
+
+		if (dbus_val > 15)
+			return TRUE;
+
+		hs->in_gain = dbus_val;
+	} else if (g_str_equal(property, "OutputGain") == TRUE) {
+		DBusMessageIter variant;
+		dbus_uint16_t dbus_val;
+
+		if (!dbus_message_iter_next(&iter))
+			return TRUE;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+			return TRUE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		if (dbus_message_iter_get_arg_type(&variant) !=
+							DBUS_TYPE_UINT16)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &dbus_val);
+		DBG("Receive OutputGain=%d", dbus_val);
+
+		if (dbus_val > 15)
+			return TRUE;
+
+		hs->out_gain = dbus_val;
+	} else if (g_str_equal(property, "NREC") == TRUE) {
+		DBusMessageIter variant;
+
+		if (!dbus_message_iter_next(&iter))
+			return TRUE;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+			return TRUE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		if (dbus_message_iter_get_arg_type(&variant) !=
+							DBUS_TYPE_BOOLEAN)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &hs->nrec);
+		DBG("Receive NREC=%s", hs->nrec ? "TRUE" : "FALSE");
+	} else if (g_str_equal(property, "AudioCodec") == TRUE) {
+		DBusMessageIter variant;
+		char codec;
+
+		if (!dbus_message_iter_next(&iter))
+			return TRUE;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+			return TRUE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		if (dbus_message_iter_get_arg_type(&variant) !=
+							DBUS_TYPE_BYTE)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&variant, &codec);
+		DBG("Receive AudioCodec=%d", codec);
+		/* TODO: Change media transport according to codec received */
+	}
+
+	return TRUE;
+}
+
+void headset_profile_connection_complete(struct audio_device *dev,
+						const char *connection_name,
+						const char *connection_path)
 {
 	struct headset *hs = dev->headset;
 	struct pending_connect *p = hs->pending;
 
-	DBG("HFP Service Level Connection established");
+	DBG("Profile connection established");
+
+	hs->connection_name = g_strdup(connection_name);
+	hs->connection_path = g_strdup(connection_path);
+	hs->watch = g_dbus_add_signal_watch(dev->conn, NULL, connection_path,
+					AUDIO_TELEPHONY_CONNECTION_INTERFACE,
+					"PropertyChanged",
+					headset_connection_property_changed,
+					dev, NULL);
 
 	headset_set_state(dev, HEADSET_STATE_CONNECTED);
 
@@ -394,6 +508,8 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
+	struct btd_device *btd_dev = dev->btd_dev;
+	struct btd_adapter *adapter;
 	struct pending_connect *p = hs->pending;
 	char hs_address[18];
 
@@ -402,16 +518,23 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	adapter = device_get_adapter(btd_dev);
+
 	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !ag.telephony_ready) {
+	if (hs->hfp_active && !telephony_is_ready(adapter)) {
 		error("Unable to accept HFP connection since the telephony "
 				"subsystem isn't initialized");
 		goto failed;
 	}
 
-	hfp_slc_complete(dev);
+	hs->tel_dev = telephony_device_connecting(chan, btd_dev, dev,
+							hs->connecting_uuid);
+	if (hs->tel_dev == NULL)
+		goto failed;
+
+	hs->connecting_uuid = NULL;
 
-	hs->rfcomm = hs->tmp_rfcomm;
+	g_io_channel_unref(hs->tmp_rfcomm);
 	hs->tmp_rfcomm = NULL;
 
 	ba2str(&dev->dst, hs_address);
@@ -568,12 +691,19 @@ static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 		svclass = hs->search_hfp ? HANDSFREE_SVCLASS_ID :
 							HEADSET_SVCLASS_ID;
 
+	if (svclass == HANDSFREE_SVCLASS_ID)
+		hs->connecting_uuid = HFP_AG_UUID;
+	else
+		hs->connecting_uuid = HSP_AG_UUID;
+
 	sdp_uuid16_create(&uuid, svclass);
 
 	err = bt_search_service(&device->src, &device->dst, &uuid,
 						get_record_cb, device, NULL);
-	if (err < 0)
+	if (err < 0) {
+		hs->connecting_uuid = NULL;
 		return err;
+	}
 
 	if (hs->pending) {
 		hs->pending->svclass = svclass;
@@ -690,6 +820,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct btd_adapter *adapter;
 	int err;
 
 	if (hs->state == HEADSET_STATE_CONNECTING)
@@ -697,7 +828,9 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	if (hs->hfp_handle && !ag.telephony_ready)
+	adapter = device_get_adapter(device->btd_dev);
+
+	if (hs->hfp_handle && !telephony_is_ready(adapter))
 		return btd_error_not_ready(msg);
 
 	device->auto_connect = FALSE;
@@ -814,13 +947,11 @@ void headset_update(struct audio_device *dev, uint16_t svc,
 static int headset_close_rfcomm(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
-	GIOChannel *rfcomm = hs->tmp_rfcomm ? hs->tmp_rfcomm : hs->rfcomm;
 
-	if (rfcomm) {
-		g_io_channel_shutdown(rfcomm, TRUE, NULL);
-		g_io_channel_unref(rfcomm);
+	if (hs->tmp_rfcomm) {
+		g_io_channel_shutdown(hs->tmp_rfcomm, TRUE, NULL);
+		g_io_channel_unref(hs->tmp_rfcomm);
 		hs->tmp_rfcomm = NULL;
-		hs->rfcomm = NULL;
 	}
 
 	return 0;
@@ -918,7 +1049,7 @@ uint32_t headset_config_init(GKeyFile *config)
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return ag.features;
+		return telephony_get_ag_features();
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
@@ -935,7 +1066,7 @@ uint32_t headset_config_init(GKeyFile *config)
 		g_free(str);
 	}
 
-	return ag.features;
+	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
@@ -973,7 +1104,7 @@ gboolean headset_cancel_stream(struct audio_device *dev, unsigned int id)
 		return TRUE;
 
 	if (hs->auto_dc) {
-		if (hs->rfcomm)
+		if (hs->tel_dev)
 			hs->dc_timer = g_timeout_add_seconds(DC_TIMEOUT,
 						(GSourceFunc) hs_dc_timeout,
 						dev);
@@ -1012,7 +1143,7 @@ unsigned int headset_request_stream(struct audio_device *dev,
 			hs->state == HEADSET_STATE_PLAY_IN_PROGRESS)
 		return connect_cb_new(hs, HEADSET_STATE_PLAYING, cb, user_data);
 
-	if (hs->rfcomm == NULL) {
+	if (hs->tel_dev == NULL) {
 		if (rfcomm_connect(dev, cb, user_data, &id) < 0)
 			return 0;
 		hs->auto_dc = TRUE;
@@ -1041,7 +1172,7 @@ unsigned int headset_config_stream(struct audio_device *dev,
 		return connect_cb_new(hs, HEADSET_STATE_CONNECTED, cb,
 					user_data);
 
-	if (hs->rfcomm)
+	if (hs->tel_dev)
 		goto done;
 
 	if (rfcomm_connect(dev, cb, user_data, &id) < 0)
@@ -1127,6 +1258,13 @@ GIOChannel *headset_get_rfcomm(struct audio_device *dev)
 	return hs->tmp_rfcomm;
 }
 
+void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid)
+{
+	struct headset *hs = dev->headset;
+
+	hs->connecting_uuid = uuid;
+}
+
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
@@ -1166,6 +1304,23 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 	switch (state) {
 	case HEADSET_STATE_DISCONNECTED:
 		close_sco(dev);
+
+		if (dev->headset->tel_dev) {
+			telephony_device_disconnect(dev->headset->tel_dev);
+			dev->headset->tel_dev = NULL;
+		}
+
+		dev->headset->connecting_uuid = NULL;
+		g_free(dev->headset->connection_name);
+		dev->headset->connection_name = NULL;
+		g_free(dev->headset->connection_path);
+		dev->headset->connection_path = NULL;
+
+		if (dev->headset->watch) {
+			g_dbus_remove_watch(dev->conn, dev->headset->watch);
+			dev->headset->watch = 0;
+		}
+
 		headset_close_rfcomm(dev);
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
@@ -1389,15 +1544,3 @@ gboolean headset_remove_state_cb(unsigned int id)
 
 	return FALSE;
 }
-
-int telephony_init(void)
-{
-	DBG("");
-
-	return 0;
-}
-
-void telephony_exit(void)
-{
-	DBG("");
-}
diff --git a/audio/headset.h b/audio/headset.h
index 465c2d6..c24e225 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -110,3 +110,8 @@ gboolean headset_unlock(struct audio_device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct audio_device *dev, void *data);
 gboolean headset_play(struct audio_device *dev, void *data);
 void headset_shutdown(struct audio_device *dev);
+
+void headset_profile_connection_complete(struct audio_device *dev,
+						const char *connection_name,
+						const char *connection_path);
+void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
diff --git a/audio/manager.c b/audio/manager.c
index 999124d..67193da 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -873,11 +873,12 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 	adp->powered = powered;
 
 	if (powered) {
-		/* telephony driver already initialized*/
-		if (telephony == TRUE)
-			return;
-		telephony_init();
-		telephony = TRUE;
+		if (telephony == FALSE) {
+			telephony_init();
+			telephony = TRUE;
+		}
+
+		telephony_adapter_init(adapter);
 		return;
 	}
 
@@ -885,6 +886,8 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 	if (telephony == FALSE)
 		return;
 
+	telephony_adapter_exit(adapter);
+
 	for (l = adapters; l; l = l->next) {
 		adp = l->data;
 
diff --git a/audio/telephony.c b/audio/telephony.c
new file mode 100644
index 0000000..a7ef319
--- /dev/null
+++ b/audio/telephony.c
@@ -0,0 +1,666 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012  Frederic Danis <frederic.danis@intel.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
+
+#include "btio.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#include "log.h"
+#include "device.h"
+#include "error.h"
+#include "glib-helper.h"
+#include "sdp-client.h"
+#include "headset.h"
+#include "telephony.h"
+#include "dbus-common.h"
+
+#define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
+#define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
+
+#define DEFAULT_HS_HS_CHANNEL 6
+#define DEFAULT_HF_HS_CHANNEL 7
+
+/*
+ * Profile configuration
+ *
+ * It describes for each supported profile:
+ *  - UUID, RFCOMM channel and security level
+ *  - remote UUID, service class and profile descriptor if they exist
+ *  - profile connection complete callback called when agent replied to
+ *    NewConnection method call
+ */
+struct profile_config {
+	const char		*uuid;		/* agent property UUID */
+	uint8_t			channel;
+	const char		*r_uuid;
+	uint16_t		r_class;
+	uint16_t		r_profile;
+	DBusPendingCallNotifyFunction connection_reply;
+};
+
+/*
+ * Telephony agent
+ *
+ * It represents the telephony agent with provided version and features.
+ *
+ * This is done by adapter.
+ */
+struct telephony_agent {
+	struct btd_adapter	*btd_adapter;
+	struct profile_config	*config;	/* default configuration */
+	char			*name;		/* agent DBus bus id */
+	char			*path;		/* agent object path */
+	uint16_t		version;	/* agent profile version */
+	uint16_t		features;	/* agent supported features */
+	guint			watch;		/* agent disconnect watcher */
+};
+
+/*
+ * Telephony device
+ *
+ * It represents the connection between telephony agent (name, path and config)
+ * and remote device (with its profile version and supported features if they
+ * can be retrieved).
+ *
+ * This is used after authentication completion and remote SDP record retrieval
+ * (if supported by profile, i.e. HFP/HSP) until disconnection.
+ */
+struct telephony_device {
+	struct btd_device	*btd_dev;
+	struct profile_config	*config;	/* default configuration */
+	char			*name;		/* agent DBus bus id */
+	char			*path;		/* agent object path */
+	struct audio_device	*au_dev;	/* Audio device for HSP/HFP */
+	uint16_t		version;	/* remote profile version */
+	uint16_t		features;	/* remote supported features */
+	GIOChannel		*rfcomm;	/* connected RFCOMM channel */
+	gboolean		pending_sdp;	/* SDP request is pending */
+	DBusPendingCall		*call;		/* D-Bus pending call */
+	guint			watch;		/* client disconnect watcher */
+};
+
+static DBusConnection *connection = NULL;
+
+static GSList *agents = NULL;	/* server list */
+
+static struct telephony_agent *find_agent(struct btd_adapter *adapter,
+					const char *sender, const char *path,
+					const char *uuid)
+{
+	GSList *l;
+
+	for (l = agents; l; l = l->next) {
+		struct telephony_agent *agent = l->data;
+
+		if (agent->btd_adapter != adapter)
+			continue;
+
+		if (sender && g_strcmp0(agent->name, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(agent->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(agent->config->uuid, uuid) != 0)
+			continue;
+
+		return agent;
+	}
+
+	return NULL;
+}
+
+static void free_agent(struct telephony_agent *agent)
+{
+	DBusMessage *msg;
+
+	if (agent->watch) {
+		msg = dbus_message_new_method_call(agent->name, agent->path,
+				AUDIO_TELEPHONY_AGENT_INTERFACE, "Release");
+		dbus_message_set_no_reply(msg, TRUE);
+		g_dbus_send_message(connection, msg);
+
+		g_dbus_remove_watch(connection, agent->watch);
+		agent->watch = 0;
+	}
+
+	btd_adapter_unref(agent->btd_adapter);
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
+gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
+						const char *uuid)
+{
+	return find_agent(adapter, NULL, NULL, uuid) != NULL;
+}
+
+static gboolean parse_properties(DBusMessageIter *props, const char **uuid,
+				uint16_t *version, uint16_t *features)
+{
+	gboolean has_uuid = FALSE;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "UUID") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, uuid);
+			has_uuid = TRUE;
+		} else if (strcasecmp(key, "Version") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, version);
+		} else if (strcasecmp(key, "Features") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, features);
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return has_uuid;
+}
+
+static int dev_close(struct telephony_device *tel_dev)
+{
+	int sock;
+
+	if (tel_dev->rfcomm) {
+		sock = g_io_channel_unix_get_fd(tel_dev->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+
+		g_io_channel_shutdown(tel_dev->rfcomm, TRUE, NULL);
+		g_io_channel_unref(tel_dev->rfcomm);
+
+		tel_dev->rfcomm = NULL;
+	}
+
+	return 0;
+}
+
+static gboolean agent_sendfd(struct telephony_device *tel_dev, int fd,
+				DBusPendingCallNotifyFunction notify)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	const char *path;
+
+	msg = dbus_message_new_method_call(tel_dev->name, tel_dev->path,
+			AUDIO_TELEPHONY_AGENT_INTERFACE, "NewConnection");
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_UNIX_FD, &fd);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	path = device_get_path(tel_dev->btd_dev);
+	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
+	dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
+							&tel_dev->version);
+
+	if (tel_dev->features != 0xFFFF)
+		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
+							&tel_dev->features);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(connection, msg,
+							&tel_dev->call, -1)) {
+		dbus_message_unref(msg);
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(tel_dev->call, notify, tel_dev, NULL);
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
+static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+					gpointer data)
+{
+	struct telephony_device *tel_dev = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void hs_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+
+	DBG("TelephonyConnection exited before connection end");
+
+	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+}
+
+static void hs_newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusMessageIter args;
+	const char *sender, *path;
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: %s", derr.message);
+		dbus_error_free(&derr);
+		headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+		goto done;
+	}
+
+	sender = dbus_message_get_sender(reply);
+
+	dbus_message_iter_init(reply, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH) {
+		DBG("Agent reply: missing TelephonyConnection object path");
+		headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	tel_dev->watch = g_dbus_add_disconnect_watch(connection, sender,
+							hs_disconnect_cb,
+							tel_dev, NULL);
+
+	DBG("Agent reply: file descriptor passed successfully");
+	g_io_add_watch(tel_dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			hs_dev_disconnect_cb, tel_dev);
+	headset_profile_connection_complete(tel_dev->au_dev, sender, path);
+
+done:
+	dbus_pending_call_unref(tel_dev->call);
+	tel_dev->call = NULL;
+	dbus_message_unref(reply);
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	sdp_data_t *sdpdata;
+	uuid_t uuid;
+	sdp_list_t *profiles;
+	sdp_profile_desc_t *desc;
+	int sk;
+
+	tel_dev->pending_sdp = FALSE;
+
+	if (err < 0) {
+		error("Unable to get service record: %s (%d)", strerror(-err),
+					-err);
+		goto failed;
+	}
+
+	if (!recs || !recs->data) {
+		error("No records found");
+		goto failed;
+	}
+
+	if (!tel_dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before sdp reply");
+		goto failed;
+	}
+
+	sdpdata = sdp_data_get(recs->data, SDP_ATTR_SUPPORTED_FEATURES);
+	if (sdpdata && sdpdata->dtd == SDP_UINT16)
+		tel_dev->features = sdpdata->val.uint16;
+
+	sdp_uuid16_create(&uuid, tel_dev->config->r_profile);
+
+	if (sdp_get_profile_descs(recs->data, &profiles) < 0)
+		goto failed;
+
+	desc = profiles->data;
+
+	if (sdp_uuid_cmp(&desc->uuid, &uuid) == 0)
+		tel_dev->version = desc->version;
+
+	sdp_list_free(profiles, free);
+
+	sk = g_io_channel_unix_get_fd(tel_dev->rfcomm);
+
+	if (agent_sendfd(tel_dev, sk, tel_dev->config->connection_reply) ==
+									FALSE) {
+		error("Failed to send RFCOMM socket to agent %s, path %s",
+						tel_dev->name, tel_dev->path);
+		goto failed;
+	}
+
+	return;
+
+failed:
+	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+}
+
+struct telephony_device *telephony_device_connecting(GIOChannel *io,
+					struct btd_device *btd_dev,
+					struct audio_device *au_dev,
+					const char *uuid)
+{
+	struct btd_adapter *adapter;
+	struct telephony_agent *agent;
+	struct telephony_device *tel_dev;
+	uuid_t r_uuid;
+	int err;
+
+	adapter = device_get_adapter(btd_dev);
+	agent = find_agent(adapter, NULL, NULL, uuid);
+	if (agent == NULL)
+		return NULL;
+
+	tel_dev = g_new0(struct telephony_device, 1);
+	tel_dev->btd_dev = btd_device_ref(btd_dev);
+	tel_dev->name = g_strdup(agent->name);
+	tel_dev->path = g_strdup(agent->path);
+	tel_dev->config = agent->config;
+	tel_dev->au_dev = au_dev;
+	tel_dev->rfcomm = g_io_channel_ref(io);
+	tel_dev->features = 0xFFFF;
+
+	sdp_uuid16_create(&r_uuid, tel_dev->config->r_class);
+
+	err = bt_search_service(&au_dev->src, &au_dev->dst, &r_uuid,
+				get_record_cb, tel_dev, NULL);
+	if (err < 0) {
+		telephony_device_disconnect(tel_dev);
+		return NULL;
+	}
+
+	tel_dev->pending_sdp = TRUE;
+
+	return tel_dev;
+}
+
+void telephony_device_disconnect(struct telephony_device *device)
+{
+	dev_close(device);
+
+	if (device->pending_sdp) {
+		struct btd_adapter *adapter;
+		bdaddr_t src, dst;
+
+		adapter = device_get_adapter(device->btd_dev);
+		adapter_get_address(adapter, &src);
+		device_get_address(device->btd_dev, &dst, NULL);
+		bt_cancel_discovery(&src, &dst);
+	}
+
+	if (device->call) {
+		dbus_pending_call_cancel(device->call);
+		dbus_pending_call_unref(device->call);
+	}
+
+	if (device->watch) {
+		g_dbus_remove_watch(connection, device->watch);
+		device->watch = 0;
+	}
+
+	btd_device_unref(device->btd_dev);
+	g_free(device->name);
+	g_free(device->path);
+	g_free(device);
+}
+
+gboolean telephony_is_ready(struct btd_adapter *adapter)
+{
+	return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
+}
+
+uint32_t telephony_get_ag_features(void)
+{
+	return 0;
+}
+
+static struct profile_config default_configs[] = {
+	{ HSP_AG_UUID,
+		DEFAULT_HS_AG_CHANNEL,
+		HSP_HS_UUID,
+		HEADSET_SVCLASS_ID,
+		HEADSET_PROFILE_ID,
+		hs_newconnection_reply },
+	{ HFP_AG_UUID,
+		DEFAULT_HF_AG_CHANNEL,
+		HFP_HS_UUID,
+		HANDSFREE_SVCLASS_ID,
+		HANDSFREE_PROFILE_ID,
+		hs_newconnection_reply },
+};
+
+static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct telephony_agent *agent = user_data;
+
+	DBG("Agent exited without calling Unregister");
+
+	agent->watch = 0;
+	agents = g_slist_remove(agents, agent);
+	free_agent(agent);
+}
+
+static struct telephony_agent *agent_new(struct btd_adapter *adapter,
+					const char *sender, const char *path,
+					const char *uuid, uint16_t version,
+					uint16_t features)
+{
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(default_configs) ; i++) {
+		if (strcasecmp(uuid, default_configs[i].uuid) == 0) {
+			struct telephony_agent *agent;
+
+			agent = g_new0(struct telephony_agent, 1);
+			agent->btd_adapter = btd_adapter_ref(adapter);
+			agent->config = &default_configs[i];
+			agent->name = g_strdup(sender);
+			agent->path = g_strdup(path);
+			agent->version = version;
+			agent->features = features;
+
+			return agent;
+		}
+	}
+
+	return NULL;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	DBusMessageIter args, props;
+	const char *sender, *path, *uuid;
+	uint16_t version = 0;
+	uint16_t features = 0xFFFF;
+	struct telephony_agent *agent;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	if (find_agent(adapter, sender, path, NULL) != NULL)
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (!parse_properties(&props, &uuid, &version, &features))
+		return btd_error_invalid_args(msg);
+
+	if (find_agent(adapter, NULL, NULL, uuid) != NULL)
+		return btd_error_already_exists(msg);
+
+	/* initialize agent properties */
+	agent = agent_new(adapter, sender, path, uuid, version, features);
+	if (agent == NULL)
+		return btd_error_invalid_args(msg);
+
+	agent->watch = g_dbus_add_disconnect_watch(conn, sender,
+							agent_disconnect_cb,
+							agent, NULL);
+
+	DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
+					sender, path, uuid, version, features);
+
+	agents = g_slist_append(agents, agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	const char *sender, *path;
+	struct telephony_agent *agent;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	agent = find_agent(adapter, sender, path, NULL);
+	if (agent == NULL)
+		return btd_error_does_not_exist(msg);
+
+	agents = g_slist_remove(agents, agent);
+
+	DBG("Unregister agent : %s%s", sender, path);
+
+	free_agent(agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable telsrv_methods[] = {
+	{ GDBUS_METHOD("RegisterAgent",
+			GDBUS_ARGS({ "agent", "o" }, { "properties", "a{sv}" }),
+			NULL, register_agent) },
+	{ GDBUS_METHOD("UnregisterAgent",
+			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
+	{ }
+};
+
+static void path_unregister(void *data)
+{
+	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
+}
+
+int telephony_adapter_init(struct btd_adapter *adapter)
+{
+	const char *path;
+
+	DBG("adapter: %p", adapter);
+
+	path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(connection, path,
+					AUDIO_TELEPHONY_INTERFACE,
+					telsrv_methods, NULL,
+					NULL, adapter, path_unregister)) {
+		error("D-Bus failed to register %s interface",
+				AUDIO_TELEPHONY_INTERFACE);
+		return -1;
+	}
+
+	DBG("Registered interface %s", AUDIO_TELEPHONY_INTERFACE);
+
+	return 0;
+}
+
+void telephony_adapter_exit(struct btd_adapter *adapter)
+{
+	struct telephony_agent *agent;
+
+	DBG("adapter: %p", adapter);
+
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+			AUDIO_TELEPHONY_INTERFACE);
+
+	while ((agent = find_agent(adapter, NULL, NULL, NULL)) != NULL) {
+		agents = g_slist_remove(agents, agent);
+		free_agent(agent);
+	}
+}
+
+int telephony_init(void)
+{
+	DBG("");
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	return 0;
+}
+
+void telephony_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/audio/telephony.h b/audio/telephony.h
index e9cd2fc..d027ce1 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -45,8 +45,22 @@
 #define HF_FEATURE_ENHANCED_CALL_STATUS		0x0020
 #define HF_FEATURE_ENHANCED_CALL_CONTROL	0x0040
 
+#define AUDIO_TELEPHONY_CONNECTION_INTERFACE "org.bluez.TelephonyConnection"
+
+struct telephony_device;
+
+struct telephony_device *telephony_device_connecting(GIOChannel *io,
+					struct btd_device *btd_dev,
+					struct audio_device *au_dev,
+					const char *uuid);
+void telephony_device_disconnect(struct telephony_device *device);
+
 gboolean telephony_is_ready(struct btd_adapter *adapter);
 uint32_t telephony_get_ag_features(void);
+gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
+						const char *uuid);
 
+int telephony_adapter_init(struct btd_adapter *adapter);
+void telephony_adapter_exit(struct btd_adapter *adapter);
 int telephony_init(void);
 void telephony_exit(void);
-- 
1.7.9.5

