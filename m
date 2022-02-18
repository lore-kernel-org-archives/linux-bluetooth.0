Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F6CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiBRWbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 17:31:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiBRWbj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 17:31:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F04285AAA
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 14:31:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d23so7933037lfv.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g3Gp/hA6E7gmxuh/z6Iu+HJ3kNLDqQqelmJ4xuo3QUQ=;
        b=hYUUYbk4tnYYKJQWNhDgntM3XFvPAUi7uNeCO+zSmS5XrR9pXjDIpnL5QOl2DrkxTf
         phVbfTb1MHC7T3Z0g/Xw1MzmVnXIe5MdVDElvrJ7UCdmFaP5g5j9En0lxVNgEcynUY5e
         gHsrRmbbCKBe5iGHZNK5K0robEAnjfvJ2W1J6pN0elTAYjGqE+Ngn8KdzqifI7kiGK8Z
         qEtKmThBGxv0H35UlwBwBLn5zFOZkWKRpVlaY03y4nOlbjjpzgwxDMldwtAuL8frtPYU
         VVkzTHOqVTLnq8PYeavFRv+G6TFMpzOV61ACi7qeV90l+4kOvlTEX7jxM/PR6WlbCub1
         A0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g3Gp/hA6E7gmxuh/z6Iu+HJ3kNLDqQqelmJ4xuo3QUQ=;
        b=VnFnkGaaE+5Ktdz3yoxVewqBiGhhRoGT07y6Qr/LVDYG9tsm/v3qdxA2cZQpyKenPl
         n1OlZ36QNT84wm1jyNGITCSBXzfWD+bwuQErgtdQJysJlFOEFHYXOA1Cume3TZuJucv/
         mMb2xu0IclwpgQih1pwJ7ZnvZ9gYQMRir3heM22ccWZ23OScxnDfebrgDLMvleYWvo0X
         c68oEqkAd7G8LtaPEN8QEMRJU7FYVlX5rf8ZRmETJrHg6s8RhK2Ju7Qzwyz4ogWdl/wM
         5XMQ8wmOHnb08oF8YOoDOfzbEjhz0G8Zsf2NsocaCwenM+ZjuB/sFD2sPnj1Sx4gSNw0
         Qh1A==
X-Gm-Message-State: AOAM533Vol5rqBggPxQ57tTLRC4I2vNFlRUSNgXIZe3G2VwOxDv4wrEC
        BcudhlN4GCwl9iDsjVRWygian6siCS0=
X-Google-Smtp-Source: ABdhPJxIC38vuqqE7YVxsG9jJBaHb2BCsDTalS/eigFCUb5KWv5jFdPyF1jP7l7CixzHzL25yIr1sA==
X-Received: by 2002:a05:6512:1044:b0:443:95c7:fd1c with SMTP id c4-20020a056512104400b0044395c7fd1cmr6940798lfb.285.1645223478770;
        Fri, 18 Feb 2022 14:31:18 -0800 (PST)
Received: from ?IPv6:2a02:2168:8737:3600:54d1:3e17:47b1:979d? ([2a02:2168:8737:3600:54d1:3e17:47b1:979d])
        by smtp.gmail.com with ESMTPSA id d5sm384910lfs.307.2022.02.18.14.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 14:31:18 -0800 (PST)
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
 <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
 <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
 <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
 <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com>
 <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
 <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
 <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
From:   Andrey Butirsky <butirsky@gmail.com>
Message-ID: <1d65ec6e-7494-c148-8b4a-b2dc463fb141@gmail.com>
Date:   Sat, 19 Feb 2022 01:31:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2/19/2022 12:38 AM, Luiz Augusto von Dentz wrote:
> Hi Andrey,
>
> On Fri, Feb 18, 2022 at 1:26 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>> Hi Luiz,
>>
>> On 2/19/2022 12:15 AM, Luiz Augusto von Dentz wrote:
>>> Hi Andrey,
>>>
>>> On Fri, Feb 18, 2022 at 3:55 AM Andrey Butirsky <butirsky@gmail.com> wrote:
>>>> Important addition: the mouse does work on Android 8.10.
>>>>
>>>> Does it mean Android has that special HID driver that missed on Linux?
>>>> 8.10 came out long before the mouse even existed..
>>>>
>>>> Do you have explanation?
>>> No, in fact android seems to also be using UHID, does it uses a vendor
>>> app to set it up?
>> No, it just works right away after connecting from Settings.
>>
>> Also, the mouse works on Windows, without additional software. It's
>> detected as "Bluetooth Low Energy GATT compliant HID device" there.
> Did you manage to test with latest git? Note that windows does seem to
> handle composite HoG device:
>
> https://github.com/bluez/bluez/issues/258
Thanks, updated the issue with info. My device is probably composite 
indeed, as these ones:

https://github.com/kyokenn/rogdrv#rogdrv

I tried BlueZ master but userspace only.


> Btw, it could be due to:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=aa699cb762a02ec7409940ddcfe65b788de8270d
>
> There were some systems (afaik 32bits) with a problem with the header
> copy we had.
My system is 64-bit. Do you think it's still worth to try to update 
BlueZ kernel part? If so, what is the procedure?
Didn't find how to build BlueZ out-of-tree kernel modules or something..
