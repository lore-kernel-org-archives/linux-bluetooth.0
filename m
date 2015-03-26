Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 1/4] tools/btmgmt: Rename add-adv --discoverable option
Date: Wed, 25 Mar 2015 20:29:54 -0700
Message-Id: <1427340597-8193-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames the --discoverable option of the add-adv command to
--general-discov, which is more consistent with the --limited-discov
option.
---
 tools/btmgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f64327b..19eeda1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3698,7 +3698,7 @@ static struct option add_adv_options[] = {
 	{ "scan-rsp",		1, 0, 's' },
 	{ "timeout",		1, 0, 't' },
 	{ "connectable",	0, 0, 'c' },
-	{ "discoverable",	0, 0, 'e' },
+	{ "general-discov",	0, 0, 'g' },
 	{ "limited-discov",	0, 0, 'l' },
 	{ "managed-flags",	0, 0, 'm' },
 	{ "tx-power",		0, 0, 'p' },
@@ -3765,7 +3765,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:celmph",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:cglmph",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -3829,7 +3829,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 'c':
 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 			break;
-		case 'e':
+		case 'g':
 			flags |= MGMT_ADV_FLAG_DISCOV;
 			break;
 		case 'l':
-- 
2.2.0.rc0.207.ga3a616c

