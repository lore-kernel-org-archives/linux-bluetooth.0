Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Audio: add dbus telephony driver
Date: Thu, 20 Oct 2011 15:52:18 +0200
Message-Id: <1319118738-20131-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am            |    4 +-
 audio/telephony-dbus.c |  554 ++++++++++++++++++++++++++++++++++++++++++++++++
 doc/audio-api.txt      |   99 +++++++++
 3 files changed, 655 insertions(+), 2 deletions(-)
 create mode 100644 audio/telephony-dbus.c

diff --git a/Makefile.am b/Makefile.am
index d528c84..f4aeac1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -165,7 +165,7 @@ noinst_LIBRARIES += audio/libtelephony.a
 
 audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
 				audio/telephony-maemo5.c audio/telephony-ofono.c \
-				audio/telephony-maemo6.c
+				audio/telephony-maemo6.c audio/telephony-dbus.c
 endif
 
 if SAPPLUGIN
@@ -345,7 +345,7 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
 			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
 			proximity/proximity.conf audio/telephony-builtin.h \
-			audio/telephony-builtin.c
+			audio/telephony-builtin.c audio/telephony-dbus.c
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
diff --git a/audio/telephony-dbus.c b/audio/telephony-dbus.c
new file mode 100644
index 0000000..59e26bf
--- /dev/null
+++ b/audio/telephony-dbus.c
@@ -0,0 +1,554 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  Frederic Danis <frederic.danis@intel.com>
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
+
+#include "btio.h"
+#include "log.h"
+#include "device.h"
+#include "error.h"
+#include "glib-helper.h"
+#include "sdp-client.h"
+#include "headset.h"
+#include "telephony.h"
+#include "dbus-common.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
+
+struct telsrv {
+	GSList *servers;	/* server list */
+};
+
+struct tel_device {
+	struct tel_agent	*agent;
+	struct audio_device	*au_dev;
+	GIOChannel		*rfcomm;
+	uint16_t		version;
+	uint16_t		features;
+};
+
+struct tel_agent {
+	char		*name;		/* agent DBus bus id */
+	char		*path;		/* agent object path */
+	const char	*uuid;		/* agent property UUID */
+	uint16_t	version;
+	uint8_t		features;
+	uint16_t	r_class;
+	uint16_t	r_profile;
+};
+
+static DBusConnection *connection = NULL;
+
+struct telsrv telsrv;
+
+static struct tel_agent *find_agent(const char *sender, const char *path,
+						const char *uuid)
+{
+	GSList *l;
+
+	for (l = telsrv.servers; l; l = l->next) {
+		struct tel_agent *agent = l->data;
+
+		if (sender && g_strcmp0(agent->name, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(agent->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(agent->uuid, uuid) != 0)
+			continue;
+
+		return agent;
+	}
+
+	return NULL;
+}
+
+static int parse_properties(DBusMessageIter *props, const char **uuid,
+				uint16_t *version, uint8_t *features)
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
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, uuid);
+			has_uuid = TRUE;
+		} else if (strcasecmp(key, "Version") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, version);
+		} else if (strcasecmp(key, "Features") == 0) {
+			if (var != DBUS_TYPE_BYTE)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, features);
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return (has_uuid) ? 0 : -EINVAL;
+}
+
+static int dev_close(struct tel_device *dev)
+{
+	int sock;
+
+	if (dev->rfcomm) {
+		sock = g_io_channel_unix_get_fd(dev->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+	}
+
+	return 0;
+}
+
+static gboolean agent_sendfd(struct tel_device *dev, int fd,
+				DBusPendingCallNotifyFunction notify)
+{
+	struct tel_agent *agent = dev->agent;
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	char *str;
+	DBusPendingCall *call;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.TelephonyAgent", "NewConnection");
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
+	str = g_strdup(agent->uuid);
+	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &str);
+	g_free(str);
+
+	dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16, &dev->version);
+
+	if (dev->features != 0xFFFF)
+		dict_append_entry(&dict, "Features", DBUS_TYPE_BYTE,
+							&dev->features);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (dbus_connection_send_with_reply(connection, msg, &call, -1) == FALSE)
+		return FALSE;
+
+	dbus_pending_call_set_notify(call, notify, dev, NULL);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
+static gboolean agent_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+						struct tel_device *dev)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct tel_device *dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before agent reply");
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: file descriptor passed successfully");
+		g_io_add_watch(dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) agent_disconnect_cb, dev);
+		headset_slc_complete(dev->au_dev);
+		goto done;
+	}
+
+	DBG("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+	dev_close(dev);
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct tel_device *dev = user_data;
+	sdp_data_t *sdpdata;
+	uuid_t uuid;
+	sdp_list_t *profiles;
+	sdp_profile_desc_t *desc;
+	int sk, ret;
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
+	sdpdata = sdp_data_get(recs->data, SDP_ATTR_SUPPORTED_FEATURES);
+	if (sdpdata && sdpdata->dtd == SDP_UINT16)
+		dev->features = sdpdata->val.uint16;
+
+	sdp_uuid16_create(&uuid, dev->agent->r_profile);
+
+	sdp_get_profile_descs(recs->data, &profiles);
+	if (profiles == NULL)
+		goto failed;
+
+	desc = profiles->data;
+
+	if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
+		dev->version = desc->version;
+
+	sdp_list_free(profiles, free);
+
+	sk = g_io_channel_unix_get_fd(dev->rfcomm);
+
+	ret = agent_sendfd(dev, sk, newconnection_reply);
+
+	return;
+
+failed:
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+}
+
+void *telephony_device_connecting(GIOChannel *io, void *telephony_device)
+{
+	struct audio_device *device = telephony_device;
+	struct tel_device *dev;
+	const char *agent_uuid;
+	struct tel_agent *agent;
+	uuid_t uuid;
+	int err;
+
+	/*TODO: check for HS roles */
+	if (headset_get_hfp_active(device))
+		agent_uuid = HFP_AG_UUID;
+	else
+		agent_uuid = HSP_AG_UUID;
+
+	agent = find_agent(NULL, NULL, agent_uuid);
+	if (agent == NULL) {
+		error("No agent registered for %s", agent_uuid);
+		return NULL;
+	}
+
+	dev = g_new0(struct tel_device, 1);
+	dev->agent = agent;
+	dev->au_dev = telephony_device;
+	dev->rfcomm = io;
+	dev->features = 0xFFFF;
+
+	sdp_uuid16_create(&uuid, agent->r_class);
+
+	err = bt_search_service(&device->src, &device->dst, &uuid,
+						get_record_cb, dev, NULL);
+	if (err < 0) {
+		g_free(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+void telephony_device_set_active(void *telephony_device, gboolean active)
+{
+	return;
+}
+
+void telephony_device_connected(void *telephony_device)
+{
+	DBG("telephony-dbus: device %p connected", telephony_device);
+}
+
+void telephony_device_disconnect(void *slc)
+{
+	struct tel_device *dev = slc;
+
+	dev_close(dev);
+}
+
+void telephony_device_disconnected(void *telephony_device)
+{
+	DBG("telephony-dbus: device %p disconnected", telephony_device);
+}
+
+gboolean telephony_get_ready_state(void)
+{
+	return find_agent(NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
+}
+
+gboolean telephony_pending_ring(void *slc)
+{
+	return FALSE;
+}
+
+void telephony_start_ring(void *slc)
+{
+	return;
+}
+
+uint32_t telephony_get_ag_features(void)
+{
+	return 0;
+}
+
+void telephony_set_fast_connectable(gboolean state)
+{
+	return;
+}
+
+gboolean telephony_get_nrec(void *slc)
+{
+	return FALSE;
+}
+
+gboolean telephony_get_inband_ringtone(void *slc)
+{
+	return FALSE;
+}
+
+void telephony_set_inband_ringtone(void *slc, gboolean state)
+{
+	return;
+}
+
+int telephony_get_speaker_gain(void *slc)
+{
+	return -1;
+}
+
+int telephony_get_mic_gain(void *slc)
+{
+	return -1;
+}
+
+int telephony_send_speaker_gain(void *slc, uint16_t gain)
+{
+	return -1;
+}
+
+int telephony_send_mic_gain(void *slc, uint16_t gain)
+{
+	return -1;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessageIter args, props;
+	const char *sender, *path, *uuid;
+	uint16_t version = 0;
+	uint8_t features = 0;
+	uint16_t r_class, r_profile;
+	struct tel_agent *agent;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	if (find_agent(sender, path, NULL) != NULL)
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (parse_properties(&props, &uuid, &version, &features) < 0)
+		return btd_error_invalid_args(msg);
+
+	if (strcasecmp(uuid, HSP_HS_UUID) == 0) {
+		r_class = HEADSET_AGW_SVCLASS_ID;
+		r_profile = HEADSET_PROFILE_ID;
+	} else if (strcasecmp(uuid, HSP_AG_UUID) == 0) {
+		r_class = HEADSET_SVCLASS_ID;
+		r_profile = HEADSET_PROFILE_ID;
+	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0) {
+		r_class = HANDSFREE_AGW_SVCLASS_ID;
+		r_profile = HANDSFREE_PROFILE_ID;
+	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0) {
+		r_class = HANDSFREE_SVCLASS_ID;
+		r_profile = HANDSFREE_PROFILE_ID;
+	} else
+		return btd_error_invalid_args(msg);
+
+	if (find_agent(NULL, NULL, uuid) != NULL)
+		return btd_error_already_exists(msg);
+
+	DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
+					sender, path, uuid, version, features);
+
+	agent = g_new0(struct tel_agent, 1);
+	agent->name = g_strdup(sender);
+	agent->path = g_strdup(path);
+	agent->uuid = g_strdup(uuid);
+	agent->version = version;
+	agent->features = features;
+	agent->r_class = r_class;
+	agent->r_profile = r_profile;
+
+	telsrv.servers = g_slist_append(telsrv.servers, agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	const char *sender, *path;
+	struct tel_agent *agent;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	agent = find_agent(sender, path, NULL);
+	if (agent == NULL)
+		return btd_error_does_not_exist(msg);
+
+	telsrv.servers = g_slist_remove(telsrv.servers, agent);
+
+	DBG("Unregister agent : %s%s", sender, path);
+
+	g_free(agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static GDBusMethodTable telsrv_methods[] = {
+	{ "RegisterAgent", "oa{sv}", "", register_agent },
+	{ "UnregisterAgent", "o", "", unregister_agent },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static void path_unregister(void *data)
+{
+	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
+}
+
+static int register_interface(void *adapter)
+{
+	const char *path;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -1;
+
+	path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(connection, path,
+					AUDIO_TELEPHONY_INTERFACE,
+					telsrv_methods, NULL,
+					NULL, NULL, path_unregister)) {
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
+static void unregister_interface(void *adapter)
+{
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+			AUDIO_TELEPHONY_INTERFACE);
+}
+
+int telephony_init(void *adapter)
+{
+	DBG("");
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	return register_interface(adapter);
+}
+
+void telephony_exit(void *adapter)
+{
+	DBG("");
+
+	unregister_interface(adapter);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
+
+struct TelephonyDBusTable *telephony_dbus_table(void)
+{
+	return NULL;
+}
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index b85400b..d32b51d 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -456,3 +456,102 @@ properties	boolean Connected [readonly]
 		uint16 MicrophoneGain  [readonly]
 
 			The speaker gain when available.
+
+
+Telephony hierarchy [experiemental]
+===================
+
+Service		org.bluez
+Interface	org.bluez.Telephony
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterAgent(object path, dict properties)
+
+			Register a TelephonyAgent to sender, the sender can
+			register as many agents as it likes.
+
+			Note: If the sender disconnects its agents are
+			automatically unregistered.
+
+			possible properties:
+
+				string UUID:
+
+					UUID of the profile which the agent is
+					for.
+
+				uint16 Version:
+
+					Version of the profile which the agent
+					implements.
+
+				byte Features:
+
+					Agent supported features as defined in
+					profile spec e.g. HFP.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+
+		void UnregisterAgent(object path)
+
+			Unregister sender agent.
+
+TelephonyAgent hierarchy
+========================
+
+Service		unique name
+Interface	org.bluez.TelephonyAgent
+Object path	freely definable
+
+ethods		void NewConnection(filedescriptor fd, dict properties)
+
+			This method gets called whenever a new connection
+			has been established. This method assumes that DBus
+			daemon with file descriptor passing capability is
+			being used.
+
+			The agent should only return successfully once the
+			establishment of the service level connection (SLC)
+			has been completed.  In the case of Handsfree this
+			means that BRSF exchange has been performed and
+			necessary initialization has been done.
+
+			If Endpoint is set the agent is responsible to
+			create an object implementing org.bluez.MediaTransport
+			and notify the Endpoint using org.bluez.MediaEndpoint.
+
+			possible properties:
+
+				strict Device:
+
+					BlueZ remote device object.
+
+				string UUID:
+
+					Profile UUID of the connection.
+
+				uint16 Version:
+
+					Remote profile version.
+
+				byte Features:
+
+					Remote profile features.
+
+				string Endpoint:
+
+					Optional. Endpoint bus id.
+
+				string EndpointPath:
+
+					Optional. Endpoint object path.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the TelephonyAgent registers itself is removed.
-- 
1.7.1

