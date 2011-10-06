Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] decode fixed channel list info rsp
Date: Thu,  6 Oct 2011 16:38:12 +0300
Message-Id: <1317908292-29104-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1317908292-29104-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1317908292-29104-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 lib/bluetooth.h |    4 ++++
 lib/l2cap.h     |    5 +++++
 parser/l2cap.c  |   22 +++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 738e07a..b0680e2 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -93,13 +93,17 @@ enum {
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
 #define htobl(d)  (d)
+#define htobll(d) (d)
 #define btohs(d)  (d)
 #define btohl(d)  (d)
+#define btohll(d) (d)
 #elif __BYTE_ORDER == __BIG_ENDIAN
 #define htobs(d)  bswap_16(d)
 #define htobl(d)  bswap_32(d)
+#define htobll(d) bswap_64(d)
 #define btohs(d)  bswap_16(d)
 #define btohl(d)  bswap_32(d)
+#define btohll(d) bswap_64(d)
 #else
 #error "Unknown byte order"
 #endif
diff --git a/lib/l2cap.h b/lib/l2cap.h
index 47b3dc3..3880551 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -139,6 +139,11 @@ struct l2cap_conninfo {
 
 #define L2CAP_SDULEN_SIZE	2
 
+/* L2CAP fixed channels */
+#define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_CONNLESS	0x04
+#define L2CAP_FC_A2MP		0x08
+
 /* L2CAP structures */
 typedef struct {
 	uint16_t	len;
diff --git a/parser/l2cap.c b/parser/l2cap.c
index c975374..8933f8f 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -80,6 +80,13 @@ static struct features l2cap_features[] = {
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
@@ -243,6 +250,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 		return btohs(bt_get_unaligned((uint16_t *) ptr));
 	case 4:
 		return btohl(bt_get_unaligned((uint32_t *) ptr));
+	case 8:
+		return btohll(bt_get_unaligned((uint64_t *) ptr));
 	}
 	return 0;
 }
@@ -729,7 +738,7 @@ static inline void echo_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 
 static void info_opt(int level, int type, void *ptr, int len)
 {
-	uint32_t mask;
+	uint64_t mask;
 	int i;
 
 	p_indent(level, 0);
@@ -740,7 +749,7 @@ static void info_opt(int level, int type, void *ptr, int len)
 		break;
 	case 0x0002:
 		mask = get_val(ptr, len);
-		printf("Extended feature mask 0x%4.4x\n", mask);
+		printf("Extended feature mask 0x%4.4x\n", (uint32_t) mask);
 		if (parser.flags & DUMP_VERBOSE)
 			for (i=0; l2cap_features[i].name; i++)
 				if (mask & l2cap_features[i].flag) {
@@ -749,7 +758,14 @@ static void info_opt(int level, int type, void *ptr, int len)
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

