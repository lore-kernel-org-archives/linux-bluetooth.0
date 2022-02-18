Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C13C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiBRV1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:27:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiBRV1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:27:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD52244656
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:26:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g39so7723465lfv.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EBUvh9r2Jlyl++tqRWYabdX3ldvBl9/9ae1PDDe/fDM=;
        b=PK3/jWIv93KN5bFxh5ugmS7p6+y1/czL5nT7jlTo4RqEwe4toaUSlwfXn0qkyxj1T7
         GgvX7F6Na4pyXwfMrezvdrkZXKv/norw9a6FD9qs1tX3ZiwhLoVR/vU6RvXpQt0Fel+Z
         Q/9YXr4FNq85nliOn+B2rgpbLjfracNnJDlNtZWeuUB0bhbkEBWMZleB0LtiLeEP6FbP
         TrAAz944G672OsuHmkVLvFl8PQ8Lq9oqVSVizquvI1Al6tWe2GdBYsr/lg6R5TLJ42WC
         lo6VFZTp1SOpJ/cafRhzqM7fJjog9gZ6olUdm/gPo7fWcA5sBxva6Luds1jqqaorZzlB
         OZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EBUvh9r2Jlyl++tqRWYabdX3ldvBl9/9ae1PDDe/fDM=;
        b=FrO1HC04oTa00rN0PjVIb9L5PAszxmJjbf3RELV/vyTfbsw8v5okKsZL2ve8Novsrl
         u5pmm5I12F8o5GJ51Rr4PbkPecZ10ShPlBmREHjZUOPzJbb8ZhTCC2RxfN7YYIBJX6/q
         aS5yiFHDT2kf8BQg5uDShqdHLeh6AIutVsfjlXXujMrA1DAMA+VC1rtEhSFFQcRlZ3PQ
         OA8eHv92IHAVyVghioPckOIwFJhg9W2WYA+5cV2zvPNDxrKJgGgMMtG/1bwmgv9cRDNF
         ebbXIhAw6G+UViOqlXltpwKuEZzihvDc2jRkXKkp3Q7BpzLH1xMWp6IIcd79CUkzwmTU
         wKCA==
X-Gm-Message-State: AOAM532O8hiwR1I36+2o916E7lFqNcggjkHX8gPeRYFlixzTFOi0F2jJ
        J7WvbUlel643PzpVdUMqJ4KuzXvUxzs=
X-Google-Smtp-Source: ABdhPJzA4wH9zkzs07+O8+iAnnDht5y/UXDXzld29gTl9j2XK0T5zhvzkRwbKIq6FYoLH5dv+dFM2Q==
X-Received: by 2002:a05:6512:36d0:b0:442:4cb2:df5 with SMTP id e16-20020a05651236d000b004424cb20df5mr6508938lfs.648.1645219597848;
        Fri, 18 Feb 2022 13:26:37 -0800 (PST)
Received: from ?IPv6:2a02:2168:8737:3600:54d1:3e17:47b1:979d? ([2a02:2168:8737:3600:54d1:3e17:47b1:979d])
        by smtp.gmail.com with ESMTPSA id c1sm378403lfc.49.2022.02.18.13.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 13:26:37 -0800 (PST)
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
From:   Andrey Butirsky <butirsky@gmail.com>
Message-ID: <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
Date:   Sat, 19 Feb 2022 00:26:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2/19/2022 12:15 AM, Luiz Augusto von Dentz wrote:
> Hi Andrey,
>
> On Fri, Feb 18, 2022 at 3:55 AM Andrey Butirsky <butirsky@gmail.com> wrote:
>>
>> Important addition: the mouse does work on Android 8.10.
>>
>> Does it mean Android has that special HID driver that missed on Linux?
>> 8.10 came out long before the mouse even existed..
>>
>> Do you have explanation?
> No, in fact android seems to also be using UHID, does it uses a vendor
> app to set it up?

No, it just works right away after connecting from Settings.

Also, the mouse works on Windows, without additional software. It's 
detected as "Bluetooth Low Energy GATT compliant HID device" there.

