Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [hcidump PATCHv2 2/2] Decode A2MP Get AMP Assoc rsp
Date: Thu, 10 May 2012 11:08:52 +0300
Message-Id: <1336637333-20723-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1336637333-20723-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20120508202209.GA10294@x220.hpllc.com>
 <1336637333-20723-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds decoding Assoc data:

...
> ACL data: handle 11 flags 0x02 dlen 53
    A2MP: Get AMP Assoc rsp: id 1 status (0) Success
      Assoc data [len 39]:
        MAC: <address>
        Preferred Chan List number of triplets 4
          Country code: XXX
          Reg ext id 201 reg class 254 coverage class 0
          Channel 1 max power 20
          Channels 2 - 12 max power 20
          Channels 4 - 8 max power 0
        PAL CAP: 00 00 00 00
        PAL VER: 01 Comp ID: <id> SubVer: 0001
...
---
 parser/l2cap.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 8 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 69383e6..b6a7c57 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -1162,20 +1162,103 @@ static inline void a2mp_assoc_req(int level, struct frame *frm)
 	printf("Get AMP Assoc req: id %d\n", h->id);
 }
 
+static void a2mp_dump_chanlist(int level, struct a2mp_tlv *tlv, char *prefix)
+{
+	struct a2mp_chan_list *chan_list = (struct a2mp_chan_list *) tlv->val;
+	struct a2mp_country_triplet *triplet;
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
+	struct a2mp_tlv *tlv;
 
 	p_indent(level, 0);
-	printf("Assoc data:");
-	for (i = 0; i < len; i++) {
-		if (!(i%16)) {
-			printf("\n");
-			p_indent(level+1, 0);
+	printf("Assoc data [len %d]:\n", len);
+
+	tlv = (struct a2mp_tlv *) assoc;
+	while (len > sizeof(*tlv)) {
+		uint16_t tlvlen = btohs(tlv->len);
+		struct a2mp_pal_ver *ver;
+
+		p_indent(level+1, 0);
+
+		switch (tlv->type) {
+		case A2MP_MAC_ADDR_TYPE:
+			if (tlvlen != 6)
+				break;
+			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
+			       tlv->val[0], tlv->val[1], tlv->val[2],
+			       tlv->val[3], tlv->val[4], tlv->val[5]);
+			break;
+
+		case A2MP_PREF_CHANLIST_TYPE:
+			a2mp_dump_chanlist(level, tlv, "Preferred Chan List");
+			break;
+
+		case A2MP_CONNECTED_CHAN:
+			a2mp_dump_chanlist(level, tlv, "Connected Chan List");
+			break;
+
+		case A2MP_PAL_CAP_TYPE:
+			if (tlvlen != 4)
+				break;
+			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
+			       tlv->val[0], tlv->val[1], tlv->val[2],
+			       tlv->val[3]);
+			break;
+
+		case A2MP_PAL_VER_INFO:
+			if (tlvlen != 5)
+				break;
+			ver = (struct a2mp_pal_ver *) tlv->val;
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
+		tlv = (struct a2mp_tlv *) assoc;
 	}
-	printf("\n");
 }
 
 static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
-- 
1.7.9.5

