Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09CC3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F2C214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 20:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ig+TQ5Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfH0UCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:02:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40652 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0UCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 16:02:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id e27so416549ljb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2019 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8lDtVuR0eXxyDY+qBYuiOQQ/aFHX3cLlSkuEhMGs5FA=;
        b=Ig+TQ5EsqgU6QyBlTR0lbjMDNl8ax7/2TX4lgb11c9E8hAIWvBMohzWqLKmIqMFeyC
         2nNuytIO3CRAB+C+NkbxEefmjDhHakFMILcXFae37J324SD8AO4C4JSvm7hzncBsU1dL
         Kyv4r/8LEndCiZm4DwxndPqw1U9IFpZXlHuOjLskiQVVbaqwE00KTHgwFKl+1YoqLdN6
         PaP0mNrJDEigPyZEQNRKSbxW/3HPtj0fB09cp1A0uYKfuDobIeNfuo1jen4YdjeDN1Ap
         VkPptn/0cZ7J4LxbAJfTfFRjPJ1Ttmzv9k1EPSC0B4+ZJ4ACjGCH7T3FiHPNNl8n3Nxr
         E3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8lDtVuR0eXxyDY+qBYuiOQQ/aFHX3cLlSkuEhMGs5FA=;
        b=L+w263SG2Pzi1mazLwMiFoNDdFs25KSV0qZR+zHngT8Lz1QyI0RNjQtn31DTh2P89C
         J1Izf3qRdpePsmJwN8gyDn8RBeMtoOjoamXJVs9EKczYpVM5lo050CbSVVM+bT9/skYf
         qklmfF3rd5LbDu2hrGSG3bm2v0UMMo1szVZXYHqAgdlTzzcbiW2TLjNXK0yBCog89pWz
         aiSM/qghm+reUyXboqyMtMqemv+pIFRw9KjGpcwfYWK19gJxlie/99EvwQpM3GgFfeQk
         EOe5YCUi+VowH3FSoHGe+5fCAQu8P6jN83NIp4dFJ20yRbaTy5cy0DwDaSKXRAFy3VCZ
         m8DA==
X-Gm-Message-State: APjAAAWpwSxO2qCWhy3B6e0eTAA6sd4DMv+Kx9Nja/0Hpc4LSyIyRycC
        cL7fkOyIBh0OjpT27AF7ULc+NQ==
X-Google-Smtp-Source: APXvYqxlSY6GgtcGpNxqB5b3yWtbXrP6d7I+yWSWQrK7k1FIlNv8bQEnKNT43nF/tpJQUOVgvZ5a4w==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr20398ljn.89.1566936158212;
        Tue, 27 Aug 2019 13:02:38 -0700 (PDT)
Received: from kynes (apn-37-7-28-223.dynamic.gprs.plus.pl. [37.7.28.223])
        by smtp.gmail.com with ESMTPSA id d16sm60819lfl.29.2019.08.27.13.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 13:02:37 -0700 (PDT)
Date:   Tue, 27 Aug 2019 22:02:36 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/2] mesh: Implement org.bluez.mesh.Node1 properties
Message-ID: <20190827200236.kyhdu5jjgq7roevw@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
 <4f4cc80d57738604b3b38049a1aecb6b75e57be2.camel@intel.com>
 <20190827182356.2pbseooolxfazg3g@kynes>
 <a1642e6a33df45cbc41c1bcd42878dabbc7576b3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1642e6a33df45cbc41c1bcd42878dabbc7576b3.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Inga,

On 08/27, Gix, Brian wrote:
> > The address part is useful when application would like to talk to its
> > own node's Config or Health Server.
> > (...)
> I think I am OK with this...   It is hard to make the argument that
> this would be an information leak when the information has been
> revealed before. And certain nodes (if they are authorized) need to be
> able to talk to their own config servers.

Ack.

> > As for sequence number part (...) I would like to make it writable
> > (increment-only) to enable address reuse, but as this stage I'm
> > still looking for a way to implement this without causing a race
> > condition, so I left it readonly for now.
> 
> This is where I start to see actual danger, and difficulty when
> considering the NVM system is "pre-reserving" sequence numbers to
> prevent NVM thrashing during heavy use. In the spirit of keeping an
> API as small as possible, giving applications the ability to adjust
> the SeqNum (even in the legal direction) should have a rock solid
> justification.

Ok, fair enough. I'm gonna drop this property in v2.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
