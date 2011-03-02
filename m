Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/3] hcitool: add "whitelist" option to create LE connections
Date: Wed,  2 Mar 2011 17:29:28 -0300
Message-Id: <1299097768-27237-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1299097768-27237-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1299097768-27237-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If "whitelist" option is given, the peer address and type will be
ignored and the white list will be used to determine which advertiser
to connect to.
---
 tools/hcitool.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 3e59630..d4775f1 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2499,12 +2499,14 @@ static void cmd_lescan(int dev_id, int argc, char **argv)
 static struct option lecc_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "random",	0, 0, 'r' },
+	{ "whitelist",	0, 0, 'w' },
 	{ 0, 0, 0, 0 }
 };
 
 static const char *lecc_help =
 	"Usage:\n"
-	"\tlecc [--random] <bdaddr>\n";
+	"\tlecc [--random] <bdaddr>\n"
+	"\tlecc --whitelist\n";
 
 static void cmd_lecc(int dev_id, int argc, char **argv)
 {
@@ -2515,18 +2517,22 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 	uint8_t initiator_filter, own_bdaddr_type, peer_bdaddr_type;
 
 	peer_bdaddr_type = LE_PUBLIC_ADDRESS;
+	initiator_filter = 0; /* Use peer address */
 
 	for_each_opt(opt, lecc_options, NULL) {
 		switch (opt) {
 		case 'r':
 			peer_bdaddr_type = LE_RANDOM_ADDRESS;
 			break;
+		case 'w':
+			initiator_filter = 0x01; /* Use white list */
+			break;
 		default:
 			printf("%s", lecc_help);
 			return;
 		}
 	}
-	helper_arg(1, 1, &argc, &argv, lecc_help);
+	helper_arg(0, 1, &argc, &argv, lecc_help);
 
 	if (dev_id < 0)
 		dev_id = hci_get_route(NULL);
@@ -2537,11 +2543,12 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
 		exit(1);
 	}
 
-	str2ba(argv[0], &bdaddr);
+	memset(&bdaddr, 0, sizeof(bdaddr_t));
+	if (argv[0])
+		str2ba(argv[0], &bdaddr);
 
 	interval = htobs(0x0004);
 	window = htobs(0x0004);
-	initiator_filter = 0x00;
 	own_bdaddr_type = 0x00;
 	min_interval = htobs(0x000F);
 	max_interval = htobs(0x000F);
-- 
1.7.4.1

