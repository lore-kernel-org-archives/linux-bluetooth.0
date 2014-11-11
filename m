Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/8] tools/btgatt-server: Accept incoming connection and initialize server.
Date: Tue, 11 Nov 2014 13:39:41 -0800
Message-Id: <1415741987-22272-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code that listens for incoming connections and creates a
bt_gatt_server and bt_att structure once a connection is accepted.
---
 tools/btgatt-server.c | 215 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 4508de2..bee6275 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -25,6 +25,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <getopt.h>
+#include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -32,8 +33,135 @@
 #include <bluetooth/l2cap.h>
 #include "lib/uuid.h"
 
+#include "monitor/mainloop.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+
+#define ATT_CID 4
+
+#define PRLOG(...) \
+	do { \
+		printf(__VA_ARGS__); \
+		print_prompt(); \
+	} while (0)
+
+#define COLOR_OFF	"\x1B[0m"
+#define COLOR_RED	"\x1B[0;91m"
+#define COLOR_GREEN	"\x1B[0;92m"
+#define COLOR_YELLOW	"\x1B[0;93m"
+#define COLOR_BLUE	"\x1B[0;94m"
+#define COLOR_MAGENTA	"\x1B[0;95m"
+#define COLOR_BOLDGRAY	"\x1B[1;30m"
+#define COLOR_BOLDWHITE	"\x1B[1;37m"
+
 static bool verbose = false;
 
+struct server {
+	int fd;
+	struct gatt_db *db;
+	struct bt_gatt_server *gatt;
+};
+
+static void print_prompt(void)
+{
+	printf(COLOR_BLUE "[GATT server]" COLOR_OFF "# ");
+	fflush(stdout);
+}
+
+static void att_disconnect_cb(void *user_data)
+{
+	printf("Device disconnected\n");
+
+	mainloop_quit();
+}
+
+static void att_debug_cb(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	PRLOG(COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE "%s\n" COLOR_OFF, prefix,
+									str);
+}
+
+static void gatt_debug_cb(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	PRLOG(COLOR_GREEN "%s%s\n" COLOR_OFF, prefix, str);
+}
+
+static struct server *server_create(int fd, uint16_t mtu)
+{
+	struct server *server;
+	struct bt_att *att;
+
+	server = new0(struct server, 1);
+	if (!server) {
+		fprintf(stderr, "Failed to allocate memory for server\n");
+		return NULL;
+	}
+
+	att = bt_att_new(fd);
+	if (!att) {
+		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	if (!bt_att_set_close_on_unref(att, true)) {
+		fprintf(stderr, "Failed to set up ATT transport layer\n");
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
+		fprintf(stderr, "Failed to set ATT disconnect handler\n");
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	server->fd = fd;
+	server->db = gatt_db_new();
+	if (!server->db) {
+		fprintf(stderr, "Failed to create GATT database\n");
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	server->gatt = bt_gatt_server_new(server->db, att, mtu);
+	if (!server->gatt) {
+		fprintf(stderr, "Failed to create GATT server\n");
+		gatt_db_destroy(server->db);
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	if (verbose) {
+		bt_att_set_debug(att, att_debug_cb, "att: ", NULL);
+		bt_gatt_server_set_debug(server->gatt, gatt_debug_cb,
+							"server: ", NULL);
+	}
+
+	/* bt_gatt_server already holds a reference */
+	bt_att_unref(att);
+
+	return server;
+}
+
+static void server_destroy(struct server *server)
+{
+	bt_gatt_server_unref(server->gatt);
+	gatt_db_destroy(server->db);
+}
+
 static void usage(void)
 {
 	printf("btgatt-server\n");
@@ -57,6 +185,67 @@ static struct option main_options[] = {
 	{ }
 };
 
+static int l2cap_le_att_listen_and_accept(bdaddr_t *src, int sec)
+{
+	int sk, nsk;
+	struct sockaddr_l2 srcaddr, addr;
+	socklen_t optlen;
+	struct bt_security btsec;
+	char ba[18];
+
+	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (sk < 0) {
+		perror("Failed to create L2CAP sket");
+		return -1;
+	}
+
+	/* Set up source address */
+	memset(&srcaddr, 0, sizeof(srcaddr));
+	srcaddr.l2_family = AF_BLUETOOTH;
+	srcaddr.l2_cid = htobs(ATT_CID);
+	srcaddr.l2_bdaddr_type = 0;
+	bacpy(&srcaddr.l2_bdaddr, src);
+
+	if (bind(sk, (struct sockaddr *)&srcaddr, sizeof(srcaddr)) < 0) {
+		perror("Failed to bind L2CAP sket");
+		close(sk);
+		return -1;
+	}
+
+	/* Set the security level */
+	memset(&btsec, 0, sizeof(btsec));
+	btsec.level = sec;
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &btsec,
+							sizeof(btsec)) != 0) {
+		fprintf(stderr, "Failed to set L2CAP security level\n");
+		close(sk);
+		return -1;
+	}
+
+	if (listen(sk, 10) < 0) {
+		perror("Listening on socket failed");
+		close(sk);
+		return -1;
+	}
+
+	printf("Started listening on ATT channel. Waiting for connections\n");
+
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+	nsk = accept(sk, (struct sockaddr *)&addr, &optlen);
+	if (nsk < 0) {
+		perror("Accept failed");
+		close(sk);
+		return -1;
+	}
+
+	ba2str(&addr.l2_bdaddr, ba);
+	printf("Connect from %s\n", ba);
+	close(sk);
+
+	return nsk;
+}
+
 int main(int argc, char *argv[])
 {
 	int opt;
@@ -64,6 +253,8 @@ int main(int argc, char *argv[])
 	uint16_t mtu = 0;
 	bdaddr_t src_addr;
 	int dev_id = -1;
+	int fd;
+	struct server *server;
 
 	while ((opt = getopt_long(argc, argv, "+hvs:m:i:",
 						main_options, NULL)) != -1) {
@@ -133,7 +324,27 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	/* TODO: Set up mainloop and listening LE socket */
+	fd = l2cap_le_att_listen_and_accept(&src_addr, sec);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to accept L2CAP ATT connection\n");
+		return EXIT_FAILURE;
+	}
+
+	mainloop_init();
+
+	server = server_create(fd, mtu);
+	if (!server) {
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	printf("Running GATT server\n");
+
+	mainloop_run();
+
+	printf("\n\nShutting down...\n");
+
+	server_destroy(server);
 
-	return 0;
+	return EXIT_SUCCESS;
 }
-- 
2.1.0.rc2.206.gedb03e5

