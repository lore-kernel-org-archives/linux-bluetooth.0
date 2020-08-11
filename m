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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA3AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5572076C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh0rUF2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKSQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHKSQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 14:16:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A0C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so7215218plk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AErl5Ugw7OMWv6KhOS8L/zGN7BNkongguRT2IWZuj04=;
        b=lh0rUF2nk897OhG50BJ5e4HTN9HUCmTaA9yrWCgqm8lQI9j9vSuYd9iQdWFIpiGXNt
         FDyObqlu6oeoqI/BHpoCvC+PaFDNQbn3UULND7E3MT4sOIK6ZKAn4OyuFa4p0NOlmeG5
         VR9KhKZ+FxFIGaI6GkTn/tVJ8880fwZyjyIrAs6714ajMQN3CFdkxxbMsp7ELa/uVFkW
         RaIG0gqi8N4m+CIWJ4+ZR12bz9kBphWNDs5bZLsrCAjVZKlzBCo54pHb+xHlOaz/qOsC
         l3f4AExCkoWA9O+XiKAq/OxWsgBB9Vnmfwah2srewD0I1DJoYcUcm3t9Xi48v8tvZTSM
         QmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AErl5Ugw7OMWv6KhOS8L/zGN7BNkongguRT2IWZuj04=;
        b=c9d1JYNZmqlc+nMMWVkxtp0A4CkrVHL0aON17enjyglCnlLo2TGElFDm9hIXwcGCWW
         2Lh+6Kgw9dspsbtOl8JdF4S0OT1PsggN4WPP4HUUpZN6SaBxnDmY5h7ES/eNFy/TjwJG
         lRPsx/cQXSARV7alDidCdZBf1eXBP1YAyWaaLlLGZk14LTEW7DZdLac9QhWuMIfDVhDV
         SV8Y/CkPNJBY4cF9qKJbXmfofqUkQlLk/f5awNoHU7r0fq9ZBXhxjG7J8gJg/qibFKUu
         KY5Mo2ebNOwwKp4rGXvqewlnPvHfDKagNpQDCJV+wVZdcHmdKTzKz25qvA3Ol9WTLH33
         sQ4A==
X-Gm-Message-State: AOAM531CLH4B1ls1WyZFZFiCo1s0+lrMVEm/ke+7OHQ1WbqJyP1qDLVZ
        Yqe7/+VcH0QrDL2mORMFbtCv3qMB
X-Google-Smtp-Source: ABdhPJwR/imoicwYWXXAMCVwjLxAumOFbkTuPwhUVi+x8l5QI61vp1PYIPCyrQng66q7Ol10ixGv9A==
X-Received: by 2002:a17:90a:3ac3:: with SMTP id b61mr2231912pjc.1.1597169784516;
        Tue, 11 Aug 2020 11:16:24 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b22sm27011519pfb.213.2020.08.11.11.16.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:16:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 1/3] sbc: Add initial code for SSE primitives
Date:   Tue, 11 Aug 2020 11:16:21 -0700
Message-Id: <20200811181623.3683374-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am              |   1 +
 sbc/sbc_primitives.c     |  20 ++-
 sbc/sbc_primitives_sse.c | 361 +++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_sse.h |  38 +++++
 4 files changed, 417 insertions(+), 3 deletions(-)
 create mode 100644 sbc/sbc_primitives_sse.c
 create mode 100644 sbc/sbc_primitives_sse.h

diff --git a/Makefile.am b/Makefile.am
index 342043d..7ff0c7d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,6 +14,7 @@ sbc_headers = sbc/sbc.h
 
 sbc_sources = sbc/sbc.c sbc/sbc_private.h sbc/sbc_math.h sbc/sbc_tables.h \
 		sbc/sbc_primitives.h sbc/sbc_primitives.c \
+		sbc/sbc_primitives_sse.h sbc/sbc_primitives_sse.c \
 		sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
 		sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
 		sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index ff343cf..97a75be 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -33,6 +33,7 @@
 #include "sbc_tables.h"
 
 #include "sbc_primitives.h"
+#include "sbc_primitives_sse.h"
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_iwmmxt.h"
 #include "sbc_primitives_neon.h"
@@ -590,6 +591,21 @@ static int sbc_calc_scalefactors_j(
 	return joint;
 }
 
+static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
+{
+	__builtin_cpu_init();
+
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
+	if (__builtin_cpu_supports("mmx"))
+		sbc_init_primitives_mmx(state);
+#endif
+
+#ifdef SBC_BUILD_WITH_SSE_SUPPORT
+	if (__builtin_cpu_supports("sse4.2"))
+		sbc_init_primitives_sse(state);
+#endif
+}
+
 /*
  * Detect CPU features and setup function pointers
  */
@@ -614,9 +630,7 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 	state->implementation_info = "Generic C";
 
 	/* X86/AMD64 optimizations */
-#ifdef SBC_BUILD_WITH_MMX_SUPPORT
-	sbc_init_primitives_mmx(state);
-#endif
+	sbc_init_primitives_x86(state);
 
 	/* ARM optimizations */
 #ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
diff --git a/sbc/sbc_primitives_sse.c b/sbc/sbc_primitives_sse.c
new file mode 100644
index 0000000..c2b729a
--- /dev/null
+++ b/sbc/sbc_primitives_sse.c
@@ -0,0 +1,361 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2020 Intel Corporation
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <limits.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+#include "sbc_primitives_sse.h"
+
+/*
+ * SSE optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_SSE_SUPPORT
+
+static inline void sbc_analyze_four_sse(const int16_t *in, int32_t *out,
+					const FIXED_T *consts)
+{
+	static const SBC_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+	};
+	__asm__ volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      32(%0), %%mm2\n"
+		"movq      40(%0), %%mm3\n"
+		"pmaddwd   32(%1), %%mm2\n"
+		"pmaddwd   40(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      48(%0), %%mm2\n"
+		"movq      56(%0), %%mm3\n"
+		"pmaddwd   48(%1), %%mm2\n"
+		"pmaddwd   56(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      64(%0), %%mm2\n"
+		"movq      72(%0), %%mm3\n"
+		"pmaddwd   64(%1), %%mm2\n"
+		"pmaddwd   72(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"\n"
+		"movq       %%mm0, %%mm2\n"
+		"pmaddwd   80(%1), %%mm0\n"
+		"pmaddwd   88(%1), %%mm2\n"
+		"\n"
+		"movq       %%mm1, %%mm3\n"
+		"pmaddwd   96(%1), %%mm1\n"
+		"pmaddwd  104(%1), %%mm3\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm3, %%mm2\n"
+		"\n"
+		"movq       %%mm0, (%3)\n"
+		"movq       %%mm2, 8(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+			"i" (SBC_PROTO_FIXED4_SCALE)
+		: "cc", "memory");
+}
+
+static inline void sbc_analyze_eight_sse(const int16_t *in, int32_t *out,
+							const FIXED_T *consts)
+{
+	static const SBC_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+	};
+	__asm__ volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"paddd       (%2), %%mm2\n"
+		"paddd       (%2), %%mm3\n"
+		"\n"
+		"movq      32(%0), %%mm4\n"
+		"movq      40(%0), %%mm5\n"
+		"movq      48(%0), %%mm6\n"
+		"movq      56(%0), %%mm7\n"
+		"pmaddwd   32(%1), %%mm4\n"
+		"pmaddwd   40(%1), %%mm5\n"
+		"pmaddwd   48(%1), %%mm6\n"
+		"pmaddwd   56(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      64(%0), %%mm4\n"
+		"movq      72(%0), %%mm5\n"
+		"movq      80(%0), %%mm6\n"
+		"movq      88(%0), %%mm7\n"
+		"pmaddwd   64(%1), %%mm4\n"
+		"pmaddwd   72(%1), %%mm5\n"
+		"pmaddwd   80(%1), %%mm6\n"
+		"pmaddwd   88(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      96(%0), %%mm4\n"
+		"movq     104(%0), %%mm5\n"
+		"movq     112(%0), %%mm6\n"
+		"movq     120(%0), %%mm7\n"
+		"pmaddwd   96(%1), %%mm4\n"
+		"pmaddwd  104(%1), %%mm5\n"
+		"pmaddwd  112(%1), %%mm6\n"
+		"pmaddwd  120(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq     128(%0), %%mm4\n"
+		"movq     136(%0), %%mm5\n"
+		"movq     144(%0), %%mm6\n"
+		"movq     152(%0), %%mm7\n"
+		"pmaddwd  128(%1), %%mm4\n"
+		"pmaddwd  136(%1), %%mm5\n"
+		"pmaddwd  144(%1), %%mm6\n"
+		"pmaddwd  152(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"psrad         %4, %%mm2\n"
+		"psrad         %4, %%mm3\n"
+		"\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"packssdw   %%mm2, %%mm2\n"
+		"packssdw   %%mm3, %%mm3\n"
+		"\n"
+		"movq       %%mm0, %%mm4\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  160(%1), %%mm4\n"
+		"pmaddwd  168(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm6\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  192(%1), %%mm6\n"
+		"pmaddwd  200(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm6\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  224(%1), %%mm6\n"
+		"pmaddwd  232(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm6\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  256(%1), %%mm6\n"
+		"pmaddwd  264(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm4, (%3)\n"
+		"movq       %%mm5, 8(%3)\n"
+		"\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  176(%1), %%mm0\n"
+		"pmaddwd  184(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  208(%1), %%mm1\n"
+		"pmaddwd  216(%1), %%mm7\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  240(%1), %%mm2\n"
+		"pmaddwd  248(%1), %%mm7\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  272(%1), %%mm3\n"
+		"pmaddwd  280(%1), %%mm7\n"
+		"paddd      %%mm3, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm0, 16(%3)\n"
+		"movq       %%mm5, 24(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+			"i" (SBC_PROTO_FIXED8_SCALE)
+		: "cc", "memory");
+}
+
+static inline void sbc_analyze_4b_4s_sse(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_four_sse(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_sse(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	sbc_analyze_four_sse(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_sse(x + 0, out, analysis_consts_fixed4_simd_even);
+
+	__asm__ volatile ("emms\n");
+}
+
+static inline void sbc_analyze_4b_8s_sse(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_eight_sse(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_sse(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	sbc_analyze_eight_sse(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_sse(x + 0, out, analysis_consts_fixed8_simd_even);
+
+	__asm__ volatile ("emms\n");
+}
+
+static inline void sbc_analyze_1b_8s_sse_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride);
+
+static inline void sbc_analyze_1b_8s_sse_odd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_sse(x, out, analysis_consts_fixed8_simd_odd);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_sse_even;
+
+	__asm__ volatile ("emms\n");
+}
+
+static inline void sbc_analyze_1b_8s_sse_even(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
+{
+	sbc_analyze_eight_sse(x, out, analysis_consts_fixed8_simd_even);
+	state->sbc_analyze_8s = sbc_analyze_1b_8s_sse_odd;
+
+	__asm__ volatile ("emms\n");
+}
+
+static void sbc_calc_scalefactors_sse(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	static const SBC_ALIGNED int32_t consts[2] = {
+		1 << SCALE_OUT_BITS,
+		1 << SCALE_OUT_BITS,
+	};
+	int ch, sb;
+	intptr_t blk;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb += 2) {
+			blk = (blocks - 1) * (((char *) &sb_sample_f[1][0][0] -
+				(char *) &sb_sample_f[0][0][0]));
+			__asm__ volatile (
+				"movq         (%4), %%mm0\n"
+			"1:\n"
+				"movq     (%1, %0), %%mm1\n"
+				"pxor        %%mm2, %%mm2\n"
+				"pcmpgtd     %%mm2, %%mm1\n"
+				"paddd    (%1, %0), %%mm1\n"
+				"pcmpgtd     %%mm1, %%mm2\n"
+				"pxor        %%mm2, %%mm1\n"
+
+				"por         %%mm1, %%mm0\n"
+
+				"sub            %2, %0\n"
+				"jns            1b\n"
+
+				"movd        %%mm0, %k0\n"
+				"psrlq         $32, %%mm0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, (%3)\n"
+
+				"movd        %%mm0, %k0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, 4(%3)\n"
+			: "+r" (blk)
+			: "r" (&sb_sample_f[0][ch][sb]),
+				"i" ((char *) &sb_sample_f[1][0][0] -
+					(char *) &sb_sample_f[0][0][0]),
+				"r" (&scale_factor[ch][sb]),
+				"r" (&consts),
+				"i" (SCALE_OUT_BITS)
+			: "cc", "memory");
+		}
+	}
+	__asm__ volatile ("emms\n");
+}
+
+void sbc_init_primitives_sse(struct sbc_encoder_state *state)
+{
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_sse;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_sse_odd;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_sse;
+	state->sbc_calc_scalefactors = sbc_calc_scalefactors_sse;
+	state->implementation_info = "SSE";
+}
+
+#endif
diff --git a/sbc/sbc_primitives_sse.h b/sbc/sbc_primitives_sse.h
new file mode 100644
index 0000000..8830cfd
--- /dev/null
+++ b/sbc/sbc_primitives_sse.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2020  Intel Corporation
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __SBC_PRIMITIVES_SSE_H
+#define __SBC_PRIMITIVES_SSE_H
+
+#include "sbc_primitives.h"
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__)) && \
+		!defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15)
+
+#define SBC_BUILD_WITH_SSE_SUPPORT
+
+void sbc_init_primitives_sse(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
-- 
2.26.2

