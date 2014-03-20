Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 60/62] tools: Use unaligned access macros from util.h
Date: Thu, 20 Mar 2014 11:43:25 -0300
Message-Id: <1395326607-27068-61-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/parser/hci.c    | 1 -
 tools/parser/l2cap.c  | 1 -
 tools/parser/parser.h | 9 ++++-----
 tools/parser/ppp.c    | 2 +-
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index b018e93..351f843 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -37,7 +37,6 @@
 #include "lib/hci.h"
 #include "lib/hci_lib.h"
 #include "lib/amp.h"
-#include "src/shared/util.h"
 
 static uint16_t manufacturer = DEFAULT_COMPID;
 
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index 53dd726..a057964 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -39,7 +39,6 @@
 #include "lib/hci.h"
 #include "lib/a2mp.h"
 #include "lib/amp.h"
-#include "src/shared/util.h"
 
 typedef struct {
 	uint16_t handle;
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index c65b4b5..dc49104 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -30,6 +30,7 @@
 #include <netinet/in.h>
 
 #include "lib/bluetooth.h"
+#include "src/shared/util.h"
 
 struct frame {
 	void		*data;
@@ -170,24 +171,22 @@ static inline uint8_t get_u8(struct frame *frm)
 
 static inline uint16_t get_u16(struct frame *frm)
 {
-	uint16_t *u16_ptr = frm->ptr;
 	frm->ptr += 2;
 	frm->len -= 2;
-	return ntohs(bt_get_unaligned(u16_ptr));
+	return get_be16(frm->ptr);
 }
 
 static inline uint32_t get_u32(struct frame *frm)
 {
-	uint32_t *u32_ptr = frm->ptr;
 	frm->ptr += 4;
 	frm->len -= 4;
-	return ntohl(bt_get_unaligned(u32_ptr));
+	return get_be32(frm->ptr);
 }
 
 static inline uint64_t get_u64(struct frame *frm)
 {
 	uint64_t *u64_ptr = frm->ptr;
-	uint64_t u64 = bt_get_unaligned(u64_ptr), tmp;
+	uint64_t u64 = get_unaligned(u64_ptr), tmp;
 	frm->ptr += 8;
 	frm->len -= 8;
 	tmp = ntohl(u64 & 0xffffffff);
diff --git a/tools/parser/ppp.c b/tools/parser/ppp.c
index 947ca56..256e172 100644
--- a/tools/parser/ppp.c
+++ b/tools/parser/ppp.c
@@ -103,7 +103,7 @@ static void hdlc_dump(int level, struct frame *frm)
 	uint8_t ctrl = get_u8(frm);
 	uint16_t fcs, proto;
 
-	fcs = bt_get_unaligned((uint16_t *) (frm->ptr + frm->len - 2));
+	fcs = get_unaligned((uint16_t *) (frm->ptr + frm->len - 2));
 	frm->len -= 2;
 
 	p_indent(level, frm);
-- 
1.8.3.1

