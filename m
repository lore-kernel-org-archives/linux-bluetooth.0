Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4461029
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 08:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhHRIWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbhHRIWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 04:22:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F8C0617AE
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 01:21:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b10so3264821eju.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IUGQJMpYD6agvdMJfJSqVaqnT5bLEbnIc4RgJSXH0jg=;
        b=KFd67qyoRkJqm+Tr0NAOAYYZhcgR6yxB489Fw38wCDJh37MO/2O2e4e8oPY+PO6uB6
         HH49ENUWtwE8gUtSvSSfOWgLs7LRZ3wgVA3tY71FoC81cixhJJmmkHCA2ueBmqusfYdH
         1h9Il7+pczkTiA8ExiLy+6fUZ7wjwFSVh7WP8qSCKCYTeGvt21zrqIqrh5pgcmsivxiY
         hU1bG4vm1e2csd8SwXEQr7ZDzQm0ENmMxUHxH3xrgueNiKd2SixlWP5Ycp734PiN3TtK
         gcS1gpjidTmNlIyp0ks2qWTjW9va8I8qSogu4J6+7SGkfAH+/o6HVnovDpUZdE2c7Xaf
         g6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUGQJMpYD6agvdMJfJSqVaqnT5bLEbnIc4RgJSXH0jg=;
        b=gJ1vwPkhQUxD6/8aqcgvXdNH9ijB3qhiLIa5/8qTxeSnqX1iqdeEsCBdqssQkBk9wk
         mMulGS6kz4PvqFaPqSiBj11/Z2MIlKyenzumTUmQKGpR6m7csXWhP3sDuBsA1IcX/zAH
         s4JIdFSbHAfJKvK/UHbmKEgsjLF5um+/4D2EA9MKZqvMgKqylZLPf9EnMDCsYsNOo/t/
         A1/oElBPxV7mxaz6zdLrXs1I3+uKwHrOQRsUTjtR6PBx8PvgTZHEWv8sfBiCcrqn15GN
         /azk0myX/foQhWx8EbL6da+ZALGwHvHjmjqBhQYP9qKMcC+KzZYSwwC8jBivWl0vSYnR
         0leg==
X-Gm-Message-State: AOAM530bR5gM08b7KUJzwIScItk5AJPlJj3TgZocmUhA8n34gRWK4RxC
        usIZcheUeV/dwAlU1kMPfli8xw==
X-Google-Smtp-Source: ABdhPJzKr1rmco8bFNuuVJquILRCkMGTN+jBNA9OPDgxFXrFZPGoyq0JQUUheWmPtUZUeQ01JFh3Ig==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr8648294ejc.459.1629274913056;
        Wed, 18 Aug 2021 01:21:53 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id ko11sm1694143ejc.54.2021.08.18.01.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:21:52 -0700 (PDT)
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
To:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000012030e05c9c8bc85@google.com>
 <58cef9e0-69de-efdb-4035-7c1ed3d23132@tessares.net>
 <6736a510-20a1-9fb5-caf4-86334cabbbb6@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <32aeb66e-d4f0-26b5-a140-4477bb87067f@tessares.net>
Date:   Wed, 18 Aug 2021 10:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6736a510-20a1-9fb5-caf4-86334cabbbb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pavel,

On 18/08/2021 10:12, Pavel Skripkin wrote:
> On 8/18/21 11:02 AM, Matthieu Baerts wrote:
>> Hello,
>>
>> On 18/08/2021 00:21, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit c4512c63b1193c73b3f09c598a6d0a7f88da1dd8
>>> Author: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Date:   Fri Jun 25 21:25:22 2021 +0000
>>>
>>>     mptcp: fix 'masking a bool' warning
>>>
>>> bisection log: 
>>> https://syzkaller.appspot.com/x/bisect.txt?x=122b0655300000
>>> start commit:   b9011c7e671d Add linux-next specific files for 20210816
>>> git tree:       linux-next
>>> final oops:    
>>> https://syzkaller.appspot.com/x/report.txt?x=112b0655300000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=162b0655300000
>>> kernel config: 
>>> https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
>>> syz repro:     
>>> https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000
>>
>> I'm pretty sure the commit c4512c63b119 ("mptcp: fix 'masking a bool'
>> warning") doesn't introduce the reported bug. This minor fix is specific
>> to MPTCP which doesn't seem to be used here.
>>
>> I'm not sure how I can tell syzbot this is a false positive.
>>
> 
> 
> looks like it's fs/namei bug. Similar reports:
> 
> https://syzkaller.appspot.com/bug?id=517fa734b92b7db404c409b924cf5c997640e324
> 
> 
> https://syzkaller.appspot.com/bug?id=484483daf3652b40dae18531923aa9175d392a4d

Thank you for having checked!
Should we mark them as "#syz dup" if you think they have the same root
cause?

> It's not false positive. I've suggested the fix here:
> https://groups.google.com/g/syzkaller-bugs/c/HE3c2fP5nic/m/1Yk17GBeAwAJ
> I am waiting for author comments about the fix :)
> 
> But, yes, syzbot bisection is often wrong, so don't rely on it much :)

Yes sorry, I wanted to say the bisection picked a wrong commit :)

All good then if syzbot often blames the wrong modification :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
