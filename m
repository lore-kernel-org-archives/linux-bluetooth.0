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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98363C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7CB20771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwS6XEWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKSQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHKSQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:16:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21513C061787
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 74so8033131pfx.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UyGhDQx+Fo5M3xKnhn89uy/B9QHHoarx84rdgC8Xt+M=;
        b=gwS6XEWEeTvDROkJDmbr4xY4Tg27BRumNXRCORqrHqSqoDt5Q0sQr3EVf7uKeAO1P8
         XcUTe7Tlbw7NO9Am9OcBDhUraqonqnm+rXhsGAvkHJJoiqjAr6W1yhlDgSFcXfZ3p36L
         +99t117x4HP4GNgamIs+bOfzpJOHh8/hb1/j4N3uxrDKyU4dvfxwPaVvtd8JE0j1vUmL
         R8nRZ3FRRbQ4ynxArrlfa0C+QSgD1bFg1qW/2unFlvVJD3JI8FQG10lgJhFgf6h8w6zZ
         IEHZBWo3d9boRE52D3Lk70vLXCA+7lsJ7RQfVTmIuG+r96vPTbKd/6mzk+pTii+4E/7H
         oJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UyGhDQx+Fo5M3xKnhn89uy/B9QHHoarx84rdgC8Xt+M=;
        b=XWW7LrPmgQ0P8mqhEF4Gln6dy0D3Y0tcgmpHESyXndHwTCpFpRquQ7YRjkmsIpPVuE
         FFAWriZHVPyyG+Gyy0Wtq9Fav0kWBb+KL4xR/gR57nYZkD6ab1Czr1Wcj2A7CSZsuWzQ
         BQJsRHZvAPGLgW1XqnLECK3jQhHBupyU+M3wJaLBFFRNmVFp+c2Nyv5DcgOzb71GdblP
         K8gvgEdqBS1J6nCkQEZl1Cvq2lDoEuS1BNBj7HEK63vbpYWyvAL+hOvVtPomJXSBJvqe
         WA8AImFXYKLKNJCjoT/AdIeXHAx0fMSWSnBqdvPiema4YB1I3AYI9eVR4qkgLqyVP01f
         qvcQ==
X-Gm-Message-State: AOAM531ShB8wEboKSq/Lge3ATitIfRBZIcHAqjpjTjLxWU0VqyyG9zO9
        6l6cIP8pxeQ2oW7SC9rWGwajnC4d
X-Google-Smtp-Source: ABdhPJy66salRM0DMojhugequGg5gyaD7WO4LX2t4ysUrV20lLsEegLyOGiDOlDYksQZYnNd/i+viA==
X-Received: by 2002:a63:6fc3:: with SMTP id k186mr1864216pgc.109.1597169785295;
        Tue, 11 Aug 2020 11:16:25 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b22sm27011519pfb.213.2020.08.11.11.16.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:16:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 2/3] sbc/sbc_primitives_sse: Optimize sbc_analyze_4s
Date:   Tue, 11 Aug 2020 11:16:22 -0700
Message-Id: <20200811181623.3683374-2-luiz.dentz@gmail.com>
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
index c2b729a..6471bd5 100644
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

