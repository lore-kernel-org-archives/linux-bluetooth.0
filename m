Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Add option to enable privacy during scanning to hcitool
Date: Fri, 28 Jan 2011 19:33:37 -0300
Message-Id: <1296254017-3381-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When privacy is enabled, random address is used during active scanning.
The non-resolvable private address shall be set using hciconfig.
---
 tools/hcitool.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index d50adaf..536d407 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2349,25 +2349,30 @@ done:
 
 static struct option lescan_options[] = {
 	{ "help",	0, 0, 'h' },
+	{ "privacy",	0, 0, 'p' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lescan_help =
 	"Usage:\n"
-	"\tlescan\n";
+	"\tlescan [--privacy] enable privacy\n";
 
 static void cmd_lescan(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
+	uint8_t own_type = 0x00;
 
 	for_each_opt(opt, lescan_options, NULL) {
 		switch (opt) {
+		case 'p':
+			own_type = 0x01; /* Random */
+			break;
 		default:
 			printf("%s", lescan_help);
 			return;
 		}
 	}
-	helper_arg(0, 0, &argc, &argv, lescan_help);
+	helper_arg(0, 1, &argc, &argv, lescan_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2378,8 +2383,8 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	err = hci_le_set_scan_parameters(dd, 0x01, htobs(0x0010), htobs(0x0010),
-								0x00, 0x00);
+	err = hci_le_set_scan_parameters(dd, 0x01, htobs(0x0010),
+					htobs(0x0010), own_type, 0x00);
 	if (err < 0) {
 		perror("Set scan parameters failed");
 		exit(1);
-- 
1.7.4.rc2

