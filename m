Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00679C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577F20855
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EUt2ZpBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUITL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:19:11 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:37159 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUITK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 03:19:10 -0500
Received: by mail-lj1-f180.google.com with SMTP id d5so2194027ljl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WRuR/cabFaoKyJpsv4Q/sgoLJ+NAm1ZaQckxgSo30uk=;
        b=EUt2ZpBuSv4fYJz5IZtQKiKl/HOvOkmI6D1PwWic7oXRSbQXgSGdCKjiebUqwGn5/k
         z33PvBcgRq9pmXut+4l3fY2NUMITfSucDTXLoxh0QcrrO+ShN72WgM2CRHft7mOf5x8z
         0J7RcaBafsdhRQyPaPKS1QkWc22HhzrxlGNZ8G2l3x8U9IUdCcxIrdm7HiZABIX3xrv9
         TVXcStlRs1neNsUpHISjBIOH5R+wXvT9jo+NZsOi6eC62CBYeamMuhuvQ8NtPCZ7GyHl
         eaQkyBLUWtjkdd1WizBxONtUQPwZvliLd4ZgezgjX6uzhJCAi/OM4ObsSrRSIqyOoyN4
         vQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WRuR/cabFaoKyJpsv4Q/sgoLJ+NAm1ZaQckxgSo30uk=;
        b=j6+8R85BWsCVhyEvtSFSzzOFHmlwrH2iFlf7Mt9waLNcqHIhewY/RLBTfuMbnAPX9N
         np2DeA0LVrzMb2lVGsstf3s+fzcCygumJeBySMTWNhLdwER+WJO6zFpw+mvHvGeKn952
         lF5ehBoiAF+RZPMbrXsPnybUGRhQ5yJCKk7YBv2oYTeYN4sXjUUimNMCW4vc5xIuAMVj
         BCsHiQ5NVmbp4dkZqDzJq1iZ6jr5gFAXFtbZCaWRW6s2kX7hqe0RKosn40sPgFQN7Lg7
         pMe3KnksE9FNWw4/3ddt5VX4CtYECb8usq8RTs4TdZIj/07MscbAVKVYtE+QtgttJbdS
         po0w==
X-Gm-Message-State: APjAAAXzTpR1dA9POXEeVrBkHMKffEM5NplyiJ++aKJIws02gYUeIjnn
        Yu6Kbnsh+u1Vh6X/AT2sbGWPOT5nAISb0g==
X-Google-Smtp-Source: APXvYqwyMeF1Ju1yQG37FPrlzoSncsnEb54QwqzSvywcQec5bVPv6/3soRfA2FmSHaCQg2iWfYF6SA==
X-Received: by 2002:a2e:9841:: with SMTP id e1mr6306951ljj.19.1574324348020;
        Thu, 21 Nov 2019 00:19:08 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z127sm910175lfa.19.2019.11.21.00.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 00:19:07 -0800 (PST)
Date:   Thu, 21 Nov 2019 09:19:05 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/2] Include destination address in MessageReceived
 API
Message-ID: <20191121081905.zb4m5gqj5kywjl3v@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian

On 11/18, Michał Lowas-Rzechonek wrote:
> This patchset changes the MessageReceived API, replacing 'subscription'
> flag with destination address of received messages.
> 
> The application receives destination address as a D-Bus variant,
> containing either as a regular 16bit address (unicast/group) or a
> 16-octet virtual label.
> 
> See previous discussion https://marc.info/?t=156719067300001&r=1&w=2 for
> rationale.

Any comments about the patchset? If the change itself looks OK, I'm
happy to improve the patch if needed.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
