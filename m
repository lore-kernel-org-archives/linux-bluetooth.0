Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 3/5] tools/btmgmt: Add support for scan rsp flags in add advertising
Date: Sun, 18 Sep 2016 12:34:39 +0200
Message-Id: <1474194881-10403-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474194881-10403-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set local-name and appearance flags for add advertising
command.
---
 tools/btmgmt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 38e959f..0def4e1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4071,6 +4071,8 @@ static void add_adv_usage(void)
 		"\t -c, --connectable         \"connectable\" flag\n"
 		"\t -g, --general-discov      \"general-discoverable\" flag\n"
 		"\t -l, --limited-discov      \"limited-discoverable\" flag\n"
+		"\t -n, --scan-rsp-local-name \"local-name\" flag\n"
+		"\t -a, --scan-rsp-appearance \"appearance\" flag\n"
 		"\t -m, --managed-flags       \"managed-flags\" flag\n"
 		"\t -p, --tx-power            \"tx-power\" flag\n"
 		"e.g.:\n"
@@ -4152,7 +4154,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:D:cglmph",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:D:cglmphna",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -4231,6 +4233,12 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 'p':
 			flags |= MGMT_ADV_FLAG_TX_POWER;
 			break;
+		case 'n':
+			flags |= MGMT_ADV_FLAG_LOCAL_NAME;
+			break;
+		case 'a':
+			flags |= MGMT_ADV_FLAG_APPEARANCE;
+			break;
 		case 'h':
 			success = true;
 		default:
-- 
2.7.4

