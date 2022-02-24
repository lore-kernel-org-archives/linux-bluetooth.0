Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6EEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 05:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiBXGAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXGAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 01:00:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89772649BF
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 21:59:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i20so492244wmc.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 21:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3rV7qCnw9rBAgXbr9d5EnEhXtSL4DlEIZjORHfyBtgU=;
        b=Fsf68gGK7Og4hDRSgSR9g8RpIPKxUc2UhpaqR3DgZNdmwoSD4KiIsBN38U7kb9MIyT
         9Pw9UVd/qocHa2o69uRzysbUMq7EteEcA2tlfBA+eTTAuIrT/JKH4zkb4Udk8A18siDC
         mVDWYNPNjtT/D7bEXKMjRfA/Fc4Z4AUipP1L3iUIw0fZJcrfkaFsPhBZCsMrtxzCyMPw
         VXEkpniBYWHZe88KhULmaiR51bHW+mmWtfBuCztprSzDuTwZPqlcotUZVApziJMi1ns+
         OuoAYLZFZyRRJJo4B+irqdCPnzgMxj6M1KnMwuVg9wIycScJXAHR75E0XsDBKXKUUCPY
         ziiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3rV7qCnw9rBAgXbr9d5EnEhXtSL4DlEIZjORHfyBtgU=;
        b=4vQDiZtrIVTvM51paqr8DDT73FYLDgllSpWtzviEhPripVMfmyb3UtKheV16jGv+I8
         f2fsx2cnLz8JZ63gMSoUKBhGKfHSu84bn1LorL5r3jgO04Pbw1Oj3LjU1XJ64Hz6FJc2
         SJJchO7FvEQQCHrQ0yV1xYwSCVcJjX/YBVMeLc3LRl/0hPEqR4LZFGRW3xf1WX36vMl6
         wkU1cflWP0IbIez3wl2oRfPGa4vznJWxr50ZsR8Zfj53o4UBTGxmJII/1J+lGecgLgIb
         A9NXVjiJxarg5p0BPUujH/15MJut0bBwLQQ0m+ErAKfPBbP8izhEa1b3Ojp52bhRI6Jm
         WUAg==
X-Gm-Message-State: AOAM533zKD4yFww8lVwYtGiz8LVHzNTtm4uUHl5kzNle7evxC53OPh/Z
        JBtHghDlTkhVKVyGtzIXz9A=
X-Google-Smtp-Source: ABdhPJy8unzcG3QmBIbLm/XorhEM2DpRMLEhlminOVVXiHnKGnBr+/NZULZTt1isqB7ajzaGu3++rQ==
X-Received: by 2002:a7b:cd87:0:b0:37b:b8a8:2d28 with SMTP id y7-20020a7bcd87000000b0037bb8a82d28mr876084wmj.176.1645682393401;
        Wed, 23 Feb 2022 21:59:53 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id 14sm1823681wrb.34.2022.02.23.21.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 21:59:52 -0800 (PST)
Message-ID: <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
Date:   Thu, 24 Feb 2022 05:59:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
 <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com>
 <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com>
 <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com>
 <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com>
In-Reply-To: <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 23/02/2022 22:42, Chris Clayton wrote:
> Hi.
> 
> <snip>
> 
>>
>> We are starting to suspect this is not a new issue, it just become
>> easier to reproduce with newer kernels since the mgmt commands are now
>> handled by a different work/thread which probably takes longer to
>> respond hitting problems such as:
>>
>> https://github.com/bluez/bluez/issues/275#issuecomment-1020608282
>>
>> This has been fixed by:
>>
>> https://github.com/bluez/bluez/commit/faad125c5505b941f06c54525616e192a6369208
>> https://github.com/bluez/bluez/commit/5f378404bff6bbfea3f20e36535c494efa5066a5
>>
> 
> I cloned bluez, but that FTBFS, so I applied the two patches by hand.
> 
> After the first boot, my bluetooth devices connected fine. But after a poweroff and boot, they didn't. Nor did they on
> the third and fourth boots, so the patches don't seem to be the answer. (They couldn't really be anyway because changes
> to the kernel have broken user-space which I understand is a big no no unless there is a really compelling reason.)
> 
> I've gathered some diagnostics today and they are attached. They consist of 6 files containing the output from btmon and
> dmesg and the log file for the system daemons, which, of course, includes bluetoothd. There are 2 sets of these files -
> one from a boot that resulted in a system where my devices would not connect and another from a boot where they could

s/would not connect and another/would connect and another/

> not connect. You'll note that the btmon log is empty for a failed connection.
> 
> I also tried a bisection with v5.16 as good and v5.17-rc1 as bad. Unfortunately, I found several steps resulted in a
> kernel where bluetooth seemed to be substantially borked - to the extent that blueman was non-functional and clicking on
> the tray icon did not start up the blueman-manager application.
> 
> I also booted into a 5.16.10 kernel and connecting bluetooth devices worked flawlessly. (This was with the unpatched
> bluez daemon)
> 
> Chris
>> So the timer doesn't start until the request is sent. but obvoiusly
>> older versions of userspace don't have that fix so they end up
>> cancelling the loading of LTKs, this would explain why reloading the
>> daemon would make it work again.
