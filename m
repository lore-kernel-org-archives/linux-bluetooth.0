Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6671360F02
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 08:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhGWHji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGWHji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 03:39:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B93C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 01:20:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so721806ljq.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/7zkjvOkARz02kiYDMoiuVEtsO92RdfxmgFCQhzDFE=;
        b=D5MAZIDtEAiLTP2fgn6tNboHLs+fwvt9jnutWvimrwqTYZCyWinx/ewlAXSMdW2Fsa
         UEnMnG1StGLY3ei6FqUYhex5bEibbyZYkS62XdAmJ96S3ZKX0iUev/Cn51x20GhoO37P
         35x7l4wVjrSUqMxGRqU4Viu2u/hEI3s6tHGxI3YUsVwNXOIzjiXdRBD+pV0cw/h2iih8
         yxO3XIc6IV/L9hO0vkwf895hDCxxUI2boYDpn6KHc0LY/I3Yc7ARZmBBUsUt868eXTv8
         IcqElVMkKgPt1HLNNO78nNb7bF6AIgT71z2Fff2MG1enXqmI6O58ahSHpttj4ENCad3F
         DtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y/7zkjvOkARz02kiYDMoiuVEtsO92RdfxmgFCQhzDFE=;
        b=LWAxUFKZmZDCNzwnYBl0KGlgoRmkMitLrmPUow8ZFsKHixuNA7TU+NYnIGnK2mZt2Y
         Fp79QeGeHc0aNWi3Ao9bhfycb2dzB9azWrV1asOqsAvSyQ9ZgZala5OlUs65+ZGlDm4d
         uMXeDhKAQKuaX2QVotTOsKF2sEicrRcrScCmILr4fTqSDDll7p+zPoEBO/NyBIjBC1uj
         Jj7ByeVZf/WAcOD5LI09UJql7yhv5MGJ6uiK5ZC38F0LzUBoGYNbv8ZRC3ncsKQ/9nTe
         J4zhSQVI7EOKysSMzZXH59ghGKIMc1abAXkjbSQDjB9uazzpbQE7eN3ShWAXEOwhZ5nt
         5gDw==
X-Gm-Message-State: AOAM531gmb6O+yqJnKNPpr/F0/1KzYNEpjKEGUhFtaWzlTK0viec3nmQ
        thIw2dlV9qROLGIF5A7PR17CrMQLPQCk8g==
X-Google-Smtp-Source: ABdhPJxE474wcVylGRk8UHmHu8Ol4EakSVBMnfycwKG7PC+6BFybSWpOXFfu9+BIInnk5AT8ZZdwlA==
X-Received: by 2002:a05:651c:a06:: with SMTP id k6mr2573335ljq.435.1627028409505;
        Fri, 23 Jul 2021 01:20:09 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id h10sm2168117lfp.151.2021.07.23.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:20:08 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Alain Michaud <alainmichaud@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>
Subject: Re: [BlueZ PATCH v2 1/3] error: BR/EDR and LE connection failure reasons
Date:   Fri, 23 Jul 2021 10:20:07 +0200
Message-ID: <2206189.ElGaqSPkdT@ix>
Organization: CODECOUP
In-Reply-To: <5350EBBD-7F81-448E-B96A-A1C09F8EC676@holtmann.org>
References: <20210626052152.2543526-1-mcchou@chromium.org> <CALWDO_V6y0sCVOGJjCfn7eqQ3RAc4NHqsFbXxRmGvnzGxU26ZQ@mail.gmail.com> <5350EBBD-7F81-448E-B96A-A1C09F8EC676@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Friday, 23 July 2021 09:38:40 CEST Marcel Holtmann wrote:

> >>>>> What is the intention to split BR/EDR and LE here. You do know
> >>>>> up-front what connection type you are. Trying to figure out from the
> >>>>> error code what connection you have been trying to establish is plain
> >>>>> wrong.>>>> 
> >>>> In fact the up-front connection type is not necessarily known. In the
> >>>> case of dual-mode devices, such as Bose QC35, a D-Bus client can issue
> >>>> Connect(), and it depends on the timing of connection request (adv
> >>>> usually arrive first compared to inquiry result), it can be either
> >>>> BR/EDR or LE link being established. Another aspect of this is the
> >>>> metrics collection, where knowing transport can be handy. For
> >>>> instance, we can associate the certain error to particular use cases
> >>>> at application layer, and that can help targeting the bottleneck to
> >>>> tackle.
> >>> 
> >>> Then we need to find a different way to convey the transport chosen.
> >>> Doing this by error message is a bad idea.>>> 
> >>>>> The description is that you want to know exactly where the connection
> >>>>> failed. And I think that can be established independent from the
> >>>>> transport.>>>> 
> >>>> Indeed the intention is to know where it failed exactly. However, as
> >>>> mentioned above, transport information is also an important piece of
> >>>> information to know.
> >>> 
> >>> We need to find a different way to inform about which transport failed
> >>> (or better which was chosen in the first place).> 
> > I would love to hear your thoughts on an alternative.  Many of the
> > Apis are transport agnostic (Connect/Pair may end up connecting to
> > either available transports for dual mode devices), but yet the error
> > that results from them are not.  Errors from one transport doesn't
> > make sense for one and vice versa.  A platform wanting to leverage
> > telemetry and metrics to drive ecosystem improvements would ultimately
> > need to know the difference even if the applications may not need to
> > care.
> 
> and we might have made a mistake in the API design and should have given the
> caller more control. We need to review the API design and see if things
> have to change. Just glueing things on at the end makes me suspicious.

Some (5, wow!) years back I've loosely proposed split for org.bluez.Device API 
that was meant to handle some of the dual mode devices issues we've been 
seeing [1] [2]. 

We never got time to fully implement it (mostly due to hacking around device.c 
instead of properly splitting internal implementation into device_le.c and 
device_bredr.c) but got some very initial PoC running.

With new interfaces old Device1 could be simply super-set of two for legacy 
applications purposes.

Maybe such approach is worth re-considering? 


[1] https://marc.info/?l=linux-bluetooth&m=145710680912268&w=2
[2] https://marc.info/?l=linux-bluetooth&m=145973293118003&w=2


-- 
pozdrawiam
Szymon Janc


