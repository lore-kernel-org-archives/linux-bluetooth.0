Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A31C43460
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F306190A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEKSZf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSZf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 14:25:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727DFC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:24:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a11so11237225plh.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ug7NELsxYhIYWU88vVsfghwegyuLJkBOzy+xlJ1ROyI=;
        b=vQmVNjJKN7GSo7+M7Lf3fNXIq8kWojeHYh2AWnPGIkM5mMdsuPjvGrx8ioiTwGVueQ
         cdYc1pt/UNuv09Wbp9PVFsd611PCF1ZFJbJz+OM4lNaAiOlCtE5e9hEJFfy75yEBRwlt
         oiPm2HFXaWIv2zQGOvCFpLoYmJm+AJzEuvTGGAOmWEN6mDLgoqxmRkGvU72mnegzaeDG
         VLcF224cGcx268GsFTHSNUzITWdgagQl7D3iyPHM1+9V1oOzJRbvYsMwyxz8PwMZ2Nq4
         Xv0V0ZGhYPeEyZrA8OzQrDnSh1VCKc2jQINKSjD8eurmFGi5s40/GdhRKRC3lqShG+8a
         npbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ug7NELsxYhIYWU88vVsfghwegyuLJkBOzy+xlJ1ROyI=;
        b=khyTz8d0PVeWSJ1QyrsFAiyREbgzTkWuqqF8JHxoeJ2pvz/YTqT49thwRyM2WmDDyC
         VLibNkUSGH410Kl/QrPwvC2StQ2LxT2g2R0TEbWJQwKIQxEmEURPiTHCFZOFbgB7oO3L
         /WVB06SO95AEsoI7mQsbNtHarP6Kd4ojttKzFzqIjh9ZtzPn+32/Sub92Sl7kcQawVPt
         AcEnH4eszW/jefK3U+q9U5R3hIUFoYc6ENZAym+91oIfwnhGPi4iy1arfdYa4ztp9X/l
         3QnIy87+4tLrLcZSN0dy15l2OYUO47oL4bmGhyiwkib4K60bQsC5Qyq+Lnsa3yM3ttM7
         jTKw==
X-Gm-Message-State: AOAM531o/0QeHoAbA6oKt1RTu1+d3Lp/35IMIh+iTQ8C2rjAEZdLN7yZ
        U9NQNS4blvy8qIUD3jugJSY=
X-Google-Smtp-Source: ABdhPJx3s5q0GZMPYt4tyHyVIIWKtJfl3/MecJblqW3staIA4R1ePUkZ1fbi+OtMrxt2rW3DmcKHgQ==
X-Received: by 2002:a17:90a:540c:: with SMTP id z12mr6475280pjh.42.1620757468003;
        Tue, 11 May 2021 11:24:28 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id t10sm2727709pju.18.2021.05.11.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:24:27 -0700 (PDT)
Message-ID: <b472ff1236cd1f0216af325ea4cd58dc7b562ae1.camel@gmail.com>
Subject: Re: [BlueZ PATCH] config: Show error if rst2man not found when
 manpages are enabled
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 11 May 2021 11:24:26 -0700
In-Reply-To: <CABBYNZKMHFVD7Z8oKOs3W-QusezCmjbZAeZn98NHVYz2YdfdEQ@mail.gmail.com>
References: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
         <CABBYNZKMHFVD7Z8oKOs3W-QusezCmjbZAeZn98NHVYz2YdfdEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 2021-05-11 at 11:07 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Tue, May 11, 2021 at 11:02 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > 
> > This patch adds a check if the conversion tool is installed when the
> > manpages is enabled, and show error if it is not installed.
> > ---
> >  configure.ac | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index f445589b0..2b044f8e5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -328,6 +328,9 @@ AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
> >                                         [enable_manpages=${enableval}])
> >  if (test "${enable_manpages}" != "no"); then
> >         AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
> > +       if (test "${RST2MAN}" = "no" ); then
> > +               AC_MSG_ERROR([rst2man is required])
> 
> I guess we can mention that it is typically packaged with
> python-docutils e.g: rstman is required: install python-docutils or
> alternatively we check python-docutils with pkgconfig since it will be
> a hard dependency anyway.

Just to keep the consistency with other errors in configure.ac, I think it is better to say
like it instead of mentioning the package name. 
Also, there is a python3-docutils and python-docutils depending on the python version
that user is using. So it may confuse the user, and the package name may different
for other distros (I didn't check though...).

> 
> > +       fi
> >  fi
> >  AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
> >  AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
> > --
> > 2.26.3
> > 
> 
> 

