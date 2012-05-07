Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] hcidump: Process A2MP Assoc Rsp
Date: Mon,  7 May 2012 16:49:27 +0300
Message-Id: <1336398567-27842-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 lib/a2mp.h     |   38 +++++++++++++++++++++
 parser/l2cap.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/lib/a2mp.h b/lib/a2mp.h
index da937d1..ac308e7 100644
--- a/lib/a2mp.h
+++ b/lib/a2mp.h
@@ -142,6 +142,44 @@ struct a2mp_disconn_rsp {
 #define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
 #define A2MP_STATUS_SECURITY_VIOLATION			0x06
 
+#define MAC_ADDR_TYPE		1
+#define PREF_CHANLIST_TYPE	2
+#define CONNECTED_CHAN		3
+#define PAL_CAP_TYPE		4
+#define PAL_VER_INFO		5
+
+struct tlv {
+	uint8_t type;
+	uint16_t len;
+	uint8_t val[0];
+} __attribute__ ((packed));
+
+struct pal_ver {
+	uint8_t ver;
+	uint16_t company_id;
+	uint16_t sub_ver;
+} __attribute__ ((packed));
+
+struct country_triplet {
+	union {
+		struct {
+			uint8_t first_channel;
+			uint8_t num_channels;
+			int8_t max_power;
+		} __attribute__ ((packed)) chans;
+		struct {
+			uint8_t reg_extension_id;
+			uint8_t reg_class;
+			uint8_t coverage_class;
+		} __attribute__ ((packed)) ext;
+	};
+} __attribute__ ((packed));
+
+struct chan_list {
+	uint8_t country_code[3];
+	struct country_triplet triplets[0];
+} __attribute__ ((packed));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 69383e6..11ce11c 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -1162,20 +1162,104 @@ static inline void a2mp_assoc_req(int level, struct frame *frm)
 	printf("Get AMP Assoc req: id %d\n", h->id);
 }
 
+static void a2mp_dump_chanlist(int level, struct tlv *tlv, char *prefix)
+{
+	struct chan_list *chan_list = (struct chan_list *) tlv->val;
+	struct country_triplet *triplet;
+	int i, num;
+
+	num = tlv->len / sizeof(*triplet);
+
+	printf("%s number of triplets %d\n", prefix, num);
+
+	p_indent(level+2, 0);
+
+	printf("Country code: %c%c%c\n", chan_list->country_code[0],
+	       chan_list->country_code[1], chan_list->country_code[2]);
+
+	for (i = 0; i < num; i++) {
+		triplet = &chan_list->triplets[i];
+
+		p_indent(level+2, 0);
+
+		if (triplet->chans.first_channel >= 201) {
+			printf("Reg ext id %d reg class %d coverage class %d\n",
+			       triplet->ext.reg_extension_id,
+			       triplet->ext.reg_class,
+			       triplet->ext.coverage_class);
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
 static inline void a2mp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
 {
-	int i;
+	struct tlv *tlv;
 
 	p_indent(level, 0);
-	printf("Assoc data:");
-	for (i = 0; i < len; i++) {
-		if (!(i%16)) {
-			printf("\n");
-			p_indent(level+1, 0);
+	printf("Assoc data [len %d]:", len);
+
+	tlv = (struct tlv *) assoc;
+	while (len > sizeof(*tlv)) {
+		uint16_t tlvlen = btohs(tlv->len);
+		struct pal_ver *ver;
+		char addr[18];
+
+		p_indent(level+1, 0);
+
+		switch (tlv->type) {
+		case MAC_ADDR_TYPE:
+			if (tlvlen != 6)
+				break;
+			/* Use bdaddr since same length */
+			p_ba2str((bdaddr_t *) tlv->val, addr);
+			printf("MAC: %s\n", addr);
+			break;
+
+		case PREF_CHANLIST_TYPE:
+			a2mp_dump_chanlist(level, tlv, "Preferred Chan List");
+			break;
+
+		case CONNECTED_CHAN:
+			a2mp_dump_chanlist(level, tlv, "Connected Chan List");
+			break;
+
+		case PAL_CAP_TYPE:
+			if (tlvlen != 4)
+				break;
+			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
+			       tlv->val[0], tlv->val[1], tlv->val[2],
+			       tlv->val[3]);
+			break;
+
+		case PAL_VER_INFO:
+			if (tlvlen != 5)
+				break;
+			ver = (struct pal_ver *) tlv->val;
+			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
+			       ver->ver, btohs(ver->company_id),
+			       btohs(ver->sub_ver));
+			break;
+
+		default:
+			printf("Unrecognized type %d\n", tlv->type);
+			break;
 		}
-		printf("%2.2x ",*assoc++);
+
+		len -= tlvlen + sizeof(*tlv);
+		assoc += tlvlen + sizeof(*tlv);
+		tlv = (struct tlv *) assoc;
 	}
-	printf("\n");
 }
 
 static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
-- 
1.7.9.5

