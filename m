Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 4/4 v1] btmgmt: Add support for setting PHY in add-adv
Date: Fri,  9 Mar 2018 12:55:54 +0530
Message-Id: <1520580354-2185-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h     |  3 +++
 tools/btmgmt.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

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
index 5ad534f..3c6b543 100755
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3802,6 +3802,9 @@ static const char *adv_flags_str[] = {
 				"tx-power",
 				"scan-rsp-appearance",
 				"scan-rsp-local-name",
+				"Secondary-channel-1M",
+				"Secondary-channel-2M",
+				"Secondary-channel-CODED",
 };
 
 static const char *adv_flags2str(uint32_t flags)
@@ -4016,6 +4019,7 @@ static void add_adv_usage(void)
 		"\t -s, --scan-rsp <data>     Scan Response Data bytes\n"
 		"\t -t, --timeout <timeout>   Timeout in seconds\n"
 		"\t -D, --duration <duration> Duration in seconds\n"
+		"\t -P, --phy <phy>           Phy type, Specify 1M/2M/CODED\n"
 		"\t -c, --connectable         \"connectable\" flag\n"
 		"\t -g, --general-discov      \"general-discoverable\" flag\n"
 		"\t -l, --limited-discov      \"limited-discoverable\" flag\n"
@@ -4034,6 +4038,7 @@ static struct option add_adv_options[] = {
 	{ "scan-rsp",		1, 0, 's' },
 	{ "timeout",		1, 0, 't' },
 	{ "duration",		1, 0, 'D' },
+	{ "phy",		1, 0, 'P' },
 	{ "connectable",	0, 0, 'c' },
 	{ "general-discov",	0, 0, 'g' },
 	{ "limited-discov",	0, 0, 'l' },
@@ -4187,6 +4192,16 @@ static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
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

