Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509B02223E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLCV7p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:59:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36472 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgLCV7p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 16:59:45 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 21149CED05;
        Thu,  3 Dec 2020 23:06:18 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH SBC] sbc_primitives: Fix build on non-x86 arch
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201203212947.2680393-1-luiz.dentz@gmail.com>
Date:   Thu, 3 Dec 2020 22:59:03 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <40EAFE51-E0D0-4D01-8602-FE9F2933AE76@holtmann.org>
References: <20201203212947.2680393-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Check if SBC_BUILD_WITH_MMX_SUPPORT is defined otherwise
> sbc_init_primitives_mmx will not be declared and
> _builtin_cpu_supports(“mmx”)) likely fail:
> 
> CC    sbc/sbc_primitives.lo
> sbc/sbc_primitives.c: In function ‘sbc_init_primitives_x86’:
> sbc/sbc_primitives.c:599:3: warning: implicit declaration of function
> ‘sbc_init_primitives_mmx’; did you mean ‘sbc_init_primitives_x86’?
> [-Wimplicit-function-declaration]
> 599 |  sbc_init_primitives_mmx(state);
>   |  ^~~~~~~~~~~~~~~~~~~~~~~
>   |  sbc_init_primitives_x86
> sbc/sbc_primitives.c: In function ‘sbc_init_primitives’:
> sbc/sbc_primitives.c:598:6: error: hwcap ‘mmx’ is an invalid argument to
> builtin ‘__builtin_cpu_supports’
> 598 | if (__builtin_cpu_supports(“mmx”))
>   |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[1]: *** [Makefile:711: sbc/sbc_primitives.lo] Error 1
> make: *** [Makefile:453: all] Error 2
> ---
> sbc/sbc_primitives.c     | 2 ++
> sbc/sbc_primitives_mmx.c | 5 -----
> 2 files changed, 2 insertions(+), 5 deletions(-)

patch has been applied.

Regards

Marcel

