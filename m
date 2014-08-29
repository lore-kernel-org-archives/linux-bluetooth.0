Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 3/7] tools/btgatt-client: Integrate bt_att and bt_gatt_client.
Date: Fri, 29 Aug 2014 08:34:08 -0700
Message-Id: <1409326452-8534-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1409326452-8534-1-git-send-email-armansito@chromium.org>
References: <1409326452-8534-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial set up of a bt_att and bt_gatt_client around the
connection socket.
---
 Makefile.tools        |   3 +-
 tools/btgatt-client.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index dac9f9a..898c2ae 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -259,7 +259,8 @@ tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/timeout.h src/shared/timeout-mainloop.c \
 				src/shared/att-types.h src/shared/att.h src/shared/att.c \
-				src/shared/gatt-helpers.h src/shared/gatt-helpers.c
+				src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
+				src/shared/gatt-client.h src/shared/gatt-client.c
 tools_btgatt_client_LDADD = lib/libbluetooth-internal.la
 
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 30e8e50..008cc9f 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -39,17 +39,98 @@
 #include <bluetooth/l2cap.h>
 
 #include "monitor/mainloop.h"
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
 
 #define ATT_CID 4
 
+#define PRLOG(format, ...) \
+	printf(format, __VA_ARGS__); print_prompt();
+
 static bool verbose = false;
 
+struct client {
+	int fd;
+	struct bt_gatt_client *gatt;
+};
+
 static void print_prompt(void)
 {
 	printf("[GATT client]# ");
 	fflush(stdout);
 }
 
+static void att_disconnect_cb(void *user_data)
+{
+	printf("Device disconnected\n");
+
+	mainloop_quit();
+}
+
+static void att_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	PRLOG("%s%s\n", prefix, str);
+}
+
+static struct client *client_create(int fd, uint16_t mtu)
+{
+	struct client *cli;
+	struct bt_att *att;
+
+	cli = new0(struct client, 1);
+	if (!cli) {
+		fprintf(stderr, "Failed to allocate memory for client\n");
+		return NULL;
+	}
+
+	att = bt_att_new(fd);
+	if (!att) {
+		fprintf(stderr, "Failed to initialze ATT transport layer\n");
+		bt_att_unref(att);
+		free(cli);
+		return NULL;
+	}
+
+	if (!bt_att_set_close_on_unref(att, true)) {
+		fprintf(stderr, "Failed to set up ATT transport layer\n");
+		bt_att_unref(att);
+		free(cli);
+		return NULL;
+	}
+
+	if (!bt_att_register_disconnect(att, att_disconnect_cb, NULL, NULL)) {
+		fprintf(stderr, "Failed to set ATT disconnect handler\n");
+		bt_att_unref(att);
+		free(cli);
+		return NULL;
+	}
+
+	if (verbose)
+		bt_att_set_debug(att, att_debug, "att: ", NULL);
+
+	cli->fd = fd;
+	cli->gatt = bt_gatt_client_new(att, mtu);
+	if (!cli->gatt) {
+		fprintf(stderr, "Failed to create GATT client\n");
+		bt_att_unref(att);
+		free(cli);
+		return NULL;
+	}
+
+	/* bt_gatt_client already holds a reference */
+	bt_att_unref(att);
+
+	return cli;
+}
+
+static void client_destroy(struct client *cli)
+{
+	bt_gatt_client_unref(cli->gatt);
+}
+
 static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 {
 	size_t len = 0;
@@ -70,6 +151,18 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	free(line);
 }
 
+static void signal_cb(int signum, void *user_data)
+{
+	switch (signum) {
+	case SIGINT:
+	case SIGTERM:
+		mainloop_quit();
+		break;
+	default:
+		break;
+	}
+}
+
 static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 									int sec)
 {
@@ -83,9 +176,9 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 		ba2str(src, srcaddr_str);
 		ba2str(dst, dstaddr_str);
 
-		printf("Opening L2CAP LE connection on ATT channel:\n"
-						"\t src: %s\n\tdest: %s\n",
-						srcaddr_str, dstaddr_str);
+		printf("btgatt-client: Opening L2CAP LE connection on ATT "
+					"channel:\n\t src: %s\n\tdest: %s\n",
+					srcaddr_str, dstaddr_str);
 	}
 
 	sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
@@ -175,6 +268,8 @@ int main(int argc, char *argv[])
 	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
 	int fd;
+	sigset_t mask;
+	struct client *cli;
 
 	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
 						main_options, NULL)) != -1) {
@@ -281,6 +376,12 @@ int main(int argc, char *argv[])
 	if (fd < 0)
 		return EXIT_FAILURE;
 
+	cli = client_create(fd, mtu);
+	if (!cli) {
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
 	if (mainloop_add_fd(fileno(stdin),
 				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
 				prompt_read_cb, NULL, NULL) < 0) {
@@ -288,9 +389,19 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	mainloop_set_signal(&mask, signal_cb, NULL, NULL);
+
 	print_prompt();
 
 	mainloop_run();
 
+	printf("\n\nShutting down...\n");
+
+	client_destroy(cli);
+
 	return EXIT_SUCCESS;
 }
-- 
2.1.0.rc2.206.gedb03e5

