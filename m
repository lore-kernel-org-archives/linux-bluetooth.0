Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624519CC28
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808480; cv=none; b=e9PwHc8wMKCL9+a6dssclOvlAQKkx4qzXlsLTosohzkIJ2Dg2JPyAZjpvFaBMYUZ7lFTsL9AyQKEt6AYnd96Sdiw/I2YeEkxumQCqhoGzW6ErY0KIYXuvxrEHEr2GbmbWUhq/Lr53Oc+IJqzDKGm8p9zJxC3JpatMYvC801vTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808480; c=relaxed/simple;
	bh=8Cz7IfkbZhtPy56zZ2Vor1dyNvN6ZGAa5R5AOTnMYi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3RQbT5SvgMeEFlSh224Jxvu1urANIj+1ZfkdFDCnOo4ePBZzv+4SCC6JVpV2nroQ8NiTXGoNcAtJz5CYB2b0jpZKoEj/FafqInXUrD1Y1kWYJ7kquCU++1H8zN8OoNP8qyuA0MmUNyMR44PVVmkyZEWxPToZQlOrzhgaUnyzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckWgAbZJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckWgAbZJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403e4c82ddso29260985ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Aug 2025 23:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754808478; x=1755413278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8XOeq6Sdfijbk/5iaot8H48yVLwNZvAs5iZT7p6AYI=;
        b=ckWgAbZJnqxZbvyjLqgrcneicRLeAikOnb1dz8eHnfBrtBRPK/wYdxSHY9w88Pe6+b
         w4qlOmDZ/bXY/h2bbOmUkKAT+TapVDKB8BvmNF9K19agZPmngwkoQsg+snlM9LuXtVXw
         cdhfmRXShu0880ZArSvDiGyv5WXPrRTvMeGXvyXWKiOYSC216a7LsNyK4mFrzfDvgFOA
         cybI4PU4QUHRcwbSdImkM4lpiLZkkMgdrJLx4LrtSS1lnqjFJfNLV6vCJ0KnfqRDOaa+
         vaKvdzmyHki6xthrcOnzXtnzFdrDaoTQII5HoLxCK80TJNiPz736idGxXOAwwIKzEDhX
         NFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754808478; x=1755413278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8XOeq6Sdfijbk/5iaot8H48yVLwNZvAs5iZT7p6AYI=;
        b=mqz+SWnEhI4uqkllJTs0P+3wdjtAbQqsHJAT7kXhlksOpG2Zrn4fODM71+5zjFA2gn
         O64rRruSY7zelqk2TLF0DYGaHG+WxY9mAw1DyIFxuoB/KQRMESm2yRXuKgt74hC8GmJy
         67yxeBPzoJqdvWbqgUbcvul6Mny7n8yPfjzWqY6bZNGviMGa0Fm/txWnhmNSXhgDy820
         tK4jEDrcRHtAA3hjGoxzfkaMBVk1V0EEQaTlQtpeRul5n4gCH8Vor87ize7naTSfIioi
         XX9FAmBGr/Yfg8J8eC88InQmYTMGzShLLW+TBQMDGn0g1CPMoWzk6g5fjucO6PHJJpLK
         ecoQ==
X-Gm-Message-State: AOJu0Yy8jplw86wJ7+lnxHlcAsEcx+7wVHIki8AjuF1QOYb2BZCi0tjB
	8zL485VP/qw/cdBHYBrEcBldSVERsNsAEfp+MLoig0XF/IctuSnO9BMP90JRcj4vbpOH2ZOUa6I
	/IlJ4GUKyK9INmFtbrSCmdhMZfw6s/4CABospxnA3dkUsT49tGAWyfznUi8PeXEcx3LU3HnBh23
	1Dyr8T8R6k7lc3zKZ9RyPpWCRHoYxGNIB2i6yaDORLZ5WsR4Bq
X-Google-Smtp-Source: AGHT+IHw+RBQcPAe3Hh57EscOf+JWuXRwCMgNEEvKj2LUNbRkvLtagl/shPIj+8TC9WAnUQ/9PTPhzzdScE=
X-Received: from plxd15.prod.google.com ([2002:a17:902:ef0f:b0:234:bca4:b7b3])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2b:b0:23c:7b9e:163e
 with SMTP id d9443c01a7336-242c1ff40camr122697325ad.11.1754808478270; Sat, 09
 Aug 2025 23:47:58 -0700 (PDT)
Date: Sun, 10 Aug 2025 06:46:58 +0000
In-Reply-To: <20250810064656.1810093-2-ochang@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810064656.1810093-2-ochang@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250810064656.1810093-4-ochang@google.com>
Subject: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in `compute_seq_size`.
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

By adding checks for sequence/alternate types in element_end to avoid a
type confusion.

This issue was found by OSS-Fuzz.

This can be triggered by using an input of
`<sequence><foo/><text/></sequence>` against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152
---
 src/sdp-xml.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 5efa62ab8..81bd11140 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -545,6 +545,13 @@ static void element_end(GMarkupParseContext *context,
 	}
 
 	if (!strcmp(element_name, "sequence")) {
+		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+					"Unexpected data type %d for sequence",
+					ctx_data->stack_head->data->dtd);
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
@@ -557,6 +564,13 @@ static void element_end(GMarkupParseContext *context,
 			ctx_data->stack_head->data->unitSize += sizeof(uint8_t);
 		}
 	} else if (!strcmp(element_name, "alternate")) {
+		if (!SDP_IS_ALT(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+					"Unexpected data type %d for alternate",
+					ctx_data->stack_head->data->dtd);
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
-- 
2.50.1.703.g449372360f-goog

