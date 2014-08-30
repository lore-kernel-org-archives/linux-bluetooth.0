Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 2/7] tools/btgatt-client: Added L2CAP LE ATT connection.
Date: Sat, 30 Aug 2014 09:02:44 -0700
Message-Id: <1409414569-20068-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1409414569-20068-1-git-send-email-armansito@chromium.org>
References: <1409414569-20068-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for connection establishment with different security
levels. Currently, only LE connections are supported.
---
 tools/btgatt-client.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index a5ce70b..30e8e50 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -28,15 +28,20 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <getopt.h>
 #include <limits.h>
+#include <errno.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
+#include <bluetooth/l2cap.h>
 
 #include "monitor/mainloop.h"
 
+#define ATT_CID 4
+
 static bool verbose = false;
 
 static void print_prompt(void)
@@ -65,6 +70,74 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	free(line);
 }
 
+static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
+									int sec)
+{
+	int sock;
+	struct sockaddr_l2 srcaddr, dstaddr;
+	struct bt_security btsec;
+
+	if (verbose) {
+		char srcaddr_str[18], dstaddr_str[18];
+
+		ba2str(src, srcaddr_str);
+		ba2str(dst, dstaddr_str);
+
+		printf("Opening L2CAP LE connection on ATT channel:\n"
+						"\t src: %s\n\tdest: %s\n",
+						srcaddr_str, dstaddr_str);
+	}
+
+	sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
+	if (sock < 0) {
+		perror("Failed to create L2CAP socket");
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
+	if (bind(sock, (struct sockaddr *)&srcaddr, sizeof(srcaddr)) < 0) {
+		perror("Failed to bind L2CAP socket");
+		close(sock);
+		return -1;
+	}
+
+	/* Set the security level */
+	memset(&btsec, 0, sizeof(btsec));
+	btsec.level = sec;
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &btsec,
+							sizeof(btsec)) != 0) {
+		fprintf(stderr, "Failed to set L2CAP security level\n");
+		close(sock);
+		return -1;
+	}
+
+	/* Set up destination address */
+	memset(&dstaddr, 0, sizeof(dstaddr));
+	dstaddr.l2_family = AF_BLUETOOTH;
+	dstaddr.l2_cid = htobs(ATT_CID);
+	dstaddr.l2_bdaddr_type = dst_type;
+	bacpy(&dstaddr.l2_bdaddr, dst);
+
+	printf("Connecting to device...");
+	fflush(stdout);
+
+	if (connect(sock, (struct sockaddr *) &dstaddr, sizeof(dstaddr)) < 0) {
+		perror(" Failed to connect");
+		close(sock);
+		return -1;
+	}
+
+	printf(" Done\n");
+
+	return sock;
+}
+
 static void usage(void)
 {
 	printf("btgatt-client\n");
@@ -95,12 +168,13 @@ static struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	int opt;
-	int sec;
+	int sec = BT_SECURITY_LOW;
 	uint16_t mtu = 0;
 	uint8_t dst_type = BDADDR_LE_PUBLIC;
 	bool dst_addr_given = false;
 	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
+	int fd;
 
 	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
 						main_options, NULL)) != -1) {
@@ -203,6 +277,10 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
+	fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
+	if (fd < 0)
+		return EXIT_FAILURE;
+
 	if (mainloop_add_fd(fileno(stdin),
 				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
 				prompt_read_cb, NULL, NULL) < 0) {
-- 
2.1.0.rc2.206.gedb03e5

