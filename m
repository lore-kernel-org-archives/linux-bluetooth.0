Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6243C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 07:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7394520825
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 07:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePysBgYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfDOHwf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:52:35 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34612 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOHwf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 03:52:35 -0400
Received: by mail-ot1-f54.google.com with SMTP id k21so13638429otf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2019 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNP1g76QhbVFqhRnnMzzAV/FMP6ecgcnAx8duO5+y/Y=;
        b=ePysBgYay5aEUx5YRReDYI5iRZzvf72v9yKQLuE/j0cUFoLiiXCU7k4t+Y07k5HE4j
         fDglS9iEf83uzdfbLB+Qp8NTxj2gc/Hm1ZOmlLQnCTMAHH7gqdvhzHxFB3SoEssgxXnv
         p5jcRrsnkgOByIyn+sersgUbKRTHpYiO2kpIzTGMR65E3C3Qa8svZfw8Xzo1+8p4ln0S
         M0gnYyUWcXV/d5ockHFrJDYahcTXLpmgnvyCjgoNVxUsq3Uw9emp+K/2Tpb5nnObVB9j
         Ma9Kq3UBecTO70PxKLC7lmSx4s1bR5kAdP6wb6FANjNqnBQqdwYkEhSDFeCe2J9gmOqE
         90LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNP1g76QhbVFqhRnnMzzAV/FMP6ecgcnAx8duO5+y/Y=;
        b=Rvq45aJsGYV+DceyOnfjWKS9C4QkRRga6Et+SHF6eBufsvnsl/lpuL2WBvtzmrsHZL
         Do97+KZ9MOgT4M9Xxtz8hFSJAC/UUbsJLcMXXBSR9hfdvA8X8ZqPYgbCf5CYNECPGI2z
         z++AcGYO2oEaFfNmW82A1SFGHskZmvmTP/pYxaeIGp8r5FfExWowtZ7JFse7QGuxfTtt
         jdnbJER+jdeRymq6gv1UZ4MPNliBzHp20Fh9prGgXhMVgWUIUDiLgN6aUY9KaxxtbEmw
         dr4JPZYLSqHpWFd7p2fqVpFcvLQGdPX5W8PGNhBo8QmxI5hACar104kDxhe7457wXPkg
         bTXw==
X-Gm-Message-State: APjAAAVm6BL86eblvH5axu6er+ReOWYmo0CQcg5MQQUHPQUjDgYyn+rx
        76Vat5UkHguCxwQVzo1u7B0S9QiNbCy1JjFTQck=
X-Google-Smtp-Source: APXvYqzWeaR1kt3pcy33qRBzZHNWjiQJNbJLRZYJ360iDq6JsjBIFiU1dHZtTLnsttKO8oGh/5PHJ8LbONVzrvpc2UI=
X-Received: by 2002:a9d:63c9:: with SMTP id e9mr46539047otl.76.1555314754657;
 Mon, 15 Apr 2019 00:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190412140803.28622-1-ludwig.nussel@suse.de>
In-Reply-To: <20190412140803.28622-1-ludwig.nussel@suse.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Apr 2019 10:52:17 +0300
Message-ID: <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com>
Subject: Re: [PATCH] Fix cups backend location
To:     Ludwig Nussel <ludwig.nussel@suse.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Fri, Apr 12, 2019 at 5:11 PM Ludwig Nussel <ludwig.nussel@suse.de> wrote:
>
> ---
>  Makefile.tools | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 7d5361bcd..9f8a0b87b 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -436,7 +436,10 @@ endif
>  endif
>
>  if CUPS
> -cupsdir = $(libdir)/cups/backend
> +# need to use upstream location here which is $exec_prefix/lib/cups/backend, see
> +# https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
> +# https://github.com/apple/cups/blob/master/backend/Makefile
> +cupsdir = $(exec_prefix)/lib/cups/backend
>
>  cups_PROGRAMS = profiles/cups/bluetooth

Any feedback on these changes?
-- 
Luiz Augusto von Dentz
