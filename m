Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 04/10] tools/btatt: Add "exchange-mtu" command.
Date: Fri, 16 May 2014 13:14:52 -0700
Message-Id: <1400271298-29769-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1400271298-29769-1-git-send-email-armansito@chromium.org>
References: <1400271298-29769-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added command for "Exchange MTU" request/response. Also added code for
initiating an L2CAP connection over the ATT channel. Tested using a CSR
uEnergy 1000 board with the following results:

$ btatt -d 00:02:5B:00:15:10 -v exchange-mtu 50
Going to set MTU to 16 bit value: 50
att: ATT command 0x02
att < 02 32 00
att > 03 17 00
Exchange MTU response: Server Rx MTU 23
---
 tools/btatt.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 1 deletion(-)

diff --git a/tools/btatt.c b/tools/btatt.c
index 476bb94..da1eb3d 100644
--- a/tools/btatt.c
+++ b/tools/btatt.c
@@ -31,6 +31,7 @@
 #include <string.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/l2cap.h>
 
 #include "monitor/mainloop.h"
 #include "src/shared/att.h"
@@ -39,11 +40,153 @@
 
 static bool verbose = false;
 
+static void handle_error(const void *param, uint16_t len)
+{
+	const struct bt_att_error_rsp_param *rp = param;
+
+	if (len != sizeof(*rp)) {
+		fprintf(stderr, "Invalid error response length (%u)\n", len);
+		return;
+	}
+
+	printf("Request failed:\n\topcode:\t%u\n\thandle:\t%u\n\terror:\t%u\n",
+			rp->request_opcode, rp->handle, rp->error_code);
+}
+
+static void exchange_mtu_cb(uint8_t opcode, const void *param,
+						uint16_t len, void *user_data)
+{
+	const struct bt_att_exchange_mtu_rsp_param *rp;
+
+	if (opcode == BT_ATT_OP_ERROR_RESP) {
+		handle_error(param, len);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_EXCHANGE_MTU_RESP) {
+		fprintf(stderr, "Invalid response opcode (%u)\n", opcode);
+		goto done;
+	}
+
+	rp = param;
+
+	if (len != sizeof(*rp)) {
+		fprintf(stderr, "Invalid \"Exchange MTU\" response length "
+								"(%u)\n", len);
+		goto done;
+	}
+
+	printf("Exchange MTU response: Server Rx MTU: %u\n", rp->server_rx_mtu);
+
+done:
+	mainloop_quit();
+}
+
+static void mtu_usage(void)
+{
+	printf("Usage: btatt exchange-mtu <ATT_MTU>\n");
+}
+
+static struct option mtu_options[] = {
+	{ "help",	0, 0, 'h'},
+	{}
+};
+
+static void cmd_mtu(struct bt_att *att, int argc, char **argv)
+{
+	struct bt_att_exchange_mtu_req_param param;
+	uint16_t mtu;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+h", mtu_options,
+							NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+		default:
+			mtu_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		mtu_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	mtu = atoi(argv[0]);
+
+	if (verbose)
+		printf("Going to set MTU to 16 bit value: %u\n", mtu);
+
+	memset(&param, 0, sizeof(param));
+	param.client_rx_mtu = mtu;
+	if (bt_att_send_sequential(att, BT_ATT_OP_EXCHANGE_MTU_REQ,
+					&param, sizeof(param),
+					exchange_mtu_cb, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send \"Exchange MTU\" request\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type)
+{
+	int sock;
+	struct sockaddr_l2 srcaddr, dstaddr;
+	char srcaddr_str[18], dstaddr_str[18];
+
+	if (verbose) {
+		ba2str(src, srcaddr_str);
+		ba2str(dst, dstaddr_str);
+
+		printf("Opening L2CAP LE connection on ATT channel: "
+					"src: %s dest: %s\n", srcaddr_str, dstaddr_str);
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
+	bacpy(&srcaddr.l2_bdaddr, src);
+	srcaddr.l2_cid = htobs(ATT_CID);
+	srcaddr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
+
+	if (bind(sock, (struct sockaddr *) &srcaddr, sizeof(srcaddr)) < 0) {
+		perror("Failed to bind L2CAP socket");
+		close(sock);
+		return -1;
+	}
+
+	/* Set up destination address */
+	memset(&dstaddr, 0, sizeof(dstaddr));
+	dstaddr.l2_family = AF_BLUETOOTH;
+	bacpy(&dstaddr.l2_bdaddr, dst);
+	dstaddr.l2_cid = htobs(ATT_CID);
+	dstaddr.l2_bdaddr_type = dst_type;
+
+	if (connect(sock, (struct sockaddr *) &dstaddr, sizeof(dstaddr)) < 0) {
+		perror("Failed to connect");
+		close(sock);
+		return -1;
+	}
+
+	return sock;
+}
+
 static struct {
 	char *cmd;
 	void (*func)(struct bt_att *att, int argc, char **argv);
 	char *doc;
 } command[] = {
+	{ "exchange-mtu",	cmd_mtu,	"\"Exchange MTU\" request." },
 	{ }
 };
 
@@ -80,6 +223,13 @@ static struct option main_options[] = {
 	{ 0, 0, 0, 0}
 };
 
+static void att_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	printf("%s%s\n", prefix, str);
+}
+
 int main(int argc, char *argv[])
 {
 	int opt, i;
@@ -88,6 +238,8 @@ int main(int argc, char *argv[])
 	uint8_t dest_type = BDADDR_LE_PUBLIC;
 	bdaddr_t src_addr, dst_addr;
 	int fd;
+	struct bt_att *att;
+	int exit_status;
 
 	while ((opt = getopt_long(argc, argv, "+hvt:i:d:",
 						main_options, NULL)) != -1) {
@@ -148,5 +300,43 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	return 0;
+	mainloop_init();
+
+	fd = l2cap_le_att_connect(&src_addr, &dst_addr, dest_type);
+
+	if (fd < 0)
+		return EXIT_FAILURE;
+
+	att = bt_att_new(fd);
+
+	if (!att) {
+		fprintf(stderr, "Failed to create bt_att.");
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	if (verbose)
+		bt_att_set_debug(att, att_debug, "att: ", NULL);
+
+	bt_att_set_close_on_unref(att, true);
+
+	for (i = 0; command[i].cmd; i++) {
+		if (strcmp(command[i].cmd, argv[0]) == 0)
+			break;
+	}
+
+	if (command[i].cmd == NULL) {
+		fprintf(stderr, "Unknown command: %s\n", argv[0]);
+		bt_att_unref(att);
+		return EXIT_FAILURE;
+	}
+
+	command[i].func(att, argc, argv);
+
+	exit_status = mainloop_run();
+
+	bt_att_cancel_all(att);
+	bt_att_unref(att);
+
+	return exit_status;
 }
-- 
1.8.3.2

