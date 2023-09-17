Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6976ECD37B4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Sep 2023 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjIQQ6n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Sep 2023 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjIQQ6k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Sep 2023 12:58:40 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841D12A
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 09:58:34 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae848.dynamic.kabel-deutschland.de [95.90.232.72])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 095C061E5FE01;
        Sun, 17 Sep 2023 18:58:28 +0200 (CEST)
Message-ID: <20d42ba9-7832-4b2f-9e85-75106e859280@molgen.mpg.de>
Date:   Sun, 17 Sep 2023 18:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: Add enable_btpclient and enable_mesh for
 internal ELL
Content-Language: en-US
To:     Koba Ko <koba.ko@canonical.com>
References: <20230917165044.40310-1-koba.ko@canonical.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230917165044.40310-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Koba,


Thank you for your patch. I think you should tag your patch with BlueZ 
in the commit message summary.

Am 17.09.23 um 18:50 schrieb Koba Ko:
> when enable_external_ell is not specified, confiugre doesn't not check

configu*re*

> if enable_btpclient and enable_mesh are enabled.
> this causes the internal ELL must be installed.

It’d be great, if you rephrased the last sentence, as I have a hard time 
to understand it.

> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>   configure.ac | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4186c3792..9897d36d6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -301,7 +301,8 @@ if (test "${enable_external_ell}" = "yes"); then
>   	AC_SUBST(ELL_CFLAGS)
>   	AC_SUBST(ELL_LIBS)
>   fi
> -if (test "${enable_external_ell}" != "yes"); then
> +if (test "${enable_external_ell}" != "yes" &&
> +		(test "${enable_btpclient}" = "yes" && test "${enable_mesh}" = "yes")); then
>   	if (test ! -f ${srcdir}/ell/ell.h) &&
>   			(test ! -f ${srcdir}/../ell/ell/ell.h); then
>   				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)


Kind regards,

Paul
