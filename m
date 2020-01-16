Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB3C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9424681
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Dm/Fo4mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392708AbgAPSQj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:16:39 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39064 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436474AbgAPSQh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 13:16:37 -0500
Received: by mail-lf1-f54.google.com with SMTP id y1so16188853lfb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8NOXEoIwyCfE3MSBNh+YfE5C2+yQ4Qu+EkGHXShP94I=;
        b=Dm/Fo4mhJmc+I3vWXVcD/syAm8hzMcOGii2NnjgzzTLD/lWRT9p1ZAKIvxNVZxpdJ6
         CTo7dWDbAZhS2GxQa1Y/32V/LaD4rFL2Gf/3csVqBPooGSl8k5KfzI69Z9drhawwtSd6
         7GHHlPzOdAHPj/BlgVlzQpF0f4g4sg9uIqS6e8+/jCaFzNM+mHkH6sMq7XGSAss2thL+
         PPQihF1ONHfgyw3MQYa9HKoaY2OuLrhgNdZkdIGLgIv4rFnxhfyrgl3eqJXi1/mIgw9I
         MWXzmSqHeG/ZzF/1J1DFsN7/AHG7WPqZmhLRqI42t9DaR1RZkGYNxqN0ci3ROmT6Ni6F
         UyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8NOXEoIwyCfE3MSBNh+YfE5C2+yQ4Qu+EkGHXShP94I=;
        b=L4OV7o04r3DzY0Jq2Taxh/AXIVk9Pzq2LOag+Qw+ncEfW82l6/S9TF7v6fzKaPOjER
         4RrC7YJSZxokjEYqtrGc2Q1OCkLWhb9XZXPh85cyv/hzjV5CYMpwTv9XqkcWiGyRv2ek
         fBIowTiSz2oqMiezxMvJPeaPe59dGkKtOFAZ6ej9LKpseWn72YXWfsfCv6HCxG0eE7Uf
         fJKe80OZW4CjYuHjPjUmTGZ4vcP44PT0inRQRLGm/XJBGaRuY+HFPwprH6WxwTpoXotp
         c5ogeLIt2pFel0xhFdxSkoC5edY8I0rRNEJRJJHJPoFYwkjf3wgVOoqJDERBLhAEKV9O
         vk7w==
X-Gm-Message-State: APjAAAXk/yrVo28RNEfpfMvW+1M1PL4/ugjTUFVfuV8C0A2mtV0hiTVP
        sa3iTTFDUWA/wM+bxz4uuzOsUg==
X-Google-Smtp-Source: APXvYqyqhE90DjsPn59HEJ/lmoGon7WdANq/8TbLY5HFur+WBd4hplhL6ktjzbh5Z8GTm+hYwLuY5Q==
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr3087588lfg.34.1579198595758;
        Thu, 16 Jan 2020 10:16:35 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id a15sm11034380lfi.60.2020.01.16.10.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:16:35 -0800 (PST)
Date:   Thu, 16 Jan 2020 19:16:33 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ v3 0/1] mesh: Sequence number related fixes
Message-ID: <20200116181633.rtda4hlxeidzmg54@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        jakub.witowski@silvair.com
References: <20200116163908.18041-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116163908.18041-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian, Jakub,

On 01/16, Brian Gix wrote:
> Adjusted comments for clarity,

Thank you.

> and adjusted the cache-write code to not rewrite the NVM storage if
> nothing has changed, to prevent NVM thrashing if we do reach the
> out-of-range boundary

True.

> I would like both Michal and Jakub's comments on these adjustments.

Thanks again, LGTM.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
