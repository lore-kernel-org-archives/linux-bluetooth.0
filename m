Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/3] Fix memory leak in src/sdpd-server.c
Date: Mon, 20 Dec 2010 00:29:05 -0400
Message-Id: <1292819346-27318-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Watches must be removed with g_source_remove() otherwise they leak a
reference count to the GIOChannel and internal memory allocations.

Also do a little refactoring to avoid too many global variables.
---
 src/sdpd-server.c |   83 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index efd6fd0..fbc4c96 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -48,9 +48,11 @@
 #include "log.h"
 #include "sdpd.h"
 
-static GIOChannel *l2cap_io = NULL, *unix_io = NULL;
-
-static int l2cap_sock, unix_sock;
+static struct sock_info {
+	int sk;
+	GIOChannel *io;
+	guint watch_id;
+} l2cap_sk, unix_sk;
 
 /*
  * SDP server initialization on startup includes creating the
@@ -71,8 +73,8 @@ static int init_server(uint16_t mtu, int master, int compat)
 	register_server_service();
 
 	/* Create L2CAP socket */
-	l2cap_sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
-	if (l2cap_sock < 0) {
+	l2cap_sk.sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (l2cap_sk.sk < 0) {
 		error("opening L2CAP socket: %s", strerror(errno));
 		return -1;
 	}
@@ -82,14 +84,16 @@ static int init_server(uint16_t mtu, int master, int compat)
 	bacpy(&l2addr.l2_bdaddr, BDADDR_ANY);
 	l2addr.l2_psm = htobs(SDP_PSM);
 
-	if (bind(l2cap_sock, (struct sockaddr *) &l2addr, sizeof(l2addr)) < 0) {
+	if (bind(l2cap_sk.sk, (struct sockaddr *) &l2addr,
+							sizeof(l2addr)) < 0) {
 		error("binding L2CAP socket: %s", strerror(errno));
 		return -1;
 	}
 
 	if (master) {
 		int opt = L2CAP_LM_MASTER;
-		if (setsockopt(l2cap_sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
+		if (setsockopt(l2cap_sk.sk, SOL_L2CAP, L2CAP_LM, &opt,
+							sizeof(opt)) < 0) {
 			error("setsockopt: %s", strerror(errno));
 			return -1;
 		}
@@ -99,7 +103,8 @@ static int init_server(uint16_t mtu, int master, int compat)
 		memset(&opts, 0, sizeof(opts));
 		optlen = sizeof(opts);
 
-		if (getsockopt(l2cap_sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, &optlen) < 0) {
+		if (getsockopt(l2cap_sk.sk, SOL_L2CAP, L2CAP_OPTIONS, &opts,
+								&optlen) < 0) {
 			error("getsockopt: %s", strerror(errno));
 			return -1;
 		}
@@ -107,25 +112,24 @@ static int init_server(uint16_t mtu, int master, int compat)
 		opts.omtu = mtu;
 		opts.imtu = mtu;
 
-		if (setsockopt(l2cap_sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, sizeof(opts)) < 0) {
+		if (setsockopt(l2cap_sk.sk, SOL_L2CAP, L2CAP_OPTIONS, &opts,
+							sizeof(opts)) < 0) {
 			error("setsockopt: %s", strerror(errno));
 			return -1;
 		}
 	}
 
-	if (listen(l2cap_sock, 5) < 0) {
+	if (listen(l2cap_sk.sk, 5) < 0) {
 		error("listen: %s", strerror(errno));
 		return -1;
 	}
 
-	if (!compat) {
-		unix_sock = -1;
+	if (!compat)
 		return 0;
-	}
 
 	/* Create local Unix socket */
-	unix_sock = socket(PF_UNIX, SOCK_STREAM, 0);
-	if (unix_sock < 0) {
+	unix_sk.sk = socket(PF_UNIX, SOCK_STREAM, 0);
+	if (unix_sk.sk < 0) {
 		error("opening UNIX socket: %s", strerror(errno));
 		return -1;
 	}
@@ -136,12 +140,13 @@ static int init_server(uint16_t mtu, int master, int compat)
 
 	unlink(unaddr.sun_path);
 
-	if (bind(unix_sock, (struct sockaddr *) &unaddr, sizeof(unaddr)) < 0) {
+	if (bind(unix_sk.sk, (struct sockaddr *) &unaddr,
+							sizeof(unaddr)) < 0) {
 		error("binding UNIX socket: %s", strerror(errno));
 		return -1;
 	}
 
-	if (listen(unix_sock, 5) < 0) {
+	if (listen(unix_sk.sk, 5) < 0) {
 		error("listen UNIX socket: %s", strerror(errno));
 		return -1;
 	}
@@ -195,21 +200,19 @@ static gboolean io_accept_event(GIOChannel *chan, GIOCondition cond, gpointer da
 	GIOChannel *io;
 	int nsk;
 
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_io_channel_unref(chan);
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		return FALSE;
-	}
 
-	if (data == &l2cap_sock) {
+	if (data == &l2cap_sk) {
 		struct sockaddr_l2 addr;
 		socklen_t len = sizeof(addr);
 
-		nsk = accept(l2cap_sock, (struct sockaddr *) &addr, &len);
-	} else if (data == &unix_sock) {
+		nsk = accept(l2cap_sk.sk, (struct sockaddr *) &addr, &len);
+	} else if (data == &unix_sk) {
 		struct sockaddr_un addr;
 		socklen_t len = sizeof(addr);
 
-		nsk = accept(unix_sock, (struct sockaddr *) &addr, &len);
+		nsk = accept(unix_sk.sk, (struct sockaddr *) &addr, &len);
 	} else
 		return FALSE;
 
@@ -256,18 +259,20 @@ int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags)
 		}
 	}
 
-	l2cap_io = g_io_channel_unix_new(l2cap_sock);
-	g_io_channel_set_close_on_unref(l2cap_io, TRUE);
+	l2cap_sk.io = g_io_channel_unix_new(l2cap_sk.sk);
+	g_io_channel_set_close_on_unref(l2cap_sk.io, TRUE);
 
-	g_io_add_watch(l2cap_io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					io_accept_event, &l2cap_sock);
+	l2cap_sk.watch_id = g_io_add_watch(l2cap_sk.io, G_IO_IN | G_IO_ERR |
+						G_IO_HUP | G_IO_NVAL,
+						io_accept_event, &l2cap_sk);
 
-	if (compat && unix_sock > fileno(stderr)) {
-		unix_io = g_io_channel_unix_new(unix_sock);
-		g_io_channel_set_close_on_unref(unix_io, TRUE);
+	if (compat) {
+		unix_sk.io = g_io_channel_unix_new(unix_sk.sk);
+		g_io_channel_set_close_on_unref(unix_sk.io, TRUE);
 
-		g_io_add_watch(unix_io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					io_accept_event, &unix_sock);
+		unix_sk.watch_id = g_io_add_watch(unix_sk.io, G_IO_IN |
+						G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						io_accept_event, &unix_sk);
 	}
 
 	return 0;
@@ -279,9 +284,13 @@ void stop_sdp_server(void)
 
 	sdp_svcdb_reset();
 
-	if (unix_io)
-		g_io_channel_unref(unix_io);
+	if (l2cap_sk.watch_id > 0)
+		g_source_remove(l2cap_sk.watch_id);
+	g_io_channel_unref(l2cap_sk.io);
+	memset(&l2cap_sk, 0, sizeof(l2cap_sk));
 
-	if (l2cap_io)
-		g_io_channel_unref(l2cap_io);
+	if (unix_sk.watch_id > 0)
+		g_source_remove(unix_sk.watch_id);
+	g_io_channel_unref(unix_sk.io);
+	memset(&unix_sk, 0, sizeof(unix_sk));
 }
-- 
1.7.0.4

