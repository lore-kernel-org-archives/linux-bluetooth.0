Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D71C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 04:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352FE20850
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 04:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jS52phGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfEHEjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 00:39:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35359 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfEHEjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 00:39:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id j20so13505989lfh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 21:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7H3CU9ljq4FRqsQ2m2Y9RjLx9vQcNyr/LeXQezkTk1I=;
        b=jS52phGLr/faCDSu39ThhZc5tfP5K47t6DGj7Ta9MKlfg0r21S1+fbnp25W8KOCim4
         1mcTOjaiirIRwyw3tevIrkp2Lwd1R9OdTIwE/yfmBzvHIMHsaV9J4s8Tgasn7EJmTIIx
         2gKCPXwlqbd/1nhHB/n0AZ1CdQOtvQAMbweGpTWDsTWC75ot7/OZFSR3sLhvQGjy1zJi
         pT4ZHcLW/eUPrCO1cocn0FxheUZ8kwBQgefq5svrPqH6tv0uoLTFbMhhkeFvIZYmXydt
         NeXqFeFHzLFvHbHJwA4X00ZwSltTh7Iu40M5ZQMzWXj0mYpKAD9fuac9VGtEyngXSWh9
         yrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7H3CU9ljq4FRqsQ2m2Y9RjLx9vQcNyr/LeXQezkTk1I=;
        b=IxUHQJTQ3vmWb3VI4vt6jk51LzwWokdbo5ilwrbSCPkvfEu/TxdlYltt+AXHjNekmT
         YAQW0lp4/CkhOdoFyPZvZSR97ZqCCwhOl6i2F0oMo0Mvi6GZ0uJC41qoGNauDbzJrgpG
         Nga9Qe1GHSjSUMu+XYtN8YXAu2nhDq3EwtO6rvMxS34sn4d1ZfxT4YSu6z1Sc83wnPI7
         kAcSphwRFmaV2xqZ7E0WZMwnzcKVVrQVVNPQiqmZwki9Kr2Kx8MtlFb6u5XyMPl2VVUE
         GWxpw/cYnQajd9GbFP7uaC9GV4tzEtWktEHloeWOsn5+F/CItfaWu/ZccRLd6IUINRbE
         hHtg==
X-Gm-Message-State: APjAAAV9d5AO2RM/6D8HBEA9h5EIaBfsjbU3OnMo+mb1C+kzdgmlwINP
        v2vbBiXr206JVFFrCp+h+Arfbg==
X-Google-Smtp-Source: APXvYqwYVOuyxCtiyftM5IHT9ZfPpdBaAl975OgKx3m2IO3IdFtEbO0BSf23i4FIRppSj9Rtc1+xMA==
X-Received: by 2002:a19:c60f:: with SMTP id w15mr7459035lff.61.1557290344600;
        Tue, 07 May 2019 21:39:04 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id r9sm417055ljb.79.2019.05.07.21.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 21:39:03 -0700 (PDT)
Date:   Wed, 8 May 2019 06:39:01 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Use node uuids as storage directory names
Message-ID: <20190508043901.bcueazjay3nm6cya@kynes>
Mail-Followup-To: Denis Kenzior <denkenz@gmail.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190507071340.20675-1-michal.lowas-rzechonek@silvair.com>
 <1557261666.31289.11.camel@intel.com>
 <18e096c6-3b22-0096-5cb2-bef7264dbefe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18e096c6-3b22-0096-5cb2-bef7264dbefe@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Denis, Brian,

On 05/07, Denis Kenzior wrote:
> > > +		if (asprintf(&cfg, "%s/%s/node.json", dir_name,
> > > +						entry->d_name) < 0)
> > > +			continue;
> > 
> > With ELL, we do not use asprintf.  Every dynamic allocation must map
> > back to l_malloc, which performs an abort() if a memory allocation
> > fails.  So this should be re-coded as a malloc of the desired size,
> > and then use snprintf, using the malloc'd length as N.
> 
> ...or use l_strdup_printf.  Which is actually asprintf underneath...
> ;)
Will do, thanks for the tip!

Incidentally, are you aware why 'main' bluez aims to drop glib?

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
