Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiBXKIg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiBXKIf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 05:08:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC6277909
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 02:08:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so912766wmq.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QE4r6AuFe3dQO6495+hzl0XpmaeVwKTjdWPNhBsedTc=;
        b=M9u7cPCyL7O0+feYRb+u1mwqCaRAByRwJxx7DK8vJaCVWkWCioNcsdWCp1y7l8dV04
         +JF2gRPloGWInxs2MrUk+wz4POQcUbgJqxT23p34ovsBTU7ELQLpmqjW0LjREVYkUuAj
         leRVT3cVtc8BWki4kto63PmbA0gwirABGE+SRg9YeRo8w2tWVRfgiZ4i48G0kwaYn/M6
         tzrour0elPLSchtfRAECjvSS9a90qPQnaKzDs9w0K26tgF4mKa+nsYtTHTuxOeeaHRZz
         q5dJyLw+qYtRCkKz0bVDmqC0WxmQk5gjxICIip96XOY/5F0Rgyy17DYRd0/taqbyMI8R
         38aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QE4r6AuFe3dQO6495+hzl0XpmaeVwKTjdWPNhBsedTc=;
        b=mzsB7k5zZm/IrpIsnXD7Q53EWDUUEnkf6CMTC63dcNpoqC0dvPz42d/Z4o2uegl4Mg
         9ghSgZXCpBOtRtu8n49gD0upbHbyogy+/DpM4UXAJcAtKzcq/IvuTbyFJoxkPi4MQKTF
         tJyFiG95oU26xctNU9ZpQwBHL+3e1ctE8prxIdclk2YH9t3TNGqGsvZef3oSmf3UAhYU
         Ol2VvM+0QvKXebUdfa8LEFL+NRe/CVW7K8HptmPOcfbsYYN3eZohPy/3z9ArPulUlBgD
         bA0I+2zRNo30eIA/WgKlPwP7KCrP/wO7H97CMZBy+3cZGTSpYNeZKkihwaBEOjb+V9+j
         cLxQ==
X-Gm-Message-State: AOAM533JuTkTu20kpEgwxWktlCNQw6samtbCHfX5UMm/osNkttJPDM5K
        d9vWRk9VQMp3Olx5J5QQjqgqG6m3eTg=
X-Google-Smtp-Source: ABdhPJzLKkSsXDqcmoAonTrWGo4YN0iInFwWxQJN6QFoSIEIp5MLI+EQzMwHcwsX3+m6ijk/MtWtyQ==
X-Received: by 2002:a05:600c:1f16:b0:37b:c7f2:fbb4 with SMTP id bd22-20020a05600c1f1600b0037bc7f2fbb4mr10655478wmb.47.1645697283951;
        Thu, 24 Feb 2022 02:08:03 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id u7sm2152961wrq.112.2022.02.24.02.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 02:08:03 -0800 (PST)
Message-ID: <17f2bf7e-1d6b-e090-8926-21a408f2b496@googlemail.com>
Date:   Thu, 24 Feb 2022 10:08:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
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
 <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 24/02/2022 08:16, Luiz Augusto von Dentz wrote:
> Hi Chris,
> 
> On Wed, Feb 23, 2022 at 9:59 PM Chris Clayton <chris2553@googlemail.com> wrote:
>>
>>
>>
>> On 23/02/2022 22:42, Chris Clayton wrote:
>>> Hi.
>>>
>>> <snip>
>>>
>>>>
>>>> We are starting to suspect this is not a new issue, it just become
>>>> easier to reproduce with newer kernels since the mgmt commands are now
>>>> handled by a different work/thread which probably takes longer to
>>>> respond hitting problems such as:
>>>>
>>>> https://github.com/bluez/bluez/issues/275#issuecomment-1020608282
>>>>
>>>> This has been fixed by:
>>>>
>>>> https://github.com/bluez/bluez/commit/faad125c5505b941f06c54525616e192a6369208
>>>> https://github.com/bluez/bluez/commit/5f378404bff6bbfea3f20e36535c494efa5066a5
>>>>
>>>
>>> I cloned bluez, but that FTBFS, so I applied the two patches by hand.
>>>
>>> After the first boot, my bluetooth devices connected fine. But after a poweroff and boot, they didn't. Nor did they on
>>> the third and fourth boots, so the patches don't seem to be the answer. (They couldn't really be anyway because changes
>>> to the kernel have broken user-space which I understand is a big no no unless there is a really compelling reason.)
>>>
>>> I've gathered some diagnostics today and they are attached. They consist of 6 files containing the output from btmon and
>>> dmesg and the log file for the system daemons, which, of course, includes bluetoothd. There are 2 sets of these files -
>>> one from a boot that resulted in a system where my devices would not connect and another from a boot where they could
>>
>> s/would not connect and another/would connect and another/
>>
>>> not connect. You'll note that the btmon log is empty for a failed connection.
>>>
>>> I also tried a bisection with v5.16 as good and v5.17-rc1 as bad. Unfortunately, I found several steps resulted in a
>>> kernel where bluetooth seemed to be substantially borked - to the extent that blueman was non-functional and clicking on
>>> the tray icon did not start up the blueman-manager application.
> 
> Running with 5.17.0-0.rc5.102.fc37.x86_64 there doesn't seem to be any
> problems, well apart from LE device with Privacy/RPA:
> 
> https://gist.github.com/Vudentz/5792f4989198c7f2994af2e31eb973af
>
> Ive tried suspend/resume a couple of times just to see if there is
> something odd going own, anyway I'm running with the latest userspace
> so perhaps I really need some old userspace to reproduce this. There

I don't have an old userspace. I built my system from source about four years ago using the methods from Linux From
Scratch and Beyond Linux From Scratch. I have been updating the packages since then as and when they are released. In a
way, you could equate my system to one of the rolling releases. It is very up-to-date but at the same time very stable.

This morning I updated to the latest releases of the 5.15 and 5.16 stable series. I've also built and installed the
latest in the 5.4 and 5.10 stable series. (All four had new releases yesterday.) Bluetooth works as expected on all 4 of
those kernels. It has also worked on every kernel released by Linus and every stables series kernel in the last four
years. I usually start trying out a development kernel when rc3, 4 or 5 is released, depending on time available. If I
find any problems I report them and provide any diagnostics required and test patches.

Bluetooth is unreliable on my system when I boot 5.17-rc kernels. There is little doubt in my mind that something that
has changed in 5.17 is at the root of this. Whether it is actually a bug in userspace doesn't change the fact that there
is a regression because of one or more changes in the kernel. As I said yesterday, my understanding is that such
regressions are frowned upon.

I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.

In the meantime I've copied this email to regressions@lists.linux.dev, so they can track this.

Chris

> might be something with name resolving though, it appears gnome don't
> show devices if they don't have a proper name (that is not their
> address) so perhaps that gives the impression there is nothing going
> on when in fact that all normal, well apart from the fact that names
> takes way too long to be resolved.
> 
>>> I also booted into a 5.16.10 kernel and connecting bluetooth devices worked flawlessly. (This was with the unpatched
>>> bluez daemon)
>>>
>>> Chris
>>>> So the timer doesn't start until the request is sent. but obvoiusly
>>>> older versions of userspace don't have that fix so they end up
>>>> cancelling the loading of LTKs, this would explain why reloading the
>>>> daemon would make it work again.
> 
> 
> 
