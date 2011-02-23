Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] hcitool: add discovery procedure to lescan command
Date: Wed, 23 Feb 2011 18:16:28 -0300
Message-Id: <1298495788-22273-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the option [--discovery=g|l] to lescan command. Use
this option to enable the general or limited discovery procedure.
If discovery option is not given scanning will display all results
ignoring the AD flags.
---
 tools/hcitool.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index d7a82cc..cb7d181 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -49,6 +49,10 @@
 /* Unofficial value, might still change */
 #define LE_LINK		0x03
 
+#define FLAGS_AD_TYPE 0x01
+#define FLAGS_LIMITED_MODE_BIT 0x01
+#define FLAGS_GENERAL_MODE_BIT 0x02
+
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
 
 static void usage(void);
@@ -2287,7 +2291,62 @@ static void cmd_clock(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
-static int print_advertising_devices(int dd)
+static int read_flags(uint8_t *flags, const uint8_t *data, size_t size)
+{
+	unsigned int offset;
+
+	if (!flags || !data)
+		return -EINVAL;
+
+	offset = 0;
+	while (offset < size) {
+		uint8_t len = data[offset];
+		uint8_t type = data[offset + 1];
+
+		/* Check if it is the end of the significant part */
+		if (len == 0)
+			break;
+
+		if (type == FLAGS_AD_TYPE) {
+			*flags = data[offset + 2];
+			return 0;
+		}
+
+		offset += 1 + len;
+	}
+
+	return -ENOENT;
+}
+
+static int check_report_filter(uint8_t procedure, le_advertising_info *info)
+{
+	uint8_t flags;
+
+	/* If no discovery procedure is set, all reports are treat as valid */
+	if (procedure == 0)
+		return 1;
+
+	/* Read flags AD type value from the advertising report if it exists */
+	if (read_flags(&flags, info->data, info->length))
+		return 0;
+
+	switch (procedure) {
+	case 'l': /* Limited Discovery Procedure */
+		if (flags & FLAGS_LIMITED_MODE_BIT)
+			return 1;
+		break;
+	case 'g': /* General Discovery Procedure */
+		if (flags & (FLAGS_LIMITED_MODE_BIT | FLAGS_GENERAL_MODE_BIT))
+			return 1;
+		break;
+	default:
+		fprintf(stderr, "Unknown discovery procedure\n");
+	}
+
+	return 0;
+}
+
+static int print_advertising_devices(int dd, uint8_t filter_type)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
 	struct hci_filter nf, of;
@@ -2334,8 +2393,10 @@ static int print_advertising_devices(int dd)
 
 		/* Ignoring multiple reports */
 		info = (le_advertising_info *) (meta->data + 1);
-		ba2str(&info->bdaddr, addr);
-		printf("%s\n", addr);
+		if (check_report_filter(filter_type, info)) {
+			ba2str(&info->bdaddr, addr);
+			printf("%s\n", addr);
+		}
 	}
 
 done:
@@ -2351,19 +2412,23 @@ static struct option lescan_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "privacy",	0, 0, 'p' },
 	{ "passive",	0, 0, 'P' },
+	{ "discovery",	1, 0, 'd' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lescan_help =
 	"Usage:\n"
 	"\tlescan [--privacy] enable privacy\n"
-	"\tlescan [--passive] set scan type passive (default active)\n";
+	"\tlescan [--passive] set scan type passive (default active)\n"
+	"\tlescan [--discovery=g|l] enable general or limited discovery"
+		"procedure\n";
 
 static void cmd_lescan(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	uint8_t own_type = 0x00;
 	uint8_t scan_type = 0x01;
+	uint8_t filter_type = 0;
 
 	for_each_opt(opt, lescan_options, NULL) {
 		switch (opt) {
@@ -2373,6 +2438,13 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		case 'P':
 			scan_type = 0x00; /* Passive */
 			break;
+		case 'd':
+			filter_type = optarg[0];
+			if (filter_type != 'g' && filter_type != 'l') {
+				fprintf(stderr, "Unknown discovery procedure\n");
+				exit(1);
+			}
+			break;
 		default:
 			printf("%s", lescan_help);
 			return;
@@ -2404,7 +2476,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 
 	printf("LE Scan ...\n");
 
-	err = print_advertising_devices(dd);
+	err = print_advertising_devices(dd, filter_type);
 	if (err < 0) {
 		perror("Could not receive advertising events");
 		exit(1);
-- 
1.7.1

