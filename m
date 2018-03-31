Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Cho, Yu-Chen" <acho@suse.com>
To: linux-bluetooth@vger.kernel.org
Cc: acho@suse.com
Subject: [PATCH BlueZ] tool/hcidump: Fix memory leak with malformed packet
Date: Sat, 31 Mar 2018 14:55:49 +0800
Message-Id: <20180331065549.5907-1-acho@suse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not allow to read more then buffer size.
---
 tools/hcidump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index af8f5925a..9044cdd02 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -89,6 +89,8 @@ struct btsnoop_pkt {
 } __attribute__ ((packed));
 #define BTSNOOP_PKT_SIZE (sizeof(struct btsnoop_pkt))
 
+#define BTSNOOP_MAX_PACKET_SIZE		(1486 + 4)
+
 static uint8_t btsnoop_id[] = { 0x62, 0x74, 0x73, 0x6e, 0x6f, 0x6f, 0x70, 0x00 };
 
 static uint32_t btsnoop_version = 0;
@@ -328,6 +330,9 @@ static void read_dump(int fd)
 			}
 
 			frm.data_len = be32toh(ph.len) - 8;
+			if (frm.data_len > BTSNOOP_MAX_PACKET_SIZE)
+				goto failed;
+
 			err = read_n(fd, frm.data + 1, frm.data_len - 1);
 		} else if (parser.flags & DUMP_BTSNOOP) {
 			uint32_t opcode;
@@ -394,6 +399,9 @@ static void read_dump(int fd)
 			}
 		} else {
 			frm.data_len = btohs(dh.len);
+			if (frm.data_len > HCI_MAX_FRAME_SIZE)
+				goto failed;
+
 			err = read_n(fd, frm.data, frm.data_len);
 		}
 
-- 
2.16.2

