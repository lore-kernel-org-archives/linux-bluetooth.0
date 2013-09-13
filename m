Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] obexd: Add request struct to MAP
Date: Fri, 13 Sep 2013 17:28:31 +0200
Message-Id: <1379086116-22617-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a pending_request struct in order to store the D-Bus request
data.

The current version stores the received D-Bus message in the MAP session
struct. The stored message is overridden by intermediate D-Bus method
calls which can lead into a crash.

Trace:
  arguments to dbus_message_unref() were incorrect,
  assertion "!message->in_cache" failed in file dbus-message.c line 1618.

 0  0x00007ffff6a6a1c9 in raise () from /usr/lib/libc.so.6
 1  0x00007ffff6a6b5c8 in abort () from /usr/lib/libc.so.6
 2  0x00007ffff7313de5 in ?? () from /usr/lib/libdbus-1.so.3
 3  0x00007ffff730ab91 in ?? () from /usr/lib/libdbus-1.so.3
 4  0x000000000043721c in message_listing_cb (session=0x6a7d30,
    transfer=0x6a9450, err=0x0, user_data=0x6a9950) at obexd/client/map.c:1166
 5  0x000000000042f7af in session_terminate_transfer (session=0x6a7d30,
    transfer=0x6a9450, gerr=0x0) at obexd/client/session.c:830
 6  0x000000000042f83d in session_notify_complete (session=0x6a7d30,
    transfer=0x6a9450) at obexd/client/session.c:845
 7  0x000000000042f8dc in transfer_complete (transfer=0x6a9450, err=0x0,
    user_data=0x6a7d30) at obexd/client/session.c:865
 8  0x0000000000439ee7 in xfer_complete (obex=0x677250, err=0x0,
    user_data=0x6a9450) at obexd/client/transfer.c:577
 9  0x000000000043a05f in get_xfer_progress_first (obex=0x677250, err=0x0,
    rsp=0x678730, user_data=0x6a9450) at obexd/client/transfer.c:621
 10 0x0000000000413f08 in handle_response (obex=0x677250, err=0x0,
    rsp=0x678730) at gobex/gobex.c:949
 11 0x00000000004147db in incoming_data (io=0x6a8a00, cond=G_IO_IN,
    user_data=0x677250) at gobex/gobex.c:1192
 12 0x00007ffff702dda6 in g_main_context_dispatch ()
   from /usr/lib/libglib-2.0.so.0
 13 0x00007ffff702e0f8 in ?? () from /usr/lib/libglib-2.0.so.0
 14 0x00007ffff702e4fa in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
 15 0x0000000000427ce8 in main (argc=1, argv=0x7fffffffdd48)
    at obexd/src/main.c:319
---
 obexd/client/map.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 95f0334..f969aad 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -101,6 +101,11 @@ struct map_data {
 	uint8_t supported_message_types;
 };
 
+struct pending_request {
+	struct map_data *map;
+	DBusMessage *msg;
+};
+
 #define MAP_MSG_FLAG_PRIORITY	0x01
 #define MAP_MSG_FLAG_READ	0x02
 #define MAP_MSG_FLAG_SENT	0x04
@@ -134,6 +139,25 @@ struct map_parser {
 
 static DBusConnection *conn = NULL;
 
+static struct pending_request *pending_request_new(struct map_data *map,
+							DBusMessage *message)
+{
+	struct pending_request *p;
+
+	p = g_new0(struct pending_request, 1);
+	p->map = map;
+	p->msg = dbus_message_ref(message);
+
+	return p;
+}
+
+static void pending_request_free(struct pending_request *p)
+{
+	dbus_message_unref(p->msg);
+
+	g_free(p);
+}
+
 static void simple_cb(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
-- 
1.8.3.4

