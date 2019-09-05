Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07943C3A5A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE72F22CF5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Q/GlH6ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfIEH3m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:29:42 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41672 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfIEH3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 03:29:41 -0400
Received: by mail-lj1-f171.google.com with SMTP id a4so1304904ljk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Sep 2019 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a/LbM5DPkxpSyrzrkgXmY0H1sRUr/jc8zJFioM5t4I0=;
        b=Q/GlH6MLWuGEBFkqGPragKLorURSgRXTS2fJgKPVwhbHsSbaNH4jaebfl08kUgcWb/
         rovy+MEMaOxldzzGNb8hw0DC18O6YLNuCxO05GzFO4OEGwKI8AGSNLHpWoBSbXW+lxW7
         F+f51r/8pntNf4Hi8Qxm1pN+JrWKgFi51Crs33aVE5/4T5IJSzESsIbNqjCS/HmwslSY
         BLtux20rLMCyqF34zdzW5wnG4K6BNA6Di5zmRmrG5X8h/P6fSTXfS3pdU9ukxwyaqrme
         AbdWh6xg7kF2cP9BvpZLSHWeteqy+52pxFScF6cngUXYJFJjf3d6oHrdY/0z3zpgDrTL
         qemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a/LbM5DPkxpSyrzrkgXmY0H1sRUr/jc8zJFioM5t4I0=;
        b=A4rt5BsbJBjjVSv/HPHnIn7eFj+k1ovcSDIopYvdngw1saCL64GI5656q1gHmCueo/
         VdXSAgLWIGm9juAEgvvLbF59lWbiOZt2oe5VtgKyQpZ90b9tleZlwHe6bCUxhfuUffro
         3+gsmLHo0xHhFqGhmw45vC64gr2F+uN/c+IiESM+QFMtfRQeO1oU0AmZF1UWzidxZmRW
         Cto0kVyLTiFnd7m4Py3M/YYWyPLq//L3jNkZXIwEqZiAFdF/z0FxsV+nksYTN8iSajqt
         2kmuMs+42ROSuao0eiE7hXwYa8Pboj9WfOqdWDohBC90rBYrqEwqggXK2qRQg0I9krBx
         WQfA==
X-Gm-Message-State: APjAAAX1j8XbpoC6h5XXTtlVZOE9zBPvZWyjuXRg1m2jaCgXDqi2EMiF
        UrNjVNfckhiwJgbKvmYt31WqnQ==
X-Google-Smtp-Source: APXvYqwJO4jaqKTU8dv6yjq9shXknI4OPrBfSqSWXe2oo0o/S2QMQAqYMbjBZ9aZEEtRP6ZGQ7ctOA==
X-Received: by 2002:a2e:9dd5:: with SMTP id x21mr1035532ljj.182.1567668579446;
        Thu, 05 Sep 2019 00:29:39 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h2sm214408ljl.21.2019.09.05.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:29:38 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:29:37 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>,
        "simon@silvair.com" <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190905072937.m4ag4wtecfevsvij@mlowasrzechonek2133>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>,
        "simon@silvair.com" <simon@silvair.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190904192525.2dqyihabxmigb54m@kynes>
 <20190904194808.nu2cy4vp6uh64m4z@kynes>
 <d79b733068e30cfa1cef106e44b7f9ee7c31526d.camel@intel.com>
 <7de19e37e75bf2759b654c3a98e00b5b0e37aa0e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7de19e37e75bf2759b654c3a98e00b5b0e37aa0e.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 09/04, Stotland, Inga wrote:
> > > >  - a combined server/client sitting on element 1 that receives
> > > >  onoff messages and, depending on the destination address, sends
> > > >  a different onoff messages to a "regular" onoff server sitting
> > > >  on element 0, allowing efficient control over switching scenes
> > > >  involving large number of nodes
> This sounds like something a vendor model mechanism should handle:
> the "mapping" should be understood on both ends: client and server.

Well, yes, I've described a vendor model... one that uses destination
group addresses to 'understand' the mapping.

I don't get what other mechanism do you have in mind?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
