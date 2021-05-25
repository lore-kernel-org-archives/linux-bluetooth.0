Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B689C47084
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA776141B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhEYTYR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhEYTYR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 15:24:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1325DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 12:22:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p7so29660650wru.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5CVQbWQEA8Z6J3MCJnT7LXQX8y66mQxXXVGdv74BjLU=;
        b=IUYW3Uvra6xL+QBVX3HN7V3imgqvlT8Hnamp3gs35tZZjcIl6f15FEDWm8goaATzZP
         tj9z3DMnnA9tPFL1uIuLXbPc3pvrROz7RNXryKa6UBP4QrROfjB9Qm74M141YLQXj+IL
         SU9wpbqDBc7DQHolmEDnRijJyEL6S8f2CVgWRo202V0qndDa5zE+fQQlICpEAGtyPEr0
         JYSKJ47oZqaRqNZGE907LOkz95JYuYCtsqM+zOkzmQKjNmX6PA8IQ2s986moZT8FyO8T
         LRLsrjxCL13pyl4PekFnDuMRn0gk7Uy0I1mxlFsr4DuwXqEnYbxJbbuKule9G/ZsQ8vD
         lqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CVQbWQEA8Z6J3MCJnT7LXQX8y66mQxXXVGdv74BjLU=;
        b=Louu8pII9jWT2D/k9FDuggxBYlmbiPCUmzsKY/CVFZhjUv50mIkCi6pfSqFaYkEb5j
         MaEdehuSHQwJfGaxDJraaDPn0mRdGFgGY0hrt6hWlfBKn1f85/jZmh+zr0ybFWLnE/QA
         4wYCbME5JWfmr0A2kZhLtKk9ebvKO8NQq71CYJmeNbgeuVYdKtATxwlPo/KJnOA8Wmkm
         cELBy8VuzT0K+vfT5uvoWXs8QTOduS1KkkgN/I8JRfPHHxhy78l+9N0PLYP4bElFI6Yk
         vw4naw65akOVmrqR8Gd6nAc5oZjikGUFh6VjqjJqrcPGYNxpd89kveOwSk0O5jYqsYht
         RT9Q==
X-Gm-Message-State: AOAM5325gxWzNHFKQoDWrtoToLBs8VLty97MQ1EgDxl2K/csADmsY6qs
        Ec/G4RRa3ZSnNOGWcvmu4Ag=
X-Google-Smtp-Source: ABdhPJzpch5gZ/sNFVJLJIMPi+ZgYlSqK9oGrt6iY4P7dF6PHUUFoyvWAlS5ZapI467+P/OdGKo52g==
X-Received: by 2002:adf:e944:: with SMTP id m4mr28865948wrn.10.1621970565720;
        Tue, 25 May 2021 12:22:45 -0700 (PDT)
Received: from [192.168.1.10] ([94.10.28.216])
        by smtp.googlemail.com with ESMTPSA id d15sm17326634wrv.84.2021.05.25.12.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 12:22:45 -0700 (PDT)
Subject: Re: BT Intel: Regression loading firmware in linux-5.13-rc3
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
 <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
 <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <d97da5b6-a337-3550-ace3-e6789fd9165f@googlemail.com>
Date:   Tue, 25 May 2021 20:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz.

On 25/05/2021 19:10, Luiz Augusto von Dentz wrote:
> Hi Chris,
> 
> On Tue, May 25, 2021 at 8:08 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>
>> Thanks for your reply, Kiran.
>>
>> Does the phrase "next release" mean linux-5.13-rc4 or the next release of linux-firmware?  I just want to know what to
>> look out for.
>>
>> Thanks
>>
>> Chris
>>
>>
>> On 25/05/2021 11:14, K, Kiran wrote:
>>> Hi Chris,
>>>
>>> This is a known issue related to firmware and is expected to be fixed in next release.
>>>
>>> Thanks,
>>> Kiran
>>>
>>>
<snip>
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9
> 
> That said we shall probably merge it to 5.13 before it is released.
> I think you should, otherwise, without patching, 5.13.0 will be broken for many bluetooth users.

I've applied your patch your patch to Linus' latest and greatest (by hand - it doesn't apply cleanly to the current 5.13
tree). The error messages are no longer produced and bluetooth is working fine, so...

Tested-by: Chris Clayton <chris2553@googlemail.com>
