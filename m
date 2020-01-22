Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0663C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E7D2465A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ssD2Y1w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAVSCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:02:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41666 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSCg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 13:02:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so283226lfp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=raDZT69f2C96QcfujZ1EHPYcQWG9gFnyrsDH4CEmMts=;
        b=ssD2Y1w2Md0EohTNwsM+YMaJVAQ9wy/wsj2Sp+xxs41twqHxqPVmwKQ4aS3C4e88ap
         6CVHbPZtMrmY8w+oY6htJXMGRNWVDNqy7uABXNYQRnQamxrS+EFhZH1WDcIH9UFcBRPq
         162m1+mW1U6xIUIY2ME4OvDAxE2Emq/pyBMl3a8agjvmpJl2A7U+J+i0OvqR3UxEC4A0
         Tq/hQ7kig/94x2fZ8kb/KlIv2vyez74Dp3mCKCh/8tsbeavL5YVvRg9NoqcKfQy+nklE
         SzTwbe45Xj2v0Zk2LvvwDxXjzjocZS5y5jvN2jRKBFEL00wPli4iEPVNZnVV6+OcM9Xm
         U8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=raDZT69f2C96QcfujZ1EHPYcQWG9gFnyrsDH4CEmMts=;
        b=CJthsgWSlnEEQKC7X7zlvBPk5xGw/tPMwB1Dur2DH4xRvp6c/REKCJVLF5QhfNSNUE
         ptv5GwxlGHe46RJjg5okgmM3cmihcV30DOPAruGQDT9KOkVFBX90+5TVjgixuWaq2mD5
         2XD5+CEmmz1JbJNv9YBJanTDbndPK5z/fM+Y/1xC9QNOxQ2/gI33xil1b5KYs1SUDJhi
         94nEcs2h1epNN8frzoi6qXCIoIsPgj8MYe5O6YU6Z5FYMMoXvj+HowGLpFaFOkZ0ECXJ
         93VeWEuwUYbWfnpIomB46tvaE/UkdDJo+IxU8OAU4NLlW4cK6nXvqgG4n0sSINGHqIxu
         XT/Q==
X-Gm-Message-State: APjAAAWBphAZIeMh2KhRIPdRgG3+hMKv4+iNHmKxtMHYGp1bcL/Q2OI2
        QJNu4j655GysA8Pb23g6Vp1cZQ==
X-Google-Smtp-Source: APXvYqxL2ibgehm956DgLWNWnpl3wA7vHbXUGuoXSyfJuKTElehNnWe0KtsVTsltGxYn594WGpBBTA==
X-Received: by 2002:ac2:4472:: with SMTP id y18mr2392710lfl.39.1579716154060;
        Wed, 22 Jan 2020 10:02:34 -0800 (PST)
Received: from kynes (apn-31-2-112-202.dynamic.gprs.plus.pl. [31.2.112.202])
        by smtp.gmail.com with ESMTPSA id w6sm21123912lfq.95.2020.01.22.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:02:33 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 22 Jan 2020 19:02:30 +0100
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Message-ID: <20200122180230.h57v3snd6x7uingg@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
 <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/20, Gix, Brian wrote:
> On Mon, 2020-01-20 at 17:11 +0100, Jakub Witowski wrote:
> > This patch allows the application to modify the CID, PID, VID and
> > CRPL in the composition data.
> 
> This will require some discussion.   Currently we are planning at
> *least* to make CRPL entirely under the control of
> bluetooth-mesh.conf, because this has a significant daemon impact.

Alright, but at the moment the daemon accepts whatever the application
specifies. The proposed patch doesn't change that, so maybe let's keep
it that way until a dedicated change in CRPL behaviour lands?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
