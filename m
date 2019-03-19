Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDAC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 09:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7362220828
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 09:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfCSJAI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:00:08 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45985 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSJAI (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Tue, 19 Mar 2019 05:00:08 -0400
Received: from linux-vvou.suse.de (unknown.telstraglobal.net [202.47.205.198])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Tue, 19 Mar 2019 10:00:05 +0100
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     acho@suse.com, jlee@suse.com
Subject: [PATCH] hcidump: Add assoc dump function assoc date length check
Date:   Tue, 19 Mar 2019 16:59:58 +0800
Message-Id: <20190319085958.6544-1-acho@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

amp_assoc_dump() didn't check the length of amp assoc struct.
If there is wrong lengh size of assoc date, amp_assoc_dump() and
amp_dump_chanlist() will read over the size(heap-buffer-overflow).

use t_len to save the length avoid use the wrong size of date.
---
 tools/parser/amp.c    | 35 +++++++++++++++++++++++++++--------
 tools/parser/hci.c    |  4 ++--
 tools/parser/l2cap.c  |  6 ++++--
 tools/parser/parser.h |  2 +-
 4 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/parser/amp.c b/tools/parser/amp.c
index 7c85fb96c..d3459dfe1 100644
--- a/tools/parser/amp.c
+++ b/tools/parser/amp.c
@@ -28,7 +28,8 @@
 #include "parser.h"
 #include "lib/amp.h"
 
-static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
+static void amp_dump_chanlist(int level, struct amp_tlv *tlv,
+			      uint16_t t_len, char *prefix)
 {
 	struct amp_chan_list *chan_list = (void *) tlv->val;
 	struct amp_country_triplet *triplet;
@@ -38,6 +39,12 @@ static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
 
 	printf("%s (number of triplets %d)\n", prefix, num);
 
+	if (btohs(tlv->len) > t_len) {
+		p_indent(level+1, 0);
+		printf("Wrong number of triplets\n");
+		num = (t_len - sizeof(*chan_list)) / sizeof(*triplet);
+	}
+
 	p_indent(level+2, 0);
 
 	printf("Country code: %c%c%c\n", chan_list->country_code[0],
@@ -68,7 +75,7 @@ static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
 	}
 }
 
-void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
+void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len, uint16_t t_len)
 {
 	struct amp_tlv *tlv = (void *) assoc;
 
@@ -76,6 +83,14 @@ void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
 	printf("Assoc data [len %d]:\n", len);
 
 	while (len > sizeof(*tlv)) {
+		if (btohs(tlv->len) > (t_len - sizeof(struct amp_tlv))) {
+			p_indent(level+1, 0);
+			printf("Assoc data get error size\n");
+			t_len -= sizeof(struct amp_tlv);
+		} else {
+			t_len -= sizeof(struct amp_tlv) + btohs(tlv->len);
+		}
+
 		uint16_t tlvlen = btohs(tlv->len);
 		struct amp_pal_ver *ver;
 
@@ -91,11 +106,13 @@ void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
 			break;
 
 		case A2MP_PREF_CHANLIST_TYPE:
-			amp_dump_chanlist(level, tlv, "Preferred Chan List");
+			amp_dump_chanlist(level, tlv,
+					  t_len, "Preferred Chan List");
 			break;
 
 		case A2MP_CONNECTED_CHAN:
-			amp_dump_chanlist(level, tlv, "Connected Chan List");
+			amp_dump_chanlist(level, tlv,
+					  t_len, "Connected Chan List");
 			break;
 
 		case A2MP_PAL_CAP_TYPE:
@@ -119,9 +136,11 @@ void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
 			printf("Unrecognized type %d\n", tlv->type);
 			break;
 		}
-
-		len -= tlvlen + sizeof(*tlv);
-		assoc += tlvlen + sizeof(*tlv);
-		tlv = (struct amp_tlv *) assoc;
+		if (btohs(tlv->len) <= t_len) {
+			len -= tlvlen + sizeof(*tlv);
+			assoc += tlvlen + sizeof(*tlv);
+			tlv = (struct amp_tlv *) assoc;
+		} else
+			len = 0;
 	}
 }
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 41f6fe087..424ff4bd7 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -1679,7 +1679,7 @@ static inline void write_remote_amp_assoc_cmd_dump(int level,
 	printf("handle 0x%2.2x len_so_far %d remaining_len %d\n", cp->handle,
 				cp->length_so_far, cp->remaining_length);
 
-	amp_assoc_dump(level + 1, cp->fragment, frm->len - 5);
+	amp_assoc_dump(level + 1, cp->fragment, frm->len - 5, frm->len - 5);
 }
 
 static inline void command_dump(int level, struct frame *frm)
@@ -2662,7 +2662,7 @@ static inline void read_local_amp_assoc_dump(int level, struct frame *frm)
 		p_indent(level, frm);
 		printf("Error: %s\n", status2str(rp->status));
 	} else {
-		amp_assoc_dump(level + 1, rp->fragment, len);
+		amp_assoc_dump(level + 1, rp->fragment, len, frm->len - 4);
 	}
 }
 
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index e43761cf7..58a23a54c 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -1172,7 +1172,8 @@ static inline void a2mp_assoc_rsp(int level, struct frame *frm, uint16_t len)
 
 	printf("Get AMP Assoc rsp: id %d status (%d) %s\n",
 			h->id, h->status, a2mpstatus2str(h->status));
-	amp_assoc_dump(level + 1, h->assoc_data, len - sizeof(*h));
+	amp_assoc_dump(level + 1, h->assoc_data,
+		       len - sizeof(*h), frm->len - sizeof(*h));
 }
 
 static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
@@ -1181,7 +1182,8 @@ static inline void a2mp_create_req(int level, struct frame *frm, uint16_t len)
 
 	printf("Create Physical Link req: local id %d remote id %d\n",
 		   h->local_id, h->remote_id);
-	amp_assoc_dump(level + 1, h->assoc_data, len - sizeof(*h));
+	amp_assoc_dump(level + 1, h->assoc_data,
+		       len - sizeof(*h), frm->len - sizeof(*h));
 }
 
 static inline void a2mp_create_rsp(int level, struct frame *frm)
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index b7e1d7568..97c4bbea1 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -249,7 +249,7 @@ void ericsson_dump(int level, struct frame *frm);
 void csr_dump(int level, struct frame *frm);
 void bpa_dump(int level, struct frame *frm);
 
-void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len);
+void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len, uint16_t t_len);
 
 static inline void parse(struct frame *frm)
 {
-- 
2.21.0

