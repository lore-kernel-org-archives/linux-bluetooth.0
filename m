Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] tools/l2cap-tester: Fix memory leak
Date: Fri, 20 Dec 2013 10:30:29 +0100
Message-Id: <1387531829-31079-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set close_on_unref on new created GIOChannel and don't close
its file descriptor.

126 (120 direct, 6 indirect) bytes in 1 blocks aredefinitely
	lost in loss record 24 of 28
at 0x4A06409: malloc (in/usr/lib64/valgrind/vgpreload_memcheck
	-amd64-linux.so)
by 0x3C9564D88E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3600.3)
by 0x3C956881F4: g_io_channel_unix_new (in/usr/lib64/libglib-
	2.0.so.0.3600.3)
by 0x402A5A: l2cap_listen_cb (l2cap-tester.c:774)
by 0x3C95647DF5: g_main_context_dispatch (in/usr/lib64/
	libglib-2.0.so.0.3600.3)
by 0x3C95648147: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
by 0x3C95648549: g_main_loop_run
	(in/usr/lib64/libglib-2.0.so.0.3600.3)
by 0x40A67C: tester_run (tester.c:784)
by 0x4026A9: main (l2cap-tester.c:991)
---
 tools/l2cap-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 7c50f26..a5028a3 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -535,7 +535,6 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	if (read(sk, buf, l2data->data_len) != l2data->data_len) {
 		tester_warn("Unable to read %u bytes", l2data->data_len);
 		tester_test_failed();
-		close(sk);
 		return FALSE;
 	}
 
@@ -544,8 +543,6 @@ static gboolean server_received_data(GIOChannel *io, GIOCondition cond,
 	else
 		tester_test_passed();
 
-	close(sk);
-
 	return FALSE;
 }
 
@@ -785,12 +782,15 @@ static gboolean l2cap_listen_cb(GIOChannel *io, GIOCondition cond,
 		GIOChannel *new_io;
 
 		new_io = g_io_channel_unix_new(new_sk);
+		g_io_channel_set_close_on_unref(new_io, TRUE);
 
 		bthost = hciemu_client_get_host(data->hciemu);
 		g_io_add_watch(new_io, G_IO_IN, server_received_data, NULL);
 		bthost_send_cid(bthost, data->handle, data->dcid,
 					l2data->read_data, l2data->data_len);
 
+		g_io_channel_unref(new_io);
+
 		return FALSE;
 	} else if (l2data->write_data) {
 		struct bthost *bthost;
-- 
1.8.3.1

