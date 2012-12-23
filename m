Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH hcidump] Add TI Logger dump support
Date: Sun, 23 Dec 2012 13:58:00 +0200
Message-ID: <1356263880-20743-1-git-send-email-chen.ganir@ti.com>
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
 parser/parser.h |    1 +
 src/hcidump.c   |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/parser/parser.h b/parser/parser.h
index f8f7009..d4fecf0 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -63,6 +63,7 @@ struct frame {
 #define DUMP_BTSNOOP	0x1000
 #define DUMP_PKTLOG	0x2000
 #define DUMP_NOVENDOR	0x4000
+#define DUMP_TILOGGER	0x8000
 #define DUMP_TYPE_MASK	(DUMP_ASCII | DUMP_HEX | DUMP_EXT)
 
 /* Parser filter */
diff --git a/src/hcidump.c b/src/hcidump.c
index 18ae64e..3daf2b6 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -110,6 +110,14 @@ struct pktlog_hdr {
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
@@ -300,7 +308,24 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 		case WRITE:
 		case SERVER:
 			/* Save or send dump */
-			if (flags & DUMP_BTSNOOP) {
+			if (flags & DUMP_TILOGGER && mode == WRITE) {
+				struct tilogger_pkt *tp = frm.ptr;
+				if (tp->type == HCI_EVENT_PKT &&
+				    tp->vendor == 0xFF &&
+				    tp->opcode == 0x0400) {
+					char out[2];
+					int i;
+
+					for(i = 0;i < tp->size-2;i++) {
+						sprintf(out,"%02X",tp->data[i]);
+						if (write_n(fd, out, 2) < 0) {
+							perror("Write error");
+							return -1;
+						}
+					}
+				}
+				continue;
+			} else if (flags & DUMP_BTSNOOP) {
 				uint64_t ts;
 				uint8_t pkt_type = ((uint8_t *) frm.data)[0];
 				dp->size = htonl(frm.data_len);
@@ -542,7 +567,9 @@ static int open_file(char *file, int mode, unsigned long flags)
 			return fd;
 		}
 	} else {
-		if (flags & DUMP_BTSNOOP) {
+		if (flags & DUMP_TILOGGER) {
+			printf ("TI Logger dump\n");
+		} else 	if (flags & DUMP_BTSNOOP) {
 			btsnoop_version = 1;
 			btsnoop_type = 1002;
 
@@ -895,6 +922,7 @@ static void usage(void)
 	"  -a, --ascii                Dump data in ascii\n"
 	"  -x, --hex                  Dump data in hex\n"
 	"  -X, --ext                  Dump data in hex and ascii\n"
+	"  -T, --tilogger=file        Dump TI hci log data to file\n"
 	"  -R, --raw                  Dump raw data\n"
 	"  -C, --cmtp=psm             PSM for CMTP\n"
 	"  -H, --hcrp=psm             PSM for HCRP\n"
@@ -936,6 +964,7 @@ static struct option main_options[] = {
 	{ "nopermcheck",	0, 0, 'Z' },
 	{ "ipv4",		0, 0, '4' },
 	{ "ipv6",		0, 0, '6' },
+	{ "tilogger",   1, 0, 'T' },
 	{ "help",		0, 0, 'h' },
 	{ "version",		0, 0, 'v' },
 	{ 0 }
@@ -952,7 +981,7 @@ int main(int argc, char *argv[])
 	uint16_t obex_port;
 
 	while ((opt = getopt_long(argc, argv,
-				"i:l:p:m:w:r:d:taxXRC:H:O:P:S:D:A:YZ46hv",
+				"i:l:p:m:w:r:d:taxT:XRC:H:O:P:S:D:A:YZ46hv",
 				main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
@@ -1009,6 +1038,12 @@ int main(int argc, char *argv[])
 			flags |= DUMP_RAW;
 			break;
 
+		case 'T':
+			mode = WRITE;
+			dump_file = strdup(optarg);
+			flags |= DUMP_TILOGGER;
+			break;
+
 		case 'C': 
 			set_proto(0, atoi(optarg), 0, SDP_UUID_CMTP);
 			break;
@@ -1101,7 +1136,8 @@ int main(int argc, char *argv[])
 		break;
 
 	case WRITE:
-		flags |= DUMP_BTSNOOP;
+		if ((flags & DUMP_TILOGGER) == 0)
+			flags |= DUMP_BTSNOOP;
 		process_frames(device, open_socket(device, flags),
 				open_file(dump_file, mode, flags), flags);
 		break;
-- 
1.7.10.4
