Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA70C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AC3225AC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgLUSmK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgLUSmJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 13:42:09 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D63C061793
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 10:41:29 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:43226)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <marius@gnu.org>)
        id 1krQ7S-0006FQ-Is; Mon, 21 Dec 2020 13:41:18 -0500
Received: from host-37-191-236-253.lynet.no ([37.191.236.253]:55836 helo=localhost)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <marius@gnu.org>)
        id 1krQ7R-0001J1-Sk; Mon, 21 Dec 2020 13:41:18 -0500
From:   marius@gnu.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, Marius Bakke <marius@devup.no>
Subject: [PATCH v2] sbc_primitives: Fix build on non-x86.
Date:   Mon, 21 Dec 2020 19:41:14 +0100
Message-Id: <20201221184114.1300-1-marius@gnu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <PH0PR11MB51269918A2B84A3120EBD8E4D3C00@PH0PR11MB5126.namprd11.prod.outlook.com>
References: <PH0PR11MB51269918A2B84A3120EBD8E4D3C00@PH0PR11MB5126.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marius Bakke <marius@devup.no>

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
index 97a75be..d8e166a 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -593,7 +593,9 @@ static int sbc_calc_scalefactors_j(
 
 static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
 {
+#if defined(__x86_64__) || defined(__i386__)
 	__builtin_cpu_init();
+#endif
 
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
 	if (__builtin_cpu_supports("mmx"))
-- 
2.29.2

