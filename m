Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208D9C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA67B20678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="iUnBPeAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAHSSD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:18:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42664 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgAHSSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 13:18:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so4299592ljj.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XIJp8Ev/SWzgxb6l0rKcAVisTQ388xWRnYoEnmIf34I=;
        b=iUnBPeAVKn4hobAxMqh/OwaVIXpfUnAeyhuMMF/QpCk0AthPuoPRX3w+XNadUiVO1t
         TAN2G+Mk0fayKVRwLA1iRHWW1lqQah/49SrrDzCxIA+VpfzgPAS3PdEbXh6fhCOHZ9Tp
         lbbOL+74On2GMp+WxBy1sxhpsVff6vafXw61JSZo4t7deE1TbaNMyybZkfVoCNKFpmoX
         bupHZgHauWdAXL9M3RzhyoXg9IoDCjUiYyo0kgNB5ufO1kbaw230mYP13g1lBeloSPGk
         H/XxCAD8kGtIAgLVgs6GM95/UuYQWfoset9nlOqCCGMvR6LcyYRT5stJ3GITDK/RdulZ
         4syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XIJp8Ev/SWzgxb6l0rKcAVisTQ388xWRnYoEnmIf34I=;
        b=tm9NdeKJfmNz9cjFa2K76B43A71hDAPA8nWFnMjMRlWorK7uOr7nzrJeS3zMppxZ7a
         6zDh3eFdLhBaScnRE/t7xec5nN5tN88fFMD+7PH/24SX2juG9svaiIm/Y1bFUMazSNNb
         UsAh3AFZTcS874FR6KQ0OCjr7MQBcGpmvKhjyxXBdYOegjn4nfcldvCxGnN1sW2z0xDq
         fMDgVbrQNkSeaPO0ssNt4u4bNofflrU2g3UclYM9x/kDUxcI6nhKL0kKqNmlsKLHBajB
         Tig8wugRqfIzi4US7jyzwiotRkq5KMaH656jVSxPAYDiyQk0RLbEiE4ctzQ9dhMH1/LZ
         M7Ag==
X-Gm-Message-State: APjAAAUqqTs2YnMYPQIQvNEkkV4SABDfgY1h8xrb64GtJxJpGImgZLzl
        M/7auhdR2Z6JJrSTeayfTK7h7Gu1Lpk=
X-Google-Smtp-Source: APXvYqxxkz5anQl0+hae/8Wk0tRTUINd5UpXYU6dODoQQWe2g/ynC5bV8c3UqeeX+NGejfol3UyDTQ==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr3668515ljg.255.1578507480975;
        Wed, 08 Jan 2020 10:18:00 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id r12sm1644386ljh.105.2020.01.08.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 10:18:00 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 8 Jan 2020 19:17:58 +0100
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix IV recovery
Message-ID: <20200108181758.kkgjtqkom4kuvzih@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
References: <20200108091604.15185-1-rafal.gajda@silvair.com>
 <89614c82891524958af2a7c75c1792b0c9ca4467.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89614c82891524958af2a7c75c1792b0c9ca4467.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Rafał,

On 01/08, Gix, Brian wrote:
> > -	if (ivu != net->iv_update || local_iv_index != net->iv_index) {
> > +	if (ivu != net->iv_update || iv_index != net->iv_index) {
> 
> Would it be fair to say that this is the *only* change to the code that fixes the logic that was
> malfunctioning?

That's correct.

> 
> If so, I would like to shrink this patch to just:
> 
> -	if (ivu != net->iv_update || local_iv_index != net->iv_index) {
> +	if (ivu != local_ivu || iv_index != local_iv_index) {
>
> or, breaking this into a 2-patch patchset, where one of the patches removes the local caching of ivu and ivi,
> and the second patch fixes the actual bug.

Ok, let's split this into 2 separate patches. I still think this "local
caching" was the underlying cause of the mistake.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
