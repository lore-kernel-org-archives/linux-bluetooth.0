Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460BF64F64
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhCDTDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:03:47 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33565 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbhCDTDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 14:03:43 -0500
Received: from relay13.mail.gandi.net (unknown [217.70.178.233])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 49D2B3A9A37
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 18:47:26 +0000 (UTC)
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay13.mail.gandi.net (Postfix) with ESMTPSA id 12DC780019;
        Thu,  4 Mar 2021 18:46:14 +0000 (UTC)
Message-ID: <ffe1130b13ab6e8b8b35e5f8cc560bd8497faa6d.camel@hadess.net>
Subject: Re: [PATCH 1/3] build: Add warnings for non-literal strings
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 04 Mar 2021 19:46:14 +0100
In-Reply-To: <CABBYNZ+yY6=WsFhA45fy2Tr33sLq0hgw7zJ3L15o3E7SQop84A@mail.gmail.com>
References: <20210304124851.219154-1-hadess@hadess.net>
         <CABBYNZ+yY6=WsFhA45fy2Tr33sLq0hgw7zJ3L15o3E7SQop84A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2021-03-04 at 10:35 -0800, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, Mar 4, 2021 at 9:21 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > ---
> >  acinclude.m4 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index 529848357..6ae34b8ae 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -21,7 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> >                 with_cflags="$with_cflags -Wredundant-decls"
> >                 with_cflags="$with_cflags -Wcast-align"
> >                 with_cflags="$with_cflags -Wswitch-enum"
> > -               with_cflags="$with_cflags -Wformat -Wformat-security"
> > +               with_cflags="$with_cflags -Wformat -Wformat-security
> > -Wformat-nonliteral"
> 
> Does it actually have any benefit of having the format as always
> string literal? I'm not really a big fan of using pragmas.

It's a security feature[1], so it's pretty important that we avoid
using non-literals when some of the arguments are user controlled,
especially in a networked daemon. We already enabled
"-Wformat-security", so not that much of a difference.

This warning is also enabled by default on Fedora's GCC, so I get to
see it whether I want to or not.

I'd be happy actually fixing those warnings if you don't want pragmas
at all, it would just be more code movement. If we can get those
patches in, I can do a follow-up.

[1]: Quick search gave me this explanation:
https://owasp.org/www-community/attacks/Format_string_attack

> >                 with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
> >                 with_cflags="$with_cflags -
> > DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
> >                 with_cflags="$with_cflags -
> > DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_32"
> > --
> > 2.29.2
> > 
> 
> 


