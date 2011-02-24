Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] hcitool: fix interval and window parameters
Date: Thu, 24 Feb 2011 15:56:08 -0300
Message-Id: <1298573768-26751-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set interval and window parameters properly if --discovery option
is present in lescan command.

According to the Bluetooth spec, during a general or limited discovery
procedure the scan interval and the scan window should be set to
11.25 ms. If --discovery option isn't present, both parameters are set
to the default value (10 ms) defined in LE Set Scan Parameters Command.

According to that command description, the interval and window parameters
should be set as follows:

	Time = N * 0.625 msec

So, in order to set the time values to 11.25 and 10 ms, the parameters
should be equal to 18 (0x0012) and 16 (0x0010), respectively.
---
 tools/hcitool.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index cb7d181..c5254ea 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2429,6 +2429,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 	uint8_t own_type = 0x00;
 	uint8_t scan_type = 0x01;
 	uint8_t filter_type = 0;
+	uint16_t interval = htobs(0x0010);
+	uint16_t window = htobs(0x0010);
 
 	for_each_opt(opt, lescan_options, NULL) {
 		switch (opt) {
@@ -2444,6 +2446,9 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 				fprintf(stderr, "Unknown discovery procedure\n");
 				exit(1);
 			}
+
+			interval = htobs(0x0012);
+			window = htobs(0x0012);
 			break;
 		default:
 			printf("%s", lescan_help);
@@ -2461,8 +2466,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_set_scan_parameters(dd, scan_type, htobs(0x0010),
-					htobs(0x0010), own_type, 0x00);
+	err = hci_le_set_scan_parameters(dd, scan_type, interval, window,
+							own_type, 0x00);
 	if (err < 0) {
 		perror("Set scan parameters failed");
 		exit(1);
-- 
1.7.1

