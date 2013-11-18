Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 11/16] android/socket: Parse SDP response and connect
Date: Mon, 18 Nov 2013 10:26:14 +0200
Message-Id: <1384763179-2218-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Parse SDP response, find RFCOMM channel and connect.
---
 android/socket.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index c22e4ed..dde000d 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -377,9 +377,72 @@ static int handle_listen(void *buf)
 	return hal_fd;
 }
 
+static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+{
+}
+
 static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
+	struct rfcomm_slot *rfslot = data;
+	GError *gerr = NULL;
+	sdp_list_t *list;
+	GIOChannel *io;
+	int chan;
+
 	DBG("");
+
+	if (err < 0) {
+		error("Unable to get SDP record: %s", strerror(-err));
+		goto fail;
+	}
+
+	if (!recs || !recs->data) {
+		error("No SDP records found");
+		goto fail;
+	}
+
+	for (list = recs; list != NULL; list = list->next) {
+		sdp_record_t *rec = list->data;
+		sdp_list_t *protos;
+
+		if (sdp_get_access_protos(rec, &protos) < 0) {
+			error("Unable to get proto list");
+			goto fail;
+		}
+
+		chan = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
+									NULL);
+		sdp_list_free(protos, NULL);
+	}
+
+	if (chan <= 0) {
+		error("Could not get RFCOMM channel %d", chan);
+		goto fail;
+	}
+
+	DBG("Got RFCOMM channel %d", chan);
+
+	io = bt_io_connect(connect_cb, rfslot, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_DEST_BDADDR, &rfslot->dst,
+				BT_IO_OPT_CHANNEL, chan,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	if (!io) {
+		error("Failed connect: %s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
+	rfslot->real_sock = g_io_channel_unix_get_fd(io);
+	rfslot->channel = chan;
+	rfcomm_connected_list = g_list_append(rfcomm_connected_list, rfslot);
+	return;
+
+fail:
+	cleanup_rfslot(rfslot);
 }
 
 static int handle_connect(void *buf)
-- 
1.7.10.4

