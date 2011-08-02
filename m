Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] audio: add profile version to NewConnection method
Date: Tue,  2 Aug 2011 16:22:20 +0200
Message-Id: <1312294940-8327-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1312294940-8327-1-git-send-email-frederic.danis@linux.intel.com>
References: <1312294940-8327-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index ec0ec5d..29d8c9c 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -64,10 +64,12 @@ struct gateway {
 	gateway_state_t state;
 	GIOChannel *rfcomm;
 	GIOChannel *sco;
+	GIOChannel *incoming;
 	gateway_stream_cb_t sco_start_cb;
 	void *sco_start_cb_data;
 	struct hf_agent *agent;
 	DBusMessage *msg;
+	int version;
 };
 
 int gateway_close(struct audio_device *device);
@@ -128,6 +130,7 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 		DBusPendingCallNotifyFunction notify, void *data)
 {
 	struct audio_device *dev = data;
+	struct gateway *gw = dev->gateway;
 	DBusMessage *msg;
 	DBusPendingCall *call;
 
@@ -135,6 +138,7 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 			"org.bluez.HandsfreeAgent", "NewConnection");
 
 	dbus_message_append_args(msg, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_UINT16, &gw->version,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send_with_reply(dev->conn, msg, &call, -1) == FALSE)
@@ -263,6 +267,80 @@ fail:
 	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 
+static int get_remote_profile_version(sdp_record_t *rec)
+{
+	uuid_t uuid;
+	sdp_list_t *profiles;
+	sdp_profile_desc_t *desc;
+	int ver = 0;
+
+	sdp_uuid16_create(&uuid, HANDSFREE_PROFILE_ID);
+
+	sdp_get_profile_descs(rec, &profiles);
+	if (profiles == NULL)
+		goto done;
+
+	desc = profiles->data;
+
+	if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
+		ver = desc->version;
+
+	sdp_list_free(profiles, free);
+
+done:
+	return ver;
+}
+
+static void get_incoming_record_cb(sdp_list_t *recs, int err,
+					gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+	GError *gerr = NULL;
+
+	if (err < 0) {
+		error("Unable to get service record: %s (%d)", strerror(-err),
+					-err);
+		return;
+	}
+
+	if (!recs || !recs->data) {
+		error("No records found");
+		return;
+	}
+
+	gw->version = get_remote_profile_version(recs->data);
+	if (gw->version > 0)
+		rfcomm_connect_cb(gw->incoming, gerr, dev);
+}
+
+static void unregister_incoming(gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+
+	if (gw->incoming) {
+		g_io_channel_unref(gw->incoming);
+		gw->incoming = NULL;
+	}
+}
+
+static void rfcomm_incoming_cb(GIOChannel *chan, GError *err,
+				gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+	uuid_t uuid;
+
+	gw->incoming = g_io_channel_ref(chan);
+
+	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
+	if (bt_search_service(&dev->src, &dev->dst, &uuid,
+				get_incoming_record_cb, dev,
+				unregister_incoming))
+		unregister_incoming(dev);
+}
+
 static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
@@ -297,6 +375,13 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto fail;
 	}
 
+	gw->version = get_remote_profile_version(recs->data);
+	if (gw->version == 0) {
+		error("Unable to get profile version from record");
+		err = -EINVAL;
+		goto fail;
+	}
+
 	memcpy(&uuid, classes->data, sizeof(uuid));
 	sdp_list_free(classes, free);
 
@@ -625,7 +710,7 @@ void gateway_start_service(struct audio_device *dev)
 	if (gw->rfcomm == NULL)
 		return;
 
-	if (!bt_io_accept(gw->rfcomm, rfcomm_connect_cb, dev, NULL, &err)) {
+	if (!bt_io_accept(gw->rfcomm, rfcomm_incoming_cb, dev, NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
 		g_error_free(err);
 	}
-- 
1.7.1

