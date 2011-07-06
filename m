Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hcidump: parsing l2cap info rsp
Date: Wed,  6 Jul 2011 12:21:23 +0300
Message-Id: <1309944083-1261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds parsing l2cap extended feature mask.

before:
hcidump -r /tmp/info-rsp.cap
HCI sniffer - Bluetooth packet analyzer ver 2.1
btsnoop version: 1 datalink type: 1002
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
---
after:
src/hcidump -r /tmp/info-rsp.cap
HCI sniffer - Bluetooth packet analyzer ver 2.1
btsnoop version: 1 datalink type: 1002
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
---
---
 parser/l2cap.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 3562475..f7f0c3e 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -65,6 +65,24 @@ static cid_info cid_table[2][CID_TABLE_SIZE];
 #define SCID cid_table[0]
 #define DCID cid_table[1]
 
+/* Can we move this to l2cap.h? */
+static struct {
+	char	*name;
+	int	flag;
+} l2cap_features[] = {
+	{ "Flow control mode",			L2CAP_FEAT_FLOWCTL	},
+	{ "Retransmission mode",		L2CAP_FEAT_RETRANS	},
+	{ "Bi-directional QoS",			L2CAP_FEAT_BIDIR_QOS	},
+	{ "Enhanced Retransmission mode",	L2CAP_FEAT_ERTM		},
+	{ "Streaming mode",			L2CAP_FEAT_STREAMING	},
+	{ "FCS Option",				L2CAP_FEAT_FCS		},
+	{ "Extended Flow Specification",	L2CAP_FEAT_EXT_FLOW	},
+	{ "Fixed Channels",			L2CAP_FEAT_FIXED_CHAN	},
+	{ "Extended Window Size",		L2CAP_FEAT_EXT_WINDOW	},
+	{ "Unicast Connectless Data Reception",	L2CAP_FEAT_UCD		},
+	{ 0 }
+};
+
 static struct frame *add_handle(uint16_t handle)
 {
 	register handle_info *t = handle_table;
@@ -643,6 +661,7 @@ static inline void echo_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 static void info_opt(int level, int type, void *ptr, int len)
 {
 	uint32_t mask;
+	int i;
 
 	p_indent(level, 0);
 
@@ -653,20 +672,12 @@ static void info_opt(int level, int type, void *ptr, int len)
 	case 0x0002:
 		mask = get_val(ptr, len);
 		printf("Extended feature mask 0x%4.4x\n", mask);
-		if (parser.flags & DUMP_VERBOSE) {
-			if (mask & 0x01) {
-				p_indent(level + 1, 0);
-				printf("Flow control mode\n");
-			}
-			if (mask & 0x02) {
-				p_indent(level + 1, 0);
-				printf("Retransmission mode\n");
-			}
-			if (mask & 0x04) {
-				p_indent(level + 1, 0);
-				printf("Bi-directional QoS\n");
-			}
-		}
+		if (parser.flags & DUMP_VERBOSE)
+			for (i=0; l2cap_features[i].name; i++)
+				if (mask & l2cap_features[i].flag) {
+					p_indent(level + 1, 0);
+					printf("%s\n", l2cap_features[i].name);
+				}
 		break;
 	case 0x0003:
 		printf("Fixed channel list\n");
-- 
1.7.4.1

