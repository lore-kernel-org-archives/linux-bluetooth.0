Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EFCC4360C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F7421855
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="AmGqm5Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfI3JL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:11:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53397 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfI3JL6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 05:11:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so12469857wmd.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2019 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5M+HwSMM3z0B/4NSmHV0F6tcj5zTP61uKDz83eBWF+g=;
        b=AmGqm5JlbVaqAM3KuY+X3npqPYtTpTTNvI4Uo+B/zN7KPKUuNzYRX+riDut+FFwKDu
         4fHzn4KRdRyDSd9WS4eHlvmydOYyLAMsBcwlYCkkrJxiGzWVjdL118QkpGI1Mzgddne8
         /HomGTJwN5QblN95ux01UZqdH0Lt/W55vqnbKREJ3EEq97YYQ+QNlnu4o+NAQ5mY8C+L
         4Vpfa4ShMGkuz+e/Lz0BG32f874i1P529xX0986p6Ja0NcRYY6Wp8eoU513kMWinGBGu
         pQ6h4VLsYJA+BeA33gH2h5n70L+7eLgZ9XRqMjXuoWNTS3s82imrlNHBHEc5JYGmGy2O
         9syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5M+HwSMM3z0B/4NSmHV0F6tcj5zTP61uKDz83eBWF+g=;
        b=b8FcxTgxc5Ng1wrfpRAQk9WPF7Z6/cDjr57qX7RvcMJY0z3r0ij7hgCKSgeq3s6ACs
         RTZU++hCfvlzSKyvNNFhveypcMFctO+XrHjpVXhhXJ/MNbRxHnS6MNPpzX4x/+s7jcnm
         M6ID7u2r8JoavP89Snkdo3pJLIoetfA1Ajru1AzUV5poYMyKsDIPfi2g84wVuOXIR0p5
         OfUWNH1TrWDfPtw8bzu5wV4UsN44AM8F8PzRgrbzPqnyqB7XxP9e4wdPbLlkNN8FL0/0
         2DJQhalng69JbSDRtp2AAjEPpHI62ZDJ4fJc2qXFn4FKr7URPCkbR2c/TocZYdLBsHXT
         z5+A==
X-Gm-Message-State: APjAAAWYANBrnUpUPpZYzhFBkrM5Ga4R2+b0Al37AIu9Nr6Ur7EnXQ2A
        A7EMziLF2u4eIZIksDysfW0iwtMa11A=
X-Google-Smtp-Source: APXvYqyu4zEodXjQdFXBLM9176w5o0PzSgh9Q0oV9aFjsZrzlkU68nQal4UCwXDJ/qjjZawjDlEBKA==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr16766622wme.105.1569834715190;
        Mon, 30 Sep 2019 02:11:55 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j1sm26809472wrg.24.2019.09.30.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 02:11:54 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:11:52 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Message-ID: <20190930091152.btiobgkhewksbuim@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Brian Gix <brian.gix@intel.com>
References: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
 <20190917065338.nfwumstizy3yw67d@mlowasrzechonek2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917065338.nfwumstizy3yw67d@mlowasrzechonek2133>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 09/17, Michał Lowas-Rzechonek wrote:
> On 09/09, Michał Lowas-Rzechonek wrote:
> > This patch ensures that Sequence Number is reset only when IV Index used
> > for outgoing messages increases.
> 
> Did you have a chance to take a look at this?

Ping?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
