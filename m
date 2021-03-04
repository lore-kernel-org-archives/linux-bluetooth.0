Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F44C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C9264F62
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhCDSzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhCDSz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 13:55:26 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AFC061756
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 10:54:46 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q203so8219677oih.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05W9YzXLfbmI2jr3bh2VuYvmWVoJ69L6SYPF8zYG2Yo=;
        b=TpA++jDag9+SdiH6PSurnKvXorxS/n21rsfAnTJJckyDjav/3HKxAOboIAF+z8ADfI
         7CO+N7Jgtqm0kDvlc15TFSStj2WPfpB/KaUv2TMvQepfv878H7TNlPrh0b2UIWZcJT64
         i+801ji96udO1xRUtXc8Uxn1KhP7sRWlNqxJ3ddw5Io5ra9Bp4X0sIxJpwWFZetU+aVx
         YftlBDNGWtRtG6dkiOb98kahjCaSiqFFkRQUc5onhrQ4LebSqheSEJDtAAnTz5USmrAE
         G1bg+1bFvoz9eIcvMjNSInlOQR7nmBBfGBFzpm5CTzOWcZAaDovsARdMJu5RBIYa/mq3
         xOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05W9YzXLfbmI2jr3bh2VuYvmWVoJ69L6SYPF8zYG2Yo=;
        b=j1kP1nrmcjSUfFjfzO0dfa93jOnYuJ11Pqnl6kWaYBsKTNRPwchGpWoEpzMkun5yp1
         Vso5ddaE1msni/hC4LHVNWaBjpaoiyxEBjT6x6dzjYxSvIGs3E1dmhHeaRENodIhZgTy
         VAEzaHkChPDqJy9Cu24FXAKSSPy+82+tcgFP+pmyzk2ZhDV8Gd/YdTLNhHV7WdPK+gtT
         CUslaMVFQgtwxFrRb/uqVhZ6Bxhxx4NzPvOK66TsPqJ5Mvg2V3HspUAWQvhiopbLFqkN
         +midOm/pOluwKl48D+BSdJXkqctvhKdkFi/6SAph/Q5peaQUxUUEOBnjVq0pldSLAvSs
         dsJQ==
X-Gm-Message-State: AOAM531ERNF4MAV8uM7O4BeiyKdd+UBvM5ySuGFuP75Zn6Mc+BCTIDy6
        N9VvU5wckw1XITwlY7S297ysrmxnluMv5HQiQxlMO7NlxLg=
X-Google-Smtp-Source: ABdhPJy+hZQKZLrDlHAmiWEFTzcynN2POteUcN29KYv7KqDWlPJ6Ni4N0Agd5E4/Ic5iuHmhnjeed4CpgM5iRaBvyTM=
X-Received: by 2002:a54:468f:: with SMTP id k15mr4022438oic.58.1614884085547;
 Thu, 04 Mar 2021 10:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20210304124851.219154-1-hadess@hadess.net> <CABBYNZ+yY6=WsFhA45fy2Tr33sLq0hgw7zJ3L15o3E7SQop84A@mail.gmail.com>
 <ffe1130b13ab6e8b8b35e5f8cc560bd8497faa6d.camel@hadess.net>
In-Reply-To: <ffe1130b13ab6e8b8b35e5f8cc560bd8497faa6d.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 10:54:34 -0800
Message-ID: <CABBYNZ+FQRJm-OUv-J6byNMzK8W0znU18FB3fwDVvFPGa=d2XQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] build: Add warnings for non-literal strings
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Mar 4, 2021 at 10:46 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2021-03-04 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Thu, Mar 4, 2021 at 9:21 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > >
> > > ---
> > >  acinclude.m4 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/acinclude.m4 b/acinclude.m4
> > > index 529848357..6ae34b8ae 100644
> > > --- a/acinclude.m4
> > > +++ b/acinclude.m4
> > > @@ -21,7 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> > >                 with_cflags="$with_cflags -Wredundant-decls"
> > >                 with_cflags="$with_cflags -Wcast-align"
> > >                 with_cflags="$with_cflags -Wswitch-enum"
> > > -               with_cflags="$with_cflags -Wformat -Wformat-security"
> > > +               with_cflags="$with_cflags -Wformat -Wformat-security
> > > -Wformat-nonliteral"
> >
> > Does it actually have any benefit of having the format as always
> > string literal? I'm not really a big fan of using pragmas.
>
> It's a security feature[1], so it's pretty important that we avoid
> using non-literals when some of the arguments are user controlled,
> especially in a networked daemon. We already enabled
> "-Wformat-security", so not that much of a difference.
>
> This warning is also enabled by default on Fedora's GCC, so I get to
> see it whether I want to or not.
>
> I'd be happy actually fixing those warnings if you don't want pragmas
> at all, it would just be more code movement. If we can get those
> patches in, I can do a follow-up.
>
> [1]: Quick search gave me this explanation:
> https://owasp.org/www-community/attacks/Format_string_attack

You should probably add the above link in the patch description,
regarding the use of pragma. I'd say we need to convert to use
literals directly then since otherwise we are not actually fixing
anything just returning it back to ignore the error where we don't use
literals.

> > >                 with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
> > >                 with_cflags="$with_cflags -
> > > DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
> > >                 with_cflags="$with_cflags -
> > > DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
> > > --
> > > 2.29.2
> > >
> >
> >
>
>


-- 
Luiz Augusto von Dentz
