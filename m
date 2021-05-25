Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8735C47085
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997E2613F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhEYKjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhEYKjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:39:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B4C06138F
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:37:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so3133275wmk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1598XzCbHxwe+ol8C/YGmtRNfZd4t0vD9mkpVHXjuv8=;
        b=GKm+tz+uBY3DBk25cFsXVTA5jP89XJrLbe/w1sKqtrKhk+oCNqjxupCSPdGKPv6tLV
         V97FrBy+yuiDIucnCT4t1XG8wz3QrKG7MU2pF8dc+8Tnhfo8W3aQDZG3cabB8j6ifr/N
         7Alg+STkvPNtnQs9g0Lq/1TRv7lhMsGX7GT8Avs3e3y/9VTSIxRPIdFmDcO3X+jakHBT
         I7cPNtaxj6Oupy3CCfFhVahaL0rMc0OA0silwrdPPIovJmZ9sHL9QQt21qzxOrZ+aXtc
         kPhIIeFm0TAh34X5uEDWk5BDgcHh0FixJ1LV17WIxmjSgzlzPYx8EGAn5UGNyDBFm63X
         qgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1598XzCbHxwe+ol8C/YGmtRNfZd4t0vD9mkpVHXjuv8=;
        b=JgKXr9h4+hMeaMJm9NWz8bY/S9vcQwfyQsDYBlI/a750qrSaLjhdBB+ncuaT/i+6iJ
         G5G1jEaJVS3tkJYq7O3G+zHycNnCBuG9ZNprJR7+XtwPbiJjCDWDNbC07Avo789Fjaiq
         NNYfKbNEIwljrtnREsDn8wXHMS0vQ3e1qtXVtNsHrJMAS0yf/F6qEayQZdvsITo15SHF
         dUb6bFQg3NLJwkHV93pFEpkNzSm/EBAy49TTEjPVKQa/cL0OsWA3qgwq5NtJI+R9GV8W
         BcWTKhLsl2FAwICsGjQy881itF55jp1Nkn0TRjVk3iDOC0cy0ys7aHGqeqG+Hg/WjF80
         zDzA==
X-Gm-Message-State: AOAM533BePjRO182hda5KFz+A5esG2ybscUFcrDOTcTwdVlB7TzjdDnP
        NOFZmpXu1CQV5nkAVZ3nBRg=
X-Google-Smtp-Source: ABdhPJy57kgHj/qFbGcwB1FsvwaeWQjSH7DjHyLfwvfU9EhVZ4VvSM9xZlVFFYNKo6p6sh7nJcVqpA==
X-Received: by 2002:a1c:c309:: with SMTP id t9mr3185079wmf.161.1621939047072;
        Tue, 25 May 2021 03:37:27 -0700 (PDT)
Received: from [192.168.1.10] ([94.10.28.216])
        by smtp.googlemail.com with ESMTPSA id r11sm15895619wrp.46.2021.05.25.03.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 03:37:26 -0700 (PDT)
Subject: Re: BT Intel: Regression loading firmware in linux-5.13-rc3
To:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
Date:   Tue, 25 May 2021 11:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for your reply, Kiran.

Does the phrase "next release" mean linux-5.13-rc4 or the next release of linux-firmware?  I just want to know what to
look out for.

Thanks

Chris


On 25/05/2021 11:14, K, Kiran wrote:
> Hi Chris,
> 
> This is a known issue related to firmware and is expected to be fixed in next release.
> 
> Thanks,
> Kiran
> 
> 
>> -----Original Message-----
>> From: Chris Clayton <chris2553@googlemail.com>
>> Sent: Tuesday, May 25, 2021 3:28 PM
>> To: linux-bluetooth@vger.kernel.org; Von Dentz, Luiz
>> <luiz.von.dentz@intel.com>
>> Subject: BT Intel: Regression loading firmware in linux-5.13-rc3
>>
>> Hi,
>>
>> I've built and installed 5.13-rc3+ (freshly pulled from Linus' tree). On booting
>> it I find that none of my bluetooth devices can connect. In the output from
>> dmesg I find:
>>
>> [    8.170332] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
>> [    8.171339] bluetooth hci0: Direct firmware load for intel/ibt-19-16-0.sfi
>> failed with error -2
>> [    8.171871] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-16-
>> 0.sfi (-2)
>>
>> As you can see it is looking for a non-existent firmware file intel/ibt-19-16-
>> 0.sfi. intel/ibt-19-16-4.{ddc,sfi} do exist and both 5.12.6 and 5.10.39
>> successfully load those.
>>
>> If I create symbolic links from the ibt-19-16-4 files to ibt-19-16-0 equivalents,
>> rc3 loads them and my bluetooth devices work fine. I can't find any ibt-19-16-
>> 0 files in the lkinux-firmware tree on kernel.org (or anywhere else for that
>> matter).
>>
>> I looked at the changes introduced in 5.13 and found a couple of suspects -
>> d68903da4e220d1e6b7c6ecdb853c36144c6acc9
>> (Bluetooth: btintel: Consolidate intel_version parsing) and its parent commit
>> 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
>> (Bluetooth: btintel: Consolidate intel_version_tlv parsing). Both were
>> authored by Luiz Augusto von Dentz and make changes to code that
>> processes the firmware version data. I built a kernel with
>> 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
>> checked out and that loads the installed firmware fine.
>> d68903da4e220d1e6b7c6ecdb853c36144c6acc9, however, seems to be the
>> the change that breaks things because it tries (and obviously fails) to load ibt-
>> 19-16-0.sfi.
>>
>> I can provide any additional diagnostics or test a fix, but please copy me in to
>> any email because I'm not subscribed to the list.
>>
>> In the meantime, I'll use my symlinks workaround.
>>
>> Thanks,
>>
>> Chris
> 
