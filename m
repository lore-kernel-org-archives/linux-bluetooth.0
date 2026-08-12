Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D73C4563
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521869; cv=none; b=M51lQ+zf5ePPhG2nDIBJMzAO13z78pCyhlC5Qcae/YQ1A+U/szZs54mehTStZ5W9rGZepeLaBARu9Rzzdz4eDlliB6L0ofOIB8pDXq1RpXuksQg8M3NchGd+vLXxR61cpeXQRF0znzCIgkuCan3hC0Kcq6xzUMnCXx9Gf/lpsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521869; c=relaxed/simple;
	bh=Pm0aNAEsxtywCRvoTuVN9Gp0mNnWLBvqPzL9z+oh6R8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsGfvbjwU6goJBYvaPE/HZ4qoeqElCoj2oFJWEWtGbH6ZXKtKP534WVXuhOcHpzbVUMW957x2nl/jW0GmLuW/LtomiDrZu49PXPkWXPdzgFPqv9fqCDDMoym5XXpVVG9i1JbOTRyMnW9CsSr9DVneelI4Mlkcf8fyObso25n8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BEA03EE61
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML
Date: Wed, 12 Aug 2026 10:01:33 +0200
Message-ID: <20260812080410.2116906-3-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEATMgZESnXpnF9odixN+j9pjFJQtDJ1lOhKFVo5Z/nUe0V4kv8/975cH/jEC+64/687m2yeqptp72V8V+Fn9K7g/HOIo1s/A9vRcgAydT3FnC79LRZiaW2AsRMtWp8LHcLMk8RcFDZX+r73gvBiN0XAE69n/K+cGPfKTwfhuW4u+6P6l14AuHgA/JCsdUHL9YAy7vZyMQgTf4Y9kDKFjf6ZpkPzEK1NNr+QOxeLPriprXbk5OoT4J/7DzuhFaA2uT7ogxycD/0WB/G3uqVtCR3ahE9Xg872i09EVeEPn7oX7BCDVBYVDLUT70+1UfOo+2x9MExJKd0WKIq1ANYXqkchXCiSyaIMyuOaYfPzXF4fBu4mJ+cNrIGzmRN/osd9v1c93fnq2i0/cJrXfAcbBo9sG7XFRN+lDO2ZLxAuQSPUlw/wH5oMzguZVU3TOFkfJtbb5l6PgT4Pdt21Esw0h0Z0Qv1lbY+d+ZKix7W5d5+izUY22FeTHDUP9B1e+J8174iuXHyFyqMqQsWoCHMGZOXUz+4hykjynOYU6PseSFbTch8Bhd9Gw+aEa1Fgpoyc+m4ivHME+eNttOGQYWbvwEUuYuktor/AX4YdgbT27oRY/Mk+CUSMEQ43mxuEC1evTpPfT4vUUukIrYm4llP/2sUAnSioXJ89Qtunc/SQ6Ohcg
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

