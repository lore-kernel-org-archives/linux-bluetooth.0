Return-Path: <SRS0=ihQD=NM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52578C0044C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0EA20820
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTbUHDwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0EA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeKAXU5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32971 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeKAXU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id f1-v6so16689539edi.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Nov 2018 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kn0EF76sLr7muD1IaxNy9U4oQeCVpwKvaTvWZFZ4suQ=;
        b=eTbUHDwlMUXjnSjhIrLYLtNnqpmsZML4+WiWlWcqhvGKYjJ3C3347TKbRhJawBfAWu
         Q+tCgfD7y6M3moIOMgZUhMyCsGTjheXkZxAUV13pWcCojlluiSOQ7UpXdxsfivMUl8Ui
         sdthRfUEZvJY+9+fbSXVtplXizZI2u5oAWjr88bHEoc++4T0eivLT7wiLj/QqgkoSs10
         Ng63XNl/BTuxYdkW4YDFnbo/1d0h4bJbtfAEJJvEXGl5RWZ5pDQygdDPzEq6KvMczfyg
         APowUx8f9QvcjAuQTLAiyww4M61L0CiRkIiYkqPXTWp0f906RGRCqghMxY9S4KjGfOKc
         h6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kn0EF76sLr7muD1IaxNy9U4oQeCVpwKvaTvWZFZ4suQ=;
        b=Cx2l6gc7KzkfrXdEPbzEPXbjj6r8E/qBCv0BCxWYnLTDo26gDF05/oPD9e9DF1rXC1
         8tTrbNrEkX5sbQaXTJdCgtxPE82Ni10EuzUBImSP0cvNlO09k+qp7/fwe/UDzmtHyXIO
         //n2hn8ihq65hvIS6P2IKLJVwmavSBtlSNpkelBNXjy5hHrQQ6/ZvMsdOzPT4tkniy5j
         TwOLwDJVC8dpp/wobTEEVmIHJJMlLCnHO/w7IpAVFxsSngGDStq+Dk9FIKO6oGpCTrlI
         XWZq/JWqjzSd6WTpzGWy1P10KuIoBiPF8wqVfXwTpy4c0x5Yo8EDQZiITOy6s1TVhR+F
         NfXg==
X-Gm-Message-State: AGRZ1gIlKQBtiAwycdF1RlL9mUaE5neAFh0QH8/GWe9NBeYq7F7wiURJ
        qFXRif2sXjxLutW/5Gtt/Oes40qm
X-Google-Smtp-Source: AJdET5fBrUdNrGB4XTOgHkkpk3k92Gy5C6pXxG9JNc8gwnpW+MMuDJ7Yj8JRsYdH6C7KIEx+RKIANg==
X-Received: by 2002:a50:ce5e:: with SMTP id k30-v6mr5051513edj.207.1541081865511;
        Thu, 01 Nov 2018 07:17:45 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id g15-v6sm5452219ejj.67.2018.11.01.07.17.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:17:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] sdp: Fix not checking if cstate length
Date:   Thu,  1 Nov 2018 16:17:39 +0200
Message-Id: <20181101141741.11449-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181101141741.11449-1-luiz.dentz@gmail.com>
References: <20181101141741.11449-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

cstate length should be smaller than cached length otherwise the
request shall be considered invalid as the data is not within the
cached buffer.

An independent security researcher, Julian Rauchberger, has reported
this vulnerability to Beyond Security’s SecuriTeam Secure Disclosure
program.
---
 src/sdpd-request.c | 74 ++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 318d04467..deaed266f 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -70,9 +70,16 @@ static sdp_buf_t *sdp_get_cached_rsp(sdp_cont_state_t *cstate)
 {
 	sdp_cstate_list_t *p;
 
-	for (p = cstates; p; p = p->next)
-		if (p->timestamp == cstate->timestamp)
+	for (p = cstates; p; p = p->next) {
+		/* Check timestamp */
+		if (p->timestamp != cstate->timestamp)
+			continue;
+
+		/* Check if requesting more than available */
+		if (cstate->cStateValue.maxBytesSent < p->buf.data_size)
 			return &p->buf;
+	}
+
 	return 0;
 }
 
@@ -624,6 +631,31 @@ static int extract_attrs(sdp_record_t *rec, sdp_list_t *seq, sdp_buf_t *buf)
 	return 0;
 }
 
+/* Build cstate response */
+static int sdp_cstate_rsp(sdp_cont_state_t *cstate, sdp_buf_t *buf,
+							uint16_t max)
+{
+	/* continuation State exists -> get from cache */
+	sdp_buf_t *cache = sdp_get_cached_rsp(cstate);
+	uint16_t sent;
+
+	if (!cache)
+		return 0;
+
+	sent = MIN(max, cache->data_size - cstate->cStateValue.maxBytesSent);
+	memcpy(buf->data, cache->data + cstate->cStateValue.maxBytesSent, sent);
+	buf->data_size += sent;
+	cstate->cStateValue.maxBytesSent += sent;
+
+	SDPDBG("Response size : %d sending now : %d bytes sent so far : %d",
+		cache->data_size, sent, cstate->cStateValue.maxBytesSent);
+
+	if (cstate->cStateValue.maxBytesSent == cache->data_size)
+		return sdp_set_cstate_pdu(buf, NULL);
+
+	return sdp_set_cstate_pdu(buf, cstate);
+}
+
 /*
  * A request for the attributes of a service record.
  * First check if the service record (specified by
@@ -633,7 +665,6 @@ static int extract_attrs(sdp_record_t *rec, sdp_list_t *seq, sdp_buf_t *buf)
 static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 {
 	sdp_cont_state_t *cstate = NULL;
-	uint8_t *pResponse = NULL;
 	short cstate_size = 0;
 	sdp_list_t *seq = NULL;
 	uint8_t dtd = 0;
@@ -719,24 +750,8 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	buf->buf_size -= sizeof(uint16_t);
 
 	if (cstate) {
-		sdp_buf_t *pCache = sdp_get_cached_rsp(cstate);
-
-		SDPDBG("Obtained cached rsp : %p", pCache);
-
-		if (pCache) {
-			short sent = MIN(max_rsp_size, pCache->data_size - cstate->cStateValue.maxBytesSent);
-			pResponse = pCache->data;
-			memcpy(buf->data, pResponse + cstate->cStateValue.maxBytesSent, sent);
-			buf->data_size += sent;
-			cstate->cStateValue.maxBytesSent += sent;
-
-			SDPDBG("Response size : %d sending now : %d bytes sent so far : %d",
-				pCache->data_size, sent, cstate->cStateValue.maxBytesSent);
-			if (cstate->cStateValue.maxBytesSent == pCache->data_size)
-				cstate_size = sdp_set_cstate_pdu(buf, NULL);
-			else
-				cstate_size = sdp_set_cstate_pdu(buf, cstate);
-		} else {
+		cstate_size = sdp_cstate_rsp(cstate, buf, max_rsp_size);
+		if (!cstate_size) {
 			status = SDP_INVALID_CSTATE;
 			error("NULL cache buffer and non-NULL continuation state");
 		}
@@ -786,7 +801,7 @@ done:
 static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 {
 	int status = 0, plen, totscanned;
-	uint8_t *pdata, *pResponse = NULL;
+	uint8_t *pdata;
 	unsigned int max;
 	int scanned, rsp_count = 0;
 	sdp_list_t *pattern = NULL, *seq = NULL, *svcList;
@@ -915,19 +930,8 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 		} else
 			cstate_size = sdp_set_cstate_pdu(buf, NULL);
 	} else {
-		/* continuation State exists -> get from cache */
-		sdp_buf_t *pCache = sdp_get_cached_rsp(cstate);
-		if (pCache && cstate->cStateValue.maxBytesSent < pCache->data_size) {
-			uint16_t sent = MIN(max, pCache->data_size - cstate->cStateValue.maxBytesSent);
-			pResponse = pCache->data;
-			memcpy(buf->data, pResponse + cstate->cStateValue.maxBytesSent, sent);
-			buf->data_size += sent;
-			cstate->cStateValue.maxBytesSent += sent;
-			if (cstate->cStateValue.maxBytesSent == pCache->data_size)
-				cstate_size = sdp_set_cstate_pdu(buf, NULL);
-			else
-				cstate_size = sdp_set_cstate_pdu(buf, cstate);
-		} else {
+		cstate_size = sdp_cstate_rsp(cstate, buf, max);
+		if (!cstate_size) {
 			status = SDP_INVALID_CSTATE;
 			SDPDBG("Non-null continuation state, but null cache buffer");
 		}
-- 
2.17.2

