Return-Path: <SRS0=NsPc=YL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7889CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 11:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22720854
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 11:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOi1W2bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442682AbfJRLax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:30:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbfJRLaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Oct 2019 07:30:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so625557wrr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2019 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SWLBIQGMJYGX5n2ku3XF1XhogJ7lGjdSiFW0sEQEvJ0=;
        b=uOi1W2bOhhbkv4b/bLU4coqoPC4QjkTogf8JyE2wCuN1cDV62zPB8A62ycyKvgx4fC
         3ImJqsIdV/BK6FgT0RuQ770aTrUlVrwzArk6ZcIIi9T/hbPzFd9cM1WvMILfhq1Ue8E2
         kgEo2lUVv8whjIdIrttQFqqwKJjkfDF4G1XzHxXej2GQL24qvCyyNMgMma87G91hLDL3
         dvDG5tNPI5ylY5HrAuKzWByPT3Ps2l2k3n6BJKFAGmq9pEnghAYzvDF4gq4peZRB1uYB
         0/SaXNpw1sfB0D/C5vjKHp3/0SKi/XLs0lAKIMlB+2+OHg1Pi81d6vp60n0570v1r2s6
         fkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SWLBIQGMJYGX5n2ku3XF1XhogJ7lGjdSiFW0sEQEvJ0=;
        b=pM1UW5JXYX2cZLGt1IFxUVAlnQ8XwrzI26ixnVmx6196Q3Mz+pX15jy6wVnxZ211T/
         3JblVqS3V9qDcDdvbn5BzLf3OujnMW7UHNQbuPGsmF0KRtEg5Gie8tqcf8L/wsLUIUMk
         PjsWNIi+3Zs81I9SmXOqT54nVLUruyEdFjhk/x94YrI+hOXxHWjBfJL9/mLUTtZWHrvK
         KgSH4WBaHm36CwQLw/7gIEMRlgTT2bnJ6/WSC72kS1EOtx0toL0fEGMO58r6YxP8Xlk/
         IhXISdxfgKOGBA1wZOI1JFtfWKGgO6UNniyt76C1kpk53O2AHg8yD9r1crn0ZcQkGz4E
         XAxg==
X-Gm-Message-State: APjAAAW4m6TvcNc6exdtCFqH0ryaiTFpcnVthkV8G8n/8e1j0rgPSycg
        LDh0CCxUTodNNyGFjgYXdqU=
X-Google-Smtp-Source: APXvYqxXRDhNnva6H07rIZ3k2EuadXjSFhGfi7iwofrKdzh8Zq2wYV27eEvK60QwPXN5ubLh5b4X5w==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr7806691wru.237.1571398250137;
        Fri, 18 Oct 2019 04:30:50 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p10sm6240823wrx.2.2019.10.18.04.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 04:30:49 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:30:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20191018113048.eshtc4gpxsxlb3mc@pali>
References: <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali>
 <20191007143307.ez6g466afu3trlxn@pali>
 <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
 <20191008103333.rqn2btlkwtcrpouo@pali>
 <CABBYNZKKUf6-FPBEGjuC5GbsNzNsDLy7LgCHxqiW_g98BaX+QA@mail.gmail.com>
 <20191009131921.ysl3ianpv5e4m677@pali>
 <20191017095957.cce7jzejvn76kwkc@pali>
 <20191018083731.GJ28704@reaktio.net>
 <CABBYNZLnFYV12U+X--cZdoTXqLkwhTFo6U_KrX2+X_N=zLJG1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLnFYV12U+X--cZdoTXqLkwhTFo6U_KrX2+X_N=zLJG1w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 18 October 2019 13:55:10 Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Oct 18, 2019 at 1:32 PM Pasi Kärkkäinen <pasik@iki.fi> wrote:
> >
> > On Thu, Oct 17, 2019 at 11:59:57AM +0200, Pali Rohár wrote:
> > > > > >
> > > > > > So... what should applications expects and how they should implement
> > > > > > above decision?
> > > > >
> > > > > Actually the decision should be based on the presence of
> > > > > RegisterApplication method, if that exists then endpoint switching
> > > > > should be supported as well, so has nothing to do the
> > > > > GetManagedObjects API of the bluetoothd. That said RegisterApplication
> > > > > was not made experimental which kind makes 5.51 broken because it
> > > > > would appear that it endpoint objects would be exposed but when in
> > > > > fact there are not, anyway lets finally have the code to use this
> > > > > interface and then we can remove the experimental flag from
> > > > > MediaEndpoint.
> > > >
> > > > Ok, so can pulseaudio do following?
> > > >
> > > > Call RegisterApplication. If success then expects that codec switching
> > > > is possible and via GetManagedObjects exports all available codecs.
> > > > If RegisterApplication fails then fallback to RegisterEndpoint, expects
> > > > that codec switching is not possible and so register only one SBC codec.
> > >
> > > Also can we solve this problem in bluez ASAP? Last released bluez
> > > version is due to that non-experimental API broken and once applications
> > > (e.g. pulseaudio) starts using this new API then A2DP without bluetoothd
> > > -E would be broken.
> > >
> > > I would propose to remove experimental mark for codec switching API and
> > > release a new bugfix version of bluez, so people would not use released
> > > 5.51 broken version... which could prevent breakage of A2DP in future.
> > >
> >
> > +1
> >
> > It would be nice to get bluez 5.52 released before 5.51 gets released by distros..
> 
> Just sent a patch marking these APIs as stable

Great! Thank you!

Now there is only my question about undocumented DelayReporting. Can you
look at that email?

> when are we expecting a new PA release btw?

I do not know. I even do not know if release date was announced.

-- 
Pali Rohár
pali.rohar@gmail.com
