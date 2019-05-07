Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C4FC004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419620656
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnI2StCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfEGUzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 16:55:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46472 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfEGUzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 16:55:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id v17so8249074otp.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9XvpZgCJwawGoPXIn8zPUV9ybaabAFKgmRnutSisA1I=;
        b=YnI2StCGwKy5TSoGm98I0dPpRBFdi8wIY5CqEp9kbL9uCtrxiEI92zBoQs+N5/AwDB
         iDBPnsflbWiujgXqt/juCbDv9GImuu04tsIgQpb7y49qxYjYw/hrbTsPN1rTSB38g/cp
         D+HYx5JVXHPPPv4ryPjvtf0vXB4FULzA5ypZTC5O14egE46jiDhZvKK4o4ws+dYHCazv
         dQfAIZUAtuKVv5MJrSsfyyetBmyVpbx9V5qRSgtygfePxGMPQinM+golF63/Ub8b0QMn
         xOCqcBq613y7l7R4+VbeuFD//rLVKzfQULn55yCa0Nx3WvQlDBKzkyFNHYDAddoQzjYo
         meRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9XvpZgCJwawGoPXIn8zPUV9ybaabAFKgmRnutSisA1I=;
        b=krsHvCZ+KTm7VxhQL51+HegxT7qLB7y9+qaQ5q39pWxSUvSgSQ6h1VGXRjy5ri0TBc
         bXOn3/rxG4nL7b1/5gjy3ObMC5zyTeliw2Q5fIwSObR+VUYYDYCVUmzvnxCd8JgPosgE
         7+pRMXkj+0XQ+oZ9Po86GO5YAArcLSqJBdvN9lRtKEjqUVyPgtCFDamIQAFE0KJqyL0u
         x1ylbHgqnPVyIfzx77LECHhiuPt9VELWYSik9b7vz6gVcu4FcCSyr49QAwTv1VteaX2J
         IURD406dBLQ3iF9kqZdPpiRL0roVZd+2g8u0E3hVCRGDrxMi3/z0RJ0lBKKzV5MaYuht
         ENqw==
X-Gm-Message-State: APjAAAWFvCqt2SSJCjgC3z/pndZQ2VQ9Gw82V6ONYhwbQ0+vJqRg2LVT
        G/RNv33Cr1dObrb2/xVVzkg=
X-Google-Smtp-Source: APXvYqxr1jAQJdRhzUbpx4//FTq2WM1oazM1tTVRcazd2fH/EQP8mjsLJhoo8hA/3tTV3tiNoVy6Gg==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr2292724otm.284.1557262551873;
        Tue, 07 May 2019 13:55:51 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m20sm6047558otq.30.2019.05.07.13.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:55:51 -0700 (PDT)
Subject: Re: [PATCH BlueZ v2] mesh: Use node uuids as storage directory names
To:     "Gix, Brian" <brian.gix@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
References: <20190507071340.20675-1-michal.lowas-rzechonek@silvair.com>
 <1557261666.31289.11.camel@intel.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <18e096c6-3b22-0096-5cb2-bef7264dbefe@gmail.com>
Date:   Tue, 7 May 2019 15:55:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1557261666.31289.11.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 05/07/2019 03:41 PM, Gix, Brian wrote:

<snip>

>> +		if (asprintf(&cfg, "%s/%s/node.json", dir_name,
>> +						entry->d_name) < 0)
>> +			continue;
> 
> With ELL, we do not use asprintf.  Every dynamic allocation must map back to l_malloc, which performs an
> abort() if a memory allocation fails.  So this should be re-coded as a malloc of the desired size, and then use
> snprintf, using the malloc'd length as N.
> 

...or use l_strdup_printf.  Which is actually asprintf underneath... ;)

Regards,
-Denis
