Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CEE23105
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLVLFI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:05:08 -0500
Received: from out0.migadu.com ([94.23.1.103]:49062 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgLVLFI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:05:08 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devup.no; s=default;
        t=1608635066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XWxI92P/e5vzE9vPZncpOlp2+6dRY+CLEei5JItwyw=;
        b=tr9yhWu6PB0YPSErj1uozxDUXTAO6Tlb7RD7+1oiCNYD0Y6DWYkqeS5xtrCFTecteRWxQi
        ccdDgO9uKMMSmbs4e4ac5fTZGQuN0byaGsLrcFnzOY1L+0c8KgHuQ3eV7uRsOOZgnZSplc
        Vz1k30NOlvsUnGeeAmFQZ7t5RxnFBUI=
From:   Marius Bakke <marius@devup.no>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, Marius Bakke <marius@gnu.org>
Subject: [PATCH v3] sbc_primitives: Fix build on non-x86.
Message-Id: <20201222110424.19368-1-marius@devup.no>
In-Reply-To: <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
References: <CABBYNZJ1PGCTVEon28vBN0apNjne2r5NgHY8e1WDtDML+4aeEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: marius@devup.no
Date:   Tue, 22 Dec 2020 11:04:26 GMT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marius Bakke <marius@gnu.org>

Don't call __builtin_cpu_init unless targeting i386 or x86_64.
Otherwise we get an error at link time:

  CC       sbc/sbc_primitives.lo
sbc/sbc_primitives.c: In function ‘sbc_init_primitives_x86’:
sbc/sbc_primitives.c:596:2: warning: implicit declaration of function ‘__builtin_cpu_init’; did you mean ‘__builtin_irint’? [-Wimplicit-function-declaration]
[...]
  CCLD     src/sbcdec
ld: sbc/.libs/libsbc-private.a(sbc_primitives.o): in function `sbc_init_primitives':
sbc_primitives.c:(.text+0x3a30): undefined reference to `__builtin_cpu_init'
---
 sbc/sbc_primitives.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 97a75be..09c214a 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -593,6 +593,7 @@ static int sbc_calc_scalefactors_j(
 
 static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
 {
+#if defined(__x86_64__) || defined(__i386__)
 	__builtin_cpu_init();
 
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
@@ -604,6 +605,7 @@ static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
 	if (__builtin_cpu_supports("sse4.2"))
 		sbc_init_primitives_sse(state);
 #endif
+#endif
 }
 
 /*
-- 
2.29.2

