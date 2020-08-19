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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA7C433E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010AC207BB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBV6XUGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHSACS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHSACR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 20:02:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD5C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x6so10488986pgx.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z0dKBvUf9vGWL9gen29+YT/xiceR0mKKGHWkGGIRMKc=;
        b=aBV6XUGvXUFLEk0bOeNbgB+C6V9BCQjb1wytJmtfiOZlzs93puXKjR8BK5a2LeWJ0v
         Z/qu8EzSmqu2HBqozRlGMR0sj10W0YeFTYe+QLfIrAsJZ2uE3rEkSnFE7HQA7uhKkve8
         7TbloMMyemuFbNti8UXx1CRIEvLBZF9LQXsgCtdiqKBCVbfR/7UWKNnyb0JefwsZWqbQ
         a197DbMBJwRdGI8ex3nqolddUGz+rBO6c3irliqfNklOrkqcXORExpCit+KGTRheslnB
         gfy655KHOv63BX7zOxp5rvYVKNKtl64MmDbetpx2FOsa3mLnUBIIVLi+x1/7frgOE576
         0FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0dKBvUf9vGWL9gen29+YT/xiceR0mKKGHWkGGIRMKc=;
        b=XSwKXbl5zV/K7G7Flp4QyL3TKa7KiY+Ocg9VLGBLWwa+h+PynwjZ8zmCvr/poAUvld
         fY3zQ+mM0Z8zgOdfK183jIiR758pQiiUeMPhNOrILUncmepga5MQ1tuJ0Sagajvnluix
         s4rBo+On/WWP3lOh4oPiXz6PctxzpGvzY7B+O/7V4VYrp0wUl0q9uK3/lgX/06SYglR5
         gU69r+cLg5Qe0q8SesxlFf+UJjVxPr4QbQ0K2/yTR/Uw22eBbzmdZXcQqWwR3yYurB4L
         pAJF0XQpAfC6sglLjK063lzMeAXZK/mzvJ0T0mHi91xfROFXRMXKn2zSMfqdXPQm3Z5k
         ZRRA==
X-Gm-Message-State: AOAM531ALCrLso5ifcaG1nmSKAOPXTi9TQCdIJ3CGD5d/btQQAr4hPYi
        7W2xVqSxQNbgZxk1JKOfB7J6zvWu/lA=
X-Google-Smtp-Source: ABdhPJwFna7JKUeYZqTtXCi9ZNN3Tm//jGDR6lnX5jzqZGPuFwbs1JBwBVa/GMX6sdod8VjiGpu/BA==
X-Received: by 2002:a05:6a00:78e:: with SMTP id g14mr16805555pfu.171.1597795334713;
        Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d80sm25957673pfd.22.2020.08.18.17.02.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] sbc/sbc_primitives_sse: Optimize sbc_analyze_8s
Date:   Tue, 18 Aug 2020 17:02:12 -0700
Message-Id: <20200819000212.211485-3-luiz.dentz@gmail.com>
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

$ time src/sbcenc_mmx -s 8 sin_64m.au > /dev/null
real    0m1.064s
user    0m1.012s
sys     0m0.049s

===  After ====

$ time src/sbcenc -s 8 sin_64m.au > /dev/null
real    0m1.032s
user    0m0.996s
sys     0m0.033s
---
 sbc/sbc_primitives_sse.c | 109 ++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

diff --git a/sbc/sbc_primitives_sse.c b/sbc/sbc_primitives_sse.c
index 2a903e1..9bff6cf 100644
--- a/sbc/sbc_primitives_sse.c
+++ b/sbc/sbc_primitives_sse.c
@@ -96,80 +96,59 @@ static inline void sbc_analyze_four_sse(const int16_t *in, int32_t *out,
 static inline void sbc_analyze_eight_sse(const int16_t *in, int32_t *out,
 							const FIXED_T *consts)
 {
-	static const SBC_ALIGNED int32_t round_c[2] = {
+	static const SBC_ALIGNED int32_t round_c[4] = {
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
 		1 << (SBC_PROTO_FIXED8_SCALE - 1),
 		1 << (SBC_PROTO_FIXED8_SCALE - 1),
 	};
 	__asm__ volatile (
-		"movq        (%0), %%mm0\n"
-		"movq       8(%0), %%mm1\n"
-		"movq      16(%0), %%mm2\n"
-		"movq      24(%0), %%mm3\n"
-		"pmaddwd     (%1), %%mm0\n"
-		"pmaddwd    8(%1), %%mm1\n"
-		"pmaddwd   16(%1), %%mm2\n"
-		"pmaddwd   24(%1), %%mm3\n"
-		"paddd       (%2), %%mm0\n"
-		"paddd       (%2), %%mm1\n"
-		"paddd       (%2), %%mm2\n"
-		"paddd       (%2), %%mm3\n"
+		"movdqu      (%0), %%xmm0\n"
+		"movdqu    16(%0), %%xmm1\n"
+		"pmaddwd     (%1), %%xmm0\n"
+		"pmaddwd   16(%1), %%xmm1\n"
+		"paddd       (%2), %%xmm0\n"
+		"paddd       (%2), %%xmm1\n"
 		"\n"
-		"movq      32(%0), %%mm4\n"
-		"movq      40(%0), %%mm5\n"
-		"movq      48(%0), %%mm6\n"
-		"movq      56(%0), %%mm7\n"
-		"pmaddwd   32(%1), %%mm4\n"
-		"pmaddwd   40(%1), %%mm5\n"
-		"pmaddwd   48(%1), %%mm6\n"
-		"pmaddwd   56(%1), %%mm7\n"
-		"paddd      %%mm4, %%mm0\n"
-		"paddd      %%mm5, %%mm1\n"
-		"paddd      %%mm6, %%mm2\n"
-		"paddd      %%mm7, %%mm3\n"
+		"movdqu    32(%0), %%xmm2\n"
+		"movdqu    48(%0), %%xmm3\n"
+		"pmaddwd   32(%1), %%xmm2\n"
+		"pmaddwd   48(%1), %%xmm3\n"
+		"paddd     %%xmm2, %%xmm0\n"
+		"paddd     %%xmm3, %%xmm1\n"
 		"\n"
-		"movq      64(%0), %%mm4\n"
-		"movq      72(%0), %%mm5\n"
-		"movq      80(%0), %%mm6\n"
-		"movq      88(%0), %%mm7\n"
-		"pmaddwd   64(%1), %%mm4\n"
-		"pmaddwd   72(%1), %%mm5\n"
-		"pmaddwd   80(%1), %%mm6\n"
-		"pmaddwd   88(%1), %%mm7\n"
-		"paddd      %%mm4, %%mm0\n"
-		"paddd      %%mm5, %%mm1\n"
-		"paddd      %%mm6, %%mm2\n"
-		"paddd      %%mm7, %%mm3\n"
+		"movdqu    64(%0), %%xmm2\n"
+		"movdqu    80(%0), %%xmm3\n"
+		"pmaddwd   64(%1), %%xmm2\n"
+		"pmaddwd   80(%1), %%xmm3\n"
+		"paddd     %%xmm2, %%xmm0\n"
+		"paddd     %%xmm3, %%xmm1\n"
 		"\n"
-		"movq      96(%0), %%mm4\n"
-		"movq     104(%0), %%mm5\n"
-		"movq     112(%0), %%mm6\n"
-		"movq     120(%0), %%mm7\n"
-		"pmaddwd   96(%1), %%mm4\n"
-		"pmaddwd  104(%1), %%mm5\n"
-		"pmaddwd  112(%1), %%mm6\n"
-		"pmaddwd  120(%1), %%mm7\n"
-		"paddd      %%mm4, %%mm0\n"
-		"paddd      %%mm5, %%mm1\n"
-		"paddd      %%mm6, %%mm2\n"
-		"paddd      %%mm7, %%mm3\n"
+		"movdqu    96(%0), %%xmm2\n"
+		"movdqu   112(%0), %%xmm3\n"
+		"pmaddwd   96(%1), %%xmm2\n"
+		"pmaddwd  112(%1), %%xmm3\n"
+		"paddd     %%xmm2, %%xmm0\n"
+		"paddd     %%xmm3, %%xmm1\n"
 		"\n"
-		"movq     128(%0), %%mm4\n"
-		"movq     136(%0), %%mm5\n"
-		"movq     144(%0), %%mm6\n"
-		"movq     152(%0), %%mm7\n"
-		"pmaddwd  128(%1), %%mm4\n"
-		"pmaddwd  136(%1), %%mm5\n"
-		"pmaddwd  144(%1), %%mm6\n"
-		"pmaddwd  152(%1), %%mm7\n"
-		"paddd      %%mm4, %%mm0\n"
-		"paddd      %%mm5, %%mm1\n"
-		"paddd      %%mm6, %%mm2\n"
-		"paddd      %%mm7, %%mm3\n"
+		"movdqu    128(%0), %%xmm2\n"
+		"movdqu    144(%0), %%xmm3\n"
+		"pmaddwd   128(%1), %%xmm2\n"
+		"pmaddwd   144(%1), %%xmm3\n"
+		"paddd      %%xmm2, %%xmm0\n"
+		"paddd      %%xmm3, %%xmm1\n"
+		"\n"
+		"psrad         %4, %%xmm0\n"
+		"psrad         %4, %%xmm1\n"
 		"\n"
-		"psrad         %4, %%mm0\n"
-		"psrad         %4, %%mm1\n"
-		"psrad         %4, %%mm2\n"
-		"psrad         %4, %%mm3\n"
+		"movdqa     %%xmm0, %%xmm2\n"
+		"movdqa     %%xmm1, %%xmm3\n"
+		"punpckhqdq %%xmm2, %%xmm2\n"
+		"punpckhqdq %%xmm3, %%xmm3\n"
+		"movdq2q    %%xmm0, %%mm0\n"
+		"movdq2q    %%xmm2, %%mm1\n"
+		"movdq2q    %%xmm1, %%mm2\n"
+		"movdq2q    %%xmm3, %%mm3\n"
 		"\n"
 		"packssdw   %%mm0, %%mm0\n"
 		"packssdw   %%mm1, %%mm1\n"
-- 
2.26.2

