Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C963C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356539AbiBULkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:40:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBULkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 06:40:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A11ADA7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 03:39:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so10897751wrf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7zy6QePz8c4asEvDZg8msbvtodGmGzMRlHFMOg79zIs=;
        b=qHvb65K3KYkd4hlqX+GLjBmaYLjDvuq4h1vXsopFgyvkEPwegnMv3PimusX/lLIEmc
         FgvHYdvhd9ZMhedDv1fQROsn3abffDEmX9zYBzVFC3oZmCY1QJyI8aiMHBN9GEnDlpWN
         /drzNryRLV816P4Aykwu0oIFYzQ+BySipDsn9w6Gpeg0EspAJIgjqTvTbV/NE1Jl6wjo
         FivQi1h0dbH0iGaoE7YfoL4yDmanIh698IsXMwiMjzR6v1x11IGWOO+E1OSdFA1Zqp4i
         ADkL8bSKer/uBL/5qT3X2YFt0REchinOECK5CFTrutPsoIw1CO8FZlfuUhivM1aU3h05
         LFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7zy6QePz8c4asEvDZg8msbvtodGmGzMRlHFMOg79zIs=;
        b=zhvM62HYxEwiT7ng9XvsLFBmDuw3utzf707uEJcytr5QLTgN0PKzzfViEMBfzwl7rM
         1em9ejGfBvr0bskGfCEuxa7b9rVrAoGbQDktXGm8mmiCdOvq/WmM1H325Vobbmjlsouw
         5GI9xaut9j5z5F0goM0ekm7u0kcr7vI54x9/yVnGqGr+GcRAfJBEXPjPY1av+PgsHIZX
         4cJpWGmFgmvbRNrC/kjEW8h3NxfMNpWMuCL+9QQTe7LnPonBAf/CUcGK31xtwpRmKm7Y
         vQxxPvsQvgK1gO88wQkcpxXu1vOSi0gqdO5cHX35ZCMoUxww5Bmn4PM28ssgVQOKMs8B
         UyLw==
X-Gm-Message-State: AOAM530XHSCAMTDPYO9IYXSwPU8WW4ee3G584Yyrm1yq7AM2JNFbd/OX
        FHLE2XAhIkBjR5l5jEiw+zNah2jU7oI=
X-Google-Smtp-Source: ABdhPJy6MR0/2sai2fcq8wJhiivnSmYtavB+PwWhVFbIvWVBxjy/MrJvQdNFo8BIr7M2C7bfNm+zbA==
X-Received: by 2002:a5d:668b:0:b0:1e4:a643:7146 with SMTP id l11-20020a5d668b000000b001e4a6437146mr15169109wru.340.1645443591852;
        Mon, 21 Feb 2022 03:39:51 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id a9sm32716876wrr.20.2022.02.21.03.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 03:39:51 -0800 (PST)
Message-ID: <db9c193e-8fd5-111c-ffc8-5e15ab9b205f@googlemail.com>
Date:   Mon, 21 Feb 2022 11:39:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Content-Language: en-GB
To:     Chris Murphy <lists@colorremedies.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi folks.

On 18/02/2022 03:49, Chris Murphy wrote:
> On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Chris,
>>
>> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>
>>> OK I started over, and for now keeping the reporting constrained to
>>> the hardware I personally have on hand.
>>>
>>> Hardware:
>>> Lenovo Thinkpad X1 Carbon Gen 7
>>> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
>>> Jefferson Peak (JfP)
>>> Sony 1000XM3 headset
>>> bluez-5.63-3.fc36.x86_64
>>>
>>> kernel 5.17.0-rc4
>>> * remove the paired headset with bluetoothctl
>>> * reset the headset so it's not longer paired either
>>> * put the headset in pairing mode
>>> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
>>> * click on Not Setup and nothing happens
>>
>> Well from the logs it doesn't seem the GNOME Setting is trying to do
>> anything, have you tried bluetoothctl> connect <address>
> 
> `bluetoothctl scan on`  does see the device
> $ bluetoothctl pair 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available
> $ bluetoothctl connect 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available
> 
> $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
> 
> 

I too am finding that my (already paired) bluetooth devices can't be connected to using 5.17 - 5.17.0-rc5 to be precise.
However, I find that if add a return
> 
> --
> Chris Murphy
> 
