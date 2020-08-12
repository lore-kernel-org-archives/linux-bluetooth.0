Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CBFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FAC207F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 12:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHLMso convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:48:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59109 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgHLMso (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 08:48:44 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 50943CECDC;
        Wed, 12 Aug 2020 14:58:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH SBC 1/3] sbc: Add initial code for SSE primitives
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200811181623.3683374-1-luiz.dentz@gmail.com>
Date:   Wed, 12 Aug 2020 14:48:42 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <93FEE5B2-F495-40C4-9386-E44DF132C49D@holtmann.org>
References: <20200811181623.3683374-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> 
> ---
> Makefile.am              |   1 +
> sbc/sbc_primitives.c     |  20 ++-
> sbc/sbc_primitives_sse.c | 361 +++++++++++++++++++++++++++++++++++++++
> sbc/sbc_primitives_sse.h |  38 +++++
> 4 files changed, 417 insertions(+), 3 deletions(-)
> create mode 100644 sbc/sbc_primitives_sse.c
> create mode 100644 sbc/sbc_primitives_sse.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 342043d..7ff0c7d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -14,6 +14,7 @@ sbc_headers = sbc/sbc.h
> 
> sbc_sources = sbc/sbc.c sbc/sbc_private.h sbc/sbc_math.h sbc/sbc_tables.h \
> 		sbc/sbc_primitives.h sbc/sbc_primitives.c \
> +		sbc/sbc_primitives_sse.h sbc/sbc_primitives_sse.c \
> 		sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
> 		sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
> 		sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
> diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
> index ff343cf..97a75be 100644
> --- a/sbc/sbc_primitives.c
> +++ b/sbc/sbc_primitives.c
> @@ -33,6 +33,7 @@
> #include "sbc_tables.h"
> 
> #include "sbc_primitives.h"
> +#include "sbc_primitives_sse.h"
> #include "sbc_primitives_mmx.h"
> #include "sbc_primitives_iwmmxt.h"
> #include "sbc_primitives_neon.h"
> @@ -590,6 +591,21 @@ static int sbc_calc_scalefactors_j(
> 	return joint;
> }
> 
> +static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
> +{
> +	__builtin_cpu_init();
> +
> +#ifdef SBC_BUILD_WITH_MMX_SUPPORT
> +	if (__builtin_cpu_supports("mmx"))
> +		sbc_init_primitives_mmx(state);
> +#endif
> +
> +#ifdef SBC_BUILD_WITH_SSE_SUPPORT
> +	if (__builtin_cpu_supports("sse4.2"))
> +		sbc_init_primitives_sse(state);
> +#endif

lets keep the ifdef in the primitive functions they belong. This should be consistent across all primitives and not spread in two places.

Regards

Marcel

