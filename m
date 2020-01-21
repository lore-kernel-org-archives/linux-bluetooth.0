Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D966C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 20:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29122207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 20:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="FuRnjyBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUUPG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:15:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39199 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgAUUPG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 15:15:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id y1so3391477lfb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HbtJxsHTBL9KqztHKdKNEHpXofiAHjtU2iQrO0XNbKE=;
        b=FuRnjyBTT1rGpudQhTZV1yx4N46BT/nl+Z1mVD44xw5DwqeiWDIb9AYgNfbDAU7E1s
         isD9P7MZWJe6tFbgIpE1FrURodlGC8fKHTl0L6VbOv+njH3/+Xk4QlSjpaWqRKUR9Apv
         XTjHb5L7yTGpuxB8HqCzlKtEY1dCLOTKs0YA6AQgpkPoei9xjS6owIA2Mr/cWhlSsl5Z
         fD2RuAXn8GqTAK14FdzutBbhYLkntxYC0Z5Ji56o/bv9TnnHw8tplUX32yng8tmLKD7b
         rfcjGKoPefZaKNlM2JosuusaRdjD+EvcpsDfDObqFwHd9cjI8tg2Tmd5kUGSJPifn1Qc
         ntjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HbtJxsHTBL9KqztHKdKNEHpXofiAHjtU2iQrO0XNbKE=;
        b=c03zAf5US1iUBi7ke1CSt9rDJzE2RSnma/54pC8qyWtmS32VjWH90bgM0b9kYy6nzJ
         sr9gqHyvELvFycUOAgWnvnmuMm1CCpd3VJtv0vyIqlDPG3kuGuY2qc0j3kzmZpjqd/db
         gM0OBENNHxjgCG473dp93YZcfZojnhWwjlPsiqXw40DUtENKKtm0ilHG37TtgJYzfYBh
         2T51SHUko5iKikJaArawF6rCaUjMHjCbmd8jcs/dHsusd3zsa0Osa3UGWHV00Iavty9T
         8IsF7ISIwMr9kVrM/q7yYnx6VOCzyl42dRaG4EaJg7AP4xu9H/dZAt7mLP2NR0M/R+NE
         wWEw==
X-Gm-Message-State: APjAAAW27UR2qArcgn1ZlrPsUIdnG2Uk/5WUafBMvjawQv4i4ZX1jWJz
        nXw3YKBtk/vRxG14kp0/V9ekIt2tLYsodQ==
X-Google-Smtp-Source: APXvYqwM4l9nIQ45sx44sljdz2O2LijfgDAQORsxyYxmrnUE9lnroDudaHwTRjKQeDJse2KetpY41w==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr3623584lfp.190.1579637704254;
        Tue, 21 Jan 2020 12:15:04 -0800 (PST)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id e17sm19243713ljg.101.2020.01.21.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:15:03 -0800 (PST)
Date:   Tue, 21 Jan 2020 21:15:01 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: Re: [RFC BlueZ 0/2] Fix types and names of beacon/import flags.
Message-ID: <20200121201501.v4ceigg5xngfvjb4@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian, Inga,

On 01/09, Michał Lowas-Rzechonek wrote:
> This patchset aims to make the API a bit more consistent.
> 
> Side question: at the moment none of the node properties emit
> PropertiesChanged signal. I think this violates D-Bus spec, since all
> properties are assumed to emit these signals by default [1] [2].
> 
> Unfortunately, at the moment ELL does not support "EmitsChangedSignal"
> annotation, so I'd like to add this to ELL, annotate node
> properties with:
>     - Features: const
>     - Beacon: true
>     - BeaconFlags: true
>     - IvIndex: true
>     - SecondsSinceLastHeard: false (for performance reasons)
>     - Addresses: const
> 
> And also emit PropertiesChanged where required.
> 
> Thoughts?

Any comments about this idea, or should I just go ahead and send a
patch?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
