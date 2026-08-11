Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D79233933
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461033; cv=none; b=uiCx+STjYyPC3R2nrKSqQoxLz2oMZtLZ+En+lg2sNM6+x5lqO0J7Igde91b8hyTEghCV4OFeklHNFB/fKusktBGyo8KIXtrSpuKpMMX5qWZAR91IEndNdaVj9mcW6g2I1BpZ5oY04TUEwv4xa11xQST11qm+T6LzDtH6QbJWlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461033; c=relaxed/simple;
	bh=6tLX04KqcbBFGSpesCmB9h+k/CgkjY8K4h38qC9+oPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbS5XJGCpWpuhBdbF43Vbx5zge5BGauXrhOLBywBAT1C7MsF4xf8R4f4jyhNDpm0Trve72SFe3Z497eKc4t04+JD3XqYiNbfFIOjvg4lE90SzrAM1NbO1UB2csg3f+r9OkMqeOQLQAOUcLbr4QxQlg4pcQOtuPbg5MnCnx/8auI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 51D0B582390
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B66093ED0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 6/9] sdp-xml: Optimise parsing large sequences
Date: Tue, 11 Aug 2026 16:54:09 +0200
Message-ID: <20260811145704.1766949-7-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTF4bdVHFdZG4ll+rkbPd4OBQm7n4PeAxiBvwtIeMQr0JxyH0jMI7CIh0yO8VHtbAjnjyTUVcX/+LOjlbUj0Jc38vMSlj7MgAgF/YKstwnYcVs8H+qe2OlQQ45quGtMhPRKXk+jkUThgKyKUTZFiD2iLMqd2XQJbZF8axpqz2frx5d/7JnMP5udHcMOOsLijYqjg0my3Yl9QgaeUoIp8WKxeMLMzUaO8EBwXb/DELMyYvuvRIKK3TkxOj28MEPFChdbzmiXO0Vw3JHsRbe10V9NROOalZV+IiiRXp60coWsdh7hH3WJ8NpXriAhtbu2HP6TMXk7qH3rbr1j4twUFTpE+PKGHXThMZHKHQzr5pN/IUZUQH8CNHxHb2dkVW0StKDJz8zatrLVzOIbeESlg57nkmnGgrQzlNsKgpyC42UqdhAWC/Ke9Z77E7XCUavu1Uv/RLTqoFIS/qAyuzPBrPxHnoLxSQUgpAG7a1sLdqrpKkG9XhXMRxITfnZVqNpSlRoeAuACKX9iVmL6K6RsSp+fknmsHdKNTYl2GaU9zJkw4ikQlhiK/ULfH5ok4wrHwepMi4V7x61v0YIk9qTdF2jqadl+Itr923JF3SfLxuycg1g0rZ8fZUTXsy1x5eVQT2Ruw1u1BpBfHfRxXa9Ic0/I9BhLPk82Z0TTYFPpPavXayQ
X-GND-State: clean

SDP sequences are stored as single-linked lists, so appending members
to a sequence requires finding the tail of the list before the
insertion.

Finding the tail of the list always starts at the beginning of the list,
so takes longer and longer as the list grows bigger.

Keep track of the tail to avoid that problem. This cuts down the
sequence_on_squared() test from around 3 to 4 seconds to less than
0.1 seconds.
---
 src/sdp-xml.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 816d19611f8b..97fb8b0c1af0 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -44,6 +44,7 @@ struct sdp_xml_data {
 	char type;			/* 0 = Text or Hexadecimal */
 	char *name;			/* Name, optional in the dtd */
 	/* TODO: What is it used for? */
+	sdp_data_t *tail;		/* Tail for O(1) dataseq append */
 };
 
 struct context_data {
@@ -609,6 +610,7 @@ static void element_end(GMarkupParseContext *context,
 
 	if (ctx_data->stack_head->next && ctx_data->stack_head->data &&
 					ctx_data->stack_head->next->data) {
+		sdp_data_t *tail;
 		switch (ctx_data->stack_head->next->data->dtd) {
 		case SDP_SEQ8:
 		case SDP_SEQ16:
@@ -616,10 +618,17 @@ static void element_end(GMarkupParseContext *context,
 		case SDP_ALT8:
 		case SDP_ALT16:
 		case SDP_ALT32:
-			ctx_data->stack_head->next->data->val.dataseq =
-				sdp_seq_append(ctx_data->stack_head->next->data->val.dataseq,
-								ctx_data->stack_head->data);
+			tail = ctx_data->stack_head->next->data->val.dataseq ?
+				ctx_data->stack_head->next->tail : NULL;
+			if (tail) {
+				sdp_seq_append(tail, ctx_data->stack_head->data);
+			} else {
+				ctx_data->stack_head->next->data->val.dataseq =
+					sdp_seq_append(NULL, ctx_data->stack_head->data);
+			}
+			ctx_data->stack_head->next->tail = ctx_data->stack_head->data;
 			ctx_data->stack_head->data = NULL;
+			ctx_data->stack_head->tail = NULL;
 			break;
 		}
 
-- 
2.55.0

