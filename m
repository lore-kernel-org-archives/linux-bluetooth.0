Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1475C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAA6218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atO8Ptv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGCM7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:59:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33511 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCM7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 08:59:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2733306wru.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HfKtndbUUkdzNrNjom1D3JuyiXLqJs7Ey9F9Icz4/JM=;
        b=atO8Ptv82la1ibaEcC2YbR7lRmXieW6nArOgNxRx/F8sd1uwZa5qBoi6eywNAVGJE9
         fhvNbEt1vExHHhPfO30jRix23BO9vx4mcs8myKW77BTnWxPQV8Y06qyr0bjFwSlNQMzR
         NFKpgeVDtR3wJiPc3IsRf9Clq7B6L1hHpW60r59HuVeH7wHD+f/m0+aOrqRsld1iTXca
         AdAG0f3te+ofnr3Qa9wvIIEH9zfEial3o61P3QAOR8+QZo1Zii9ZmorKclhOwkk3MSJi
         er5oAIv7UMJnPc6MfX+bqxODm7CRHsQEv7ypLNZzxpR/oYF2v87hHhvf8VVysXzmzDJn
         vrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HfKtndbUUkdzNrNjom1D3JuyiXLqJs7Ey9F9Icz4/JM=;
        b=dseaIb9eiv0FBm8yvF/cb8QEkxNVcIsB5Kq+2nkidZXLFcF6Aqb5HoEhj3vR7dNtzx
         EfFp4dHE6Q4+ygbNLl4dGqoq9+LwABw4spN7053XjbTLxHNbOAhCm7Ql2W3zVbpkSyTU
         TaFs++xO5AZ0FN8a/omw1E0ARPtlMzrAIulhf7FHWqxJMfj4AtSwUgzJk1uB7IgVypqG
         39NEdvHqH8IiGRKGAf5xzeQn/UcYHHA7lv2BICtB8YL6nWqE1dIqP9NeeKk4R/NUnnX4
         uMpvC4MoeX+nMjjDtYa8L0s8k6W22VVHlU7GlS4Q/lvRKuOWAixnXg+0HndK3n+Euj2Z
         Hr6A==
X-Gm-Message-State: APjAAAVd1QW9dl+fFrSNYfH+wNGVAX1TCKQVBk52qQc79mXix2TpH1oK
        wiPR3HY8mDWQH9C7SN2lh4E=
X-Google-Smtp-Source: APXvYqzJgeFYGLwVHODTDEB7TIA9guL1kAAk9ybNdDUrmaTyC8x08lS/PoaDtxlZJTIJJXUtV+2gXw==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr31294281wru.27.1562158745732;
        Wed, 03 Jul 2019 05:59:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k63sm2659872wmb.2.2019.07.03.05.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 05:59:05 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:59:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: install a2dp-codecs.h file
Message-ID: <20190703125904.4fywymmawb52bxb7@pali>
References: <20190324142058.neuunjf46lgwcrgh@pali>
 <20190406145222.so7oyma2gme67pfn@pali>
 <CABBYNZJvs8SEGVcQPO7ZdkLoKAkWJmjton3wZqOn++u=J6m5=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJvs8SEGVcQPO7ZdkLoKAkWJmjton3wZqOn++u=J6m5=A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 15 April 2019 10:58:53 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Sat, Apr 6, 2019 at 5:54 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Sunday 24 March 2019 15:20:58 Pali Rohár wrote:
> > > Hello, some projects like pulseaudio is re-using a2dp-codecs.h file. It
> > > has own private copy of it. To simplify sharing this file between
> > > projects, what do you think about exposing this file as part of bluez
> > > API? That make install would install this file into system and other
> > > projects like pulseaudio could depends on it.
> >
> > Hello, any idea about exporting this a2dp-codecs.h file?
> 
> We don't actually need it in BlueZ, well except for BlueZ for Android
> which apparently has no users. But we could have a way to fetch it in
> PulseAudio, afaik that was something similar going on some year back.

BlueZ itself needs it for avinfo tool (tools/avinfo.c). And also it is
used in profiles/audio/a2dp.c file.

-- 
Pali Rohár
pali.rohar@gmail.com
