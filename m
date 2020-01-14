Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C4BC33CB3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2F24680
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oAw9vSVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANPkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:40:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52831 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgANPkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 10:40:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so14354550wmc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ARVjpVqHgT/h6H4VkHs5hytp1R5FS7Lwl8LwJ8z9xg4=;
        b=oAw9vSVVOytkAybVGta2F2g659t+qayXOTlcfgQxHeTBNSQUm6nUc4QEhYww8XWRrm
         y3A64ejuG2KWubZ6qjtoPv56wOYkuUCK85ymmUfojqzOwWEwCThmBzh2cWYzg/WiC6XK
         UxKwKuuVxYkbE4QiiZCygLYb9BQHeDRSKxy0E6RV94yc0cnDbhlLrwLU/l6r2AfNBQg2
         HiQi/V7tEDy65wM9GrXhx/ul0XQr8mtSdmlZgJLwWyYByzYt7RM8hVr7m/K2QSem/qzv
         89RBuo3Qlb+UNcDIo6QEYM3JOk4v30G5jhUVI0uI4w/2WawWYiR5hCE82DtPYjrOAMv1
         Dbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ARVjpVqHgT/h6H4VkHs5hytp1R5FS7Lwl8LwJ8z9xg4=;
        b=INgDlftSIDVQx4V9cIe6cN280yM8IPdYBAvpFmdQ2gTNiHlZD9vZ6B9wvHs+vcktT8
         fdB2r6XEwROn5KHUx2UmdrL2s4xKyDdsMwzC32uXzcWCBouLI8FY1vcb67PRfFOoHd72
         h0zgGJL9cV29dIoBH/YhzqEGVQt1nwoF3krs5W3UnCjHsuNVlcL1WQHDIGnZR4BJolQ2
         UxMRBKwhqdSNr2sxf8Este4Z2aVTbaE/HPux9IaAWdcx6UNSDD+vZciuQuPthVelQEHY
         J7e1Sz1erqR2QmNn5aBhKIYHUeWCryJ32UiqFsrb3c9coIWrqKpkiIXjXIBM4k5zXD89
         DPCw==
X-Gm-Message-State: APjAAAV1s3AA8yzz1XkRX5AEs43nxv73vwRkVEpX5yj5MwqcKXOIOSi7
        zmF5JQht+puQKaFERiPTUgx9ww==
X-Google-Smtp-Source: APXvYqwSIbICcNt6Zv0k3SqtdJPf9mtR0HtCnsoPfQgQFjczqmmw6/jH1gGGxf3gOTBEKldnlocbJw==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr27374241wmi.149.1579016415184;
        Tue, 14 Jan 2020 07:40:15 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id p26sm18429339wmc.24.2020.01.14.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:40:14 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Tue, 14 Jan 2020 16:40:12 +0100
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Message-ID: <20200114154012.gixnyhceabg2lrsp@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200114114914.25868-1-jakub.witowski@silvair.com>
 <1382d00407f6c7836f7983e374d6c504931f6e9e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1382d00407f6c7836f7983e374d6c504931f6e9e.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/14, Gix, Brian wrote:
> > +	uint32 SequenceNumber [read-only]
> > +
> > +		This property may be read at any time to determine the
> > +		sequence number.
> > +
> 
> Is there a use case justification for exposing this value?  Why an Application would need this?

There are 2 use cases:
 - debugging and monitoring RPL behaviour
 - we'd like to add another API to increase the sequence number - this
   is useful when you Import() a node from another database and would
   like to bump its sequence number up to a previously known value, so
   that the rest of the network can talk to it

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
