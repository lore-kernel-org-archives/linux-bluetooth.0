Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E752BEC4E
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461030; cv=none; b=pMWcIqW3QikSp//Q4qvBVSN8SmZH4GDSyeR38eB1y43QVCsRHGrxxU+lEYWU29mBdzSjh5BxF7CqyIDTcmtUDAaqlZBC+6QjMeVmOqJy/AoM4w+DajKF3Uk+tW2OWbvguAmOXtvOPpo9aiB1iDPirWpYQRcZYGgsLoxPT0tnx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461030; c=relaxed/simple;
	bh=Pm0aNAEsxtywCRvoTuVN9Gp0mNnWLBvqPzL9z+oh6R8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzEyeb82BZlztigMW4tU0UmmfOuQZAuzgiLQAR8aGXaFfJzSzomxHbHVNj9xGD2yFemrk6A7fkdXISW0xidRg2s76z3f5/wZtkqgCnred71PL8z45LznAdX1omBwpLhh8gBQrpX9/pjvHX6JEobauFHSGW76YmRkj73BFj317gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 798BC582340
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4F6D3ED0B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:13 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML
Date: Tue, 11 Aug 2026 16:54:05 +0200
Message-ID: <20260811145704.1766949-3-hadess@hadess.net>
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
X-GND-Cause: dmFkZTE7//a8gsi3w1GPpapT5Ukt+fEcfN0ZqTSeGCFTUi06HsKf4CTnNBAfQbQDkgHMQet12ca5SSLbtGFwNNEDfR56GEWiE694LLeds/YbTFK8oKE84ZZdRJN/9FvvJbitjEXe5X2Ux89sLo+6GZDvGV8fazWxgXEouHAPP8iOQOz18/3hSyqTpUBzum+i6Ub0Nt2fhaOHGrZ6NgN+LKLEtlkbSxHz7YtbNs3pVeVioymzgo9MfUufhQwyCrV3uFtqkiDCROWsNOJPwtkJ1K6Q+FDhjCe4szlYUmtKvmhPVzImpKtNCEY8GR2ieMfP074xV8f74uk7YI29NimMTemkaUPeQv2l5IX20LILR6/x/8R9SqdGeEFBcdswvowgPlhdT/RjudwqC1HyCrp3LtNOOM11OdPbMl7tqOnbZOXm6HdPiLi1hyE8tN4jzkf7WtKHUK2Xf9uY00mDQNbGcV+0Dr66eu//b9CQzoMpV2HNyEEgeRZexf/gkartiPPDWYtf0xo0jIQ78K9FecmJf0kucs4J2JK89C2+CI1eAflUXuzHjOo8LRD/Grd6HDRRXVYXvkbtFVdZIVOPUxdLJrtllIM/6za5SMaATdILBJSSEiJy3cO3gGJcNdHsxhD+BV7X1j1vApn4fsT5mmgfUwHfGzYgrlcFzU+CGtwFFlYWe599lA
X-GND-State: clean

When element_end() processes </attribute>, it frees ctx_data->stack_head
and clears the stack even if parsing is still nested inside a parent
container.

If a crafted ServiceRecord places a nested <attribute> inside <sequence>,
a later sibling scalar element such as <uint64> can become the new stack
head. When the closing </sequence> is then processed, compute_seq_size()
is reached without first validating that the current node is actually
a sequence.

sdp_data_t.val stores both scalar members such as uint64 and the
dataseq pointer in the same union. As a result, attacker-controlled
scalar data can be reinterpreted as a linked-list pointer and traversed
until bluetoothd crashes.

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Reported-by: Aisle Research
Co-authored-by: Aisle Research
---
 src/sdp-xml.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index e5b30e88505f..c8f9ed013b29 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -529,7 +529,9 @@ static void element_end(GMarkupParseContext *context,
 		return;
 
 	if (!strcmp(element_name, "attribute")) {
-		if (ctx_data->stack_head && ctx_data->stack_head->data) {
+		/* Attributes are expected at top-level record scope. */
+		if (ctx_data->stack_head && ctx_data->stack_head->data &&
+		    ctx_data->stack_head->next == NULL) {
 			int ret = sdp_attr_add(ctx_data->record, ctx_data->attr_id,
 							ctx_data->stack_head->data);
 			if (ret == -1)
@@ -539,6 +541,11 @@ static void element_end(GMarkupParseContext *context,
 			ctx_data->stack_head->data = NULL;
 			sdp_xml_data_free(ctx_data->stack_head);
 			ctx_data->stack_head = NULL;
+		} else if (ctx_data->stack_head && ctx_data->stack_head->next) {
+			g_set_error(err, G_MARKUP_ERROR,
+				    G_MARKUP_ERROR_INVALID_CONTENT,
+				    "Nested <attribute> is invalid");
+			return;
 		} else {
 			DBG("No data for attribute 0x%04x", ctx_data->attr_id);
 		}
@@ -558,6 +565,13 @@ static void element_end(GMarkupParseContext *context,
 	}
 
 	if (!strcmp(element_name, "sequence")) {
+		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR,
+				    G_MARKUP_ERROR_INVALID_CONTENT,
+				    "Mismatched </sequence> close");
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
@@ -570,6 +584,13 @@ static void element_end(GMarkupParseContext *context,
 			ctx_data->stack_head->data->unitSize += sizeof(uint8_t);
 		}
 	} else if (!strcmp(element_name, "alternate")) {
+		if (!SDP_IS_ALT(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR,
+				    G_MARKUP_ERROR_INVALID_CONTENT,
+				    "Mismatched </alternate> close");
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
-- 
2.55.0

