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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF9C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9912075E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 00:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBTJdZVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHSACQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHSACP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 20:02:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364FC061342
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id i10so4961076pgk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQ4LWb684mNHZcH5T+SHWEtZWJfEIJln+Io+MEEnEtM=;
        b=WBTJdZValcXOX61h8fx+y7EXUCnH8IOQfgo/Yl05CnDlYSpGOu2iTlixktq1wdqxjF
         h+LHNafSUclY9dgjd1iJF4UZGNjOhNC+dyZy3yUqNWFSRTZh153Xi5GpYyCAgWUuK77s
         G1FKdvqpbGNwExuJVxjnHzYGDaShX/rSlTPwIO0M3syjLJFINwqECEq3P7JYEWtciyJN
         MSo07VzE+fCA2nptWv07k0FCfArF8tjxWBKI9vwZCQCvemDhRdxuT6LgU08lMeFimezE
         vfeJ3KmambguXRfSrZuQt5KQ01nq5eZaJAW8tsUzQh6BrjnRbKqiluSFkfrzVbhOKqC0
         89LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQ4LWb684mNHZcH5T+SHWEtZWJfEIJln+Io+MEEnEtM=;
        b=a36mcCzwtg4t+Xy89mEFYkNdTfeIlCb9/GyA1NTS0UV7Ldz1MfoThpV/UiEylPpWFK
         SrMfVMiZqfJ3SmG5VurjnAqDU8lOsPJmsg9A4mjCfmv0vKIrjOjItjUQoY8/VTUksNPf
         hk+BLZMvbBe13Bh1EWGC7XwJrjn7sZqFwD4Cnk0FtJu7OJXD9u41ptO2v20r4CtzQ9cN
         LX5afDNQgec/+qQoWskhqYtWRiqYunojF6aHZ/Xxh48Pz3HUpJdrUGf7H8+5AOJpaKUU
         g7DHDp4t4Jm+OygPZ9So2z/KsDnfH5fhwTPRSr8Zh1OAetDAoK6Oa1ACjE7iMAOig/vO
         xT7w==
X-Gm-Message-State: AOAM530G+zPYgMkoAOx0FSuNfu6689JSku1p1A+WVgVL4UpOdnTy4CjB
        Bkwi7aQSabpmNRm0gpH1446d7JDvjoo=
X-Google-Smtp-Source: ABdhPJygWvso55P70N3AzCgnUJ/1MBN4I7ixIVtnqxal/78ACpbLYMRBTq3IOoN5US3PSF2Ssh+3HA==
X-Received: by 2002:a65:4502:: with SMTP id n2mr13862284pgq.132.1597795332966;
        Tue, 18 Aug 2020 17:02:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d80sm25957673pfd.22.2020.08.18.17.02.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 17:02:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] sbc: Add initial code for SSE primitives
Date:   Tue, 18 Aug 2020 17:02:10 -0700
Message-Id: <20200819000212.211485-1-luiz.dentz@gmail.com>
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
 sbc/sbc_primitives.c     |  18 +-
 sbc/sbc_primitives_mmx.c |  49 +-----
 sbc/sbc_primitives_sse.c | 365 +++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_sse.h |  38 ++++
 5 files changed, 428 insertions(+), 43 deletions(-)
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
index ff343cf..c9d1045 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -33,6 +33,7 @@
 #include "sbc_tables.h"
 
 #include "sbc_primitives.h"
+#include "sbc_primitives_sse.h"
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_iwmmxt.h"
 #include "sbc_primitives_neon.h"
@@ -590,6 +591,19 @@ static int sbc_calc_scalefactors_j(
 	return joint;
 }
 
+static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
+{
+	__builtin_cpu_init();
+
+	if (__builtin_cpu_supports("mmx"))
+		sbc_init_primitives_mmx(state);
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
@@ -614,9 +628,7 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 	state->implementation_info = "Generic C";
 
 	/* X86/AMD64 optimizations */
-#ifdef SBC_BUILD_WITH_MMX_SUPPORT
-	sbc_init_primitives_mmx(state);
-#endif
+	sbc_init_primitives_x86(state);
 
 	/* ARM optimizations */
 #ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index e2c3e56..6984ce5 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -350,50 +350,19 @@ static void sbc_calc_scalefactors_mmx(
 	__asm__ volatile ("emms\n");
 }
 
-static int check_mmx_support(void)
+void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 {
-#ifdef __amd64__
-	return 1; /* We assume that all 64-bit processors have MMX support */
-#else
-	int cpuid_feature_information;
-	__asm__ volatile (
-		/* According to Intel manual, CPUID instruction is supported
-		 * if the value of ID bit (bit 21) in EFLAGS can be modified */
-		"pushf\n"
-		"movl     (%%esp),   %0\n"
-		"xorl     $0x200000, (%%esp)\n" /* try to modify ID bit */
-		"popf\n"
-		"pushf\n"
-		"xorl     (%%esp),   %0\n"      /* check if ID bit changed */
-		"jz       1f\n"
-		"push     %%eax\n"
-		"push     %%ebx\n"
-		"push     %%ecx\n"
-		"mov      $1,        %%eax\n"
-		"cpuid\n"
-		"pop      %%ecx\n"
-		"pop      %%ebx\n"
-		"pop      %%eax\n"
-		"1:\n"
-		"popf\n"
-		: "=d" (cpuid_feature_information)
-		:
-		: "cc");
-    return cpuid_feature_information & (1 << 23);
-#endif
+	state->sbc_analyze_4s = sbc_analyze_4b_4s_mmx;
+	if (state->increment == 1)
+		state->sbc_analyze_8s = sbc_analyze_1b_8s_mmx_odd;
+	else
+		state->sbc_analyze_8s = sbc_analyze_4b_8s_mmx;
+	state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
+	state->implementation_info = "MMX";
 }
 
+#else
 void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 {
-	if (check_mmx_support()) {
-		state->sbc_analyze_4s = sbc_analyze_4b_4s_mmx;
-		if (state->increment == 1)
-			state->sbc_analyze_8s = sbc_analyze_1b_8s_mmx_odd;
-		else
-			state->sbc_analyze_8s = sbc_analyze_4b_8s_mmx;
-		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
-		state->implementation_info = "MMX";
-	}
 }
-
 #endif
diff --git a/sbc/sbc_primitives_sse.c b/sbc/sbc_primitives_sse.c
new file mode 100644
index 0000000..42cdb03
--- /dev/null
+++ b/sbc/sbc_primitives_sse.c
@@ -0,0 +1,365 @@
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
+#else
+void sbc_init_primitives_sse(struct sbc_encoder_state *state)
+{
+}
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

