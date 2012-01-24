Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 6/6] Fix btio users to not expect a default security level
Date: Mon, 23 Jan 2012 21:27:05 -0300
Message-Id: <1327364825-7285-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The users of btio should not expect that btio will set the security
level to medium if it wasn't specified. Now, all the users specfify
the security level needed.
---
 audio/avdtp.c        |    1 +
 audio/gateway.c      |    2 ++
 audio/headset.c      |    1 +
 input/device.c       |    1 +
 network/connection.c |    1 +
 serial/port.c        |    2 ++
 6 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index d3568ba..cd66fd4 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2525,6 +2525,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
 				BT_IO_OPT_DEST_BDADDR, &session->dst,
 				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
diff --git a/audio/gateway.c b/audio/gateway.c
index 9b1aab3..bde3e02 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -501,6 +501,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CHANNEL, ch,
 				BT_IO_OPT_INVALID);
 	if (!io) {
@@ -847,6 +848,7 @@ unsigned int gateway_request_stream(struct audio_device *dev,
 		io = bt_io_connect(BT_IO_SCO, sco_connect_cb, dev, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 				BT_IO_OPT_DEST_BDADDR, &dev->dst,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 		if (!io) {
 			error("%s", err->message);
diff --git a/audio/headset.c b/audio/headset.c
index c5ea58b..a10a386 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1625,6 +1625,7 @@ static int rfcomm_connect(struct audio_device *dev, headset_stream_cb_t cb,
 					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_CHANNEL, hs->rfcomm_ch,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
 
 	hs->rfcomm_ch = -1;
diff --git a/input/device.c b/input/device.c
index a1ecdd7..0ab63c0 100644
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
index ca1f4b2..f864972 100644
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
index 5b76d14..36e3bd6 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -422,6 +422,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 				BT_IO_OPT_SOURCE_BDADDR, &device->src,
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (!port->io) {
 		error("%s", gerr->message);
@@ -462,6 +463,7 @@ connect:
 				BT_IO_OPT_SOURCE_BDADDR, &device->src,
 				BT_IO_OPT_DEST_BDADDR, &device->dst,
 				BT_IO_OPT_CHANNEL, port->channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_INVALID);
 	if (port->io == NULL)
 		return -EIO;
-- 
1.7.8.1

