Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF381C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867522073B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 14:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="HLZhAQoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgE0OK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgE0OKZ (ORCPT
        <rfc822;Linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 10:10:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA012C08C5C1
        for <Linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 07:10:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l27so6172071ejc.1
        for <Linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3ChsXwgtsdDHA1e6pctmj99FS/CCPNNaSdj5UWBamA=;
        b=HLZhAQoQEL5cGLM16CKyDGUiOSEF4CniuvXjMi1sdtXtdJ7qdUJqj3kTwhKF3W9fho
         1nkxUNVshJ85K+vkV0dugnuyur29CKPkxEXfl4puUTg0gGXHC9rLe7yfP3b98HLnISFc
         +FEe4SRTAWuS+lkK99gu84uT57pijMml/ND+UrXANA+uCOGPtwBUVgQJf8JLS87ONE2H
         VP5SqpHNpAVKALYKFH01A9lNPW9xiT6pqgSjNbWa+GwZNYfVlVkWD4SGT0m+IqrPqgYN
         EGG2QuwBQHFiP/ePY9FU69+ygJPFxTxFHOW1LE6JXYGE1cImddYZc378CK2GiBCND9Sb
         aQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r3ChsXwgtsdDHA1e6pctmj99FS/CCPNNaSdj5UWBamA=;
        b=EQ8aQmGKBQsU/USGPeqPf+0d6pqaTgOUusWak+8/tvQkyVz/f+AjjNMi/1My//ejSD
         XmheTwOOsfeZB8KlJYletzGqjmw8uRziY30dfP4VOhw5HjKaFfBPKCUQVElnmTH5GuYr
         c1yT2QQjkUv6K4+RExspL3+c1pufj1QSMETirm494WJ10J5o8B7fwAcoVOdB8Q2iwVGc
         yfe/yfwqPQMAlzws1Q4FXSXFVBEl8hnrRk3XPX0aE+36oLS/U4GItF0W3guN3vmRa4tZ
         nDPJ5YYffQs21xj0Vmrfdl9sPJ4wyJya25EASNqwJnkeQY9sSdPhO0jt4b6kEc3aZ9OX
         bJXA==
X-Gm-Message-State: AOAM531v7cg9M6IAeyXFeUcpwGqAC+5f5P5Ynl6EkxAS1r5nuo/VHX0e
        riUgQYR+zCXyqXy0+a0bdCoH1vn5AKQ=
X-Google-Smtp-Source: ABdhPJwMXi9Nl1W2TKeLEmKK6VS1MGAup/Bs2KlxP4HKRqZ1QwlkrrdBNCs8+pQOhdz/DDEde3U08Q==
X-Received: by 2002:a17:907:9f0:: with SMTP id ce16mr6126270ejc.476.1590588622554;
        Wed, 27 May 2020 07:10:22 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id y16sm2910700ejq.82.2020.05.27.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:10:21 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Martin Woolley <mwoolley@bluetooth.com>
Cc:     "Linux-bluetooth@vger.kernel.org" <Linux-bluetooth@vger.kernel.org>
Subject: Re: Comments on the ConnectDevice API function
Date:   Wed, 27 May 2020 16:10:19 +0200
Message-ID: <11527909.O9o76ZdvQC@ix>
Organization: CODECOUP
In-Reply-To: <DM5PR17MB1963CCA502759CB08EB9FFE1C5B10@DM5PR17MB1963.namprd17.prod.outlook.com>
References: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com> <CABBYNZKonvHxnabQsu84rVQEPpou45UgqVUECZ2HoTdd7pWT+A@mail.gmail.com> <DM5PR17MB1963CCA502759CB08EB9FFE1C5B10@DM5PR17MB1963.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Martin,

On Wednesday, 27 May 2020 15:41:12 CEST Martin Woolley wrote:
> Hi Luiz
> 
> thanks for your response. Much appreciated. I must confess this is the first
> time I've used the BlueZ APIs directly (via D-Bus). 
 
> I'm all for hiding implementation details where possible in APIs and making
> the API itself take care of conditional aspects if possible, but these were
> just my $0.02, no more than that. I wasn't aware of the background or the
> philosophy, so thanks for that insight as well.
 
> Having the API take care of the AlreadyExists error by providing a
> connection to the already discovered device, transparently does seem a nice
> touch for the application developer but certainly not essential.

This API was added only for qualification purposes (there are some GAP tests 
specified in a way that upper tester is not doing discovery) and it shouldn't 
be used for 'normal' usage.


 
> All the best
> 
> Martin
> 
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com> 
> Sent: 22 May 2020 18:49
> To: Martin Woolley <mwoolley@bluetooth.com>
> Cc: Linux-bluetooth@vger.kernel.org
> Subject: Re: Comments on the ConnectDevice API function
> 
> Hi Martin,
> 
> On Fri, May 22, 2020 at 1:25 AM Martin Woolley <mwoolley@bluetooth.com>
> wrote:
> >
> >
> > Hello
> >
> >
> >
> > I've recently been working with BlueZ via D-Bus and have a situation which
> > requires me to be able to connect to a device whose Bluetooth device
> > address is known, but without first scanning. This is a link layer state
> > transition with the specification allows.
>
> >
> >
> > BlueZ currently supports this via an API adapter function called
> > ConnectDevice, whose status is currently "experimental". From my
> > experience of using this function, it seems to behave like this:
>
> >
> >
> > If the BlueZ instance has not scanned yet, so that the target device is
> > not known to it, the ConnectDevice call results in scanning taking place
> > and then if the target device is found, it is connected to. Success!
>
> >
> >
> > But if scanning has previously been performed, regardless of the state of
> > the actual device (e.g. advertising and ready to accept connections), an
> > exception is thrown with a message whose text value is "Already Exists".
>
> >
> >
> > I was wondering if I could influence the design of the API before the
> > ConnectDevice experimental status is removed?
>
> >
> >
> > I would like to suggest that there should be no need for a special API to
> > connect directly to a device without first scanning. Why burden the
> > application developer needing to call it just in case this condition
> > applies, catching the BlueZ exception ("Already Exists") and responding
> > by then calling the normal Connect API?
> 
> I guess the intention was to have the application use the intended API for
> devices already present _before_ calling ConnectDevice, so before entering
> the address manually the application would enumerate the existing devices
> and figure out if that was already present.
 
> 
> > An alternative would be to accommodate this special case (not scanned
> > before) in the implementation of the standard device Connect(bdaddr)
> > function or if that makes no sense because Device objects must correspond
> > to previously discovered, physical devices, then at least the adapter
> > ConnectDevice function could take care of the two possible paths and
> > simplify matters for the application developer.
> 
> I guess you probably know this but just in case someone look at the archives
> it is better that we make some things clearer, while the core spec allows
> connecting without scanning D-Bus are intend to be a higher level API thus
> why ConnectDevice was not really necessary for a long time and we just
> introduced it for qualification purpose or when there are multiple adapter
> where one acts as scanner. Also ever since the introduction of privacy
> (random addresses) APIs that takes addresses becomes rather complicated to
> be used directly, and there exists ways to scan for a specific address with
> pattern filtering:
> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
> l.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Ftree%2Fdoc%2Fadapter-api.txt%23n
> 122&amp;data=02%7C01%7C%7Cfafcb0f940054867612508d7fe7866fb%7Ce4e0fec5fc6c4dd
> 6ae374bdb30e156b9%7C0%7C0%7C637257665400787125&amp;sdata=Iy%2FwWkxs%2FyW3gL2
> 39FLWdoDRGa0apb63WxMhYwRoneM%3D&amp;reserved=0 
> That said I don't oppose to remove Already Exists error, but we should be
> very clear that the use of such API should only be recommended with users
> input and does not substitute the likes of Device.Connect.
 
> --
> Luiz Augusto von Dentz


-- 
pozdrawiam
Szymon Janc


