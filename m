Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] tools/hcitool: Simplify parsing in cmd_lecup
Date: Mon, 12 Jan 2015 17:19:39 +0100
Message-Id: <1421079580-26470-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
References: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

strtoul already detects 10 or 16 base if given base is 0.
---
 tools/hcitool.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 612e5bc..a37e028 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3307,7 +3307,7 @@ static const char *lecup_help =
 static void cmd_lecup(int dev_id, int argc, char **argv)
 {
 	uint16_t handle = 0, min, max, latency, timeout;
-	int opt, dd, base;
+	int opt, dd;
 	int options = 0;
 
 	/* Aleatory valid values */
@@ -3317,26 +3317,21 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 	timeout = 0x0C80;
 
 	for_each_opt(opt, lecup_options, NULL) {
-		if (optarg && strncasecmp("0x", optarg, 2) == 0)
-			base = 16;
-		else
-			base = 10;
-
 		switch (opt) {
 		case 'H':
-			handle = strtoul(optarg, NULL, base);
+			handle = strtoul(optarg, NULL, 0);
 			break;
 		case 'm':
-			min = strtoul(optarg, NULL, base);
+			min = strtoul(optarg, NULL, 0);
 			break;
 		case 'M':
-			max = strtoul(optarg, NULL, base);
+			max = strtoul(optarg, NULL, 0);
 			break;
 		case 'l':
-			latency = strtoul(optarg, NULL, base);
+			latency = strtoul(optarg, NULL, 0);
 			break;
 		case 't':
-			timeout = strtoul(optarg, NULL, base);
+			timeout = strtoul(optarg, NULL, 0);
 			break;
 		default:
 			printf("%s", lecup_help);
-- 
1.9.1

