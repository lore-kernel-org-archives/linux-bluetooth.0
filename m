Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AE9C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 19:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3894664DD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 19:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhA0T36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 14:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhA0T35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 14:29:57 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC2C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 11:29:17 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 36so2847071otp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B2hYtK6ywVznJY/GPnKWtqL8e4sYmR15g6HTT7sKmg0=;
        b=Pyhk2IkK+nOLqcTeMlPUWi/fkx9m/wYTwgAZXk4OVXqr3ubGC/x9RV4qYiCcovkpHg
         6wqUlDx6d0psgxlSWG4poo053dI2JCuATFZJ7BLNC0WB+9MHu+/h0cjsAfQMP0ZNvgdF
         B+aLRx8ZLdpE4Qf0gGIvwsMeouR22j4brK6hUg+R9Dly95Ky4bQEKuMZ0fvMGt7O6JPw
         c2ztj8iglzyp9qr5T1QUbybHBbwYekd+r0aQpZ399PEdYD9ix7laqUTWJhh8/tdGOl9C
         NhsMs9JBqRIiJQ2405dwcjBiP2P5iLDsHDeeKf0Z7QDGWmuL6s+q6f72RvUPaYSIvhdS
         oZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2hYtK6ywVznJY/GPnKWtqL8e4sYmR15g6HTT7sKmg0=;
        b=uV1zjnd5ehZH+f4qtOhvgRS4Dwk1Y1lG/UpgrAbRWkyipXPijWhyh7Wacs2kWr79vL
         YWFCueMADbiWlCfH1VWXTsVXVPJBNqUczFKBjFHXAu21BDo0gulW+Y333OQAQblMMXUi
         pLOPxSZgYK0L48l17c8T6b3Pl9P4owIuI5vgVo1JAU9PZk/RT4NUv8WBHcUhVc5ARVRu
         PoXDi1JAHCIgWpkcwQtDMKr72P4cb/HB8mYeb1GPMxt3jmaaBUd6pMy0weXThlgXjuWF
         QSdEa1UJkcJrlAUr5TH3WCvSyZytaoGlpJqw74BxckL4jZdg1ajmzTDvcICtJaxOo2Lw
         Ya3w==
X-Gm-Message-State: AOAM531OI5eJMbkoQAn8IcrH3AjCRvCeMpuwbmZ4qSumoTIyzomDrz9b
        aXlrDsfM8o1xol6h3hoBDNc=
X-Google-Smtp-Source: ABdhPJywxYAsgfIxvh4W1XOjygc9+sB/wE3HMuFQ/pyZPo+vsszLiCK6iIxZk6C5USeFtI0WOqNxMA==
X-Received: by 2002:a9d:7ccd:: with SMTP id r13mr8865421otn.253.1611775757065;
        Wed, 27 Jan 2021 11:29:17 -0800 (PST)
Received: from ?IPv6:2603:8081:7707:83ea::1652? (2603-8081-7707-83ea-0000-0000-0000-1652.res6.spectrum.com. [2603:8081:7707:83ea::1652])
        by smtp.googlemail.com with ESMTPSA id n1sm604119oog.31.2021.01.27.11.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:29:16 -0800 (PST)
Subject: Re: [PATCH BlueZ 1/2] advertising: Make data size explicit for
 formats
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com
References: <20210127174050.1536152-1-brian.gix@intel.com>
 <20210127174050.1536152-2-brian.gix@intel.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <18a9e26f-92f7-50b7-8389-a7197e2f3298@gmail.com>
Date:   Wed, 27 Jan 2021 13:29:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20210127174050.1536152-2-brian.gix@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>   		error("Controller capabilities malformed, size %lu != %u",

Note that it might make things prettier/easier to use %zu instead.  Refer to 
'man 3 printf'

> -				sizeof(rp->cap_len) + rp->cap_len, length);
> +			(long) sizeof(rp->cap_len) + rp->cap_len, length);
>   		return;
>   	}
>   
> 

Regards,
-Denis
