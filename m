Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: hcitool: add option for LE_Scan_Type parameter
Date: Fri, 11 Feb 2011 09:23:44 -0800
Message-Id: <1297445024-29256-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

The LE_Scan_Type parameter controls the type of scan to perform.
---
 tools/hcitool.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index c097526..7ed7f98 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2350,23 +2350,29 @@ done:
 static struct option lescan_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "privacy",	0, 0, 'p' },
+	{ "passive",	0, 0, 'P' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lescan_help =
 	"Usage:\n"
-	"\tlescan [--privacy] enable privacy\n";
+	"\tlescan [--privacy] enable privacy\n"
+	"\tlescan [--passive] set scan type passive (default active)\n";
 
 static void cmd_lescan(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	uint8_t own_type = 0x00;
+	uint8_t scan_type = 0x01;
 
 	for_each_opt(opt, lescan_options, NULL) {
 		switch (opt) {
 		case 'p':
 			own_type = 0x01; /* Random */
 			break;
+		case 'P':
+			scan_type = 0x00; /* Passive */
+			break;
 		default:
 			printf("%s", lescan_help);
 			return;
@@ -2383,7 +2389,7 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_set_scan_parameters(dd, 0x01, htobs(0x0010),
+	err = hci_le_set_scan_parameters(dd, scan_type, htobs(0x0010),
 					htobs(0x0010), own_type, 0x00);
 	if (err < 0) {
 		perror("Set scan parameters failed");
-- 
1.7.1

