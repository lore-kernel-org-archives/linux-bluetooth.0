Return-Path: <SRS0=f53w=QU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C3C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Feb 2019 15:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3210A222D0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Feb 2019 15:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH/J9sGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392552AbfBMPwJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:52:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40292 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392550AbfBMPwJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 10:52:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so4715043oth.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Feb 2019 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOsWmjifz2N2AL5eUzR9VIIz1rTp4j2VNog08FwgyB8=;
        b=ZH/J9sGW5/8CELAMNZLPRbQLeLCieuckgu4bn9NaVEcxHKkuwr8N6l93H87rN2fMh0
         19KcNNmneIYdDRWdy1GfT9DIXOs1mc07jdg+6PZ9CE1G+HrN59UmSKWozOJtgj463cF1
         uzQphAs894B5iIjFDlwjldhrs904RGqOIFmABUAXk6dO1zqW0kofGLznn7sxCeMv2mb1
         dg7IsIXFTR4laqWe/GSF6wRf+OdpSmOmDerW2KkFiVzL2Z0Wqdqd/uW6e3ptJY+HI4As
         czF7ElkAzFIR4Gr67x+2CDPLiJqdbSiOahhaLP5+4Ovvp8/vDf/z7ocz3I05AWEFREM0
         F7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOsWmjifz2N2AL5eUzR9VIIz1rTp4j2VNog08FwgyB8=;
        b=Fa+AnNWvEHZa23F7jTTMnQ5ca/WjDEOtltsyrWiFZuZgOYR0aq0tyT1+peokV6+XjM
         5kDYPrfJpmkj1iVq/q04bS8kbkoCyAWe0Sz2FgQpJzU3EhxCBUAM+Ebws4us8UMXyw1M
         34F8Je/wpmdP9dCGVV9zyRVWYMWUV5R3WkeouIMVeqE2QcbSWoxr7p8G8JlDr+7RSrTI
         hjeKhKBh3M2mC61sl6EJ70LDEcPumkoNz4F4ScExorfWM7CMKeQADcjm4hCRCEGVuRdC
         LmWQGTKW7QMNK/25c4ohrpJrOfjVH3Jyc4l9J1YzTJjgeOy/V4hFQd2nkJjy5CuuqI8T
         SOGQ==
X-Gm-Message-State: AHQUAubZNHqKaUm5NXGWRhCSEYRAn8HQg10rSsXk5OjqicZR8wkQ9uE3
        eQFC2Gyg1AgeaH5jetguyfnxDse4TBr92e2lLgqmrw==
X-Google-Smtp-Source: AHgI3IZIQRGZ9cvAy5V1U9uY91StyVf/ZleiYrtexqmeI8Q/nFPc2TOWuZEdBA4TUQmWpWuolwJf83OMqPO5gqWWOh4=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr616182otr.242.1550071230634;
 Wed, 13 Feb 2019 07:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20190212151515.13436-1-szymon.janc@codecoup.pl>
In-Reply-To: <20190212151515.13436-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Feb 2019 17:20:17 +0200
Message-ID: <CABBYNZ+ETBN2zkAaOgNo6MocY27eH+Lw24qysyNJUpCKYVbc2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] build: Fix missing dependency for btpclient
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,
On Tue, Feb 12, 2019 at 5:18 PM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> prog_DEPENDENCIES is computed by automake only if not supplied so we
> must provide all dependencies if provided manually.
>
> This resulted in random build failures:
>
> libtool:   error: cannot find the library 'lib/libbluetooth-internal.la'
>     or unhandled argument 'lib/libbluetooth-internal.la'
> make[1]: *** [Makefile:5436: tools/btpclient] Error 1
> ---
>  Makefile.tools | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 1f8271542..0f94bbbe7 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -471,5 +471,5 @@ noinst_PROGRAMS += tools/btpclient
>  tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
>  tools_btpclient_LDADD = lib/libbluetooth-internal.la \
>                                 src/libshared-ell.la $(ell_ldadd)
> -tools_btpclient_DEPENDENCIES = $(ell_dependencies)
> +tools_btpclient_DEPENDENCIES = lib/libbluetooth-internal.la $(ell_dependencies)
>  endif
> --
> 2.20.1

Applied.

-- 
Luiz Augusto von Dentz
