Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D8C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB1161628
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhEKSJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEKSJS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 14:09:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519FC06138A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:08:11 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id h202so27461237ybg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvuBK4aSTZYBYeCUeYPhHSIY916hSJ6uu/doeG4KOxI=;
        b=qrJ384/FzjGFpidwkUqTV9xkcqgmMjQoYb2KSvgkggfTPnQMosGUNfGAqzW3h601Lx
         cwIg3HLOyAFyFCV9iFCBCuoB02/qTGH0AAKK0gJ4tmasMsmANb1iWgNM62ByGW9UagvC
         b1cdo+OmX3dlnCNzWgXYlnqudW8pmHBbL4282S/x9NLfotnuyQ1B7Zyxd+r4dcahOl78
         36opCphLzj870TmlDLmRhtA6DSCqOm8TOrY0uSEyz+yWGVZ2klu4gtrg2wsl4h7deJJC
         cldM3toK6MGKtodgN4ILi2kSacQMPlzr62E89U16RjLn6B33LT2FMXK+dKzR0PkeT/b1
         CH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvuBK4aSTZYBYeCUeYPhHSIY916hSJ6uu/doeG4KOxI=;
        b=otbC9wx/OEApriALq31VH48hYk6/h0d9Ly/Imv/2/hbd2mXyo4r86n9dXugbTNjHwr
         yJU9QXWPdyfTET9fB5xdaQexPmC4umG4/R5nKNygdjCL5a4Dy23mhjoSBCXvBcZden5n
         fdiW5MH78lOx0YYz6zsldY6M3+5hhUSnVUcm/hotLppViLSAvW+fvhCoGuPjLGWA2Yat
         LRswE/iTWlPYlTbv7d2VX55pX82VsY4NCJ+gVaqeRh6dAqj/eED07L4tyvS0ZXuXdcjO
         RX7omQ1cEB5bq5QMiM26YjPGttilFyS+VFNpiuEnVgn6zfnVWS1vxuKs6W5z93u5r6HW
         6K5g==
X-Gm-Message-State: AOAM531rtn4kuEMaSUaE5ToSFwJIsB4ZLc9Q4Qswux5SNdc4o6S6G5Ua
        tq8NGyKYu57QdjW4ArzmTSzrrjN7WgcoB9WfxQY=
X-Google-Smtp-Source: ABdhPJw3DpTOFL1//bdBevV5U/vF292kKtPJQszRjqjbjpMppn/1YH/P/BSf2rfXqmIiKuCIuLyBjOAjJXJSmJrzi78=
X-Received: by 2002:a25:a466:: with SMTP id f93mr42739975ybi.264.1620756490409;
 Tue, 11 May 2021 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 May 2021 11:07:59 -0700
Message-ID: <CABBYNZKMHFVD7Z8oKOs3W-QusezCmjbZAeZn98NHVYz2YdfdEQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH] config: Show error if rst2man not found when
 manpages are enabled
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, May 11, 2021 at 11:02 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds a check if the conversion tool is installed when the
> manpages is enabled, and show error if it is not installed.
> ---
>  configure.ac | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index f445589b0..2b044f8e5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -328,6 +328,9 @@ AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
>                                         [enable_manpages=${enableval}])
>  if (test "${enable_manpages}" != "no"); then
>         AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
> +       if (test "${RST2MAN}" = "no" ); then
> +               AC_MSG_ERROR([rst2man is required])

I guess we can mention that it is typically packaged with
python-docutils e.g: rstman is required: install python-docutils or
alternatively we check python-docutils with pkgconfig since it will be
a hard dependency anyway.

> +       fi
>  fi
>  AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
>  AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
> --
> 2.26.3
>


-- 
Luiz Augusto von Dentz
