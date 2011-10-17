Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/4] add 64 bit get_val support
Date: Mon, 17 Oct 2011 17:02:08 +0300
Message-Id: <1318860129-27386-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318860129-27386-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318860129-27386-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 parser/l2cap.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 6a5a4b2..232b24d 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -232,7 +232,7 @@ static uint8_t get_ext_ctrl(int in, uint16_t handle, uint16_t cid)
 	return 0;
 }
 
-static uint32_t get_val(uint8_t *ptr, uint8_t len)
+static uint64_t get_val(uint8_t *ptr, uint8_t len)
 {
 	switch (len) {
 	case 1:
@@ -241,6 +241,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 		return btohs(bt_get_unaligned((uint16_t *) ptr));
 	case 4:
 		return btohl(bt_get_unaligned((uint32_t *) ptr));
+	case 8:
+		return btohll(bt_get_unaligned((uint64_t *) ptr));
 	}
 	return 0;
 }
@@ -409,7 +411,7 @@ static inline void command_rej(int level, struct frame *frm)
 
 	switch (reason) {
 	case 0x0001:
-		printf(" mtu %d\n", get_val(frm->ptr + L2CAP_CMD_REJ_SIZE, 2));
+		printf(" mtu %llu\n", get_val(frm->ptr + L2CAP_CMD_REJ_SIZE, 2));
 		break;
 	case 0x0002:
 		cid = get_val(frm->ptr + L2CAP_CMD_REJ_SIZE, 4);
@@ -552,13 +554,13 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t handle,
 			set_mode(in, handle, cid, 0x00);
 			printf("MTU");
 			if (h->len > 0)
-				printf(" %d", get_val(h->val, h->len));
+				printf(" %llu", get_val(h->val, h->len));
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
 			printf("FlushTO");
 			if (h->len > 0)
-				printf(" %d", get_val(h->val, h->len));
+				printf(" %llu", get_val(h->val, h->len));
 			break;
 
 		case L2CAP_CONF_QOS:
@@ -582,7 +584,7 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t handle,
 		case L2CAP_CONF_EWS:
 			printf("EWS");
 			if (h->len > 0)
-				printf(" %d", get_val(h->val, h->len));
+				printf(" %llu", get_val(h->val, h->len));
 			set_ext_ctrl(in, handle, cid, 1);
 			break;
 
@@ -727,18 +729,18 @@ static inline void echo_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 
 static void info_opt(int level, int type, void *ptr, int len)
 {
-	uint32_t mask;
+	uint64_t mask;
 	int i;
 
 	p_indent(level, 0);
 
 	switch (type) {
 	case 0x0001:
-		printf("Connectionless MTU %d\n", get_val(ptr, len));
+		printf("Connectionless MTU %llu\n", get_val(ptr, len));
 		break;
 	case 0x0002:
 		mask = get_val(ptr, len);
-		printf("Extended feature mask 0x%4.4x\n", mask);
+		printf("Extended feature mask 0x%4.4x\n", (uint32_t) mask);
 		if (parser.flags & DUMP_VERBOSE)
 			for (i=0; l2cap_features[i].name; i++)
 				if (mask & l2cap_features[i].flag) {
-- 
1.7.4.1

