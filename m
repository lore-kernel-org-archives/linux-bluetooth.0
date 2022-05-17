Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58299C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 21:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiEQV3c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 May 2022 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiEQV3a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 May 2022 17:29:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A4E51E55
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 14:29:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so108995eja.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r9FLg6Ulw4ZMRwdMmm9YktNls1yBqN/+uy4HOs01Dg=;
        b=HW37OyG9lLsh4ynJltyrU99FpZSTIPb3VtYYR14r5hlIp/Sn4fF15iumwpTddHQgEG
         AAdN7XtzcbEkGpVIbkk/DeWdNrZMIOkOCQiIbCIvXM4Anp5fR2OQ7zjnZl/PrYWA9st8
         BNUVGSceaVZOWZHP7dCYMB7Wdao4lFdS6eULU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r9FLg6Ulw4ZMRwdMmm9YktNls1yBqN/+uy4HOs01Dg=;
        b=7Hd5hivP7uzl/JfJUPBqJjh9ax51yNd721W50+vdWe4n3knw6LUBCnmehXhz0/laCY
         kqu1+hgD4/rMufQfOPALSLjyJLz5ASlM7uBKEt9ylSf1grp1+VOw7CYjWwFtRNHC/VR5
         0ef5gsXyS+TSRQiZLcOJ3A0HQGc4F2LLhVuV9qgiDlpLjPIrRNFXgLGXbCgwbk130F2r
         ehz6FoQ8seuNkFqDBVedaOkrwrg/uVchaGdx1y8kTz2W9aIYGucT44mc32IfcAVlUQRf
         b3kmi74MrqJQIFjYLt2NSQtkxOLGnFUi7uUpVSXcNyuHuAkvsMJLPaiYsENWFtjeEuej
         jqYQ==
X-Gm-Message-State: AOAM531Qmw/WWbF8vHUFH34s85H9CKpqG8kQFF4Zu9DiNcA4y42fKSqM
        jj5hbzcLRcAMkBca18tBfAwM+ig1G7f3ZQ==
X-Google-Smtp-Source: ABdhPJzwmAFY3hqdDcds8zI8JAGHMjn007WLLOxkH0qz5d64GGeoiJzD+FFqwARkRx/cVol9HwTGCg==
X-Received: by 2002:a17:907:6e88:b0:6fa:888d:74a7 with SMTP id sh8-20020a1709076e8800b006fa888d74a7mr21461920ejc.335.1652822967513;
        Tue, 17 May 2022 14:29:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id el9-20020a170907284900b006f3ef214e55sm135851ejc.187.2022.05.17.14.29.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 14:29:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id g6so193640ejw.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 May 2022 14:29:27 -0700 (PDT)
X-Received: by 2002:a17:906:dc8d:b0:6f4:75da:2fc8 with SMTP id
 cs13-20020a170906dc8d00b006f475da2fc8mr21307709ejc.7.1652822966540; Tue, 17
 May 2022 14:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
 <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
 <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com> <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
 <307e7ee7-b973-4d15-03fd-31cc6087163b@mindspring.com> <5a1c1826-92a9-f949-9f40-473416ab82b9@mindspring.com>
 <db5b5136-25c9-c334-e5bd-725bcbcc89a2@mindspring.com>
In-Reply-To: <db5b5136-25c9-c334-e5bd-725bcbcc89a2@mindspring.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 17 May 2022 14:29:15 -0700
X-Gmail-Original-Message-ID: <CAO271mn_oxDcZ_uho_3jN=Z0WZY0uQTop59KC5w-CZOC=kSM1Q@mail.gmail.com>
Message-ID: <CAO271mn_oxDcZ_uho_3jN=Z0WZY0uQTop59KC5w-CZOC=kSM1Q@mail.gmail.com>
Subject: Re: Battery1 vs. GATT reporting
To:     Ed Beroset <beroset@mindspring.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for circling back, I appreciate it!


On Tue, May 17, 2022 at 2:24 PM Ed Beroset <beroset@mindspring.com> wrote:
>
> On 3/2/22 10:33, Ed Beroset wrote:
> > On 3/1/22 11:01, Ed Beroset wrote:
> >> On 3/1/22 10:43, Sonny Sasaka wrote:
> >>> Hi Ed,
> >>>
> >>> What I do is call `gatt.select-attribute` on the characteristic called
> >>> "Battery Level", but it is not shown in your case. So maybe this is
> >>> the bug that you are encountering. What is the exact version of your
> >>> BlueZ (commit sha if possible)? Could you also try tip of tree to see
> >>> if this is already fixed?
> >>
> >> Hi Sonny,
> >>
> >> I'm sorry, I should have noted that this is with the tip of tree,
> >> commit bf09e1f048.  Thanks for your help with this!
> >
> > I am trying this from a different computer today and I find that now the
> > Battery Service and Battery Level characteristic are showing up, even on
> > the same devices I was reading the other day.  Not sure what's going on,
> > but I am investigating further.  At the moment, it seems more likely
> > that the problem is either with my devices or with my software.  I just
> > wanted to report back to avoid having you all waste your time.  When I
> > figure this out, I'll send another update.  Thanks for the help so far.
>
> OK, it's been a while, but the problem was eventually tracked not to
> BlueZ but a Qt component I was using.  Essentially, changes in BlueZ
> were being tracked by changes in Qt, but there was a problem with the Qt
> implementation starting with BlueZ version 5.55.  No change required in
> BlueZ, and already fixed in Qt, but I thought I'd circle back around and
> let you all know the resolution.
>
> https://bugreports.qt.io/browse/QTBUG-70222
>
> Ed
