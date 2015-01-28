Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools/sdptool: Check if HCI is powered UP before executing commands
Date: Wed, 28 Jan 2015 14:43:07 +0100
Message-Id: <1422452587-32279-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before executing commands should be checked if any or chosen HCI is
powered up. If not further executing of command makes no sense.
---
 tools/sdptool.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 17561b1..9ff7a1c 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -4352,17 +4352,20 @@ static struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	int i, opt;
+	int i, opt, err;
 
 	bacpy(&interface, BDADDR_ANY);
 
+	err = hci_get_route(NULL);
+
 	while ((opt=getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (!strncmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &interface);
+				err = hci_devba(atoi(optarg + 3), &interface);
 			else
 				str2ba(optarg, &interface);
+				err = hci_get_route(&interface);
 			break;
 
 		case 'h':
@@ -4374,6 +4377,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (err < 0) {
+		printf("No powered on HCI interface found\n");
+		exit(0);
+	}
+
 	argc -= optind;
 	argv += optind;
 	optind = 0;
-- 
1.9.3

