Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84BC10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 18:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17492077C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZBVRGXDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfDJS0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:26:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbfDJS0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 14:26:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id v22so3028456lje.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FlBMFhcacvArGvYgkZUmlY1MOs1qhn8pYfSY/86QVY8=;
        b=ZBVRGXDsNle8y/oFFWB3L7Fpzoj2RKXaqmvwfalTqQOBprLd4vM+1wmJMCUEt7y7m0
         Vp0IxsQpb1JO8TSWDPcoHvVEAb9q2clWirJE7OcDdYqJ6ZRiN2M31BodJIDEcX73TCnp
         j7hmxdt4mhHhDeaydO2Yq+kzH/9OZhik3CtWAV572fNscJP8QZBMedCrCEHUP3fYziRV
         VkAaVFip6SDXNM2I5WXZxYiGc+Z+7mMzTU16EG5TZWKoFHxDBHI3igt6f53j09gZdEcb
         MCIp60R0ufVCNoirkUyH6VhFJDmOLWk9UDkScPthTtauMOXm5d/azIsEHkQmzBwLy8aI
         mHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FlBMFhcacvArGvYgkZUmlY1MOs1qhn8pYfSY/86QVY8=;
        b=gvHmeaDGUzIJRG22qDeqt5ZySQNJ6RexCsYLcMmWaoknczXz++TZkGMuXhYn3SJUNa
         BjHASQKJOdogvaQt61gXW6et7jTIkPVDSz2uPY47ZCA6RHhAYte4DXK2sl8a/1J7vcYc
         Jn8LDv4qEgQ92NpvenEbbr8bEdXSuV1erlxypZkWFdRHYOn1vVShDU306Er+sPEb2vMT
         BwMvpeTi1H6jc/wuXU5pglH4U5Ij7PhQJNTMaitCO5VWa+5g0zEuow1r5H1QB5Jd0nvW
         fLcA1eApXj3oRcvRqzs/B9xA96DJXzI9hYMwwpBeOW7xkDSV98tjV390tqRIHIWBbZjr
         77OA==
X-Gm-Message-State: APjAAAXxq/aVGi5v49GP1Hqr3tAu1FeQqxSq+FxrZqRzyQKDK+6PN2hk
        kX0pGgCRXuTv63OsfZzGr2aYasaOyLA=
X-Google-Smtp-Source: APXvYqwqOHvHdORqQksim0uZFbjC2BegC+gw4c/KMgqwuLIWybHeI+vCRHd0SxiJIx0n5nptxmYTvw==
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr24289443ljj.79.1554920808249;
        Wed, 10 Apr 2019 11:26:48 -0700 (PDT)
Received: from kynes (apn-77-114-92-43.dynamic.gprs.plus.pl. [77.114.92.43])
        by smtp.gmail.com with ESMTPSA id p15sm7143303lfc.48.2019.04.10.11.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 11:26:47 -0700 (PDT)
Date:   Wed, 10 Apr 2019 20:26:45 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190410182645.r7lprmpz3jfggill@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
References: <20190322225754.27039-1-brian.gix@intel.com>
 <20190322225754.27039-2-brian.gix@intel.com>
 <20190401104213.vpqhgw55leg6olza@scytale>
 <DEBB0CAA2616974FAE35E4B560B9A4376CAE27AA@ORSMSX103.amr.corp.intel.com>
 <20190405190304.swhyog5zefvq37e2@kynes>
 <D6866572D7A1DB48A0D22000C21836C76CFD7997@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6866572D7A1DB48A0D22000C21836C76CFD7997@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 04/05, Stotland, Inga wrote:
> > Imagine an existing network provisioned by someone else, (...)
> > We would like to add a Linux-based device to that network. (...)
> > To achieve that, we need some kind of API that allows provisioning
> > meshd locally, ideally via D-Bus.
>
> To me, this scenario seems to me more like "import the node" rather
> than "provision the device".

Yes, indeed. Having an API to import a complete node into the daemon
would be enough. But note that such an import would need to contain, and
*all* the keys, device key included.

> We could do that with either a new Import(dict cofiguration) method,
> where configuration is a dictionary that contains all the preset
> values (netkeys, uuid, unicast, etc). This method is different from
> Create() since the netkeys are coming from the "outside".

Yes, that would do, but there seem to be some objections to passing keys
over DBus.

> The current approach is to keep all the netkeys and appkeys within the
> daemon without ever exposing them to an application.

Yeah, I know. I just don't think it's practical to assume this, because
of the use cases mentioned earlier in this thread. I strongly feel there
is a need for a centralized database, handled outside of the daemon,
ideally on a some kind of internet server.

> Alternatively, If a node has been created and configured by a third
> party then adding it to the existing meshd management could be
> achieved by transcribing its configuration into a meshd internal
> storage format (which is in json readable form and could be
> potentially exposed as a schema).

That's true, but this would also mean that the storage format becomes an
API.

I don't think this is a good idea, I'd rather allow the daemon to modify
storage format freely (with a proper migration from older versions, of
course). Especially considering that while JSON works for now, I think
in a long run node data should be stored in some kind of transactional
database.

> > Moreover, since the Attach() token already travels through the bus (...)
> Just having the token is not enough: there are some checking
> mechanisms (and I believe they need to be extended) to check the
> validity of the attaching application.

As far as I can see, these checks mostly concern composition data
(elements/models in particular), and this can be easily queried. Mesh
daemon doesn't seem to use any additional secrets besides the token.

So from what I gather, the daemon already depends on the bus being
secure, and I don't see any practical difference between exchange of
tokens and exchange of keys.

> > > Most of your recommendation directly affect the security of the Keys, 
> > > and whether they get passed via D-Bus...  And this is something that I 
> > > would *not* do without the OK from Marcel Holtmann (...)
> > Could you please point me to the relevant thread? I know I'm late to
> > he party and would very much like to catch up, as much as I can.
> This was a verbal discussion I believe.

Oh... Could someone (Brian? Marcel?) please summarize the main points
then? It's hard to argue about arguments I cannot possibly know :(

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
