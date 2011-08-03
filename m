Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] audio: add profile version to HandsfreeAgent
Date: Wed,  3 Aug 2011 15:34:17 +0200
Message-Id: <1312378457-12732-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
Samsung SGH-D600 returning 0x0101 as profile version) do not accept
an AT+BRSF with latest features.
The Handsfree agent should adapt its AT+BRSF command depending on the
remote version, so add version information as parameter of
NewConnection method.

Here is traces of buggy exchange:

< ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(d): cid 0x0046 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 12 fcs 0xb0
      0000: 41 54 2b 42 52 53 46 3d  31 31 38 0d              AT+BRSF=118.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 25
    L2CAP(d): cid 0x0042 len 21 [psm 1]
        SDP SSA Req: tid 0x0 len 0x10
          pat uuid-16 0x111e (Handsfree)
          max 240
          aid(s) 0x0001 (SrvClassIDList) 0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 12 flags 0x02 dlen 27
    L2CAP(d): cid 0x0040 len 23 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x12
          count 15
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
          cont 00
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 9 fcs 0x76 credits 1
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0046 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d



and after the fix (and corresponding fix in oFono):

< ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0048 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 11 fcs 0xb0
      0000: 41 54 2b 42 52 53 46 3d  32 32 0d                 AT+BRSF=22.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> ACL data: handle 12 flags 0x02 dlen 28
    L2CAP(d): cid 0x0041 len 24 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 19 fcs 0x76 credits 1
      0000: 0d 0a 2b 42 52 53 46 3a  20 33 33 0d 0a 0d 0a 4f  ..+BRSF: 33....O
      0010: 4b 0d 0a                                          K..
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0048 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 10 fcs 0xb0
      0000: 41 54 2b 43 49 4e 44 3d  3f 0d                    AT+CIND=?.
---
 audio/gateway.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/hfp-api.txt |    2 +-
 2 files changed, 87 insertions(+), 2 deletions(-)

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
diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
index 93251e8..cf2e730 100644
--- a/doc/hfp-api.txt
+++ b/doc/hfp-api.txt
@@ -62,7 +62,7 @@ Service         unique name
 Interface       org.bluez.HandsfreeAgent
 Object path     freely definable
 
-Methods		void NewConnection(filedescriptor fd)
+Methods		void NewConnection(filedescriptor fd, uint16 version)
 
 			This method gets called whenever a new handsfree
 			connection has been established.  The objectpath
-- 
1.7.1

