Return-Path: <cyrus@holtmann.org>
From: Steven Walter <stevenrwalter@gmail.com>
To: linux-bluetooth@vger.kernel.org, armansito@chromium.org
Cc: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH BlueZ 3/5] tools/btgatt-server.c: convert to glib mainloop
Date: Wed,  3 Dec 2014 10:54:32 -0500
Message-Id: <1417622074-20023-3-git-send-email-stevenrwalter@gmail.com>
In-Reply-To: <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
References: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
 <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prep work for running gatt-dbus services
---
 Makefile.tools        |   4 +-
 tools/btgatt-server.c | 136 ++++++++++++++++++++++++++------------------------
 2 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index ef4162b..7520ab5 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -277,8 +277,8 @@ tools_btgatt_client_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
 tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
-tools_btgatt_server_LDADD = src/libshared-mainloop.la \
-						lib/libbluetooth-internal.la
+tools_btgatt_server_LDADD = lib/libbluetooth-internal.la src/libshared-glib.la \
+						@GLIB_LIBS@
 
 EXTRA_DIST += tools/bdaddr.1
 endif
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index c603b30..fa07cfb 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -20,14 +20,17 @@
 #include <config.h>
 #endif
 
+#include <assert.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <signal.h>
 #include <time.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
 #include <errno.h>
+#include <glib.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -35,7 +38,6 @@
 #include <bluetooth/l2cap.h>
 #include "lib/uuid.h"
 
-#include "monitor/mainloop.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
@@ -101,11 +103,13 @@ static void print_prompt(void)
 	fflush(stdout);
 }
 
+static GMainLoop *event_loop;
+
 static void att_disconnect_cb(void *user_data)
 {
 	printf("Device disconnected\n");
 
-	mainloop_quit();
+	g_main_loop_quit(event_loop);
 }
 
 static void att_debug_cb(const char *str, void *user_data)
@@ -536,18 +540,11 @@ static void populate_db(struct server *server)
 	populate_hr_service(server);
 }
 
-static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
+static struct server *server_create(struct server *server, int fd, uint16_t mtu, bool hr_visible)
 {
-	struct server *server;
 	struct bt_att *att;
 	size_t name_len = strlen(test_device_name);
 
-	server = new0(struct server, 1);
-	if (!server) {
-		fprintf(stderr, "Failed to allocate memory for server\n");
-		return NULL;
-	}
-
 	att = bt_att_new(fd);
 	if (!att) {
 		fprintf(stderr, "Failed to initialze ATT transport layer\n");
@@ -575,11 +572,6 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	server->device_name[name_len] = '\0';
 
 	server->fd = fd;
-	server->db = gatt_db_new();
-	if (!server->db) {
-		fprintf(stderr, "Failed to create GATT database\n");
-		goto fail;
-	}
 
 	server->gatt = bt_gatt_server_new(server->db, att, mtu);
 	if (!server->gatt) {
@@ -600,7 +592,6 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 
 	/* bt_gatt_server already holds a reference */
 	bt_att_unref(att);
-	populate_db(server);
 
 	return server;
 
@@ -647,11 +638,9 @@ static struct option main_options[] = {
 
 static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec)
 {
-	int sk, nsk;
-	struct sockaddr_l2 srcaddr, addr;
-	socklen_t optlen;
+	int sk;
+	struct sockaddr_l2 srcaddr;
 	struct bt_security btsec;
-	char ba[18];
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 	if (sk < 0) {
@@ -687,19 +676,7 @@ static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec)
 
 	printf("Started listening on ATT channel. Waiting for connections\n");
 
-	memset(&addr, 0, sizeof(addr));
-	optlen = sizeof(addr);
-	nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
-	if (nsk < 0) {
-		perror("Accept failed");
-		goto fail;
-	}
-
-	ba2str(&addr.l2_bdaddr, ba);
-	printf("Connect from %s\n", ba);
-	close(sk);
-
-	return nsk;
+	return sk;
 
 fail:
 	close(sk);
@@ -907,8 +884,9 @@ static void cmd_help(struct server *server, char *cmd_str)
 		printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
 }
 
-static void prompt_read_cb(int fd, uint32_t events, void *user_data)
+static gboolean prompt_read_cb(GIOChannel *channel, GIOCondition events, gpointer user_data)
 {
+	int fd = g_io_channel_unix_get_fd(channel);
 	ssize_t read;
 	size_t len = 0;
 	char *line = NULL;
@@ -916,19 +894,19 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	struct server *server = user_data;
 	int i;
 
-	if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
-		mainloop_quit();
-		return;
+	if (events & (G_IO_HUP | G_IO_ERR)) {
+		g_main_loop_quit(event_loop);
+		return FALSE;
 	}
 
 	read = getline(&line, &len, stdin);
 	if (read < 0)
-		return;
+		return FALSE;
 
 	if (read <= 1) {
 		cmd_help(server, NULL);
 		print_prompt();
-		return;
+		return TRUE;
 	}
 
 	line[read-1] = '\0';
@@ -955,18 +933,46 @@ failed:
 	print_prompt();
 
 	free(line);
+	return TRUE;
+}
+
+static gboolean signal_cb(void *user_data)
+{
+	g_main_loop_quit(event_loop);
+	return FALSE;
 }
 
-static void signal_cb(int signum, void *user_data)
+static struct server *server;
+static uint16_t mtu = 0;
+static bool hr_visible = false;
+
+static gboolean new_connection_cb(GIOChannel *channel, GIOCondition events, gpointer user_data)
 {
-	switch (signum) {
-	case SIGINT:
-	case SIGTERM:
-		mainloop_quit();
-		break;
-	default:
-		break;
+	int sk = g_io_channel_unix_get_fd(channel);
+	int nsk;
+	socklen_t optlen;
+	struct sockaddr_l2 addr;
+	char ba[18];
+
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+	nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
+	if (nsk < 0) {
+		perror("Accept failed");
+		return TRUE;
+	}
+
+	ba2str(&addr.l2_bdaddr, ba);
+	printf("Connect from %s\n", ba);
+	close(sk);
+
+	server = server_create(server, nsk, mtu, hr_visible);
+	if (!server) {
+		close(nsk);
+		return EXIT_FAILURE;
 	}
+
+	return TRUE;
 }
 
 int main(int argc, char *argv[])
@@ -976,10 +982,6 @@ int main(int argc, char *argv[])
 	int dev_id = -1;
 	int fd;
 	int sec = BT_SECURITY_LOW;
-	uint16_t mtu = 0;
-	sigset_t mask;
-	bool hr_visible = false;
-	struct server *server;
 
 	while ((opt = getopt_long(argc, argv, "+hvrs:m:i:",
 						main_options, NULL)) != -1) {
@@ -1057,35 +1059,37 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Failed to accept L2CAP ATT connection\n");
 		return EXIT_FAILURE;
 	}
+	GIOChannel *channel = g_io_channel_unix_new(fd);
+	g_io_add_watch(channel, G_IO_IN, new_connection_cb, NULL);
 
-	mainloop_init();
+	event_loop = g_main_loop_new(NULL, FALSE);
 
-	server = server_create(fd, mtu, hr_visible);
+	server = new0(struct server, 1);
 	if (!server) {
-		close(fd);
+		fprintf(stderr, "Failed to allocate memory for server\n");
 		return EXIT_FAILURE;
 	}
+	server->db = gatt_db_new();
+	populate_db(server);
 
-	if (mainloop_add_fd(fileno(stdin),
-				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
-				prompt_read_cb, server, NULL) < 0) {
-		fprintf(stderr, "Failed to initialize console\n");
-		server_destroy(server);
-
+	if (!server->db) {
+		fprintf(stderr, "Failed to create GATT database\n");
 		return EXIT_FAILURE;
 	}
 
-	printf("Running GATT server\n");
+	channel = g_io_channel_unix_new(fileno(stdin));
+	int source = g_io_add_watch(channel, G_IO_IN | G_IO_ERR | G_IO_HUP,
+				prompt_read_cb, server);
+
 
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
+	printf("Running GATT server\n");
 
-	mainloop_set_signal(&mask, signal_cb, NULL, NULL);
+	g_unix_signal_add_full(G_PRIORITY_DEFAULT, SIGINT, signal_cb, NULL, NULL);
+	g_unix_signal_add_full(G_PRIORITY_DEFAULT, SIGTERM, signal_cb, NULL, NULL);
 
 	print_prompt();
 
-	mainloop_run();
+	g_main_loop_run(event_loop);
 
 	printf("\n\nShutting down...\n");
 
-- 
1.9.1

