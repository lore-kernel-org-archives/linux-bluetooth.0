Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v2 4/4] btmgmt: Add support for setting PHY in add-adv
Date: Tue, 13 Mar 2018 11:24:05 +0530
Message-Id: <1520920445-30353-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520920445-30353-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520920445-30353-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h     |  3 +++
 tools/btmgmt.c | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 7a25e17..ec6a380 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -506,6 +506,9 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_TX_POWER		(1 << 4)
 #define MGMT_ADV_FLAG_APPEARANCE	(1 << 5)
 #define MGMT_ADV_FLAG_LOCAL_NAME	(1 << 6)
+#define MGMT_ADV_FLAG_SEC_1M		(1 << 7)
+#define MGMT_ADV_FLAG_SEC_2M		(1 << 8)
+#define MGMT_ADV_FLAG_SEC_CODED		(1 << 9)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 6ada176..e44ecac 100755
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3629,6 +3629,9 @@ static const char *adv_flags_str[] = {
 				"tx-power",
 				"scan-rsp-appearance",
 				"scan-rsp-local-name",
+				"Secondary-channel-1M",
+				"Secondary-channel-2M",
+				"Secondary-channel-CODED",
 };
 
 static const char *adv_flags2str(uint32_t flags)
@@ -3846,6 +3849,7 @@ static void add_adv_usage(void)
 		"\t -s, --scan-rsp <data>     Scan Response Data bytes\n"
 		"\t -t, --timeout <timeout>   Timeout in seconds\n"
 		"\t -D, --duration <duration> Duration in seconds\n"
+		"\t -P, --phy <phy>           Phy type, Specify 1M/2M/CODED\n"
 		"\t -c, --connectable         \"connectable\" flag\n"
 		"\t -g, --general-discov      \"general-discoverable\" flag\n"
 		"\t -l, --limited-discov      \"limited-discoverable\" flag\n"
@@ -3864,6 +3868,7 @@ static struct option add_adv_options[] = {
 	{ "scan-rsp",		1, 0, 's' },
 	{ "timeout",		1, 0, 't' },
 	{ "duration",		1, 0, 'D' },
+	{ "phy",		1, 0, 'P' },
 	{ "connectable",	0, 0, 'c' },
 	{ "general-discov",	0, 0, 'g' },
 	{ "limited-discov",	0, 0, 'l' },
@@ -3932,7 +3937,7 @@ static void cmd_add_adv(int argc, char **argv)
 	uint32_t flags = 0;
 	uint16_t index;
 
-	while ((opt = getopt_long(argc, argv, "+u:d:s:t:D:cglmphna",
+	while ((opt = getopt_long(argc, argv, "+u:d:s:t:D:P:cglmphna",
 						add_adv_options, NULL)) != -1) {
 		switch (opt) {
 		case 'u':
@@ -4017,6 +4022,16 @@ static void cmd_add_adv(int argc, char **argv)
 		case 'a':
 			flags |= MGMT_ADV_FLAG_APPEARANCE;
 			break;
+		case 'P':
+			if (strcasecmp(optarg, "1M") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_1M;
+			else if (strcasecmp(optarg, "2M") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_2M;
+			else if (strcasecmp(optarg, "CODED") == 0)
+				flags |= MGMT_ADV_FLAG_SEC_CODED;
+			else
+				goto done;
+			break;
 		case 'h':
 			success = true;
 			/* fall through */
-- 
2.7.4

