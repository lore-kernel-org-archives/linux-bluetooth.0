Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A9C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741820882
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lcfDBSW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAUK7c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:59:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34258 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAUK7c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 05:59:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so2296037ljg.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBkbZZ9Xl4UYv61NxMZo/mX0xPmCMNhIWzGF59jtO8g=;
        b=lcfDBSW0B241anVpQeYHO3QSNx9H5W0RgU07DQwNrrra25TY/0u3dqKj0mRoUhbONP
         FE/aE0qdSnxdwbZbzYaaNQvFqc7uo8CR69eE3CzwKQRLRP5AhK7OkeqlywHbNZQtCn4Z
         MiF3UtTrbfX+BXH3qsLTKw6cuDy7soup+mYXKl0vILDsJacXT6IGXSKgmYmiyTsBCat5
         ZmVMxr2KuNBxJ6igPa+JgRQTvDzlYVOHDznKsJEiWbE72HxtKaGNus8grQpWYsF7Rci4
         HR5rcGKXxXuhj15u0YYQTiw3hSAGyb5XSkQ+bW5dSgfqv3jTHVMA7/aSEv+dmLICY9kM
         cbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pBkbZZ9Xl4UYv61NxMZo/mX0xPmCMNhIWzGF59jtO8g=;
        b=LCadbjW5KsqTCHBmYMaJQoage1v/mL5zb3pJw4SWJRPEb0aZSIH4hXg5fR/gzO9nYD
         pKsrfJQwAJr8Az+4WxhDX1FRBIo1ZqewWGXECigkgjErpyQUjQxOUEW0K9lLqZOutKYf
         JfdZieJT9BqQr0IrMwqqNEE1O+ReuzlF42b0EhAgpi/Pk3a+1+m6IgitoYfW7hxWrXhP
         n6rqhS5V0PqszWtdLFkIskz/zKxjQEmKFKenmYCGkEAxTYzpo+EI+YpzatME/t2ubLHh
         vBV/nEdxCcnpjPemmlGE1rxwTHdd4uQyNvBHT4RsjK6pK7TH3dytgd1d9CKex1I4j4gx
         58SQ==
X-Gm-Message-State: APjAAAWzLcpFd/bbiUOtsQMa+aM3Fm8csw1XbkLAs07lgI+jx8pC0Y+P
        hhHg1qX2FbbZd+DEqi/wmd6sMg==
X-Google-Smtp-Source: APXvYqw2sfLn+YH9HSfQG1rLNr4+6Ld5q6mTC7IW7tYLlF0Pqcxa3VuggVA1Fg7qrzLdhLJwQOpE6A==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr16294463ljg.168.1579604369909;
        Tue, 21 Jan 2020 02:59:29 -0800 (PST)
Received: from jwitowski2365 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y14sm18220113ljk.46.2020.01.21.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 02:59:29 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:59:27 +0100
From:   "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Message-ID: <20200121105927.s2a3avh7tdcnf566@jwitowski2365>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
 <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/20, Gix, Brian wrote:
> Hi Jakub,
> 
> a few things..
> 
> First, the subject line for user space patches should always be [BlueZ PATCH...] to differentiate bluez.git
> patches from kernel patches.
Correct, sorry for that.

> 
> Also:  The title of the patch should always start with the component being modified... in this case 
> "mesh: Allow reattach..." or "tools/mesh: XXXX" for example
> 
Ok

> On Mon, 2020-01-20 at 17:11 +0100, Jakub Witowski wrote:
> > This patch allows the application to modify the CID, PID, VID and CRPL in the composition data.
> 
> This will require some discussion.   Currently we are planning at *least* to make CRPL entirely under the
> control of bluetooth-mesh.conf, because this has a significant daemon impact.

Ok, I don't have a problem with that. I guess this is going to behave in
the same way as feature bits, and CRPL will disappear from Application1
properties altogether?

> 
> The other settings I am not as concerned about...  If the spec really does allow their alteration though, I am
> willing to consider them.
> 

It doesn't explicitly allow the update, but doesn't forbid it
either... These values are application properties, and particularly the
VID can change after software upgrade, (even if element layout doesn't,
that would require re-provisioning etc.). Supporting this is the main
use case.

> > According the Mesh Profile (2.3.4 Elements) the modification of fields other than "Elements" is not
> > prohibited.
> > 
> > Also in my opinion (as you can see in the 1st patch), there is no need to use pointer to the node_composition
> > struct.
> > The static is more clear and less problematic.
> > 
> > Jakub Witowski (3):
> >   mesh: use static node_comp instead of the pointer
> >   mesh: add composition data setter
> >   mesh: allow to reattach with new composition data
> > 
> >  mesh/mesh-config-json.c | 46 +++++++++++++++-----
> >  mesh/mesh-config.h      |  2 +
> >  mesh/node.c             | 96 +++++++++++++++++++++++++----------------
> >  3 files changed, 96 insertions(+), 48 deletions(-)
> > 
