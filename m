Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE14C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B726101E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhHIUth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhHIUtg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 16:49:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D5C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 13:49:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id by4so7883137edb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtG2SKcqzTRDzOIRWaryRXW0Pnq2PB5zWj0AxQ8r3/w=;
        b=WPs+rLYrU4u0D3LSY9OI6KG1OSPoLOHfV50aHv3R7s4IjUp2xuyga1WGpKdY5FxMtB
         peuN1PHKyR6aeWu0Ql4BDfEliUyr2KRF4+G4PTaAeJNRHmM189mHrAk2s8UzvT1hO72u
         5kOWEM5tBvH/DtXVs/VNMHo1C/t97LS06KXmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtG2SKcqzTRDzOIRWaryRXW0Pnq2PB5zWj0AxQ8r3/w=;
        b=B01F8wEJPkUnBHFQL4GXuMEbSTeSRy3rf7fhjrN3Ua5cL4NvAqtpjRuqaodln73Oyw
         TIdFKnRDB2MX6KHqZsnGMPl8IjJ1qTzYliqFfeWbSFyTnbu49/IaRlE2bR2yUY/ZYv2j
         CP7HaGJ3/FxUVUtRKwI0RJXtWmO9kOspHmc5+lurXzysm/ljMwNHKjIYjv4ThKWNAaPu
         NrrBIivvBiyPbTjae5PtRCnhoXPCLwyrZxFzeQnQH50wvTLJ1F27tBbl63cz2TRXT11o
         pHy3X9qUtNDo2mMQXNbFES1UsdHqxbhbtpcMYuFZUkbvQw9XCvA5sA4nLH29XN3TQP0U
         0Dbw==
X-Gm-Message-State: AOAM532CM/qZvktz0aLC2D91w+PlqIq2MIq0ZQEqk0Uq1pXjLpia0euZ
        hpg9ezYR3NatxnkxH6jFzhGzjCRgXZPl2CMr
X-Google-Smtp-Source: ABdhPJzfQttE9zNB+eECriwJMT5e30WisRV6a2iPnrRCkWEn5SJC0u58dGN3uySlJMKLcSTkvBMcfA==
X-Received: by 2002:aa7:d815:: with SMTP id v21mr234848edq.262.1628542153988;
        Mon, 09 Aug 2021 13:49:13 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id i17sm2282479ejo.121.2021.08.09.13.49.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 13:49:13 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id b13so23137920wrs.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 13:49:13 -0700 (PDT)
X-Received: by 2002:adf:f809:: with SMTP id s9mr4284552wrp.370.1628542153088;
 Mon, 09 Aug 2021 13:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org> <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
 <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org> <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
 <391e3587-bb19-05be-cc36-08a8c91916de@somainline.org> <CAO271mk0N4yyA74kzB14y8nbFKfT914JNA7Hvq8QMCfs-VR2zw@mail.gmail.com>
 <656381df-01bb-ecdb-a782-79bd8bd05423@somainline.org>
In-Reply-To: <656381df-01bb-ecdb-a782-79bd8bd05423@somainline.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 9 Aug 2021 13:49:02 -0700
X-Gmail-Original-Message-ID: <CAO271m=hQV8ooxAtL0iFO2A1Nw92cq=1DiciivDRJtiN_CHf9Q@mail.gmail.com>
Message-ID: <CAO271m=hQV8ooxAtL0iFO2A1Nw92cq=1DiciivDRJtiN_CHf9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Aug 9, 2021 at 1:31 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Sonny,
>
> On 8/9/21 7:46 PM, Sonny Sasaka wrote:
> > Hi Marijn,
> >
> > Thank you for following up. Chrome OS has temporarily adopted my patch
> > to resolve the issue without changing the audio client. We will pick
> > up your patch at the next uprev.
>
> Note that these patches are still draft in search for initial feedback
> on the approach, even if the implementation itself is trivial.  Does
> this mean you won't be able to test this locally until the next uprev?
> Either way I will have to confirm their usefulness in PulseAudio too
> before actually committing to this, so there's no hurry.
Yes, Chrome OS is currently not working on solving this issue since
there is already a local fix. We will adopt the BlueZ fix after your
patch gets merged and is available in BlueZ future version when we
rebase with upstream in the next uprev.

>
> Marijn
