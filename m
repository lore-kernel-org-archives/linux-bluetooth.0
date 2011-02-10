Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hcitool: add bdaddr type option to lecc
Date: Wed,  9 Feb 2011 16:59:11 -0800
Message-Id: <1297299551-10297-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

---
 tools/hcitool.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 536d407..c097526 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2420,7 +2420,7 @@ static struct option lecc_options[] = {
 
 static const char *lecc_help =
 	"Usage:\n"
-	"\tlecc <bdaddr>\n";
+	"\tlecc <bdaddr> [conn type]\n";
 
 static void cmd_lecc(int dev_id, int argc, char **argv)
 {
@@ -2437,7 +2437,7 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 			return;
 		}
 	}
-	helper_arg(1, 1, &argc, &argv, lecc_help);
+	helper_arg(1, 2, &argc, &argv, lecc_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2450,10 +2450,14 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
+	if (argc == 2)
+		peer_bdaddr_type = atoi(argv[1]);
+	else	
+		peer_bdaddr_type = 0;
+
 	interval = htobs(0x0004);
 	window = htobs(0x0004);
 	initiator_filter = 0x00;
-	peer_bdaddr_type = 0x00;
 	own_bdaddr_type = 0x00;
 	min_interval = htobs(0x000F);
 	max_interval = htobs(0x000F);
-- 
1.7.1

