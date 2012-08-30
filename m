Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump] amp: Decode Read Data Block Size HCI cmd
Date: Thu, 30 Aug 2012 16:06:19 +0300
Message-Id: <1346331979-3837-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Decode Read Data Block Size HCI command and command status.

 < HCI Command: Read Data Block Size (0x04|0x000a) plen 0
 > HCI Event: Command Complete (0x0e) plen 10
    Read Data Block Size (0x04|0x000a) ncmd 1
    status 0x00
    Max ACL 1492 Block len 1492 Num blocks 4
---
 lib/hci.h    |    8 ++++++++
 parser/hci.c |   24 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index 3dbb221..d068a2f 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1316,6 +1316,14 @@ typedef struct {
 } __attribute__ ((packed)) read_bd_addr_rp;
 #define READ_BD_ADDR_RP_SIZE 7
 
+#define OCF_READ_DATA_BLOCK_SIZE	0x000A
+typedef struct {
+	uint8_t		status;
+	uint16_t	max_acl_len;
+	uint16_t	data_block_len;
+	uint16_t	num_blocks;
+} __attribute__ ((packed)) read_data_block_size_rp;
+
 /* Status params */
 #define OGF_STATUS_PARAM	0x05
 
diff --git a/parser/hci.c b/parser/hci.c
index 115cf1e..38794bd 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -338,7 +338,7 @@ static char *cmd_hostctl_str[CMD_HOSTCTL_NUM + 1] = {
 	"Write LE Host Supported",
 };
 
-#define CMD_INFO_NUM 9
+#define CMD_INFO_NUM 10
 static char *cmd_info_str[CMD_INFO_NUM + 1] = {
 	"Unknown",
 	"Read Local Version Information",
@@ -350,6 +350,7 @@ static char *cmd_info_str[CMD_INFO_NUM + 1] = {
 	"Read Country Code",
 	"Unknown",
 	"Read BD ADDR",
+	"Read Data Block Size",
 };
 
 #define CMD_STATUS_NUM 11
@@ -2041,6 +2042,24 @@ static inline void bdaddr_response_dump(int level, struct frame *frm)
 	raw_dump(level, frm);
 }
 
+static inline void read_data_block_size_dump(int level, struct frame *frm)
+{
+	read_data_block_size_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x\n", rp->status);
+
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	} else {
+		p_indent(level, frm);
+		printf("Max ACL %d Block len %d Num blocks %d\n",
+			btohs(rp->max_acl_len), btohs(rp->data_block_len),
+							btohs(rp->num_blocks));
+	}
+}
+
 static inline void generic_response_dump(int level, struct frame *frm)
 {
 	uint8_t status = get_u8(frm);
@@ -2886,6 +2905,9 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 		case OCF_READ_BD_ADDR:
 			bdaddr_response_dump(level, frm);
 			return;
+		case OCF_READ_DATA_BLOCK_SIZE:
+			read_data_block_size_dump(level, frm);
+			return;
 		}
 		break;
 
-- 
1.7.9.5

