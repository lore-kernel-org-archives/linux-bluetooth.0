Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 5/7] tools/btmgmt: Add --managed-flags option to add-adv
Date: Tue, 24 Mar 2015 20:05:52 -0700
Message-Id: <1427252754-27889-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1427252754-27889-1-git-send-email-armansito@chromium.org>
References: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the --managed-flags (-m) option to the add-adv command,
which can be used to request that the "Flags" AD field be managed by
the kernel for a given advertising instance.
---
 tools/btmgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index a870b52..22a2c8c 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3688,7 +3688,7 @@ static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
 static void add_adv_usage(void)
 {
 	print("Usage: add-adv [-u uuid] [-d adv_data] [-s scan_rsp] "
-			"[-t timeout] [-c] [-d] [-e] [-l] <instance_id>");
+			"[-t timeout] [-c] [-d] [-e] [-l] [-m] <instance_id>");
 }
 
 static struct option add_adv_options[] = {
@@ -3700,6 +3700,7 @@ static struct option add_adv_options[] = {
 	{ "connectable",	0, 0, 'c' },
 	{ "discoverable",	0, 0, 'e' },
 	{ "limited-discov",	0, 0, 'l' },
+	{ "managed-flags",	0, 0, 'm' },
 	{ 0, 0, 0, 0}
 };
 
@@ -3763,7 +3764,7 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 	bool quit = true;
 	uint32_t flags = 0;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:celh",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:celmh",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -3833,6 +3834,9 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
 		case 'l':
 			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
 			break;
+		case 'm':
+			flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+			break;
 		case 'h':
 			success = true;
 		default:
-- 
2.2.0.rc0.207.ga3a616c

