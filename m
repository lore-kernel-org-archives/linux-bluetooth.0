Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] audio/AVCTP: Retry rejected outgoing connect if incoming was rejected
Date: Thu, 26 Sep 2013 15:54:02 +0200
Message-ID: <1380203642-26401-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incoming AVCTP connection is rejected when there is outgoing connection
in progress. It is possible that remote device will do the same and
AVCTP will not be connected at all. In such case retry outgoing
connection if it was rejected by remote and in the meantime incoming
connection was rejected by bluetoothd.

profiles/audio/avrcp.c:avrcp_connect() path /org/bluez/hci0/
    dev_00_1E_DE_21_85_6A
profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
profiles/audio/sink.c:sink_set_state() State changed
    /org/bluez/hci0/dev_00_1E_DE_21_85_6A: SINK_STATE_CONNECTING ->
    SINK_STATE_CONNECTED
profiles/audio/transport.c:transport_update_playing()
    /org/bluez/hci0/dev_00_1E_DE_21_85_6A/fd1
    State=TRANSPORT_STATE_IDLE Playing=0
profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect
    from 00:1E:DE:21:85:6A
Control: Refusing unexpected connect
profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
connect error: Connection refused (111)

This fix connecting to Nokia BH-505 headset.
---
 profiles/audio/avctp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 845027f..d9b798c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -202,6 +202,8 @@ struct avctp {
 	uint8_t key_quirks[256];
 	struct key_pressed key;
 	bool initiator;
+
+	bool incoming_refused;
 };
 
 struct avctp_passthrough_handler {
@@ -1162,6 +1164,36 @@ fail:
 	}
 }
 
+static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data);
+
+static bool retry_control_connect(struct avctp *session)
+{
+	GIOChannel *io;
+
+	info ("Control: retrying to connect");
+
+	if (session->control) {
+		avctp_channel_destroy(session->control);
+		session->control = NULL;
+	}
+
+	io = bt_io_connect(avctp_connect_cb, session, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(session->device),
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
+				BT_IO_OPT_INVALID);
+	if (io == NULL)
+		return false;
+
+	session->control = avctp_channel_create(session, io, NULL);
+	g_io_channel_unref(io);
+
+	return true;
+}
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct avctp *session = data;
@@ -1170,6 +1202,11 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	GError *gerr = NULL;
 
 	if (err) {
+		if (session->incoming_refused && err->code == ECONNREFUSED) {
+			if (retry_control_connect(session))
+				return;
+		}
+
 		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 		error("%s", err->message);
 		return;
@@ -1301,6 +1338,8 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	if (session->control != NULL) {
 		error("Control: Refusing unexpected connect");
 		g_io_channel_shutdown(chan, TRUE, NULL);
+
+		session->incoming_refused = session->initiator;
 		return;
 	}
 
-- 
1.8.4

