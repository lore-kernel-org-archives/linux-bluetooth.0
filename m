Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] btproxy: Add three-wire (h5) protocol initial support
Date: Thu, 26 Nov 2015 17:23:44 +0200
Message-Id: <1448551424-18448-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

With H5 support it is possible to create pts and attach to it using
hciattach ot btattach with 3wire protocol. This is useful for testing
and developing three-wire protocol.
Implementation is based on kernel hci_h5.c H5 protocol.

Simple usage:
To open virtual pts run:
$ sudo tools/btproxy -d --pty -3
Opening pseudoterminal
New pts created: /dev/pts/2
Opening user channel for hci0

Now attach to it using hciattach:
$ sudo hciattach -n /dev/pts/2 3wire
Device setup complete
---
 tools/btproxy.c | 541 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 535 insertions(+), 6 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 6d78876..c718e48 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -47,23 +47,22 @@
 #include "src/shared/util.h"
 #include "src/shared/mainloop.h"
 #include "src/shared/ecc.h"
+#include "src/shared/queue.h"
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
 #include "monitor/bt.h"
 
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
 #define BTPROTO_HCI	1
-struct sockaddr_hci {
-	sa_family_t	hci_family;
-	unsigned short	hci_dev;
-	unsigned short  hci_channel;
-};
 #define HCI_CHANNEL_USER	1
 
 static uint16_t hci_index = 0;
 static bool client_active = false;
 static bool debug_enabled = false;
 static bool emulate_ecc = false;
+static bool three_wire = false;
 
 static void hexdump_print(const char *str, void *user_data)
 {
@@ -287,6 +286,516 @@ static void host_read_destroy(void *user_data)
 		mainloop_remove_fd(proxy->dev_fd);
 }
 
+/* three-wire (H5) packet processing */
+
+#define H5_ACK_TIMEOUT		250
+
+#define HCI_3WIRE_ACK_PKT	0
+#define HCI_3WIRE_LINK_PKT	15
+
+/*
+ * Maximum Three-wire packet:
+ *     4 byte header + max value for 12-bit length + 2 bytes for CRC
+ */
+#define H5_MAX_LEN (4 + 0xfff + 2)
+
+/* Sliding window size */
+#define H5_TX_WIN_MAX		4
+
+#define SLIP_DELIMITER	0xc0
+#define SLIP_ESC	0xdb
+#define SLIP_ESC_DELIM	0xdc
+#define SLIP_ESC_ESC	0xdd
+
+#define H5_RX_ESC	1
+
+#define H5_HDR_SEQ(hdr)		((hdr)[0] & 0x07)
+#define H5_HDR_ACK(hdr)		(((hdr)[0] >> 3) & 0x07)
+#define H5_HDR_CRC(hdr)		(((hdr)[0] >> 6) & 0x01)
+#define H5_HDR_RELIABLE(hdr)	(((hdr)[0] >> 7) & 0x01)
+#define H5_HDR_PKT_TYPE(hdr)	((hdr)[1] & 0x0f)
+#define H5_HDR_LEN(hdr)		((((hdr)[1] >> 4) & 0x0f) + ((hdr)[2] << 4))
+
+#define H5_SET_SEQ(hdr, seq)	((hdr)[0] |= (seq))
+#define H5_SET_ACK(hdr, ack)	((hdr)[0] |= (ack) << 3)
+#define H5_SET_RELIABLE(hdr)	((hdr)[0] |= 1 << 7)
+#define H5_SET_TYPE(hdr, type)	((hdr)[1] |= type)
+#define H5_SET_LEN(hdr, len)	(((hdr)[1] |= ((len) & 0x0f) << 4), \
+						((hdr)[2] |= (len) >> 4))
+
+static const uint8_t sync_req[] = { 0x01, 0x7e };
+static const uint8_t sync_rsp[] = { 0x02, 0x7d };
+static const uint8_t conf_req[] = { 0x03, 0xfc };
+static const uint8_t wakeup_req[] = { 0x05, 0xfa };
+static const uint8_t woken_req[] = { 0x06, 0xf9 };
+static const uint8_t sleep_req[] = { 0x07, 0x78 };
+
+static struct h5 {
+	size_t rx_pending;
+	uint8_t rx_buf[H5_MAX_LEN];
+	uint8_t *rx_ptr;
+	uint8_t flags;
+
+	uint8_t rx_ack;		/* Received last ack number */
+	uint8_t tx_seq;		/* Next seq number to send */
+	uint8_t tx_ack;		/* Next ack number to send */
+
+	uint8_t tx_win;
+
+	enum {
+		H5_UNINITIALIZED,
+		H5_INITIALIZED,
+		H5_ACTIVE,
+	} state;
+
+	int timer_id;
+
+	struct queue *tx_queue_unack;
+	struct queue *tx_queue_unrel;
+	struct queue *tx_queue_rel;
+
+	int (*rx_func)(struct proxy *proxy, uint8_t byte);
+} h5;
+
+struct h5_pkt {
+	uint16_t len;
+	uint8_t data[0];
+};
+
+static void h5_reset_rx(void);
+
+static void h5_reset_peer(void)
+{
+	h5.state = H5_UNINITIALIZED;
+
+	mainloop_remove_timeout(h5.timer_id);
+	h5.timer_id = -1;
+	h5_reset_rx();
+}
+
+static void h5_init(void)
+{
+	h5.tx_win = H5_TX_WIN_MAX;
+	h5_reset_peer();
+
+	h5.tx_queue_unack = queue_new();
+	h5.tx_queue_unrel = queue_new();
+	h5.tx_queue_rel = queue_new();
+}
+
+static bool h5_reliable_pkt(uint8_t type)
+{
+	switch (type) {
+	case HCI_ACLDATA_PKT:
+	case HCI_COMMAND_PKT:
+	case HCI_EVENT_PKT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static uint8_t h5_slip_byte(uint8_t *pkt, uint8_t byte)
+{
+	const uint8_t esc_delim[] = { SLIP_ESC, SLIP_ESC_DELIM };
+	const uint8_t esc_esc[] = { SLIP_ESC, SLIP_ESC_ESC };
+
+	switch (byte) {
+	case SLIP_DELIMITER:
+		memcpy(pkt, &esc_delim, sizeof(esc_delim));
+		return sizeof(esc_delim);
+	case SLIP_ESC:
+		memcpy(pkt, &esc_esc, sizeof(esc_esc));
+		return sizeof(esc_esc);
+	default:
+		memcpy(pkt, &byte, sizeof(byte));
+		return sizeof(byte);
+	}
+}
+
+static void h5_print_header(const uint8_t *hdr, const char *str)
+{
+	if (H5_HDR_RELIABLE(hdr))
+		printf("%s REL: seq %u ack %u crc %u type %u len %u\n",
+				str, H5_HDR_SEQ(hdr), H5_HDR_ACK(hdr),
+				H5_HDR_CRC(hdr), H5_HDR_PKT_TYPE(hdr),
+				H5_HDR_LEN(hdr));
+	else
+		printf("%s UNREL: ack %u crc %u type %u len %u\n",
+				str, H5_HDR_ACK(hdr), H5_HDR_CRC(hdr),
+				H5_HDR_PKT_TYPE(hdr), H5_HDR_LEN(hdr));
+}
+
+static void h5_send(const uint8_t *payload, uint8_t pkt_type, int len)
+{
+	struct h5_pkt *pkt;
+	uint8_t *ptr;
+	uint8_t hdr[4];
+	int i;
+
+	memset(hdr, 0, sizeof(hdr));
+
+	H5_SET_ACK(hdr, h5.tx_ack);
+
+	if (h5_reliable_pkt(pkt_type)) {
+		H5_SET_RELIABLE(hdr);
+		H5_SET_SEQ(hdr, h5.tx_seq);
+		h5.tx_seq = (h5.tx_seq + 1) % 8;
+	}
+
+	H5_SET_TYPE(hdr, pkt_type);
+	H5_SET_LEN(hdr, len);
+
+	/* Calculate CRC */
+	hdr[3] = ~((hdr[0] + hdr[1] + hdr[2]) & 0xff);
+
+	if (debug_enabled)
+		h5_print_header(hdr, "TX: <");
+
+	/*
+	 * Max len of packet: (original len + 4 (H5 hdr) + 2 (crc)) * 2
+	 * (because bytes 0xc0 and 0xdb are escaped, worst case is when
+	 * the packet is all made of 0xc0 and 0xdb) + 2 (0xc0
+	 * delimiters at start and end).
+	 */
+	pkt = malloc(sizeof(*pkt) + (len + 6) * 2 + 2);
+	if (!pkt)
+		return;
+
+	ptr = pkt->data;
+
+	*ptr++ = SLIP_DELIMITER;
+
+	for (i = 0; i < 4; i++)
+		ptr += h5_slip_byte(ptr, hdr[i]);
+
+	for (i = 0; i < len; i++)
+		ptr += h5_slip_byte(ptr, payload[i]);
+
+	*ptr++ = SLIP_DELIMITER;
+
+	pkt->len = ptr - pkt->data;
+
+	if (h5_reliable_pkt(pkt_type))
+		queue_push_tail(h5.tx_queue_rel, pkt);
+	else
+		queue_push_tail(h5.tx_queue_unrel, pkt);
+}
+
+static void h5_process_sig_pkt(void)
+{
+	uint8_t conf_rsp[3] = { 0x04, 0x7b };
+	const uint8_t *hdr = h5.rx_buf;
+	const uint8_t *payload = hdr + 4;
+
+	if (H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT)
+		return;
+
+	if (H5_HDR_LEN(hdr) < 2)
+		return;
+
+	conf_rsp[2] = h5.tx_win & 0x07;
+
+	if (!memcmp(payload, sync_req, sizeof(sync_req))) {
+		if (h5.state == H5_ACTIVE)
+			h5_reset_peer();
+
+		h5_send(sync_rsp, H5_HDR_PKT_TYPE(hdr), sizeof(sync_rsp));
+		return;
+	} else if (!memcmp(payload, conf_req, 2)) {
+		h5_send(conf_rsp, H5_HDR_PKT_TYPE(hdr), sizeof(conf_rsp));
+		return;
+	}
+
+	exit(1);
+}
+
+static void h5_process_data(struct proxy *proxy, uint8_t pkt_type)
+{
+	uint8_t pkt[1 + h5.rx_ptr - 4 - h5.rx_buf];
+
+	pkt[0] = pkt_type;
+	memcpy(&pkt[1], h5.rx_buf + 4, sizeof(pkt) - 1);
+
+	host_write_packet(proxy, pkt, sizeof(pkt));
+}
+
+static void pkt_print(void *data, void *user_data)
+{
+	struct h5_pkt *pkt = data;
+
+	h5_print_header((uint8_t *)pkt + sizeof(*pkt) + 1, "unack pkt");
+}
+
+static void h5_process_unack_queue(void)
+{
+	struct h5_pkt *pkt;
+	uint8_t len = queue_length(h5.tx_queue_unack);
+	uint8_t seq = h5.tx_seq;
+
+	if (!len)
+		return;
+
+	printf("%s: rx_ack %u tx_ack %u tx_seq %u\n", __func__,
+					h5.rx_ack, h5.tx_ack, h5.tx_seq);
+
+	printf("%s: unack queue length %u\n", __func__, len);
+
+	queue_foreach(h5.tx_queue_unack, pkt_print, NULL);
+
+	/* Remove acked packets from unack queue */
+	while (len > 0) {
+		if (h5.rx_ack == seq)
+			break;
+
+		len--;
+		seq = (seq - 1) & 0x07;
+	}
+
+	if (seq != h5.rx_ack)
+		fprintf(stderr, "Acked wrong packet\n");
+
+	while (len--) {
+		printf("%s: Remove packet\n", __func__);
+
+		pkt = queue_pop_head(h5.tx_queue_unack);
+		if (pkt)
+			free(pkt);
+	}
+}
+
+static void h5_process_complete_pkt(struct proxy *proxy)
+{
+	const uint8_t *hdr = h5.rx_buf;
+
+	if (H5_HDR_RELIABLE(hdr)) {
+		h5.tx_ack = (h5.tx_ack + 1) % 8;
+		/* TODO: Set ack req flag */
+	}
+
+	h5.rx_ack = H5_HDR_ACK(hdr);
+
+	h5_process_unack_queue();
+
+	switch (H5_HDR_PKT_TYPE(hdr)) {
+	case HCI_COMMAND_PKT:
+	case HCI_EVENT_PKT:
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+		/* Need to remove three-wire header */
+		h5_process_data(proxy, (H5_HDR_PKT_TYPE(hdr)));
+		break;
+	default:
+		/* Handle three-wire protocol */
+		h5_process_sig_pkt();
+	}
+
+	h5_reset_rx();
+}
+
+static int h5_crc(struct proxy *proxy, const uint8_t byte)
+{
+	h5_process_complete_pkt(proxy);
+
+	return 0;
+}
+
+static int h5_payload(struct proxy *proxy, const uint8_t byte)
+{
+	const uint8_t *hdr = h5.rx_buf;
+
+	if (H5_HDR_RELIABLE(hdr)) {
+		/* TODO: process tx_ack */
+	}
+
+	if (H5_HDR_CRC(hdr)) {
+		h5.rx_func = h5_crc;
+		h5.rx_pending = 2;
+	} else {
+		h5_process_complete_pkt(proxy);
+	}
+
+	return 0;
+}
+
+static int h5_3wire_hdr(struct proxy *proxy, const uint8_t byte)
+{
+	const uint8_t *hdr = h5.rx_buf;
+
+	if (debug_enabled)
+		h5_print_header(hdr, "RX: >");
+
+	/* Add header checks here */
+
+	h5.rx_func = h5_payload;
+	h5.rx_pending = H5_HDR_LEN(hdr);
+
+	return 0;
+}
+
+static int h5_pkt_start(struct proxy *proxy, const uint8_t byte)
+{
+	if (byte == SLIP_DELIMITER)
+		return 1;
+
+	h5.rx_func = h5_3wire_hdr;
+	h5.rx_pending = 4;
+
+	return 0;
+}
+
+static int h5_delimeter(struct proxy *proxy, const uint8_t byte)
+{
+	if (byte == SLIP_DELIMITER)
+		h5.rx_func = h5_pkt_start;
+
+	return 1;
+}
+
+static void h5_reset_rx(void)
+{
+	h5.rx_pending = 0;
+	h5.flags = 0;
+
+	h5.rx_ptr = h5.rx_buf;
+
+	h5.rx_func = h5_delimeter;
+}
+
+static void h5_process_byte(const uint8_t byte)
+{
+	/* Mark escaped */
+	if (!(h5.flags & H5_RX_ESC) && byte == SLIP_ESC) {
+		h5.flags |= H5_RX_ESC;
+		return;
+	}
+
+	if (h5.flags & H5_RX_ESC) {
+		h5.flags &= ~H5_RX_ESC;
+
+		switch (byte) {
+		case SLIP_ESC_DELIM:
+			*h5.rx_ptr++ = SLIP_DELIMITER;
+			break;
+		case SLIP_ESC_ESC:
+			*h5.rx_ptr++ = SLIP_ESC;
+			break;
+		default:
+			fprintf(stderr, "Invalid esc byte %x\n", byte);
+			h5_reset_rx();
+			return;
+		}
+	} else {
+		*h5.rx_ptr++ = byte;
+	}
+
+	h5.rx_pending--;
+}
+
+static void h5_process_tx_queue(struct proxy *proxy);
+
+static void h5_timer_cb(int id, void *user_data)
+{
+	struct proxy *proxy = user_data;
+	struct h5_pkt *pkt;
+
+	printf("%s: Retransmitting %u packets\n", __func__,
+					queue_length(h5.tx_queue_unack));
+
+	while ((pkt = queue_peek_tail(h5.tx_queue_unack))) {
+		h5.tx_seq = (h5.tx_seq - 1) & 0x07;
+
+		/* Move pkt from unack to rel queue */
+		queue_remove(h5.tx_queue_unack, pkt);
+		queue_push_head(h5.tx_queue_rel, pkt);
+	}
+
+	h5_process_tx_queue(proxy);
+}
+
+static void h5_process_tx_queue(struct proxy *proxy)
+{
+	struct h5_pkt *pkt;
+
+	while ((pkt = queue_pop_head(h5.tx_queue_unrel))) {
+		if (!write_packet(proxy->host_fd, pkt->data, pkt->len, "H: ")) {
+			fprintf(stderr, "Write to Host descriptor failed\n");
+			mainloop_remove_fd(proxy->host_fd);
+		}
+
+		free(pkt);
+	}
+
+	if (queue_length(h5.tx_queue_unack) >= h5.tx_win) {
+		printf("Unacked queue too big\n");
+		return;
+	}
+
+	while ((pkt = queue_pop_head(h5.tx_queue_rel))) {
+		if (!write_packet(proxy->host_fd, pkt->data, pkt->len, "H: ")) {
+			fprintf(stderr, "Write to Host descriptor failed\n");
+			mainloop_remove_fd(proxy->host_fd);
+		}
+
+		queue_push_tail(h5.tx_queue_unack, pkt);
+		if (h5.timer_id >= 0) {
+			mainloop_modify_timeout(h5.timer_id, H5_ACK_TIMEOUT);
+			continue;
+		}
+
+		h5.timer_id = mainloop_add_timeout(H5_ACK_TIMEOUT, h5_timer_cb,
+								proxy, NULL);
+	}
+}
+
+static void host_write_3wire_packet(struct proxy *proxy, void *buf,
+				    uint16_t len)
+{
+	const uint8_t *ptr = buf;
+
+	while (len > 0) {
+		int processed;
+
+		if (h5.rx_pending > 0) {
+			if (*ptr == SLIP_DELIMITER) {
+				fprintf(stderr, "Too short packet\n");
+				h5_reset_rx();
+				continue;
+			}
+
+			h5_process_byte(*ptr);
+
+			ptr++;
+			len--;
+			continue;
+		}
+
+		processed = h5.rx_func(proxy, *ptr);
+		if (processed < 0) {
+			fprintf(stderr, "Error processing SLIP packet\n");
+			return;
+		}
+
+		ptr += processed;
+		len -= processed;
+
+		h5_process_tx_queue(proxy);
+	}
+
+	h5_process_tx_queue(proxy);
+}
+
+static void dev_write_3wire_packet(struct proxy *proxy, uint8_t *buf,
+								uint16_t len)
+{
+	uint8_t pkt_type = buf[0];
+
+	/* Get payload out of H4 packet */
+	h5_send(&buf[1], pkt_type, len - 1);
+
+	h5_process_tx_queue(proxy);
+}
+
 static void host_read_callback(int fd, uint32_t events, void *user_data)
 {
 	struct proxy *proxy = user_data;
@@ -351,6 +860,14 @@ process_packet:
 		sco_hdr = (void *) (proxy->host_buf + 1);
 		pktlen = 1 + sizeof(*sco_hdr) + sco_hdr->dlen;
 		break;
+	case SLIP_DELIMITER:
+		/* 2 bytes start/end packets + SLIP header and checksum */
+		if (proxy->host_len < 4 + 2)
+			return;
+
+		/* Later we shall check unslipped packet */
+		pktlen = proxy->host_len;
+		break;
 	case 0xff:
 		/* Notification packet from /dev/vhci - ignore */
 		proxy->host_len = 0;
@@ -367,6 +884,8 @@ process_packet:
 
 	if (emulate_ecc)
 		host_emulate_ecc(proxy, proxy->host_buf, pktlen);
+	else if (three_wire)
+		host_write_3wire_packet(proxy, proxy->host_buf, pktlen);
 	else
 		host_write_packet(proxy, proxy->host_buf, pktlen);
 
@@ -475,6 +994,8 @@ process_packet:
 
 	if (emulate_ecc)
 		dev_emulate_ecc(proxy, proxy->dev_buf, pktlen);
+	else if (three_wire)
+		dev_write_3wire_packet(proxy, proxy->dev_buf, pktlen);
 	else
 		dev_write_packet(proxy, proxy->dev_buf, pktlen);
 
@@ -764,6 +1285,7 @@ static void usage(void)
 		"\t-l, --listen [address]      Use TCP server\n"
 		"\t-u, --unix [path]           Use Unix server\n"
 		"\t-P, --pty                   Use PTY\n"
+		"\t-3, --3wire                 Use 3wire protocol\n"
 		"\t-p, --port <port>           Use specified TCP port\n"
 		"\t-i, --index <num>           Use specified controller\n"
 		"\t-a, --amp                   Create AMP controller\n"
@@ -778,6 +1300,7 @@ static const struct option main_options[] = {
 	{ "listen",   optional_argument, NULL, 'l' },
 	{ "unix",     optional_argument, NULL, 'u' },
 	{ "pty",      no_argument,       NULL, 'P' },
+	{ "3wire",    no_argument,       NULL, '3' },
 	{ "port",     required_argument, NULL, 'p' },
 	{ "index",    required_argument, NULL, 'i' },
 	{ "amp",      no_argument,       NULL, 'a' },
@@ -803,7 +1326,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "rc:l::u::Pp:i:aedvh",
+		opt = getopt_long(argc, argv, "rc:l::u::P3p:i:aedvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -830,6 +1353,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			use_pty = true;
 			break;
+		case '3':
+			three_wire = true;
+			break;
 		case 'p':
 			tcp_port = atoi(optarg);
 			break;
@@ -933,6 +1459,9 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 
+		if (three_wire)
+			h5_init();
+
 		if (!setup_proxy(master_fd, false, dev_fd, true)) {
 			close(dev_fd);
 			close(master_fd);
-- 
2.5.0

