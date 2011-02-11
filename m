Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: hcitool: add bdaddr type option to lecc
Date: Fri, 11 Feb 2011 10:31:04 -0800
Message-Id: <1297449064-32164-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

---
 tools/hcitool.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 6883b28..d7a82cc 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2421,12 +2421,13 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 
 static struct option lecc_options[] = {
 	{ "help",	0, 0, 'h' },
+	{ "random",	0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lecc_help =
 	"Usage:\n"
-	"\tlecc <bdaddr>\n";
+	"\tlecc [--random] <bdaddr>\n";
 
 static void cmd_lecc(int dev_id, int argc, char **argv)
 {
@@ -2436,8 +2437,13 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	uint16_t min_interval, supervision_timeout, window, handle;
 	uint8_t initiator_filter, own_bdaddr_type, peer_bdaddr_type;
 
+	peer_bdaddr_type = 0x00; /* Public device address */
+
 	for_each_opt(opt, lecc_options, NULL) {
 		switch (opt) {
+		case 'r':
+			peer_bdaddr_type = 0x01; /* Random */
+			break;
 		default:
 			printf("%s", lecc_help);
 			return;
@@ -2459,7 +2465,6 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	interval = htobs(0x0004);
 	window = htobs(0x0004);
 	initiator_filter = 0x00;
-	peer_bdaddr_type = 0x00;
 	own_bdaddr_type = 0x00;
 	min_interval = htobs(0x000F);
 	max_interval = htobs(0x000F);
-- 
1.7.1

