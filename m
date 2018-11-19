Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAEFC43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA720823
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 08:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CA720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeKSSfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:35:39 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:38619 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKSSfj (ORCPT
        <rfc822;groupwise-linux-bluetooth@vger.kernel.org:0:0>);
        Mon, 19 Nov 2018 13:35:39 -0500
Received: from linux-vvou.apac.novell.com (unknown.telstraglobal.net [134.159.103.118])
        by smtp.nue.novell.com with ESMTP (NOT encrypted); Mon, 19 Nov 2018 09:12:43 +0100
From:   "Cho, Yu-Chen" <acho@suse.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, acho@suse.com, jlee@suse.com
Subject: [PATCH BlueZ] hcidump: fixed AMP Assoc dump heap-over-flow
Date:   Mon, 19 Nov 2018 16:12:27 +0800
Message-Id: <20181119081227.7457-1-acho@suse.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

amp_assoc_dump() didn't check the length of amp assoc struct of
Type-Length-Value (TLV) triplets, and the Connected Chan List
(number of triplets) is also need to check, or there are wrong
length for the number of triplets.

---
 tools/parser/amp.c | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/parser/amp.c b/tools/parser/amp.c
index 158ca4a75..420099c90 100644
--- a/tools/parser/amp.c
+++ b/tools/parser/amp.c
@@ -33,7 +33,7 @@ static void amp_dump_chanlist(int level, struct amp_tlv *tlv, char *prefix)
 	struct amp_country_triplet *triplet;
 	int i, num;
 
-	num = (tlv->len - sizeof(*chan_list)) / sizeof(*triplet);
+	num = sizeof(*chan_list->triplets) / sizeof(*chan_list->triplets[0]);
 
 	printf("%s (number of triplets %d)\n", prefix, num);
 
@@ -80,47 +80,54 @@ void amp_assoc_dump(int level, uint8_t *assoc, uint16_t len)
 
 		p_indent(level+1, 0);
 
-		switch (tlv->type) {
-		case A2MP_MAC_ADDR_TYPE:
-			if (tlvlen != 6)
-				break;
-			printf("MAC: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
+		if (tlvlen != 0) {
+			switch (tlv->type) {
+			case A2MP_MAC_ADDR_TYPE:
+				if (tlvlen != 6)
+					break;
+				printf("MAC: ");
+				printf("%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n",
 					tlv->val[0], tlv->val[1], tlv->val[2],
 					tlv->val[3], tlv->val[4], tlv->val[5]);
-			break;
-
-		case A2MP_PREF_CHANLIST_TYPE:
-			amp_dump_chanlist(level, tlv, "Preferred Chan List");
-			break;
+				break;
 
-		case A2MP_CONNECTED_CHAN:
-			amp_dump_chanlist(level, tlv, "Connected Chan List");
-			break;
+			case A2MP_PREF_CHANLIST_TYPE:
+				amp_dump_chanlist(level, tlv,
+						   "Preferred Chan List");
+				break;
 
-		case A2MP_PAL_CAP_TYPE:
-			if (tlvlen != 4)
+			case A2MP_CONNECTED_CHAN:
+				amp_dump_chanlist(level, tlv,
+						   "Connected Chan List");
 				break;
-			printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
+
+			case A2MP_PAL_CAP_TYPE:
+				if (tlvlen != 4)
+					break;
+				printf("PAL CAP: %2.2x %2.2x %2.2x %2.2x\n",
 					tlv->val[0], tlv->val[1], tlv->val[2],
 					tlv->val[3]);
-			break;
-
-		case A2MP_PAL_VER_INFO:
-			if (tlvlen != 5)
 				break;
-			ver = (struct amp_pal_ver *) tlv->val;
-			printf("PAL VER: %2.2x Comp ID: %4.4x SubVer: %4.4x\n",
+
+			case A2MP_PAL_VER_INFO:
+				if (tlvlen != 5)
+					break;
+				ver = (struct amp_pal_ver *) tlv->val;
+				printf("PAL VER: ");
+				printf("%2.2x Comp ID: %4.4x SubVer: %4.4x\n",
 					ver->ver, btohs(ver->company_id),
 					btohs(ver->sub_ver));
-			break;
+				break;
 
-		default:
-			printf("Unrecognized type %d\n", tlv->type);
-			break;
-		}
+			default:
+				printf("Unrecognized type %d\n", tlv->type);
+				break;
+			}
 
-		len -= tlvlen + sizeof(*tlv);
-		assoc += tlvlen + sizeof(*tlv);
-		tlv = (struct amp_tlv *) assoc;
+			len -= tlvlen + sizeof(*tlv);
+			assoc += tlvlen + sizeof(*tlv);
+			tlv = (struct amp_tlv *) assoc;
+		} else
+			break;
 	}
 }
-- 
2.19.1

