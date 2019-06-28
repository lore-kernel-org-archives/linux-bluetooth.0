Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6686CC4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 17:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27385208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="AvGpx5GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF1RSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:18:49 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43508 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF1RSt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 13:18:49 -0400
Received: by mail-lf1-f53.google.com with SMTP id j29so4430311lfk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jn+5vBmHqSJS3qpAyk/O56B7fjRzVlbPtxiwOZe4gZQ=;
        b=AvGpx5GKVVDnmX3gWHwPhzSs4hLfCIot/4lMLiFR/U8qKgxDKA5XMkdrtaZS0FinUr
         aHzosQTChbSX/Tn0KTcEkbM5cukI47Bnxm1ZzbsCfb0RZcOhiks81ftiQ0oAL2Ub6HH8
         0zOsKN1/g/btmigGE6zk7d25zXzRtw60o1b9OCpPn4vfPHwXd0mSYsiAGyxw2bDgn4dM
         5Whb4tyYzDWlgv0QNOfTi/4bYY5cAeLQjYrVNxc7VepevPxoasHt/VLEBtWKlbO3pRtC
         Um9w6V4BkrKRSYirIrUbC+/FdN/aKKr3rrA4185J3mE9kWVzvqvXqiDFsfg3ghv7ntpt
         R1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jn+5vBmHqSJS3qpAyk/O56B7fjRzVlbPtxiwOZe4gZQ=;
        b=AfjCY/DYWNT0STMTBQQDIzHSO8ehTX7fTvnEBY87/N5INf9pLR53OM07SLZg5H+JWW
         anQUOfniNow0X/oeHxjTF+hZpqFVNchs0mXZ2QJ2CGPmtyK/eGWMvxMVXcJ50KH3+uZw
         LTrjaEVDwGPkFqvBZfctDQb3yofysEAwNc7JPFXKudXTEp71JqCNRqR6/vQXMKnjfZRH
         YBgAC2V+nzROkmR2rhH24S1/LcSavPtvCbe5LFX50lS0PQCKANaoS9RrUNcpR/uea16V
         LCufpZ88QUfyFDwvWhvwaJ//d2XKcrYygLMxSTG+Ss3mOu0McGQkcxrxS9/MqAujr/AI
         SVJw==
X-Gm-Message-State: APjAAAVsKMz8YocPFjD20bV+y6TBrQ3EcAMOYf95N85RCWM+pY5vQeN8
        WyWD5hOYxCu3WPtPXmnqSDt2jA==
X-Google-Smtp-Source: APXvYqysEbS3XdvUIec+myr+F6+vn9eR2wshlLn7xaaipuiuzxbcQEUop/GYcxHDeiHfPK7imFnZzA==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr5653300lfo.63.1561742327374;
        Fri, 28 Jun 2019 10:18:47 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id k4sm915621ljj.41.2019.06.28.10.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:18:46 -0700 (PDT)
Date:   Fri, 28 Jun 2019 19:18:44 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Message-ID: <20190628171844.3jy7lvwewff2i7c6@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
 <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
 <20190628132932.bhcvcx4tzlfkertu@mlowasrzechonek2133>
 <1561732393.7802.50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561732393.7802.50.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 06/28, Gix, Brian wrote:
> > I have a question here: what's the idea behind net_index argument in
> > this API? There is no such argument in regular Send() call, and I don't
> 
> Unlike App Keys, Device keys do not have a bound Net Key...

Right. Thanks for the explanation (and patience...).  I'll send v2 after
the weekend.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
