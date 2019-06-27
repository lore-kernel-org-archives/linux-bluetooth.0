Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD2C48BE4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 19:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF3620665
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="WzwyZXdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0Tvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:51:32 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33787 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Tvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 15:51:32 -0400
Received: by mail-lj1-f182.google.com with SMTP id h10so3618190ljg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s2c+W2/SVlHdbnOy1whLfgvdhAVTw2338QXZ3gZBx84=;
        b=WzwyZXdFJqLfUbZen3Qzf3jGXr06QMvpZpWdmijhE7W4/U+gg70hZi2vsXoIS1ib6L
         eHjP9kBAEv1zV7+z2joJ4HwY6pIqfxEXyUjSV3ExQVUpqxfnGeIUrcTRn4jpOQl6x4Ut
         n8NGMoaXmtfgdPzOeLjdB8KdmYmDm4K2Z9sO7IybCDxolNVJ+tvGizMtD8GiAS0fbTwP
         VTXo1S/K5V77eJILz0xZeZU6mYoRlAkNWeKNZTSWIb+Qx6p/4Y45P8zeh2BlOa46Z5Tp
         qpM0C3P6VHeBjeNyfNSNEs2rO7xrFW2eSaWuvwsG5WXFIYUPIlA2v+xxWIb6azznKcwa
         WlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s2c+W2/SVlHdbnOy1whLfgvdhAVTw2338QXZ3gZBx84=;
        b=YvNEUDsWBvxvqR2XLqX2qTB3Kl8IBIauO4QurtL98gN6jG1r9JYRKe0S8HDxBV9mm1
         8MHihKILWVhQAOT0BNEkO3lqI/XpSYLlxUDvr0/l6k4Qr5QH2HAGVhWrBvkFQ40M6a2T
         x9YWeapN76YmZUR0/pz138nKxPPWar3Gtc/1hDxen0AvgEHRlAW4iDHsSPoCM8SRJg/Z
         qPRNJHoHdgSFV9l2otoP99Q0bhexVlMit1howKMBX6dYb97RzVV75zAZcvf9HlLTYnnx
         Pd2GRhJ1cVy/PPE8Uc6eyJEH5IRFjDJkHYpFZ2DiO2uIim0L9TMfrlfiHYQR5F9xBNZf
         lzuw==
X-Gm-Message-State: APjAAAWlWiYwKuyBMJ5MzJcf7iOZ7T3sE3RPIZJT+o0FNldTSznw7lyn
        2o3sAVjm7dwfxeXIFGyDtqVjpg==
X-Google-Smtp-Source: APXvYqzyEsaOS/XuRPPRs/zwJ9Lns75it7IoecbdRFB7/bYaHAtyLGt153itmsLkrizIcd15f2XYfA==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr3622570ljd.109.1561665090513;
        Thu, 27 Jun 2019 12:51:30 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id 199sm664393ljf.44.2019.06.27.12.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 12:51:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 21:51:27 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Was: mesh: Added ImportLocalNode call with its API --> Multiple
 Methods?
Message-ID: <20190627195127.payxcdeexiamsi24@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190625143855.29889-1-jakub.witowski@silvair.com>
 <1561568468.22940.16.camel@intel.com>
 <14abe0f2129a2334d32aa14f2167380a5208880b.camel@intel.com>
 <CAMCw4t3pXTbtt05RD694jzF_MNT_J9dcFMtA7iuD4ujZT9FDbg@mail.gmail.com>
 <1561660267.7802.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561660267.7802.29.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,

On 06/27, Gix, Brian wrote:
> I am starting to think we may need multiple methods here to deal with
> the desired use cases:

I don't like this. Back in the day we discussed that we'd like to avoid
D-Bus API bloat...

> * ImportNodeProvData()
> (...)
> The daemon method would perform a GetManagedObject of the calling
> application, to create a node.json with all of the Composition data,
> elements, models, features, etc.

While the initial idea was indeed about importing the whole node,
including configuration, models etc., during implementation we figured
that the reason to do it is to eventually Attach() to such a node - it
doesn't make sense to import something you wouldn't use.

If so, then you need to have an appropriate application anyway, which
the daemon can simply query for all the needed info, as it does at the
moment during Join() and CreateNetwork() calls. This nicely fits into
REQUEST_TYPE processing in get_managed_objects_cb().

This results in smaller API and *significantly* simpler code. As you
mentioned, doing a full migration is complicated.

> * MigrateNode()
> This method would be what Inga and I had originally envisioned for the
> ImportLocalNode() call... It would contain *all* the information that
> a pre-existing node had... including preconfigured pub/sub, features,
> Sequence value that reflected that this node already existed elsewhere
> on the mesh, but was simply being migrated to this device, etc.

The application can do all the configuration using loopback Config
Server messages, so I don't think we need a Migrate() call at all. The
application already receives current node configuration when
Attach()ing, so it can determine if something needs to be reconfigured.

And again, you would need an Attach()able application anyway, so all the
information would need to be duplicated in application's D-Bus
interfaces and in the JSON passed to Migrate() call. This seems like a
violation of DRY principle.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
