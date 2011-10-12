Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 hcidump 3/3] decode fixed channel list info rsp
Date: Wed, 12 Oct 2011 11:31:36 +0300
Message-Id: <1318408296-28840-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318408296-28840-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode fixed channels in information response

< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x000a
        L2CAP Signalling Channel
        AMP Manager Protocol
---
 parser/l2cap.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 6a5a4b2..8a76021 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -61,10 +61,12 @@ static cid_info cid_table[2][CID_TABLE_SIZE];
 #define DCID cid_table[1]
 
 /* Can we move this to l2cap.h? */
-static struct {
+struct features {
 	char	*name;
 	int	flag;
-} l2cap_features[] = {
+};
+
+static struct features l2cap_features[] = {
 	{ "Flow control mode",			L2CAP_FEAT_FLOWCTL	},
 	{ "Retransmission mode",		L2CAP_FEAT_RETRANS	},
 	{ "Bi-directional QoS",			L2CAP_FEAT_BIDIR_QOS	},
@@ -78,6 +80,13 @@ static struct {
 	{ 0 }
 };
 
+static struct features l2cap_fix_chan[] = {
+	{ "L2CAP Signalling Channel",		L2CAP_FC_L2CAP		},
+	{ "L2CAP Connless",			L2CAP_FC_CONNLESS	},
+	{ "AMP Manager Protocol",		L2CAP_FC_A2MP		},
+	{ 0 }
+};
+
 static struct frame *add_handle(uint16_t handle)
 {
 	register handle_info *t = handle_table;
@@ -241,6 +250,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 		return btohs(bt_get_unaligned((uint16_t *) ptr));
 	case 4:
 		return btohl(bt_get_unaligned((uint32_t *) ptr));
+	case 8:
+		return btohll(bt_get_unaligned((uint64_t *) ptr));
 	}
 	return 0;
 }
@@ -727,7 +738,7 @@ static inline void echo_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 
 static void info_opt(int level, int type, void *ptr, int len)
 {
-	uint32_t mask;
+	uint64_t mask;
 	int i;
 
 	p_indent(level, 0);
@@ -738,7 +749,7 @@ static void info_opt(int level, int type, void *ptr, int len)
 		break;
 	case 0x0002:
 		mask = get_val(ptr, len);
-		printf("Extended feature mask 0x%4.4x\n", mask);
+		printf("Extended feature mask 0x%4.4x\n", (uint32_t) mask);
 		if (parser.flags & DUMP_VERBOSE)
 			for (i=0; l2cap_features[i].name; i++)
 				if (mask & l2cap_features[i].flag) {
@@ -747,7 +758,14 @@ static void info_opt(int level, int type, void *ptr, int len)
 				}
 		break;
 	case 0x0003:
-		printf("Fixed channel list\n");
+		mask = get_val(ptr, len);
+		printf("Fixed channel list 0x%4.4llx\n", mask);
+		if (parser.flags & DUMP_VERBOSE)
+			for (i=0; l2cap_fix_chan[i].name; i++)
+				if (mask & l2cap_fix_chan[i].flag) {
+					p_indent(level + 1, 0);
+					printf("%s\n", l2cap_fix_chan[i].name);
+				}
 		break;
 	default:
 		printf("Unknown (len %d)\n", len);
-- 
1.7.4.1

