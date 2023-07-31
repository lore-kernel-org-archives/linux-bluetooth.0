Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E3C04A94
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 06:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGaGYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaGYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 02:24:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8CE41
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 23:24:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991da766865so656802666b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jul 2023 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690784689; x=1691389489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iG5nzJL1feUJDoTi2nTBJuwBhom6IrcGDILho7oXlgk=;
        b=OwilGwT2pK41wZhO3AdCcc8ZrqpSD7RIGn5XE/ap1aV6hOTa0uWKxmzK+32g++vgAV
         A3khWSJQCfXjyvubDATTBJMgTDRJOluzIXC8rR9SGgbta8jniwIOAK/SEtYgGxYo9gJi
         3EPoB7fniOArXVTLmGinDC+1e3/+PcO0LNcw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784689; x=1691389489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iG5nzJL1feUJDoTi2nTBJuwBhom6IrcGDILho7oXlgk=;
        b=iumyLpDPpy/O+TTavPHydpHFd5OtxOa/STIvcgGdUxsiLevSPnNO48CHtvbhg7nafC
         TYqVoSQ8STtFZtJmyhBFBpkBF+0lRAKh2s26LOx3pRtgRd6BZn/GxIMvyCSKVkL2//Yp
         ukkaxl90RYX4vxI9BW1lePKBk5lNocMeOevQayqWAizafNC0ZrLy96CYxgh04G56lsG9
         RFpZl72y3C3NZ7xl45Qh1mu1r8IvOnWizjSeWrlHuUAdEuCym46ujXaljXNZZQhnyJ/q
         lvLcjl0kqGekqHy0zSwL9KP2jgwnR1fJuJnY1FmSB5gLGQUC0dZYvT8rect7kMmb30kk
         1WCA==
X-Gm-Message-State: ABy/qLaiVWnYBXI+vb6iLj106Ybd8FeALPyunumt5NgIkudTTEt6l9Ut
        Qb4ZxikZOals9H+xc6GUgG2EUg==
X-Google-Smtp-Source: APBJJlFFnjHmC/RSjbOTWI0GOiJaMVl7YygsHdsLtuSBLYIMq84G9R5oqsnoFQMJ7u/KgRfT/tyhQA==
X-Received: by 2002:a17:906:1090:b0:99b:56f1:3002 with SMTP id u16-20020a170906109000b0099b56f13002mr6462535eju.61.1690784689011;
        Sun, 30 Jul 2023 23:24:49 -0700 (PDT)
Received: from ?IPV6:2a01:390:0:101:d239:aa38:9027:f188? ([2a01:390:0:101:d239:aa38:9027:f188])
        by smtp.gmail.com with ESMTPSA id cw25-20020a170906c79900b0098d2d219649sm5717568ejb.174.2023.07.30.23.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:48 -0700 (PDT)
Message-ID: <ec12c138-048e-8ca2-866a-7142667ef62c@streamunlimited.com>
Date:   Mon, 31 Jul 2023 08:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH BlueZ 1/2] adapter: Be able to use ConnectDevice for
 discovered devices
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org,
        Szymon Janc <szymon.janc@codecoup.pl>
References: <CABBYNZKtfk4O=1VLoh0nb_PtR8hzJsPg53P+_q3+kAUAO+cWxg@mail.gmail.com>
 <20230731041229.1429016-1-simon.mikuda@streamunlimited.com>
 <b91708a1-8dd5-f587-03f0-302ee9a85570@molgen.mpg.de>
Content-Language: en-US
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <b91708a1-8dd5-f587-03f0-302ee9a85570@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul.

Should I submit new patch with fixed commit message text?

For the testing part:

Precondition: have the linux BT adapter (DUT) ready and some remote 
device you want to connect to

Steps:

- make remote device discoverable
- scan for devices on DUT: bluetoothctl --> scan on
- wait until the remote device pops out on dbus interface
- connect to the remote device using Adapter1.ConnectDevice

To do this you can use these commands:

LE: gdbus call --system --dest org.bluez --object-path /org/bluez/hci0 
--method org.bluez.Adapter1.ConnectDevice "{'Address': 
<'00:00:00:00:00:00'>, 'AddressType': <'public'>}"
BR/EDR: gdbus call --system --dest org.bluez --object-path 
/org/bluez/hci0 --method org.bluez.Adapter1.ConnectDevice "{'Address': 
<'00:00:00:00:00:00'>}"

For example if remote device emits LE advertisements with general 
discoverable flag set and the flag "BR/EDR not supported" is NOT set 
calling reqeuset Device1.Connect would result connecting on BR/EDR 
transport bearer.

BR,

Simon

On 31. 7. 2023 7:43, Paul Menzel wrote:
> [Cc: +Szymon]
>
> Dear Simon,
>
>
> Thank you for your patch. In the commit summary, an alternative to “Be 
> able” could be “Allow”.
>
> Am 31.07.23 um 06:12 schrieb Simon Mikuda:
>> This can be useful when you want to specify trasport type for already
>
> tra*n*sport
>
>> paired device (e.g. use LE transport for dual mode device).
>
> Could you please elaborate a little more? Maybe even give an example, 
> how this can be tested?
>
>> ---
>>   src/adapter.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 2679d4302..17f4a637d 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -3763,9 +3763,6 @@ static DBusMessage 
>> *connect_device(DBusConnection *conn,
>>       if (!bacmp(&addr, BDADDR_ANY))
>>           return btd_error_invalid_args(msg);
>>   -    if (btd_adapter_find_device(adapter, &addr, addr_type))
>> -        return btd_error_already_exists(msg);
>> -
>>       device_connect(adapter, &addr, addr_type, msg);
>>       return NULL;
>>   }
