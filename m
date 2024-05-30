Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539D17C200
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081264; cv=none; b=ay4IC00q7HGeMK1SShx7tTmaRKU159hbQcaONKZs/JG6opxMoadwHswOHO+S4QLxH5SIRdo6S+zR99gX/YYhLFBhtdrtfZssRLOJkrU2sTsQQ5o4vFuITdrB2pSlf5jftL9+p33kUPq16NHE8QQjS7mRknbAz3LgdoFopKZvgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081264; c=relaxed/simple;
	bh=3Z9StN4Y3GsmIVNcVnqzHhyrNqb0jq50SknvFIp5NRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW4NZwGVpNDFVZjYOa4NtfxLionYZTcd5jvwCmrPb70QYihFPj4rOPAcBKzaHwr2g4/yzpKsRyrq6/o8Saa0/AvA3iZmzR4R0VkNNe2WNfzdLqtBfNFaUW4F6XGfEV8KZmY8czcbmKKSaj4Z43e0ftSgu1qtpndG3kG3UL/gKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63A4120013;
	Thu, 30 May 2024 15:00:59 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 6/9] sdp: Fix ineffective error guard
Date: Thu, 30 May 2024 16:58:00 +0200
Message-ID: <20240530150057.444585-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

The return value from gen_attridseq_pdu() can be -ENOMEM or the always
positive return value from sdp_gen_pdu(), but we only guard against a
single negative return value "-1" (-EPERM).

Check for all negative values to avoid manipulating a negative length as
a valid one.

Error: INTEGER_OVERFLOW (CWE-190): [#def10] [important]
bluez-5.76/lib/sdp.c:4082:2: tainted_data_return: Called function "gen_attridseq_pdu(pdata, attrid_list, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))", and a possible return value is known to be less than zero.
bluez-5.76/lib/sdp.c:4082:2: assign: Assigning: "seqlen" = "gen_attridseq_pdu(pdata, attrid_list, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))".
bluez-5.76/lib/sdp.c:4091:2: overflow: The expression "t->reqsize" is considered to have possibly overflowed.
bluez-5.76/lib/sdp.c:4097:2: overflow: The expression "t->reqsize + cstate_len" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.76/lib/sdp.c:4097:2: overflow_sink: "t->reqsize + cstate_len", which might have underflowed, is passed to "sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len)".
4095|		reqhdr->plen = htons((t->reqsize + cstate_len) - sizeof(sdp_pdu_hdr_t));
4096|
4097|->		if (sdp_send_req(session, t->reqbuf, t->reqsize + cstate_len) < 0) {
4098|			SDPERR("Error sending data:%m");
4099|			t->err = errno;

Error: INTEGER_OVERFLOW (CWE-190): [#def11] [important]
bluez-5.76/lib/sdp.c:4466:2: tainted_data_return: Called function "gen_attridseq_pdu(pdata, attrids, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))", and a possible return value is known to be less than zero.
bluez-5.76/lib/sdp.c:4466:2: assign: Assigning: "seqlen" = "gen_attridseq_pdu(pdata, attrids, ((reqtype == SDP_ATTR_REQ_INDIVIDUAL) ? 9 : 10))".
bluez-5.76/lib/sdp.c:4475:2: overflow: The expression "reqsize" is considered to have possibly overflowed.
bluez-5.76/lib/sdp.c:4480:2: assign: Assigning: "_reqsize" = "reqsize".
bluez-5.76/lib/sdp.c:4486:3: overflow: The expression "_reqsize + copy_cstate(_pdata, 2048U - _reqsize, cstate)" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.76/lib/sdp.c:4486:3: assign: Assigning: "reqsize" = "_reqsize + copy_cstate(_pdata, 2048U - _reqsize, cstate)".
bluez-5.76/lib/sdp.c:4492:3: overflow_sink: "reqsize", which might have underflowed, is passed to "sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize)".
4490|			reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
4491|			rsphdr = (sdp_pdu_hdr_t *) rspbuf;
4492|->			status = sdp_send_req_w4_rsp(session, reqbuf, rspbuf, reqsize, &rspsize);
4493|			if (rspsize < sizeof(sdp_pdu_hdr_t)) {
4494|				SDPERR("Unexpected end of packet");
---
 lib/sdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index d43bbbd2de05..2e66505b21b8 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3604,7 +3604,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrids,
 		reqtype == SDP_ATTR_REQ_INDIVIDUAL? SDP_UINT16 : SDP_UINT32);
-	if (seqlen == -1) {
+	if (seqlen < 0) {
 		errno = EINVAL;
 		goto end;
 	}
@@ -3959,7 +3959,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrid_list,
 			reqtype == SDP_ATTR_REQ_INDIVIDUAL? SDP_UINT16 : SDP_UINT32);
-	if (seqlen == -1) {
+	if (seqlen < 0) {
 		t->err = EINVAL;
 		goto end;
 	}
@@ -4081,7 +4081,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrid_list,
 			reqtype == SDP_ATTR_REQ_INDIVIDUAL ? SDP_UINT16 : SDP_UINT32);
-	if (seqlen == -1) {
+	if (seqlen < 0) {
 		t->err = EINVAL;
 		goto end;
 	}
@@ -4465,7 +4465,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrids,
 		reqtype == SDP_ATTR_REQ_INDIVIDUAL ? SDP_UINT16 : SDP_UINT32);
-	if (seqlen == -1) {
+	if (seqlen < 0) {
 		errno = EINVAL;
 		status = -1;
 		goto end;
-- 
2.45.1

