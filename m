Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 8/8] Fix btio users to not expect a default security level
Date: Fri, 19 Aug 2011 21:09:29 -0300
Message-Id: <1313798969-8772-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The users of btio should not expect that btio will set the security
level to medium if it wasn't specified. Now, all the users specfify
the security level needed.
---
 audio/avdtp.c        |    1 +
 audio/control.c      |    1 +
 audio/gateway.c      |    2 ++
 audio/headset.c      |    1 +
 input/device.c       |    1 +
 network/connection.c |    1 +
 serial/port.c        |    2 ++
 7 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 11f6515..d825dd3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2518,6 +2518,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
 				BT_IO_OPT_DEST_BDADDR, &session->dst,
 				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
diff --git a/audio/control.c b/audio/control.c
index 882c9fb..53b7876 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -2012,6 +2012,7 @@ gboolean avrcp_connect(struct audio_device *dev)
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
 				BT_IO_OPT_PSM, AVCTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (err) {
 		avctp_set_state(control, AVCTP_STATE_DISCONNECTED);
diff --git a/audio/gateway.c b/audio/gateway.c
index e9485d0..afd2f94 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -421,6 +421,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CHANNEL, ch,
 				BT_IO_OPT_INVALID);
 	if (!io) {
@@ -751,6 +752,7 @@ gboolean gateway_request_stream(struct audio_device *dev,
 		io = bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 		if (!io) {
 			error("%s", err->message);
diff --git a/audio/headset.c b/audio/headset.c
index 8e63afc..d36e07c 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1622,6 +1622,7 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_CHANNEL, hs->rfcomm_ch,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
 
 	hs->rfcomm_ch = -1;
diff --git a/input/device.c b/input/device.c
index 70d0ba2..bde7236 100644
--- a/input/device.c
+++ b/input/device.c
@@ -368,6 +368,7 @@ static gboolean rfcomm_connect(struct input_conn *iconn, GError **err)
 				NULL, err,
 				BT_IO_OPT_SOURCE_BDADDR, &idev->src,
 				BT_IO_OPT_DEST_BDADDR, &idev->dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (!io)
 		return FALSE;
diff --git a/network/connection.c b/network/connection.c
index ac27cf2..c56368e 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -373,6 +373,7 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 				BT_IO_OPT_SOURCE_BDADDR, &peer->src,
 				BT_IO_OPT_DEST_BDADDR, &peer->dst,
 				BT_IO_OPT_PSM, BNEP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_OMTU, BNEP_MTU,
 				BT_IO_OPT_IMTU, BNEP_MTU,
 				BT_IO_OPT_INVALID);
diff --git a/serial/port.c b/serial/port.c
index d011084..ba2eb64 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -404,6 +404,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 				BT_IO_OPT_SOURCE_BDADDR, &device->src,
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (!port->io) {
 		error("%s", gerr->message);
@@ -444,6 +445,7 @@ connect:
 				BT_IO_OPT_SOURCE_BDADDR, &device->src,
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (port->io)
 		return 0;
-- 
1.7.6

