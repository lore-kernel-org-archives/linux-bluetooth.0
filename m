Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 08:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiBXIYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiBXIYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 03:24:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D526F4CD
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:24:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r10so717550wrp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 00:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=XqWyJi0pSAm3AXOPmlEWu4cafaZycSG89jRF8U7cukw=;
        b=M2vnYrG29YNK+K3W7gGuzGXd4tiasxcq4Vh6jzDOG4NL0ZAAyNTNVtqZb+Fg2vuWBZ
         ktVxYL4PQNM8Nu1xsT1YFP5NEUbZwuep/8mg97miJCumIH7AjJ3quboNYwJ04+T8RvXv
         Odl8BtfZMHPPxvdV5Mc+XwxvrQp/ggRWyiH4sUeVR4m4fhDa4wua4Y+JHUylbndWPslV
         4th+wWbZbnEN+sibS9ftbn47HEYh/jNiBhGcyc5acwG2Sgap5hclLXt4oA5XW5mTANg6
         KgqgzkAAIRyDyDm6jMqDRvWCpShHl5+i6JTtHz/G3d0lUVdi0QCQQipp8Kob8mAwwA4z
         LR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XqWyJi0pSAm3AXOPmlEWu4cafaZycSG89jRF8U7cukw=;
        b=1lRxtlb1ChfY2FdrsF4Y3pJMYWKEt0IDeNqpsRJs/y/RRdJLV5mWYZwVDuFyFUpKCc
         8QEgA+0fbhpteKuj6u71IecNMv3OwFyITLC9AsjepYGnsUMKw+LB4/4LGtXFn67s397X
         BWcZ/53fTxUb67/IxtOxN/iMW0AFVOb6ByBlpmScFFjSGs/m62eYZiDLurdJziAy9XUb
         AWeFnHr1xZCJf6ceoS/P0ZfgQ9M+6AnwntlaiQOeXn0mptHmXlLWJM/NI5Uy3YRdrbZw
         ynMk/bbqM3shrtVlD532Ny7TnAxX61+6QzknxKZcwiUA07ac/HgG8Qfck2/GyKDZDB+w
         GcNw==
X-Gm-Message-State: AOAM532c1/ICgMZUaifu3N7xsLKP8LPuYnrMK3lXv2C8tyV/lVLgtml3
        ErQmuNa1LijCy2hzOTQWngJgXN86Nag=
X-Google-Smtp-Source: ABdhPJyZXkcPWjchRe3Dav3rCLvHQqg77obLMU0UT1Appu/vwwRkjdugzhblvA6JKRPPdZ0sur1iVQ==
X-Received: by 2002:a05:6000:18ab:b0:1e8:f67a:1518 with SMTP id b11-20020a05600018ab00b001e8f67a1518mr1267224wri.52.1645691050267;
        Thu, 24 Feb 2022 00:24:10 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id j9sm2411037wmc.5.2022.02.24.00.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:24:09 -0800 (PST)
Message-ID: <a58b7849-540a-53a8-bfc5-6198312a0728@googlemail.com>
Date:   Thu, 24 Feb 2022 08:24:07 +0000
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
 <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
In-Reply-To: <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On 24/02/2022 05:59, Chris Clayton wrote:
> 
> 
> On 23/02/2022 22:42, Chris Clayton wrote:
>> Hi.
>>
>> <snip>
>>
>>>
>>> We are starting to suspect this is not a new issue, it just become
>>> easier to reproduce with newer kernels since the mgmt commands are now
>>> handled by a different work/thread which probably takes longer to
>>> respond hitting problems such as:
>>>
>>> https://github.com/bluez/bluez/issues/275#issuecomment-1020608282
>>>
>>> This has been fixed by:
>>>
>>> https://github.com/bluez/bluez/commit/faad125c5505b941f06c54525616e192a6369208
>>> https://github.com/bluez/bluez/commit/5f378404bff6bbfea3f20e36535c494efa5066a5
>>>
>>
>> I cloned bluez, but that FTBFS, so I applied the two patches by hand.
>>

Sorry, the FTBFS was my error - I didn't do the autotools magic properly. More haste, less speed!

So I've now built and tested 5.17-rc5+ (v5.17-rc5-21-g23d04328444a) with bluetoothd built from a fresh clone of the
bluez git tree taken this morning (HEAD is d89af9a). I'm sorry to say that I still get the intermittent failures when
trying to connect my bluetooth devices. By intermittent I mean that if after starting the system from cold, if the first
attempt to connect fails, then subsequent attempts also fail. If, however, the first attempt succeeds, I can disconnect
and connect again as many times as I want. With a 5.16.10 kernel, connecting and disconnecting  works reliably like it
did with vanilla bluez-5.63.

Chris

>> After the first boot, my bluetooth devices connected fine. But after a poweroff and boot, they didn't. Nor did they on
>> the third and fourth boots, so the patches don't seem to be the answer. (They couldn't really be anyway because changes
>> to the kernel have broken user-space which I understand is a big no no unless there is a really compelling reason.)
>>
>> I've gathered some diagnostics today and they are attached. They consist of 6 files containing the output from btmon and
>> dmesg and the log file for the system daemons, which, of course, includes bluetoothd. There are 2 sets of these files -
>> one from a boot that resulted in a system where my devices would not connect and another from a boot where they could
> 
> s/would not connect and another/would connect and another/
> 
>> not connect. You'll note that the btmon log is empty for a failed connection.
>>
>> I also tried a bisection with v5.16 as good and v5.17-rc1 as bad. Unfortunately, I found several steps resulted in a
>> kernel where bluetooth seemed to be substantially borked - to the extent that blueman was non-functional and clicking on
>> the tray icon did not start up the blueman-manager application.
>>
>> I also booted into a 5.16.10 kernel and connecting bluetooth devices worked flawlessly. (This was with the unpatched
>> bluez daemon)
>>
>> Chris
>>> So the timer doesn't start until the request is sent. but obvoiusly
>>> older versions of userspace don't have that fix so they end up
>>> cancelling the loading of LTKs, this would explain why reloading the
>>> daemon would make it work again.
