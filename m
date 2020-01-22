Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC31C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035924125
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 13:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="QiY6x/Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAVNxr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:53:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgAVNxr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 08:53:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so7299987wma.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TpJ00RjhyarGuVDFXHxiq2+1L4PDDN83aH0IDxmE/dQ=;
        b=QiY6x/Y1MkmATQe5q8aF0HbmjVmJe7uFT5wkhaJuwCPPedzE26pEPzZh6g1WC+E4Rq
         /H98rTqwDeFNLiC3Dvu2cSQchR9DpC45g+jTPwHvJ3EaEZzibV0ctmV6U6yEXlM8EIut
         OwvGr6g6rNmJUDmiJAO/hOXLF79OfUHcfzYaaY6wVWmY2t716THcS3xL4L59var51Fu/
         PA6R/wl0gUCayv9CnjdYw++eA1fZmxMGxv81QjnxF0rSythunjaKsWCbvgcRTnD3tRqc
         udm2bKJ40OhJFuRgjJwuD6udRQY6pOFhn6ejR1I/cbDbAnhWlWAlWg4JnL1bjIOTye9C
         Okcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TpJ00RjhyarGuVDFXHxiq2+1L4PDDN83aH0IDxmE/dQ=;
        b=od+1KId+l7PoT+yQfIyxoNjwbnEajawf2JL4KkJyi7pK39tdFrZ88pwmmd/nKbt06C
         sFtmkq8IkK75ADalsjgmawz0O9HW2+Tj7jnnAAZi5l71I5vSUPadVLVJq5EGc1yIg0jT
         OXr/Vefh2W+Egg5mc4d3FyeIq8ZSFLhSGkdZn6zs02+HS5PoLbv9W5QP2zu7TazgClPB
         Cnpuf56bv7OgpYX4LT/HGUpUzV70G6hswgyRH4NdMTdAe4+NeVK7v8kcSqi/2US80ZD3
         Gu8YxkJAz5MBE15eCcOcOma2/pIjyoQvOqPUditLx6YOKwoVCZHh4OodlZNMrFuQgrzZ
         cvbA==
X-Gm-Message-State: APjAAAVxTTkXd9WuyX5tHrFwJyVcc2X5YSxmB8uktiXuZuS2AN5aV4Kf
        mAwwbwSHi1whgyjf/sAtTqGdNA==
X-Google-Smtp-Source: APXvYqzs/6mA1Dj0pvn3GSDHEvvBLijwakCXvlWSKi3WQEtWdac3r2Q25AP/lVUT1m+nZ0IDgs9dsw==
X-Received: by 2002:a05:600c:54c:: with SMTP id k12mr3135314wmc.124.1579701224956;
        Wed, 22 Jan 2020 05:53:44 -0800 (PST)
Received: from jwitowski2365 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id a14sm61572437wrx.81.2020.01.22.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:53:44 -0800 (PST)
Date:   Wed, 22 Jan 2020 14:53:42 +0100
From:   "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Message-ID: <20200122135342.2hricyvu4ilxsejj@jwitowski2365>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
 <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
 <20200121105927.s2a3avh7tdcnf566@jwitowski2365>
 <2565ef678df9e316ac980937f0f629aad83703b6.camel@intel.com>
 <20200121200524.olwlsw57xcrio5lq@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121200524.olwlsw57xcrio5lq@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,
On 01/21, Michał Lowas-Rzechonek wrote:
> Hi Inga,
> 
> On 01/21, Stotland, Inga wrote:
> > I would strongly prefer not to allow changing CID. Is there a good
> > reason to change CID ever?
> 
> I don't know, maybe legal, after acquisition, or something?
> 
> I don't see any practical difference between these 3 IDs - nothing in
> the spec is tied to them, they are informational only. So maybe keep
> things simple and not add any "special" logic around the CID?
I fully agree with Michal. Do you have a reason to treat the CID
in a different way than PID and VID ? It does not seems to have a
negative impact for the BlueZ.
> 
> -- 
> Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
> Silvair http://silvair.com
> Jasnogórska 44, 31-358 Krakow, POLAND
