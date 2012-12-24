Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH] hcidump: Add TI Logger dump support
Date: Mon, 24 Dec 2012 15:04:13 +0200
Message-ID: <1356354253-26134-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Texas Instruments controllers can be configured to send the
internal firmware log through a vendor specific HCI event on
the hci transport.
This patch allows capturing those log events, and writing them
to a file, which can then be used with the latest TI Logger
application to read and show the logs.

This is usefull in case there is no other way to get the TI log
(for example, the lack of a connection to the controller Log TX
hardware line).
---
 tools/hcidump.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 055c8fa..64ae3a9 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -46,6 +46,7 @@
 #include "lib/hci_lib.h"
 
 #define SNAP_LEN	HCI_MAX_FRAME_SIZE
+#define TILOG_OUT_SIZE  3
 
 /* Modes */
 enum {
@@ -53,7 +54,8 @@ enum {
 	READ,
 	WRITE,
 	PPPDUMP,
-	AUDIO
+	AUDIO,
+	TILOGR
 };
 
 /* Default options */
@@ -102,6 +104,14 @@ struct pktlog_hdr {
 } __attribute__ ((packed));
 #define PKTLOG_HDR_SIZE (sizeof(struct pktlog_hdr))
 
+struct tilogger_pkt {
+	uint8_t type;
+	uint8_t vendor;
+	uint8_t size;
+	uint16_t opcode;
+	uint8_t	 data[0];	/* Packet Data */
+} __attribute__ ((packed));
+
 static inline int read_n(int fd, char *buf, int len)
 {
 	int t = 0, w;
@@ -148,6 +158,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 	int nfds = 0;
 	char *buf, *ctrl;
 	int len, hdr_size = HCIDUMP_HDR_SIZE;
+	struct tilogger_pkt *tp;
 
 	if (sock < 0)
 		return -1;
@@ -245,6 +256,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 
 		frm.ptr = frm.data;
 		frm.len = frm.data_len;
+		tp = frm.ptr;
 
 		switch (mode) {
 		case WRITE:
@@ -274,6 +286,23 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 			}
 			break;
 
+		case TILOGR:
+			if (tp->type == HCI_EVENT_PKT && tp->vendor == 0xFF &&
+							tp->opcode == 0x0400) {
+				char out[TILOG_OUT_SIZE];
+				int i, data_len = tp->size - 2;
+
+				/* Format as required by TI Log application */
+				for (i = 0; i < data_len; i++) {
+					sprintf(out,"%02X",tp->data[i]);
+					if (write_n(fd, out, 2) < 0) {
+						perror("Write error");
+						return -1;
+					}
+				}
+			}
+			break;
+
 		default:
 			/* Parse and print */
 			parse(&frm);
@@ -443,7 +472,7 @@ static int open_file(char *file, int mode, unsigned long flags)
 	struct btsnoop_hdr *hdr = (struct btsnoop_hdr *) buf;
 	int fd, len, open_flags;
 
-	if (mode == WRITE || mode == PPPDUMP || mode == AUDIO)
+	if (mode == WRITE || mode == PPPDUMP || mode == AUDIO || mode == TILOGR)
 		open_flags = O_WRONLY | O_CREAT | O_TRUNC;
 	else
 		open_flags = O_RDONLY;
@@ -490,6 +519,8 @@ static int open_file(char *file, int mode, unsigned long flags)
 			lseek(fd, 0, SEEK_SET);
 			return fd;
 		}
+	} else if (mode == TILOGR) {
+		printf ("TI Logger dump\n");
 	} else {
 		if (flags & DUMP_BTSNOOP) {
 			btsnoop_version = 1;
@@ -648,6 +679,7 @@ static void usage(void)
 	"  -a, --ascii                Dump data in ascii\n"
 	"  -x, --hex                  Dump data in hex\n"
 	"  -X, --ext                  Dump data in hex and ascii\n"
+	"  -T, --tilogger=file        Dump TI hci log data to file\n"
 	"  -R, --raw                  Dump raw data\n"
 	"  -C, --cmtp=psm             PSM for CMTP\n"
 	"  -H, --hcrp=psm             PSM for HCRP\n"
@@ -684,6 +716,7 @@ static struct option main_options[] = {
 	{ "audio",		1, 0, 'A' },
 	{ "novendor",		0, 0, 'Y' },
 	{ "nopermcheck",	0, 0, 'Z' },
+	{ "tilogger",   1, 0, 'T' },
 	{ "help",		0, 0, 'h' },
 	{ "version",		0, 0, 'v' },
 	{ 0 }
@@ -700,7 +733,7 @@ int main(int argc, char *argv[])
 	uint16_t obex_port;
 
 	while ((opt = getopt_long(argc, argv,
-				"i:l:p:m:w:r:taxXRC:H:O:P:S:D:A:YZhv",
+				"i:l:p:m:w:r:taxT:XRC:H:O:P:S:D:A:YZhv",
 				main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
@@ -752,6 +785,11 @@ int main(int argc, char *argv[])
 			flags |= DUMP_RAW;
 			break;
 
+		case 'T':
+			mode = TILOGR;
+			dump_file = strdup(optarg);
+			break;
+
 		case 'C':
 			set_proto(0, atoi(optarg), 0, SDP_UUID_CMTP);
 			break;
@@ -837,6 +875,11 @@ int main(int argc, char *argv[])
 		read_dump(open_file(dump_file, mode, flags));
 		break;
 
+	case TILOGR:
+		process_frames(device, open_socket(device, flags),
+				open_file(dump_file, mode, flags), flags);
+		break;
+
 	case WRITE:
 		flags |= DUMP_BTSNOOP;
 		process_frames(device, open_socket(device, flags),
-- 
1.7.10.4
