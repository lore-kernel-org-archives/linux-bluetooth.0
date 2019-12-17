Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B3EC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D4620733
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="PVhQ31va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLQSrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:47:33 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42720 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLQSrd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 13:47:33 -0500
Received: by mail-lf1-f45.google.com with SMTP id y19so7701440lfl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 10:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8OwAqGtEoRGOFXHVK2q79HPSD1YTvug3FZanSHC1lHo=;
        b=PVhQ31vaQapbnStIpqSkPVkE6wG7NBsaIMJ8A2Y3Vfze9B+mg375AiMzSrkLCb2Ifw
         yCnb3iwKhE73852GCuO+hGnk4tRTx3xfb30mjk7qgWh4PfHfab+BM/pOJXf4vWe4yqex
         T8aOzK6t4WMlYS1FtujboxmQARZYj7Xw7vCOgFLwiWgSf2ngon49/D2qtcDwgDaoli1z
         /DwVgohZAodxIiIip7Zm4L7pJzwXd4kL2+ekBFYPsKFEASube3UhHStZwECiteVpf8Wd
         pzErIHH4V7t06KpguFzSM6C+pa4Cw8YAoEw/FEoUulqFcnk49C/yqs5JKTqYIf0hX1BL
         S6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8OwAqGtEoRGOFXHVK2q79HPSD1YTvug3FZanSHC1lHo=;
        b=GM13WPaFvoLEiePURaPBZxj6zw15Jngh/M+aeszulEVXpvNM0ui5Hz2GL04kyAIKTo
         if0fKZMleWCQi1VoHaPEHI1lX6KAdok1R6JDVFdi6YpqFy7T9uW/FqL/jSg+D+mnBFKL
         pJ/7hDs91uXNfxEUZJ9byQ4oflfk7cV3r5iakfrsX4HjD4uCtFjumjHniTGI2+qLfY29
         8QsZqJXwPS4KRVPo/kYBF9w/w+Exbskbq2vHf5ai4XuIHgU6A5OjDH+wTZPbfxuzwnAR
         YpekKWZMYU54qzFgNcED89Flc+hf3ZpcEm6u9iINGnbuoBbDxm4v+LW+ZoPzGApXJyPA
         DwEQ==
X-Gm-Message-State: APjAAAV0MaGIeNS5bKqMY9574Hj4ouRDPuU0fYIab1TeE4sY30jUIEqb
        iijujNOu5diajVdsI0II9qw9RcRU70A3UQ==
X-Google-Smtp-Source: APXvYqwjIQTKX/CySvqM6FA/3kM72cjL0tYlVHKuCG3fWjEypmiO2h0OR7NyJisLokydu2WkMBKeZA==
X-Received: by 2002:a19:8842:: with SMTP id k63mr3656687lfd.90.1576608450870;
        Tue, 17 Dec 2019 10:47:30 -0800 (PST)
Received: from kynes (apn-46-215-206-57.dynamic.gprs.plus.pl. [46.215.206.57])
        by smtp.gmail.com with ESMTPSA id b17sm12899518ljd.5.2019.12.17.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 10:47:30 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:47:28 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: Re: mesh: Handling application failures on Create/Join/Import
Message-ID: <20191217184728.qoapokv7acfyaz33@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
References: <20191217184330.coc6c7b7hw4to6vx@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217184330.coc6c7b7hw4to6vx@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/17, Michał Lowas-Rzechonek wrote:
> I would like to discuss possible solutions to this. 
> 
> One of the ideas is to give the application some time to successfully
> Attach() itself to the new node, otherwise it gets removed.
> 
> Another possibility would be to remove "created but never attached" nodes on
> daemon restart.

Or maybe change the token flow a bit and instead of straight return,
make the daemon call JoinComplete in all 3 cases, expecting a call
return from the application?

If JoinComplete call fails, node could be dropped.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
