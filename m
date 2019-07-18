Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52134C76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C29E2173B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="PHei9dex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfGRIQV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:16:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36692 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfGRIQV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 04:16:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so18544600lfc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZwvbWBo6ZsnbZt9gGxSBltySN18aXeyFFOZF0q4o6WE=;
        b=PHei9dexdSYyXzpoinkXaP/lek48C6RFT/vMgd2T5a7xfTitfvo3PVKeD3kafUnPPG
         psikZs262AFUnPPSTBN5ne/hgJPtj9h6Z5sO9M+ukcutEWtozAHq/1fxaSkpTmSaUqIB
         bNMxPXBGPE3OlOeR02QTWe2aNcfFQsjy+qC1YRLSeE86R2uR7qLhr5i/q2kvpfSUl0sC
         tJBvv9GrmUYG0jDsZT7Tu+Vij/DAihEJq6NJkJrwyfCFh6iJEwW8n5+OcfpRCBHOJh4g
         mVRuXQPVZWiiz+o8U60k+iMmCte7h19pDrzaMlxX1saxRZPOGLj3ye4XBJ4PE2AYXy4V
         N26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZwvbWBo6ZsnbZt9gGxSBltySN18aXeyFFOZF0q4o6WE=;
        b=R2m2VYM7ZYeqNAc66IQWfKPLA/BCeUWPtuV/d4068poir7NMiced42EiryOnKzAY31
         bsdlamTCxEsIP6vaZWMIerXCP2H9RxBw0eVxaaQEUWits7mMcayzkyzzAwgmIYwjRaNS
         m7DwweWJYC14rQ9t+09c0cf20+UxviQU+GD9z2cSTzJY7av+SvvWjTBKIxa46nUyzdf1
         zIUBz4TuStm649kJs9PmCAT5Ha0Jk6sa/eyKA+zQdyTb0SLI0bpCc1A9sXf3fz9mTOzG
         imqeGUOdLG4+4S96p6CFkHWotXdWjCOVwGu/Tj9MeCTc/HFe2PgVTyoTzd5VEUTCWn1I
         jcIg==
X-Gm-Message-State: APjAAAVbCCag4c1Wiv4EEKSKcBpd7QcYj8LM4HupZZG4zLkDm3gP9sAm
        pKYU+O51752DMHwyjQ65rIePhw==
X-Google-Smtp-Source: APXvYqzMLRBQoF4mKJDHz/QVAcDYMTDRsoxha+Vf/WlmnPBCtYH9g3AlyrWvuy2fTK7ppKMpIHF+ow==
X-Received: by 2002:a19:8093:: with SMTP id b141mr20872029lfd.137.1563437778826;
        Thu, 18 Jul 2019 01:16:18 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o8sm4915680ljh.100.2019.07.18.01.16.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 01:16:17 -0700 (PDT)
Date:   Thu, 18 Jul 2019 10:16:16 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
Subject: Re: [PATCH BlueZ v5 1/4] mesh: Add ImportLocalNode API documentation
Message-ID: <20190718081616.ujsbh2ot5hbhmulz@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
 <20190717083650.26346-2-michal.lowas-rzechonek@silvair.com>
 <915ea1c10883aaf1e4d42c5a749bfda964b54b51.camel@intel.com>
 <20190717194712.i4dtiwhldq2is2z2@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CBD3539@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CBD3539@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Inga,

On 07/17, Gix, Brian wrote:
> The application has no need to even exist at this point, as long as it 
> can attach to the token at some point in the future.  But this *does* 
> enable the ability to have a *generic* application that can inject 
> nodes (fully configured, or "New") into the daemon.

The same thing can be said about CreateNetwork() call - you don't really 
*need* to have an attached (of even "attachable") application in order 
to create a new node.

In fact, CreateNetwork() and ImportLocalNode() calls are very similar in 
this regard, it's just that CreateNetwork generates keys, addresses and 
starting sequence number on the daemon side, while ImportLocalNode() 
allows passing them from the application.

Since CreateNetwork() does query the app via D-Bus, I think it's more 
consistent to query the app during ImportLocalNode() as well.

That, or replace both calls with a more generic CreateNode() call that 
would accept create/import data as an agument, and not query the app at 
all.

> > If we say that it must also do the same via JSON, to call 
> > ImportLocalNode, it leads to code duplication on the application 
> > side.
> >
> > Moreover, the app still needs to be queried via D-Bus to check that 
> > the passed JSON matches the D-Bus structure - otherwise the app 
> > would then fail to Attach() and the user would be in deep trouble.
>
> The composition as reflected by the GetManagedObjects() call is 
> "sanity checked" against the internal storage *every* time the App 
> attaches...  I think Inga is concerned with code complexity and bloat 
> to repeat this during ImportLocalNode(),

This is covered by the same code path as other calls. I think it's 
cleaner to always perform GetManagedObjects() dance for all 4 calls.

And, as I mentioned before, this code path becomes even simpler when we 
refactor "sanity checking" to compare serialized composition data.

> This is different from the Join() case, in my opinion, where the JSON 
> (or other storage) is being created *totally* from scratch, via the 
> provisioning interaction with the remote Provisioner. In that case, 
> yes... the "owning application" needs to be present on the D-Bus.

Not necessarily. The application needs to provide ProvisionAgent 
interface only, and only in cases where provisioner selects 
authentication method that requires the app to perform some OOB action.

It is entirely possible for a joining node to say it doesn't support any 
OOB actions, and the mesh daemon can accept provisioning wihout any 
interaction with the app.

> > I'm not convinced that the "full" configuration is even needed. We 
> > certaintly don't use it in our use case, but it might be required in 
> > the future.
>
> We *definitely* need an option for importing/migrating a fully 
> configured node.  Phones are retired and replaced... Workstations are 
> retired and replaced...  Some nodes publications will inevitably need 
> to pick up the "current conversation" with the migrated node, where 
> the old conversation left off. And this will almost certainly be a 
> rare (but important) operation, and a "Utility" application to perform 
> the operation (that does not itself need to have the model/element 
> arrays implemented) will be easier to write and maintain.
(...)
> Again, I cannot think of any situations where Join/Attach/Create would 
> ever exist in the absence of the Application.
>
> This is an easy and obvious use case with Import.

I don't think it makes sense to have a utility application that would 
migrate the node without having anything that would Attach() to it.

IMO the migration operation should be a part of application logic, 
because this operation requires talking to external Provisioner, and 
Provisioner API is vendor specific. So I don't think you can't really 
create a 'generic migration tool'.

In case of replaced device, the use case I see is re-installing the same 
application on a new device, and having it re-create the node either 
from data received from the Provisioner, or exported from the previous 
instance of the application. I don't see a need to instantiate the node 
on the replaces device without reinstalling the application - such a 
node would not be operational anyway.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
