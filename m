Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] decode fixed channel list info rsp
Date: Mon, 24 Oct 2011 12:22:34 +0300
Message-Id: <1319448154-8743-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1319448154-8743-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1319448154-8743-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode fixed channels in information response

< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x0000000a
        L2CAP Signalling Channel
        AMP Manager Protocol
---
 parser/l2cap.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 6a5a4b2..3eea172 100644
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
@@ -728,6 +737,7 @@ static inline void echo_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 static void info_opt(int level, int type, void *ptr, int len)
 {
 	uint32_t mask;
+	uint64_t fc_mask;
 	int i;
 
 	p_indent(level, 0);
@@ -747,7 +757,14 @@ static void info_opt(int level, int type, void *ptr, int len)
 				}
 		break;
 	case 0x0003:
-		printf("Fixed channel list\n");
+		fc_mask = bt_get_le64(ptr);
+		printf("Fixed channel list 0x%8.8llx\n", fc_mask);
+		if (parser.flags & DUMP_VERBOSE)
+			for (i=0; l2cap_fix_chan[i].name; i++)
+				if (fc_mask & l2cap_fix_chan[i].flag) {
+					p_indent(level + 1, 0);
+					printf("%s\n", l2cap_fix_chan[i].name);
+				}
 		break;
 	default:
 		printf("Unknown (len %d)\n", len);
-- 
1.7.4.1

