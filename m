Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 1/5] Inline ATT dump functions
Date: Wed, 23 Mar 2011 11:46:37 -0300
Message-Id: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/att.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/parser/att.c b/parser/att.c
index 7b8b83c..6c1d0d8 100644
--- a/parser/att.c
+++ b/parser/att.c
@@ -257,7 +257,7 @@ static const char *uuid2str(uint16_t uuid)
 	}
 }
 
-static void att_error_dump(int level, struct frame *frm)
+static inline void att_error_dump(int level, struct frame *frm)
 {
 	uint8_t op = get_u8(frm);
 	uint16_t handle = btohs(htons(get_u16(frm)));
@@ -270,7 +270,7 @@ static void att_error_dump(int level, struct frame *frm)
 	printf("%s (0x%.2x) on handle 0x%2.2x\n", attop2str(op), op, handle);
 }
 
-static void att_mtu_req_dump(int level, struct frame *frm)
+static inline void att_mtu_req_dump(int level, struct frame *frm)
 {
 	uint16_t client_rx_mtu = btohs(htons(get_u16(frm)));
 
@@ -278,7 +278,7 @@ static void att_mtu_req_dump(int level, struct frame *frm)
 	printf("client rx mtu %d\n", client_rx_mtu);
 }
 
-static void att_mtu_resp_dump(int level, struct frame *frm)
+static inline void att_mtu_resp_dump(int level, struct frame *frm)
 {
 	uint16_t server_rx_mtu = btohs(htons(get_u16(frm)));
 
@@ -286,7 +286,7 @@ static void att_mtu_resp_dump(int level, struct frame *frm)
 	printf("server rx mtu %d\n", server_rx_mtu);
 }
 
-static void att_find_info_req_dump(int level, struct frame *frm)
+static inline void att_find_info_req_dump(int level, struct frame *frm)
 {
 	uint16_t start = btohs(htons(get_u16(frm)));
 	uint16_t end = btohs(htons(get_u16(frm)));
@@ -295,7 +295,7 @@ static void att_find_info_req_dump(int level, struct frame *frm)
 	printf("start 0x%2.2x, end 0x%2.2x\n", start, end);
 }
 
-static void att_find_info_resp_dump(int level, struct frame *frm)
+static inline void att_find_info_resp_dump(int level, struct frame *frm)
 {
 	uint8_t fmt = get_u8(frm);
 
@@ -330,7 +330,7 @@ static void att_find_info_resp_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_find_by_type_req_dump(int level, struct frame *frm)
+static inline void att_find_by_type_req_dump(int level, struct frame *frm)
 {
 	uint16_t start = btohs(htons(get_u16(frm)));
 	uint16_t end = btohs(htons(get_u16(frm)));
@@ -346,7 +346,7 @@ static void att_find_by_type_req_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
-static void att_find_by_type_resp_dump(int level, struct frame *frm)
+static inline void att_find_by_type_resp_dump(int level, struct frame *frm)
 {
 	while (frm->len > 0) {
 		uint16_t uuid = btohs(htons(get_u16(frm)));
@@ -358,7 +358,7 @@ static void att_find_by_type_resp_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_read_by_type_req_dump(int level, struct frame *frm)
+static inline void att_read_by_type_req_dump(int level, struct frame *frm)
 {
 	uint16_t start = btohs(htons(get_u16(frm)));
 	uint16_t end = btohs(htons(get_u16(frm)));
@@ -385,7 +385,7 @@ static void att_read_by_type_req_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_read_by_type_resp_dump(int level, struct frame *frm)
+static inline void att_read_by_type_resp_dump(int level, struct frame *frm)
 {
 	uint8_t length = get_u8(frm);
 
@@ -406,7 +406,7 @@ static void att_read_by_type_resp_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_read_req_dump(int level, struct frame *frm)
+static inline void att_read_req_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
 
@@ -414,7 +414,7 @@ static void att_read_req_dump(int level, struct frame *frm)
 	printf("handle 0x%2.2x\n", handle);
 }
 
-static void att_read_blob_req_dump(int level, struct frame *frm)
+static inline void att_read_blob_req_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
 	uint16_t offset = btohs(htons(get_u16(frm)));
@@ -423,7 +423,7 @@ static void att_read_blob_req_dump(int level, struct frame *frm)
 	printf("handle 0x%4.4x offset 0x%4.4x\n", handle, offset);
 }
 
-static void att_read_blob_resp_dump(int level, struct frame *frm)
+static inline void att_read_blob_resp_dump(int level, struct frame *frm)
 {
 	p_indent(level, frm);
 	printf("value");
@@ -433,7 +433,7 @@ static void att_read_blob_resp_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
-static void att_read_multi_req_dump(int level, struct frame *frm)
+static inline void att_read_multi_req_dump(int level, struct frame *frm)
 {
 	p_indent(level, frm);
 	printf("Handles\n");
@@ -444,7 +444,7 @@ static void att_read_multi_req_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_read_multi_resp_dump(int level, struct frame *frm)
+static inline void att_read_multi_resp_dump(int level, struct frame *frm)
 {
 	p_indent(level, frm);
 	printf("values");
@@ -454,7 +454,7 @@ static void att_read_multi_resp_dump(int level, struct frame *frm)
 	printf("\n");
 }
 
-static void att_read_by_group_resp_dump(int level, struct frame *frm)
+static inline void att_read_by_group_resp_dump(int level, struct frame *frm)
 {
 	uint8_t length = get_u8(frm);
 
@@ -476,7 +476,7 @@ static void att_read_by_group_resp_dump(int level, struct frame *frm)
 	}
 }
 
-static void att_handle_notify_dump(int level, struct frame *frm)
+static inline void att_handle_notify_dump(int level, struct frame *frm)
 {
 	uint16_t handle = btohs(htons(get_u16(frm)));
 
-- 
1.7.1

