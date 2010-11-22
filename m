Return-Path: <cyrus@holtmann.org>
From: Wade Brown <brownw@us.panasonic.com>
To: linux-bluetooth@vger.kernel.org
Cc: Wade Brown <brownw@us.panasonic.com>
Subject: [PATCH] Add a runtime option to set the BCSP communication rate
Date: Mon, 22 Nov 2010 23:03:12 +0000
Message-Id: <1290466992-5023-1-git-send-email-brownw@us.panasonic.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bccmd.c    |   45 ++++++++++++++++++++++++++++++++++++++++-----
 tools/csr.h      |    3 ++-
 tools/csr_bcsp.c |    4 ++--
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index 686e858..5cb9255 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -59,7 +59,7 @@
 #define CSR_TYPE_ARRAY		CSR_TYPE_COMPLEX
 #define CSR_TYPE_BDADDR		CSR_TYPE_COMPLEX
 
-static inline int transport_open(int transport, char *device)
+static inline int transport_open(int transport, char *device, speed_t bcsp_rate)
 {
 	switch (transport) {
 	case CSR_TRANSPORT_HCI:
@@ -69,7 +69,7 @@ static inline int transport_open(int transport, char *device)
 		return csr_open_usb(device);
 #endif
 	case CSR_TRANSPORT_BCSP:
-		return csr_open_bcsp(device);
+		return csr_open_bcsp(device, bcsp_rate);
 	case CSR_TRANSPORT_H4:
 		return csr_open_h4(device);
 	case CSR_TRANSPORT_3WIRE:
@@ -1109,6 +1109,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-t <transport>     Select the transport\n"
 		"\t-d <device>        Select the device\n"
+		"\t-b <bcsp rate>     Select the bcsp transfer rate\n"
 		"\t-h, --help         Display help\n"
 		"\n");
 
@@ -1137,6 +1138,7 @@ static void usage(void)
 static struct option main_options[] = {
 	{ "transport",	1, 0, 't' },
 	{ "device",	1, 0, 'd' },
+	{ "bcsprate", 1, 0, 'b'},
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
@@ -1145,8 +1147,9 @@ int main(int argc, char *argv[])
 {
 	char *device = NULL;
 	int i, err, opt, transport = CSR_TRANSPORT_HCI;
+	speed_t bcsp_rate = B38400;
 
-	while ((opt=getopt_long(argc, argv, "+t:d:i:h", main_options, NULL)) != EOF) {
+	while ((opt=getopt_long(argc, argv, "+t:d:i:b:h", main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 't':
 			if (!strcasecmp(optarg, "hci"))
@@ -1171,7 +1174,39 @@ int main(int argc, char *argv[])
 		case 'i':
 			device = strdup(optarg);
 			break;
-
+		case 'b':
+			switch (atoi(optarg)) {
+			case 9600: bcsp_rate = B9600; break;
+			case 19200: bcsp_rate = B19200; break;
+			case 38400: bcsp_rate = B38400; break;
+			case 57600: bcsp_rate = B57600; break;
+			case 115200: bcsp_rate = B115200; break;
+			case 230400: bcsp_rate = B230400; break;
+			case 460800: bcsp_rate = B460800; break;
+			case 500000: bcsp_rate = B500000; break;
+			case 576000: bcsp_rate = B576000; break;
+			case 921600: bcsp_rate = B921600; break;
+			case 1000000: bcsp_rate = B1000000; break;
+			case 1152000: bcsp_rate = B1152000; break;
+			case 1500000: bcsp_rate = B1500000; break;
+			case 2000000: bcsp_rate = B2000000; break;
+#ifdef B2500000
+			case 2500000: bcsp_rate = B2500000; break;
+#endif
+#ifdef B3000000
+			case 3000000: bcsp_rate = B3000000; break;
+#endif
+#ifdef B3500000
+			case 3500000: bcsp_rate = B3500000; break;
+#endif
+#ifdef B4000000
+			case 4000000: bcsp_rate = B4000000; break;
+#endif
+			default:
+				printf("Unknown BCSP baud rate specified, defaulting to 38400bps\n");
+				bcsp_rate = B38400;
+			}
+			break;
 		case 'h':
 		default:
 			usage();
@@ -1188,7 +1223,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	if (transport_open(transport, device) < 0)
+	if (transport_open(transport, device, bcsp_rate) < 0)
 		exit(1);
 
 	if (device)
diff --git a/tools/csr.h b/tools/csr.h
index 1d70491..8b94d7b 100644
--- a/tools/csr.h
+++ b/tools/csr.h
@@ -22,6 +22,7 @@
  */
 
 #include <stdint.h>
+#include <termios.h>
 
 #define CSR_VARID_PS_CLR_ALL			0x000b	/* valueless */
 #define CSR_VARID_PS_FACTORY_SET		0x000c	/* valueless */
@@ -519,7 +520,7 @@ int csr_read_usb(uint16_t varid, uint8_t *value, uint16_t length);
 int csr_write_usb(uint16_t varid, uint8_t *value, uint16_t length);
 void csr_close_usb(void);
 
-int csr_open_bcsp(char *device);
+int csr_open_bcsp(char *device, speed_t bcsp_rate);
 int csr_read_bcsp(uint16_t varid, uint8_t *value, uint16_t length);
 int csr_write_bcsp(uint16_t varid, uint8_t *value, uint16_t length);
 void csr_close_bcsp(void);
diff --git a/tools/csr_bcsp.c b/tools/csr_bcsp.c
index e551311..df247a2 100644
--- a/tools/csr_bcsp.c
+++ b/tools/csr_bcsp.c
@@ -46,7 +46,7 @@ static uint8_t send_buffer[512];
 static struct ubcsp_packet receive_packet;
 static uint8_t receive_buffer[512];
 
-int csr_open_bcsp(char *device)
+int csr_open_bcsp(char *device, speed_t bcsp_rate)
 {
 	struct termios ti;
 	uint8_t delay, activity = 0x00;
@@ -84,7 +84,7 @@ int csr_open_bcsp(char *device)
 	ti.c_cc[VMIN] = 1;
 	ti.c_cc[VTIME] = 0;
 
-	cfsetospeed(&ti, B38400);
+	cfsetospeed(&ti, bcsp_rate);
 
 	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
 		fprintf(stderr, "Can't change port settings: %s (%d)\n",
-- 
1.7.2.2

