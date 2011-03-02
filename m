Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/3] hcitool: add random address type to LE Add to White List
Date: Wed,  2 Mar 2011 17:29:27 -0300
Message-Id: <1299097768-27237-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1299097768-27237-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1299097768-27237-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 3bdd3f5..3e59630 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2566,20 +2566,25 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 
 static struct option lewladd_options[] = {
 	{ "help",	0, 0, 'h' },
+	{ "random",	0, 0, 'r' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lewladd_help =
 	"Usage:\n"
-	"\tlewladd <bdaddr>\n";
+	"\tlewladd [--random] <bdaddr>\n";
 
 static void cmd_lewladd(int dev_id, int argc, char **argv)
 {
 	int err, opt, dd;
 	bdaddr_t bdaddr;
+	uint8_t bdaddr_type = LE_PUBLIC_ADDRESS;
 
 	for_each_opt(opt, lewladd_options, NULL) {
 		switch (opt) {
+		case 'r':
+			bdaddr_type = LE_RANDOM_ADDRESS;
+			break;
 		default:
 			printf("%s", lewladd_help);
 			return;
@@ -2599,7 +2604,7 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 
 	str2ba(argv[0], &bdaddr);
 
-	err = hci_le_add_white_list(dd, &bdaddr, LE_PUBLIC_ADDRESS, 1000);
+	err = hci_le_add_white_list(dd, &bdaddr, bdaddr_type, 1000);
 	hci_close_dev(dd);
 
 	if (err < 0) {
-- 
1.7.4.1

