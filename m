Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] btproxy: h5: Emulate packet loss
Date: Tue, 22 Dec 2015 15:32:27 +0200
Message-Id: <1450791147-13224-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1450791147-13224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1450791147-13224-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Emulating packet loss helps testing H:5 Bluetooth drivers. When full
H:5 packet with specified number received we drop it forcing remote
side to re-send packet.
---
 tools/btproxy.c | 12 +++++++++---
 tools/h5.c      | 11 ++++++++++-
 tools/h5.h      |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 02ae53d..92bf51f 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -69,6 +69,7 @@ static bool client_active = false;
 static bool debug_enabled = false;
 static bool emulate_ecc = false;
 static bool three_wire = false;
+static int emulate_lose_num = -1;
 
 static void hexdump_print(const char *str, void *user_data)
 {
@@ -560,8 +561,8 @@ static bool setup_proxy_h5(int host_fd, bool host_shutdown,
 				dev_read_callback, proxy, dev_read_destroy);
 
 	if (three_wire)
-		h5_init(proxy, debug_enabled, host_write_packet,
-							dev_write_packet);
+		h5_init(proxy, debug_enabled, emulate_lose_num,
+					host_write_packet, dev_write_packet);
 
 	return true;
 }
@@ -822,6 +823,7 @@ static void usage(void)
 		"\t-u, --unix [path]           Use Unix server\n"
 		"\t-P, --pty                   Use PTY\n"
 		"\t-3, --3wire                 Use 3wire protocol\n"
+		"\t-L, --lose <num>            Lose specified byte number\n"
 		"\t-p, --port <port>           Use specified TCP port\n"
 		"\t-i, --index <num>           Use specified controller\n"
 		"\t-a, --amp                   Create AMP controller\n"
@@ -837,6 +839,7 @@ static const struct option main_options[] = {
 	{ "unix",     optional_argument, NULL, 'u' },
 	{ "pty",      no_argument,       NULL, 'P' },
 	{ "3wire",    no_argument,       NULL, '3' },
+	{ "lose",     required_argument, NULL, 'L' },
 	{ "port",     required_argument, NULL, 'p' },
 	{ "index",    required_argument, NULL, 'i' },
 	{ "amp",      no_argument,       NULL, 'a' },
@@ -862,7 +865,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "rc:l::u::P3p:i:aedvh",
+		opt = getopt_long(argc, argv, "rc:l::u::P3L:p:i:aedvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -892,6 +895,9 @@ int main(int argc, char *argv[])
 		case '3':
 			three_wire = true;
 			break;
+		case 'L':
+			emulate_lose_num = atoi(optarg);
+			break;
 		case 'p':
 			tcp_port = atoi(optarg);
 			break;
diff --git a/tools/h5.c b/tools/h5.c
index 03a58a0..7602efe 100644
--- a/tools/h5.c
+++ b/tools/h5.c
@@ -77,6 +77,7 @@ static const uint8_t woken_req[] = { 0x06, 0xf9 };
 static const uint8_t sleep_req[] = { 0x07, 0x78 };
 
 static bool debug_enabled = false;
+static int emulate_lose_num = -1;
 
 struct h5 {
 	size_t rx_pending;
@@ -125,13 +126,14 @@ static void h5_reset_peer(struct h5 *h5)
 	h5_reset_rx(h5);
 }
 
-bool h5_init(struct proxy *proxy, bool debug,
+bool h5_init(struct proxy *proxy, bool debug, int lose,
 		void (*host_w)(struct proxy *proxy, void *buf, uint16_t len),
 		void (*dev_w)(struct proxy *proxy, void *buf, uint16_t len))
 {
 	struct h5 *h5;
 
 	debug_enabled = debug;
+	emulate_lose_num = lose;
 
 	h5 = malloc(sizeof(*h5));
 	if (!h5)
@@ -362,6 +364,13 @@ static void h5_process_complete_pkt(struct proxy *proxy)
 {
 	struct h5 *h5 = proxy_get_h5(proxy);
 	const uint8_t *hdr = h5->rx_buf;
+	static int drop_num;
+
+	if (drop_num++ == emulate_lose_num) {
+		printf("Emulate packet loss, num: %d\n", drop_num);
+		h5_reset_rx(h5);
+		return;
+	}
 
 	if (H5_HDR_RELIABLE(hdr)) {
 		h5->tx_ack = (h5->tx_ack + 1) % 8;
diff --git a/tools/h5.h b/tools/h5.h
index 9c661fa..4f46628 100644
--- a/tools/h5.h
+++ b/tools/h5.h
@@ -24,7 +24,7 @@
 struct proxy;
 struct h5;
 
-bool h5_init(struct proxy *proxy, bool debug,
+bool h5_init(struct proxy *proxy, bool debug, int lose,
 		void (*host_w)(struct proxy *proxy, void *buf, uint16_t len),
 		void (*dev_w)(struct proxy *proxy, void *buf, uint16_t len));
 void h5_clean(struct h5 *h5);
-- 
2.5.0

