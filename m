Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40E1A6836
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729663; cv=none; b=amrbdsCUgs4E+QENbapLzTm42S1s6NKX7c19+xs6GRC/BZ1ew/sry5Il9tbRXlhoug/oSkH0WiHbSFMlh0sJT8JBMTPQ3nYCwpDKhbfJ2Xs12gxdzfPh206VLwy2W8+59HaGHXSz7yXJ63tNmnZM5raj+VjtA04XyToGDO7wUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729663; c=relaxed/simple;
	bh=jF77E+Wzp/nx3cBMfwOuD/Iz2bMC5jvXavEMJQy63AQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iOly6Cx5bKDlohMA/Fj1uZOys858L8EWylNONfJADToTrvDNoW2AawRBjTHX95Cm8DEoIFMtmScUUbspEre5XY3+EQb/pKrwoJLu4pJpdGp+OpapacWBlA3pcjNEdxbZcNPsre/Dez+ZGHoEruZi/RHQ3we/6hkL1GS921LCb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwgXI7fU; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwgXI7fU"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf9466412fso966581e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786729661; x=1787334461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOdn8uH6vUr+RTDhO6/Gm+rtGQKbjeKrJV8Jbf1rsrY=;
        b=IwgXI7fUu1ZGc91r94w189uasnqKgL43tiwX5F5w/6SsRlgRcbfJTFNaniGRERlwD7
         0NlsbqlPVhRFv+Vb8Hp9LihhR+3SZIYhNoYbWV9vw0JmoZCWJ+cd4LF6kpBV16AYDQ2Y
         vLQw2sRe5y+iHQvKaGTxLVNLOAIzKMXLSuxVW5qUQFLWJOB5WQvkS7fSNZ9cFJ/2qHDY
         D/Z6LSJWCx8kvoD4aZ4C8Ppjz1FpolIt4OHmqy1iIoLX2kAFLZscXlTtnAAaVpnvWiQM
         zbB5rKHGBzOLBmeT8s+RwOPcKstXY/VdUCejUnyDFnydLxx962HGAX2u60dnFGlymuM4
         4xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729661; x=1787334461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NOdn8uH6vUr+RTDhO6/Gm+rtGQKbjeKrJV8Jbf1rsrY=;
        b=OV4zE8m0A36sTprpAbOtFmqXOXZRMKbAE727WZePnrHqGmCrGIZVYFsaC45snh1ySO
         uJEOm9kmSztxOQHV+5E0ss8iWZsu0JZQNr4fVplayJ71WnwI82VP0YluP1IJ6z0/aBIz
         5806wQEW38CPKPM/N5BDpRzgNV9+m+4uoAASo56qpvHjPP768469gNHWGYZjbfao6OGu
         XUepUeJ5E4nyzIVwP40F4O3x9i80hzNAT70th2dUFWnUgdPn5zKUNkWrb2PdyE/UTEx8
         /E+LgyPnZfmqef7+3WOyfQHjqFPU1x6gAltwvf8UGZXsah9UGLzTTL2nGze1Lk1OA2Tm
         tIIQ==
X-Gm-Message-State: AOJu0YxHypnsEvLpz870+zdI/5lMPydBrMrv4alDrdoAllrwl5kxlz/c
	V/erZlpe7ofgIsDh77/p90kD0tIk9DwDHw1U9obFgZth1lwPegKuP50Ya45Klwy9
X-Gm-Gg: AR+sD10sPU2PaC5tX5ryO1QX3T+BA3huMVZT4W13DOgxpQdD3NR1Ya+0IXhrjYSss6I
	hvRGmbJoMHIEX65wu155NfpHfftQITOHBp0ZKVg/UYBj9aviok1L4L3y7NBJneADKnXf95gvtfS
	8o61vO3E+c4iiu9XDnAKl81UOsT9CzvpTbuamot+e1amm/92xVuRCowtfbyLt8uubWQlmObFLpC
	3H5btvSreMEXRHCcj1ZQF9L9+fuC9rNDqotnL4rs7bUjGhIogYwnCMUeYCsejNJZp/G7LntU5Da
	dMw4C9a6AyBFdd9+5kAbSJ69YIaXVwxD8ARWlF6LItJIjmDCrOF76XDdz/1tm1GSEM/EHe02YW5
	meYxjFx3/2w2yV5S7UuJIBP0r03nHePPYuCjpE7fiKfkJHHDoE5d68OYeisuRnE82fzuZzv2xH8
	UCHbDFJJdnoN/f2mNsBUtt1d5Ar0PZIMJBzsCnV4L7gbXEaf2It1Lc61aAaj1/wFsbMxBb0Ohyl
	F5EHEh3eI05Df7eAoC5/iokmSto4AOKWF4Wf3IqApW+7WdEZX2IPTY=
X-Received: by 2002:a05:6122:6091:b0:5c2:cffc:2c55 with SMTP id 71dfb90a1353d-5c59178bfc2mr1803403e0c.0.1786729661179;
        Fri, 14 Aug 2026 10:47:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c59472656csm1158387e0c.5.2026.08.14.10.47.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:47:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] sdp-xml: Fix leaking the parse stack on malformed input
Date: Fri, 14 Aug 2026 13:47:29 -0400
Message-ID: <20260814174731.1441738-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sdp_xml_parse_record() frees its context but never the elements left on
ctx_data->stack_head.

element_end() returns early without popping the stack when it rejects a
document, for instance on a mismatched </sequence> close, so a malformed
record leaves its elements behind and they are never freed.

Free the remaining stack elements before returning. Found with the
compute-seq-size-type-confusion.xml test:

56 (direct) + 1,072 (indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_xml_data_alloc (sdp-xml.c:73)
   by element_start (sdp-xml.c:473)
   by g_markup_parse_context_parse (gmarkup.c:1369)
   by sdp_xml_parse_record (sdp-xml.c:696)

Assisted-by: Claude:claude-opus-5
---
 src/sdp-xml.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index bad9e289344f..bcd5785f87ca 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -551,6 +551,17 @@ static void sdp_xml_data_free(struct sdp_xml_data *elem)
 	free(elem);
 }
 
+/* Free the elements left on the stack, e.g. by a document that is malformed */
+static void sdp_xml_data_free_stack(struct sdp_xml_data *elem)
+{
+	while (elem) {
+		struct sdp_xml_data *next = elem->next;
+
+		sdp_xml_data_free(elem);
+		elem = next;
+	}
+}
+
 static void element_end(GMarkupParseContext *context,
 		const char *element_name, gpointer user_data, GError **err)
 {
@@ -696,6 +707,7 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
 		error("XML parsing error");
 		g_markup_parse_context_free(ctx);
+		sdp_xml_data_free_stack(ctx_data->stack_head);
 		sdp_record_free(record);
 		free(ctx_data);
 		return NULL;
@@ -703,6 +715,8 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 
 	g_markup_parse_context_free(ctx);
 
+	sdp_xml_data_free_stack(ctx_data->stack_head);
+
 	free(ctx_data);
 
 	return record;
-- 
2.54.0

