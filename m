Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58F6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 10:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiLLKIQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 05:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLLKIO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 05:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416352D9
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 02:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670839634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGXQSPHedGuszQET1W/i2vDSg7R0rzEkGl03y527D0E=;
        b=ObsH68d6sFsVHt1SBdWYglNvEZS4rnEKRHg69nYuiyyP7t+uu5Cle4+yo6IE1gFl1lEOkN
        WnkiTCrumL2V7fslEWmJHnbJz9HLDNcMKNDtzzPakbgK7tW2gFY4DQc45sm0Ode5hKZaT4
        qiJ5kv3lo5duXvrgxPwRZR6LGyMIg9c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-Ity_69WIPx2siis2HxWa-w-1; Mon, 12 Dec 2022 05:07:12 -0500
X-MC-Unique: Ity_69WIPx2siis2HxWa-w-1
Received: by mail-qt1-f200.google.com with SMTP id fg11-20020a05622a580b00b003a7eaa5cb47so11092217qtb.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 02:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGXQSPHedGuszQET1W/i2vDSg7R0rzEkGl03y527D0E=;
        b=LzcIoSlYY4e4B9/l739U6Hx2XR0keXUI3I5tORdmtacoWCYUAiiAK2/b2uOGEMEd/3
         xf4vfxOQDW5s0TPkiOzMomnMWtPoozbNuntLLeXsT2LndHrtoBT9f4jRR0m/BPwDTWdZ
         UmBK509bmxamOT90J6NJzLHJYY179VRQ/hT81r65713XvbU9AqvbhvPhVW+foWaOZECG
         cGAmUX7tbJSZJ2jno5Fh9YvgaMyzuB624fi9OWpuzXZcUs5lIgYD3t0fHztnL9dBSkdU
         /Q7+p7zjCUubUPy6moocvkDHv6vfUeeo6VFrUzyLiCbtCi5ycnVAS5+iPaxGLObHqj3j
         jmyA==
X-Gm-Message-State: ANoB5plojPcFnzJirpVVnzSAqU8BMTVJQLRRtdxh85w0ywKpIxGCtqcd
        3ZOwp38MCUqGcovb2DBDFBBcADLcK6qq4w4B9OSQrNw9oId66keByXfZANyyQztVC+sRxSb1iIG
        vn5fsq1udSvmT5Tr6s6Jr0xOVT7oDVLZhoFHuWmes078H
X-Received: by 2002:a05:620a:12f1:b0:6ff:aaca:3c2f with SMTP id f17-20020a05620a12f100b006ffaaca3c2fmr13874qkl.635.1670839631795;
        Mon, 12 Dec 2022 02:07:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7kYzmPZTPlUVlBdzjQYjc9aqulPgQXBB3rVsB44v/UqrPZRZur/Zbp7Ms5mj0yDY19rs0tmlAFueFhfAigk+Y=
X-Received: by 2002:a05:620a:12f1:b0:6ff:aaca:3c2f with SMTP id
 f17-20020a05620a12f100b006ffaaca3c2fmr13870qkl.635.1670839631569; Mon, 12 Dec
 2022 02:07:11 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
 <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
 <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com> <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
In-Reply-To: <CACT4ouf8vDzhXkFAOh-LAbi1GKYp66YNMG_5VrkW0CqnxVBt0g@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 12 Dec 2022 11:06:59 +0100
Message-ID: <CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 21, 2022 at 5:35 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
>
> On Mon, Nov 21, 2022 at 12:08 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.c=
om> wrote:
> > > the fw 74 seems to be a different issue - could you post more info ab=
out
> > > separately?
>
> This was my fault: I was checking many different things, and I checked
> this with an outdated kernel. With latest wireless tree and fw-74 it
> works fine, both with the patch from this thread and without it. Sorry
> for the noise.
>
> So I will wait  for this patch to be posted so I can backport it to
> RHEL, but using fw-74 also fixes the issue, as you said.

Hi Johannes, following with this: will anyone from Intel post this
patch? I can do it on your behalf, but I thought you'd prefer to do it
yourself.

>
> Thanks
>
> --
> =C3=8D=C3=B1igo Huguet



--=20
=C3=8D=C3=B1igo Huguet

