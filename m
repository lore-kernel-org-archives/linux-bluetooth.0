Return-Path: <cyrus@holtmann.org>
Message-ID: <5396FC23.1000303@remote-exploit.org>
Date: Tue, 10 Jun 2014 14:37:55 +0200
From: "mmo@remote-exploit.org" <mmo@remote-exploit.org>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Added parameters vendorid and productid for usb communication
 using bccmd
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, so here is not the patch regarding the parameters for vendor and
productid.

Greetings

Max


>From 9d32b222e9ec5e606cb725a0fc3e789d5d035d66 Mon Sep 17 00:00:00 2001
From: Max Moser <mmo@remote-exploit.org>
Date: Tue, 10 Jun 2014 13:38:38 +0200
Subject: [PATCH] Added parameters vendorid and productid for usb
 communication using bccmd.

---
 tools/bccmd.c   |   32 ++++++++++++++++++++++++++++----
 tools/csr.h     |    2 +-
 tools/csr_usb.c |   12 ++++++------
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index 4649ad5..8acd7ad 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -59,13 +59,13 @@
 #define CSR_TYPE_ARRAY		CSR_TYPE_COMPLEX
 #define CSR_TYPE_BDADDR		CSR_TYPE_COMPLEX

-static inline int transport_open(int transport, char *device, speed_t
bcsp_rate)
+static inline int transport_open(int transport, char *device, speed_t
bcsp_rate, uint16_t vendorid, uint16_t productid)
 {
 	switch (transport) {
 	case CSR_TRANSPORT_HCI:
 		return csr_open_hci(device);
 	case CSR_TRANSPORT_USB:
-		return csr_open_usb(device);
+		return csr_open_usb(device,vendorid,productid);
 	case CSR_TRANSPORT_BCSP:
 		return csr_open_bcsp(device, bcsp_rate);
 	case CSR_TRANSPORT_H4:
@@ -1086,6 +1086,8 @@ static void usage(void)
 		"\t-t <transport>     Select the transport\n"
 		"\t-d <device>        Select the device\n"
 		"\t-b <bcsp rate>     Select the bcsp transfer rate\n"
+	        "\t-p <productid>     Select the productid for usb devices
(default 0x0001)\n"
+                "\t-v <vendorid>      Select the vendorid for usb
devices (default 0x0a12)\n"
 		"\t-h, --help         Display help\n"
 		"\n");

@@ -1115,6 +1117,8 @@ static struct option main_options[] = {
 	{ "transport",	1, 0, 't' },
 	{ "device",	1, 0, 'd' },
 	{ "bcsprate", 1, 0, 'b'},
+	{ "productid", 1, 0, 'p'},
+	{ "vendorid", 1, 0, 'v'},
 	{ "help",	0, 0, 'h' },
 	{ 0, 0, 0, 0 }
 };
@@ -1123,9 +1127,11 @@ int main(int argc, char *argv[])
 {
 	char *device = NULL;
 	int i, err, opt, transport = CSR_TRANSPORT_HCI;
+	uint16_t vendorid = 0x0a12; // default vendorid
+	uint16_t productid = 0x0001; // default productid
 	speed_t bcsp_rate = B38400;

-	while ((opt=getopt_long(argc, argv, "+t:d:i:b:h", main_options, NULL))
!= EOF) {
+	while ((opt=getopt_long(argc, argv, "+t:d:i:b:p:v:h", main_options,
NULL)) != EOF) {
 		switch (opt) {
 		case 't':
 			if (!strcasecmp(optarg, "hci"))
@@ -1183,6 +1189,24 @@ int main(int argc, char *argv[])
 				bcsp_rate = B38400;
 			}
 			break;
+		case 'p':
+			if (!strncasecmp(optarg, "0x", 2)){
+			 productid = strtol(optarg, NULL, 16);
+			}
+			else{
+			 printf("Please provide the productid in hex representation, eg.
0x0001\n");
+			 exit(1);
+			}
+			break;
+		case 'v':
+			if (!strncasecmp(optarg, "0x", 2)){
+			 vendorid = strtol(optarg, NULL, 16);
+			}
+			else{
+			 printf("Please provide the productid in hex representation, eg.
0x0a12\n");
+			 exit(1);
+			}
+			break;
 		case 'h':
 		default:
 			usage();
@@ -1199,7 +1223,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}

-	if (transport_open(transport, device, bcsp_rate) < 0)
+	if (transport_open(transport, device, bcsp_rate, vendorid, productid) < 0)
 		exit(1);

 	free(device);
diff --git a/tools/csr.h b/tools/csr.h
index 8b94d7b..cbddeae 100644
--- a/tools/csr.h
+++ b/tools/csr.h
@@ -515,7 +515,7 @@ int csr_read_hci(uint16_t varid, uint8_t *value,
uint16_t length);
 int csr_write_hci(uint16_t varid, uint8_t *value, uint16_t length);
 void csr_close_hci(void);

-int csr_open_usb(char *device);
+int csr_open_usb(char *device, uint16_t vendorid, uint16_t productid);
 int csr_read_usb(uint16_t varid, uint8_t *value, uint16_t length);
 int csr_write_usb(uint16_t varid, uint8_t *value, uint16_t length);
 void csr_close_usb(void);
diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index 5fb6bdc..7c63a79 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -86,7 +86,7 @@ static int read_value(const char *name, const char
*attr, const char *format)
 	return value;
 }

-static char *check_device(const char *name)
+static char *check_device(const char *name, uint16_t vendorid, uint16_t
productid)
 {
 	char path[PATH_MAX];
 	int busnum, devnum, vendor, product;
@@ -109,13 +109,13 @@ static char *check_device(const char *name)
 	if (product < 0)
 		return NULL;

-	if (vendor != 0x0a12 || product != 0x0001)
+	if (vendor != vendorid || product != productid)
 		return NULL;

 	return strdup(path);
 }

-static char *find_device(void)
+static char *find_device(uint16_t vendorid, uint16_t productid)
 {
 	char *path = NULL;
 	DIR *dir;
@@ -135,7 +135,7 @@ static char *find_device(void)
 						|| strchr(d->d_name, ':'))
 			continue;

-		path = check_device(d->d_name);
+		path = check_device(d->d_name,vendorid,productid);
 		if (path)
 			break;
 	}
@@ -148,12 +148,12 @@ static char *find_device(void)
 static uint16_t seqnum = 0x0000;
 static int handle = -1;

-int csr_open_usb(char *device)
+int csr_open_usb(char *device, uint16_t vendorid, uint16_t productid)
 {
 	int interface = 0;
 	char *path;

-	path = find_device();
+	path = find_device(vendorid,productid);
 	if (!path) {
 		fprintf(stderr, "Device not available\n");
 		return -1;
-- 
1.7.10.4

