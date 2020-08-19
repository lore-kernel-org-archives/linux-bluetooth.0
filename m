Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B000C433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEA8207FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgWMc0GF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHSACQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHSACP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 20:02:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB9C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x25so10765598pff.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uSA0Ybo7FyRxzr9ClbGhKtFYud7d1Je4lZohhQzo/UQ=;
        b=rgWMc0GFFP67vj1Er+uBtgmm8BCRFksV5lkiVAqUZFa0jYwCT3u02NWmnXey/rjiS4
         mAD1ALPXcraVBpDRtuXEalMRBgcBz212xosKO1M2JX/siZ6dfY+uHwEUIWwYsdZzlyIg
         ZYyJyLM1dDkiBVPJEn5DV2ky14NPKs1jrHdfqU+4m7s9ZVqAZhLraUN9WYWto5Pa1YmK
         UQTU5tyijc6R2Xe4dwxmCuDcgExfUkyN2Qt3sZCDMBB5VaX7DpPxnqMgo+Yj2X1c/eu2
         10lOmEkmAZkGvG99aMDPEqKfjSUV35VE/PWAlkQ38Qk0Kt0HvaIu5yj7AhYyoTPzeQQB
         6ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSA0Ybo7FyRxzr9ClbGhKtFYud7d1Je4lZohhQzo/UQ=;
        b=m1F/0h3IFSrky/YUyjpcl+hjliLcXPuitmGW9yb0jWEjCF3mZcsGPBEoTmnaIs/m04
         MUeC4P9hhBi1amT19NwibNbHmf6fhs6P/0OocZr6VcyHhabrqc9kqpclXzga9rXqmRfl
         i+xPuya10+nFEEg1K6O0snAKBE7zWkGlY0JZv84KsXRASM4AK8TfN7dkJSJEHUuXmQ2y
         UAv9UU/hvUueacmWkpsj9vWD02tAkkyJWG6gvRAsGby6Oi9HWFZ+qMXsYPLE2LimasZv
         Z4CFte4lLbX/rXscfegyS8TwGcy2b4ypw30hTr+O4qtR+bl1CdA8QJHtAho7+dSDnTRF
         VcqQ==
X-Gm-Message-State: AOAM533xpSx3XOvS1S/f3Zaqq8dEPxNBE99sPbwxOqyU97+TrnpY52Th
        /Dz1XkLYS3Ou9PdAklR3kwui3kiUABg=
X-Google-Smtp-Source: ABdhPJyRwLIfLZqQFQe8RGLC/Vlrqb1fALSCzl9JYxTO/F5zL/YK2OqPuK1RoxWBpxp3ad1p8g7pyw==
X-Received: by 2002:a62:1dc3:: with SMTP id d186mr17270021pfd.93.1597795333812;
        Tue, 18 Aug 2020 17:02:13 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d80sm25957673pfd.22.2020.08.18.17.02.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 17:02:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] sbc/sbc_primitives_sse: Optimize sbc_analyze_4s
Date:   Tue, 18 Aug 2020 17:02:11 -0700
Message-Id: <20200819000212.211485-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819000212.211485-1-luiz.dentz@gmail.com>
References: <20200819000212.211485-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use 128 bit XMM registers whenever possible.

$ time src/sbcenc_mmx -s 4 sin_4m.au > /dev/null
real    0m1.073s
user    0m1.039s
sys     0m0.030s

===  After ====

$ time src/sbcenc -s 4 sin_4m.au > /dev/null
real    0m1.049s
user    0m1.000s
sys     0m0.047s
---
 sbc/sbc_primitives_sse.c | 58 +++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/sbc/sbc_primitives_sse.c b/sbc/sbc_primitives_sse.c
index 42cdb03..2a903e1 100644
--- a/sbc/sbc_primitives_sse.c
+++ b/sbc/sbc_primitives_sse.c
@@ -38,48 +38,40 @@
 static inline void sbc_analyze_four_sse(const int16_t *in, int32_t *out,
 					const FIXED_T *consts)
 {
-	static const SBC_ALIGNED int32_t round_c[2] = {
+	static const SBC_ALIGNED int32_t round_c[4] = {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
 		1 << (SBC_PROTO_FIXED4_SCALE - 1),
 		1 << (SBC_PROTO_FIXED4_SCALE - 1),
 	};
 	__asm__ volatile (
-		"movq        (%0), %%mm0\n"
-		"movq       8(%0), %%mm1\n"
-		"pmaddwd     (%1), %%mm0\n"
-		"pmaddwd    8(%1), %%mm1\n"
-		"paddd       (%2), %%mm0\n"
-		"paddd       (%2), %%mm1\n"
+		"movdqu      (%0), %%xmm0\n"
+		"pmaddwd     (%1), %%xmm0\n"
+		"paddd       (%2), %%xmm0\n"
 		"\n"
-		"movq      16(%0), %%mm2\n"
-		"movq      24(%0), %%mm3\n"
-		"pmaddwd   16(%1), %%mm2\n"
-		"pmaddwd   24(%1), %%mm3\n"
-		"paddd      %%mm2, %%mm0\n"
-		"paddd      %%mm3, %%mm1\n"
+		"movdqu    16(%0), %%xmm1\n"
+		"pmaddwd   16(%1), %%xmm1\n"
+		"paddd     %%xmm1, %%xmm0\n"
 		"\n"
-		"movq      32(%0), %%mm2\n"
-		"movq      40(%0), %%mm3\n"
-		"pmaddwd   32(%1), %%mm2\n"
-		"pmaddwd   40(%1), %%mm3\n"
-		"paddd      %%mm2, %%mm0\n"
-		"paddd      %%mm3, %%mm1\n"
+		"movdqu    32(%0), %%xmm1\n"
+		"pmaddwd   32(%1), %%xmm1\n"
+		"paddd     %%xmm1, %%xmm0\n"
 		"\n"
-		"movq      48(%0), %%mm2\n"
-		"movq      56(%0), %%mm3\n"
-		"pmaddwd   48(%1), %%mm2\n"
-		"pmaddwd   56(%1), %%mm3\n"
-		"paddd      %%mm2, %%mm0\n"
-		"paddd      %%mm3, %%mm1\n"
+		"movdqu    48(%0), %%xmm1\n"
+		"pmaddwd   48(%1), %%xmm1\n"
+		"paddd     %%xmm1, %%xmm0\n"
 		"\n"
-		"movq      64(%0), %%mm2\n"
-		"movq      72(%0), %%mm3\n"
-		"pmaddwd   64(%1), %%mm2\n"
-		"pmaddwd   72(%1), %%mm3\n"
-		"paddd      %%mm2, %%mm0\n"
-		"paddd      %%mm3, %%mm1\n"
+		"movdqu    64(%0), %%xmm1\n"
+		"pmaddwd   64(%1), %%xmm1\n"
+		"paddd     %%xmm1, %%xmm0\n"
+		"\n"
+		"psrad         %4, %%xmm0\n"
+		"\n"
+		"movdqa    %%xmm0, %%xmm1\n"
+		"punpckhqdq %%xmm1, %%xmm1\n"
+		"movdq2q   %%xmm0, %%mm0\n"
+		"movdq2q   %%xmm1, %%mm1\n"
 		"\n"
-		"psrad         %4, %%mm0\n"
-		"psrad         %4, %%mm1\n"
 		"packssdw   %%mm0, %%mm0\n"
 		"packssdw   %%mm1, %%mm1\n"
 		"\n"
-- 
2.26.2

