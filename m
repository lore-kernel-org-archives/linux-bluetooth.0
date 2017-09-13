Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix possible crash when accepting stream transport
Date: Wed, 13 Sep 2017 14:42:36 +0300
Message-Id: <20170913114236.17071-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

During the course of bt_io_accept the setup can be freed causing the
callback to be called which can lead to the following crash:

bluetoothd[853]: profiles/audio/a2dp.c:setup_unref() 0x8183c1c0: ref=0
bluetoothd[853]: profiles/audio/a2dp.c:setup_free() 0x8183c1c0
...
bluetoothd[853]: HUP or ERR on socket: Connection reset by peer (104)
bluetoothd[853]: profiles/audio/a2dp.c:setup_unref() 0x8183c1c0: ref=-80438434
bluetoothd[853]: profiles/audio/a2dp.c:setup_free() 0x8183c1c0

0  0x80106888 in stream_free ()
1  0xb7621d49 in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
2  0xb7621d92 in g_slist_free_full () from /usr/lib/libglib-2.0.so.0
3  0x80107d09 in avdtp_unref ()
4  0x8010273b in setup_unref ()
5  0x80104c54 in transport_cb ()
6  0x80136a9c in accept_cb ()
---
 profiles/audio/a2dp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 58e1534a4..cf0040076 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -104,6 +104,7 @@ struct a2dp_setup {
 	gboolean reconfigure;
 	gboolean start;
 	GSList *cb;
+	GIOChannel *io;
 	int ref;
 };
 
@@ -158,6 +159,11 @@ static void setup_free(struct a2dp_setup *s)
 {
 	DBG("%p", s);
 
+	if (s->io) {
+		g_io_channel_shutdown(s->io, TRUE, NULL);
+		g_io_channel_unref(s->io);
+	}
+
 	setups = g_slist_remove(setups, s);
 	if (s->session)
 		avdtp_unref(s->session);
@@ -1475,6 +1481,7 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	if (err) {
 		error("%s", err->message);
+		if (err)
 		goto drop;
 	}
 
@@ -1493,6 +1500,9 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
+	g_io_channel_unref(setup->io);
+	setup->io = NULL;
+
 	setup_unref(setup);
 
 	return;
@@ -1537,12 +1547,24 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 		if (!setup || !setup->stream)
 			goto drop;
 
+		if (setup->io) {
+			error("transport channel already exists");
+			goto drop;
+		}
+
 		if (!bt_io_accept(io, transport_cb, setup, NULL, &err)) {
 			error("bt_io_accept: %s", err->message);
 			g_error_free(err);
 			goto drop;
 		}
 
+		/*
+		 * Reference the channel so it can be shutdown properly
+		 * stopping bt_io_accept from calling the callback with invalid
+		 * setup pointer.
+		 */
+		setup->io = g_io_channel_ref(io);
+
 		return;
 	}
 
-- 
2.13.5

