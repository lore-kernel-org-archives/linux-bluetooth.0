Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] hcidump: Fix compilation errors due to unaligned memory access
Date: Tue, 18 Dec 2012 12:10:57 +0100
Message-ID: <1355829058-10033-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use bt_get_le* helper functions to access unaligned memory. This fix
number of compilation errors on ARM similar to:

CC     tools/parser/hci.o
tools/parser/hci.c: In function ‘ext_inquiry_data_dump’:
tools/parser/hci.c:797:10 error: cast increases required alignment of
	target type [-Werror=cast-align]
tools/parser/hci.c:797:10: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [tools/parser/hci.o] Error 1
---
 tools/parser/hci.c   |  7 ++-----
 tools/parser/l2cap.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 4d2b91b..17b776d 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -791,12 +791,9 @@ static inline void ext_inquiry_data_dump(int level, struct frame *frm,
 		printf("%s service classes:",
 				type == 0x02 ? "Shortened" : "Complete");
 
-		for (i = 0; i < len / 2; i++) {
-			uint16_t val;
+		for (i = 0; i < len / 2; i++)
+			printf(" 0x%4.4x", bt_get_le16(data + i * 2));
 
-			val = btohs(bt_get_unaligned(((uint16_t *) (data + i * 2))));
-			printf(" 0x%4.4x", val);
-		}
 		printf("\n");
 		break;
 
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index 6b3e17a..42f5e1a 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -250,9 +250,9 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 	case 1:
 		return *ptr;
 	case 2:
-		return btohs(bt_get_unaligned((uint16_t *) ptr));
+		return bt_get_le16(ptr);
 	case 4:
-		return btohl(bt_get_unaligned((uint32_t *) ptr));
+		return bt_get_le32(ptr);
 	}
 	return 0;
 }
@@ -595,9 +595,9 @@ static void conf_rfc(void *ptr, int len, int in, uint16_t handle,
 		uint16_t rto, mto, mps;
 		txwin = *((uint8_t *) (ptr + 1));
 		maxtrans = *((uint8_t *) (ptr + 2));
-		rto = btohs(bt_get_unaligned((uint16_t *) (ptr + 3)));
-		mto = btohs(bt_get_unaligned((uint16_t *) (ptr + 5)));
-		mps = btohs(bt_get_unaligned((uint16_t *) (ptr + 7)));
+		rto = bt_get_le16(ptr + 3);
+		mto = bt_get_le16(ptr + 5);
+		mps = bt_get_le16(ptr + 7);
 		printf(", TxWin %d, MaxTx %d, RTo %d, MTo %d, MPS %d",
 					txwin, maxtrans, rto, mto, mps);
 	}
@@ -916,7 +916,7 @@ static void l2cap_ctrl_ext_parse(int level, struct frame *frm, uint32_t ctrl)
 		printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
-			len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
+			len = bt_get_le16(frm->ptr);
 			frm->ptr += L2CAP_SDULEN_SIZE;
 			frm->len -= L2CAP_SDULEN_SIZE;
 			printf(" (len %d)", len);
@@ -949,7 +949,7 @@ static void l2cap_ctrl_parse(int level, struct frame *frm, uint32_t ctrl)
 		printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
 			uint16_t len;
-			len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
+			len = bt_get_le16(frm->ptr);
 			frm->ptr += L2CAP_SDULEN_SIZE;
 			frm->len -= L2CAP_SDULEN_SIZE;
 			printf(" (len %d)", len);
@@ -1062,7 +1062,7 @@ static inline void a2mp_discover_req(int level, struct frame *frm, uint16_t len)
 
 	do {
 		len -= 2;
-		mask = btohs(*(uint16_t *)(&octet[0]));
+		mask = bt_get_le16(octet);
 		printf(" 0x%4.4x", mask);
 
 		extension = octet[1] & 0x80;
@@ -1102,7 +1102,7 @@ static inline void a2mp_discover_rsp(int level, struct frame *frm, uint16_t len)
 
 	do {
 		len -= 2;
-		mask = btohs(*(uint16_t *)(&octet[0]));
+		mask = bt_get_le16(octet);
 		printf(" 0x%4.4x", mask);
 
 		extension = octet[1] & 0x80;
@@ -1324,7 +1324,7 @@ static void l2cap_parse(int level, struct frame *frm)
 		if (p_filter(FILT_L2CAP))
 			return;
 
-		psm = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
+		psm = bt_get_le16(frm->ptr);
 		frm->ptr += 2;
 		frm->len -= 2;
 
@@ -1433,7 +1433,7 @@ static void l2cap_parse(int level, struct frame *frm)
 				frm->ptr += 2;
 				frm->len -= 4;
 			}
-			fcs = btohs(bt_get_unaligned((uint16_t *) (frm->ptr + frm->len)));
+			fcs = bt_get_le16(frm->ptr + frm->len);
 		}
 
 		if (!p_filter(FILT_L2CAP)) {
-- 
1.8.0

