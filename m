Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9FCC433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF4620771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGYOIwgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgHKSQ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHKSQ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:16:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A6C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 2so2270013pjx.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZuY+8ttpOiBKxERHjcGAwCRhPfgHFomYRLZ89jgaUJI=;
        b=pGYOIwguiT71kLJwMKFDadxrolB7t7l/kGTIK2b4yFSdlxPgvkMgjf9/DiaFgmR1vT
         KakZFS77e/12pW8u564C9n+GHBN739eYceqxijFGEOJMtZJIYADja5N60VK3Um+oXsnD
         Om4fh393zfvyGHRrn0jHco6XC648XCw2GDFDCUV5YDNpPDdKvG0d/UmOu+1LInYe9d/I
         yJyJkin+1tmKTngljqfNlGT0xVNjSIbMcJ7Thi2p9NpuVnXSM9aD6TQ7zC7pJ0TmN4IX
         shHiR8yfl6rK0ecSN6zG9dhakEkpQ1ZW9roiral2lDG2UvBA7s59aOiDvywuIJ4ymK1T
         7P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuY+8ttpOiBKxERHjcGAwCRhPfgHFomYRLZ89jgaUJI=;
        b=MW2LIUPodYv7IefrBjWKm5T9d+5Ob9gXRHJ4PmEnJvAO6q0CL+o6i6VyH7xX2VywHx
         3zArB370RObge9pV2jOxO/KT0+gRmgMbDPOOho15vhk5oS9UhFKjzpxhk1pNeiJ2tJuf
         konBGUA0ENMsYl692PAXEP5mrklGBVrOwgcFjRYH76WOKnhHmQy4dhWFFtpvjWjnERwq
         eP6o68q1uniqteNFvfFVQCOPWlG6cxBSVR1VIRg+gr84XQTxyUOx3T2MJLtecZOq0whB
         RHnxcxTLyQ5lAFdZVcPZGPuvIZnfcC6okv1vu3l5BaCF5LAiuRu7OtpmKJOkH5eTWhsl
         7Pvg==
X-Gm-Message-State: AOAM530CHBVJo7H0/MZzIFXLX72oiE2klP4LlR4nOti2NaTLsSncG+fj
        oQJKlqVkbxAzL6Njz6XF3Tq8x7Ae
X-Google-Smtp-Source: ABdhPJwZUTeF7RhbZyEQi55oHMef1OMcXh6lE6+MVhSd+UJJAE3rCM6nG0g9VqUusf0ybJjWj6926A==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr2383393pjb.209.1597169786957;
        Tue, 11 Aug 2020 11:16:26 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b22sm27011519pfb.213.2020.08.11.11.16.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:16:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 3/3] sbc/sbc_primitives_sse: Optimize sbc_analyze_8s
Date:   Tue, 11 Aug 2020 11:16:23 -0700
Message-Id: <20200811181623.3683374-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200811181623.3683374-1-luiz.dentz@gmail.com>
References: <20200811181623.3683374-1-luiz.dentz@gmail.com>
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
index 6471bd5..6f8eb49 100644
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

