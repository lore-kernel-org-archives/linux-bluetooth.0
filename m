Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/socket: Refactor connect to allow directly connect to rfcomm
Date: Wed, 18 Dec 2013 16:18:54 +0200
Message-Id: <1387376336-17092-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since Socket HAL allows us to specify RFCOMM channel number and directly
connect refactor send function to allow connect directly is uuid is zero
and channel number is specified.
---
 android/socket.c | 71 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index cee4b6e..656222e 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -838,13 +838,47 @@ fail:
 	cleanup_rfsock(rfsock);
 }
 
-static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+static bool do_connect(struct rfcomm_sock *rfsock, int chan)
 {
-	struct rfcomm_sock *rfsock = data;
 	BtIOSecLevel sec_level = BT_IO_SEC_MEDIUM;
+	GIOChannel *io;
 	GError *gerr = NULL;
+
+	if (rfsock->profile)
+		sec_level = rfsock->profile->sec_level;
+
+	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
+				BT_IO_OPT_CHANNEL, chan,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("Failed connect: %s", gerr->message);
+		g_error_free(gerr);
+		return false;
+	}
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+	g_io_channel_unref(io);
+
+	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		return false;
+	}
+
+	rfsock->real_sock = g_io_channel_unix_get_fd(io);
+	rfsock_set_buffer(rfsock);
+	rfsock->channel = chan;
+	connections = g_list_append(connections, rfsock);
+
+	return true;
+}
+
+static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	struct rfcomm_sock *rfsock = data;
 	sdp_list_t *list;
-	GIOChannel *io;
 	int chan;
 
 	DBG("");
@@ -885,36 +919,9 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	DBG("Got RFCOMM channel %d", chan);
 
-	if (rfsock->profile)
-		sec_level = rfsock->profile->sec_level;
-
-	io = bt_io_connect(connect_cb, rfsock, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &rfsock->dst,
-				BT_IO_OPT_CHANNEL, chan,
-				BT_IO_OPT_SEC_LEVEL, sec_level,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("Failed connect: %s", gerr->message);
-		g_error_free(gerr);
-		goto fail;
-	}
-
-	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
-		error("Error sending RFCOMM channel");
-		goto fail;
-	}
-
-	rfsock->real_sock = g_io_channel_unix_get_fd(io);
-	rfsock_set_buffer(rfsock);
-	rfsock->channel = chan;
-	connections = g_list_append(connections, rfsock);
-
-	g_io_channel_unref(io);
-
-	return;
+	if (do_connect(rfsock, chan))
+		return;
 fail:
-	connections = g_list_remove(connections, rfsock);
 	cleanup_rfsock(rfsock);
 }
 
-- 
1.8.3.2

