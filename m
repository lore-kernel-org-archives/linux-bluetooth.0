Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 1/4] Fix constness of att_get_u{8,16,32}() functions
Date: Mon,  4 Oct 2010 15:13:01 -0400
Message-Id: <1286219584-8199-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 69071b4..3f1e239 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -123,21 +123,21 @@ struct att_data_list {
 };
 
 /* These functions do byte conversion */
-static inline uint8_t att_get_u8(void *ptr)
+static inline uint8_t att_get_u8(const void *ptr)
 {
-	uint8_t *u8_ptr = ptr;
+	const uint8_t *u8_ptr = ptr;
 	return bt_get_unaligned(u8_ptr);
 }
 
-static inline uint16_t att_get_u16(void *ptr)
+static inline uint16_t att_get_u16(const void *ptr)
 {
-	uint16_t *u16_ptr = ptr;
+	const uint16_t *u16_ptr = ptr;
 	return btohs(bt_get_unaligned(u16_ptr));
 }
 
-static inline uint32_t att_get_u32(void *ptr)
+static inline uint32_t att_get_u32(const void *ptr)
 {
-	uint32_t *u32_ptr = ptr;
+	const uint32_t *u32_ptr = ptr;
 	return btohl(bt_get_unaligned(u32_ptr));
 }
 
-- 
1.7.0.4

