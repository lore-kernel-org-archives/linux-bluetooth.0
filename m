Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 2/2] Make assoc dump function available for HCI parser
Date: Mon,  4 Jun 2012 17:17:16 +0300
Message-Id: <1338819436-15549-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338819436-15549-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338819436-15549-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP Assoc dump will be used for HCI dump functions
---
 Makefile.am    |    3 +-
 lib/a2mp.h     |   38 -----------------
 parser/amp.c   |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/l2cap.c |  104 ++--------------------------------------------
 4 files changed, 132 insertions(+), 140 deletions(-)
 create mode 100644 parser/amp.c

diff --git a/Makefile.am b/Makefile.am
index 80d04e8..64927d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -26,7 +26,8 @@ parser_sources =  parser/parser.h parser/parser.c \
 					parser/tcpip.c \
 					parser/ericsson.c \
 					parser/csr.c \
-					parser/bpa.c
+					parser/bpa.c \
+					parser/amp.c
 
 
 sbin_PROGRAMS = src/hcidump
diff --git a/lib/a2mp.h b/lib/a2mp.h
index 61f1c1e..da937d1 100644
--- a/lib/a2mp.h
+++ b/lib/a2mp.h
@@ -142,44 +142,6 @@ struct a2mp_disconn_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
 #define A2MP_STATUS_SECURITY_VIOLATION			0x06
 
-#define A2MP_MAC_ADDR_TYPE		1
-#define A2MP_PREF_CHANLIST_TYPE		2
-#define A2MP_CONNECTED_CHAN		3
-#define A2MP_PAL_CAP_TYPE		4
-#define A2MP_PAL_VER_INFO		5
-
-struct a2mp_tlv {
-	uint8_t type;
-	uint16_t len;
-	uint8_t val[0];
-} __attribute__ ((packed));
-
-struct a2mp_pal_ver {
-	uint8_t ver;
-	uint16_t company_id;
-	uint16_t sub_ver;
-} __attribute__ ((packed));
-
-struct a2mp_country_triplet {
-	union {
-		struct {
-			uint8_t first_channel;
-			uint8_t num_channels;
-			int8_t max_power;
-		} __attribute__ ((packed)) chans;
-		struct {
-			uint8_t reg_extension_id;
-			uint8_t reg_class;
-			uint8_t coverage_class;
-		} __attribute__ ((packed)) ext;
-	};
-} __attribute__ ((packed));
-
-struct a2mp_chan_list {
-	uint8_t country_code[3];
-	struct a2mp_country_triplet triplets[0];
-} __attribute__ ((packed));
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/parser/amp.c b/parser/amp.c
new file mode 100644
index 0000000..9e0f7f3
--- /dev/null
+++ b/parser/amp.c
@@ -0,0 +1,127 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Intel Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "parser/parser.h"
+#include "lib/amp.h"
+
+void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
+{
+	struct amp_chan_list *chan_list = (void *) tlv->val;
+	struct amp_country_triplet *triplet;
+	int i, num;
+
+	num = (tlv->len - sizeof(*chan_list)) / sizeof(*triplet);
+
+	printf("%s (number of triplets %d)\n", prefix, num);
+
+	p_indent(level+2, 0);
+
+	printf("Country code: %c%c%c\n", chan_list->country_code[0],
+		chan_list->country_code[1], chan_list->country_code[2]);
+
+	for (i = 0; i < num; i++) {
+		triplet = &chan_list->triplets[i];
+
+		p_indent(level+2, 0);
+
+		if (triplet->chans.first_channel >= 201) {
+			printf("Reg ext id %d reg class %d coverage class %d\n",
+						triplet->ext.reg_extension_id,
+						triplet->ext.reg_class,
+						triplet->ext.coverage_class);
+		} else {
+			if (triplet->chans.num_channels == 1)
+				printf("Channel %d max power %d\n",
+						triplet->chans.first_channel,
+						triplet->chans.max_power);
+			else
+				printf("Channels %d - %d max power %d\n",
+						triplet->chans.first_channel,
+						triplet->chans.first_channel +
+						triplet->chans.num_channels,
+						triplet->chans.max_power);
+		}
+	}
+}
+
+void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
+{
+	struct amp_tlv *tlv = (void *) assoc;
+
+	p_indent(level, 0);
+	printf("Assoc data [len %d]:\n", len);
+
+	while (len > sizeof(*tlv)) {
+		uint16_t tlvlen = btohs(tlv->len);
+		struct amp_pal_ver *ver;
+
+		p_indent(level+1, 0);
+
+		switch (tlv->type) {
+		case A2MP_MAC_ADDR_TYPE:
+			if (tlvlen != 6)
+				break;
+			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
+					tlv->val[0], tlv->val[1], tlv->val[2],
+					tlv->val[3], tlv->val[4], tlv->val[5]);
+			break;
+
+		case A2MP_PREF_CHANLIST_TYPE:
+			amp_dump_chanlist(level, tlv, "Preferred Chan List");
+			break;
+
+		case A2MP_CONNECTED_CHAN:
+			amp_dump_chanlist(level, tlv, "Connected Chan List");
+			break;
+
+		case A2MP_PAL_CAP_TYPE:
+			if (tlvlen != 4)
+				break;
+			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
+					tlv->val[0], tlv->val[1], tlv->val[2],
+					tlv->val[3]);
+			break;
+
+		case A2MP_PAL_VER_INFO:
+			if (tlvlen != 5)
+				break;
+			ver = (struct amp_pal_ver *) tlv->val;
+			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
+					ver->ver, btohs(ver->company_id),
+					btohs(ver->sub_ver));
+			break;
+
+		default:
+			printf("Unrecognized type %d\n", tlv->type);
+			break;
+		}
+
+		len -= tlvlen + sizeof(*tlv);
+		assoc += tlvlen + sizeof(*tlv);
+		tlv = (struct amp_tlv *) assoc;
+	}
+}
+
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 056e2a6..31e006c 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -38,6 +38,7 @@
 #include "lib/hci.h"
 #include "lib/l2cap.h"
 #include "lib/a2mp.h"
+#include "lib/amp.h"
 
 typedef struct {
 	uint16_t handle;
@@ -1162,112 +1163,13 @@ static inline void a2mp_assoc_req(int level, struct frame *frm)
 	printf("Get AMP Assoc req: id %d\n", h->id);
 }
 
-static void a2mp_dump_chanlist(int level, struct a2mp_tlv *tlv, char *prefix)
-{
-	struct a2mp_chan_list *chan_list = (struct a2mp_chan_list *) tlv->val;
-	struct a2mp_country_triplet *triplet;
-	int i, num;
-
-	num = tlv->len / sizeof(*triplet);
-
-	printf("%s number of triplets %d\n", prefix, num);
-
-	p_indent(level+2, 0);
-
-	printf("Country code: %c%c%c\n", chan_list->country_code[0],
-		chan_list->country_code[1], chan_list->country_code[2]);
-
-	for (i = 0; i < num; i++) {
-		triplet = &chan_list->triplets[i];
-
-		p_indent(level+2, 0);
-
-		if (triplet->chans.first_channel >= 201) {
-			printf("Reg ext id %d reg class %d coverage class %d\n",
-						triplet->ext.reg_extension_id,
-						triplet->ext.reg_class,
-						triplet->ext.coverage_class);
-		} else {
-			if (triplet->chans.num_channels == 1)
-				printf("Channel %d max power %d\n",
-						triplet->chans.first_channel,
-						triplet->chans.max_power);
-			else
-				printf("Channels %d - %d max power %d\n",
-						triplet->chans.first_channel,
-						triplet->chans.first_channel +
-						triplet->chans.num_channels,
-						triplet->chans.max_power);
-		}
-	}
-}
-
-static inline void a2mp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
-{
-	struct a2mp_tlv *tlv;
-
-	p_indent(level, 0);
-	printf("Assoc data [len %d]:\n", len);
-
-	tlv = (struct a2mp_tlv *) assoc;
-	while (len > sizeof(*tlv)) {
-		uint16_t tlvlen = btohs(tlv->len);
-		struct a2mp_pal_ver *ver;
-
-		p_indent(level+1, 0);
-
-		switch (tlv->type) {
-		case A2MP_MAC_ADDR_TYPE:
-			if (tlvlen != 6)
-				break;
-			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
-					tlv->val[0], tlv->val[1], tlv->val[2],
-					tlv->val[3], tlv->val[4], tlv->val[5]);
-			break;
-
-		case A2MP_PREF_CHANLIST_TYPE:
-			a2mp_dump_chanlist(level, tlv, "Preferred Chan List");
-			break;
-
-		case A2MP_CONNECTED_CHAN:
-			a2mp_dump_chanlist(level, tlv, "Connected Chan List");
-			break;
-
-		case A2MP_PAL_CAP_TYPE:
-			if (tlvlen != 4)
-				break;
-			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
-					tlv->val[0], tlv->val[1], tlv->val[2],
-					tlv->val[3]);
-			break;
-
-		case A2MP_PAL_VER_INFO:
-			if (tlvlen != 5)
-				break;
-			ver = (struct a2mp_pal_ver *) tlv->val;
-			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
-					ver->ver, btohs(ver->company_id),
-					btohs(ver->sub_ver));
-			break;
-
-		default:
-			printf("Unrecognized type %d\n", tlv->type);
-			break;
-		}
-
-		len -= tlvlen + sizeof(*tlv);
-		assoc += tlvlen + sizeof(*tlv);
-		tlv = (struct a2mp_tlv *) assoc;
-	}
-}
-
 static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
 {
 	struct a2mp_assoc_rsp *h = frm->ptr;
 
 	printf("Get AMP Assoc rsp: id %d status (%d) %s \n",
 			h->id, h->status, a2mpstatus2str(h->status));
-	a2mp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
+	amp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
 }
 
 static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
@@ -1276,7 +1178,7 @@ static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
 
 	printf("Create Physical Link req: local id %d remote id %d\n",
 		   h->local_id, h->remote_id);
-	a2mp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
+	amp_assoc_dump(level + 1, (uint8_t *) &h->assoc_data, len - 2);
 }
 
 static inline void a2mp_create_rsp(int level, struct frame *frm)
-- 
1.7.9.5

