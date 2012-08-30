Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] hcitool: Add LE scan based on White List
Date: Thu, 30 Aug 2012 13:16:33 -0300
Message-Id: <1346343393-19164-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the LE scanning command allowing the user to inform
an option to enable LE scanning detecting advertises sent from devices
in the White List Only. This option can be used combined with others.
---
 tools/hcitool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 66e5c20..aefbd68 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2487,6 +2487,7 @@ static struct option lescan_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "privacy",	0, 0, 'p' },
 	{ "passive",	0, 0, 'P' },
+	{ "whitelist",	0, 0, 'w' },
 	{ "discovery",	1, 0, 'd' },
 	{ "duplicates",	0, 0, 'D' },
 	{ 0, 0, 0, 0 }
@@ -2496,6 +2497,7 @@ static const char *lescan_help =
 	"Usage:\n"
 	"\tlescan [--privacy] enable privacy\n"
 	"\tlescan [--passive] set scan type passive (default active)\n"
+	"\tlescan [--whitelist] scan for address in the whitelist only\n"
 	"\tlescan [--discovery=g|l] enable general or limited discovery"
 		"procedure\n"
 	"\tlescan [--duplicates] don't filter duplicates\n";
@@ -2506,6 +2508,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 	uint8_t own_type = 0x00;
 	uint8_t scan_type = 0x01;
 	uint8_t filter_type = 0;
+	uint8_t filter_policy = 0x00;
 	uint16_t interval = htobs(0x0010);
 	uint16_t window = htobs(0x0010);
 	uint8_t filter_dup = 1;
@@ -2518,6 +2521,9 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		case 'P':
 			scan_type = 0x00; /* Passive */
 			break;
+		case 'w':
+			filter_policy = 0x01; /* Whitelist */
+			break;
 		case 'd':
 			filter_type = optarg[0];
 			if (filter_type != 'g' && filter_type != 'l') {
@@ -2548,7 +2554,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 	}
 
 	err = hci_le_set_scan_parameters(dd, scan_type, interval, window,
-							own_type, 0x00, 1000);
+						own_type, filter_policy, 1000);
 	if (err < 0) {
 		perror("Set scan parameters failed");
 		exit(1);
-- 
1.7.12

