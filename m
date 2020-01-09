Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4882C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E152077C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="MaONT6uX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgAIV3k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:29:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35187 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIV3j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:29:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id j1so8830710lja.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dr6hmUOEEVkx566zXdNca4NBj3yQTAAohBNMUPSdoBA=;
        b=MaONT6uXfuuVD5gWQEblvW1acQSkm9YVNGLJEgAxCMLdQKhlOd9reo97sv/nb6XsOm
         V/XTswK0XDP5RUTxogF25ToykYzZ83Uom4sbtEkiP72dllElsBbhzI9gAVCyVNzc6N8u
         Q4WzMRJPGlN7EsQFk69UlVsHQs4P57E0sNGI7RY7Poqm8LrSgUeiM28+kcpEfJO8yCgq
         jxtjD1uk1DRqeFwg8LG/lkKJaGnt7ynhJdkbTzvOrPl00tsiQtuqcZSApnkYeaW+cRMh
         5SQo4nE0HJqd1XsNxAVNdShW3XZAfX1f+ilrs9wBfQ5bm3WMLcY3YTnR3k3WwQMokSJh
         zHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dr6hmUOEEVkx566zXdNca4NBj3yQTAAohBNMUPSdoBA=;
        b=W/vT1Jmcbi1IG6A3vy9X46QTE9D/q49xymQWasGAhsPJoVldUWWqs4WV2bhbfc+bal
         PXmlZwtRiFk+qes7xKmWEZUhBbJONVsdFP29tCQBIp48iS69JgQx38x6wwQwGC6jNVRS
         7xTe42fIIsthF6dMFFuVOf1EJeTZrISfQ0dD6FhqQBeYqXMhP8Gj4ZL9j0ldSGIni6qX
         49kv1VVMynAYhi24+dOKct/QTEuupRNoxzx6TzZZrMQT7JwPqW2kWaLXSp1B8eLyRsE7
         0SH2thm1vDP1CjVDeMVh8fI57gdU3IxhDQClxxvQ/fqD2HobmcP+G0qsPOxxoH+dUoGj
         80AQ==
X-Gm-Message-State: APjAAAWEPZWxZ2l8NcrPrCJWJzXSK1+7tY1TE9wt0k8WaqbLJGGz2ZIY
        OSpzwS0J6DM2ta+BB3vcWySoow==
X-Google-Smtp-Source: APXvYqzeQiQAJ70k6vssnkWCTJedxfRogIAG/8jV3iYDgyBUmcqZycbfQ+Cp3ILOvOd2eTnbqW/uyg==
X-Received: by 2002:a2e:6c13:: with SMTP id h19mr44316ljc.221.1578605377664;
        Thu, 09 Jan 2020 13:29:37 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id g24sm3622404lfb.85.2020.01.09.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:29:37 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:29:35 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Message-ID: <20200109212935.6dn5ivmnupfd5f2d@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200109175715.22925-1-inga.stotland@intel.com>
 <20200109210006.e3qv6uxnr2w3isc5@kynes>
 <31a576190ecbd1ba3f7e779d746baf35815fbed9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a576190ecbd1ba3f7e779d746baf35815fbed9.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/09, Stotland, Inga wrote:
>> Please don't use bit shifts for division.
> Why?

Because it's a different operation, and is less readable.  It's a
formula, so use math operators for numbers and bit operators for bits.

For example, idx_pair <<= 12 is fine, because the *context* is
bit-packing. Noone sane would write this as idx_pair *= 4096. This
reasoning applies the other way as well: don't write foo >> 2 where you
mean foo / 4.

>> Also, I think it's clearer to write this as:
>>     req_size = num_keys * 3 - num_keys % 2
>
> No, this is not how I read the spec. We need to pack 2 key indices in 3 octets.
> For example, 4 keys are packed in 6 octets and 5 keys are packed in 8 octets.

Yes, you're right. Sorry.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
