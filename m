Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC0C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 16:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjA0QyS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 11:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjA0QyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 11:54:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DF1C58D
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 08:53:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso5938088wmb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8NXvZFywEreGGrzUATLFsaVp7xdfqMWexBf+xqrl28=;
        b=YFU8IZY830Ogp1LD5LIhSVPbXF5kDrG1iKFfnHJIjMLX4YjWyGxMFy1X6oKvvIwws7
         vNWVBL2yO3SGfhsDo05z22V/2EAoHmkXzchKmXNHu/MzaiKLs+RifPTVnZhTA+jhsX/E
         ki/JDcprGD5sSef+j4mON/1LimBe51748XhwKK7BTLAKt7YPZ2bW+pXHCjtoF4ncKrJb
         Q9uRb1SNtHiO+3isniG9xhY1U9AjbycyScT25vGaLUa+wq8IsICX97TDcD9HPA9j8Tbh
         WD3vlIKfFIwhNARVyC+kpaJYfqTZRr272InenDcZzlt+zbAJFE7wEwCiZUf6XeKNw+q2
         2PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8NXvZFywEreGGrzUATLFsaVp7xdfqMWexBf+xqrl28=;
        b=2LqKHvM0I45R2TWt+rBvdvlyBXPyltsvpJK53P4L106cAvhqzEHW8pKYSxsmHfWbIb
         TuDhMM90uGQNaAn3N9Li9nU/zurM9AX5CVQj1M3Shr2eVsin0CrshIKoagvcdeqniUUK
         aEXeOO+b7NyiLmj4EHyLx09y5Kh+qkOIEkbAltXUAIe80sHGkKPBzJdlfA36K7yv9TZ2
         6gquUvrsgqLJBBytb0ak5NhTQESCV97mGVkiWeUabW0e8sMaX2TEKoO876RPqpxdCS55
         q2G618nPa1bJtmTsVwTtMXzCqFHqjxDhkW1xRQoP4w7DRHd/qs+TPkB3Gi3W6HLIxeC+
         YG8w==
X-Gm-Message-State: AFqh2koc88bXyFFV+Mh8XUOsInnQqHr20UTg96w8XspZ1bh6Nc0ARmwl
        4NK74oIa57ay9itwMVkVcBK1EQ==
X-Google-Smtp-Source: AMrXdXvp9Xv1POD0JhkQyysKnVNOpzSNYQlWTbGEJSWP6O2ep0ABvngbOO0TS+/Lf6eowDswTCWbhQ==
X-Received: by 2002:a7b:c5c5:0:b0:3db:114:a67f with SMTP id n5-20020a7bc5c5000000b003db0114a67fmr39489469wmk.17.1674838432044;
        Fri, 27 Jan 2023 08:53:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c08a900b003dc3d9fb09asm1559716wmp.47.2023.01.27.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:53:51 -0800 (PST)
Message-ID: <ed5fec12-1c86-d235-718f-f812e7461d94@linaro.org>
Date:   Fri, 27 Jan 2023 17:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC 1/2] dt-bindings: net: realtek-bluetooth: Add
 RTL8821CS
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
References: <20230126165529.1452252-1-macroalpha82@gmail.com>
 <20230126165529.1452252-2-macroalpha82@gmail.com>
 <02bddab6-4c63-bb39-9a11-8dab81322c28@linaro.org>
 <63d3fff7.050a0220.db92.7af4@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63d3fff7.050a0220.db92.7af4@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 27/01/2023 17:46, Chris Morgan wrote:
> On Fri, Jan 27, 2023 at 11:24:03AM +0100, Krzysztof Kozlowski wrote:
>> On 26/01/2023 17:55, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Add compatible string for RTL8821CS for existing Realtek Bluetooth
>>> driver.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>
>> Based on your driver it is compatible with rtl8822cs, so you can
>> indicate it in the binding and use just one of_device_id entry.
> 
> It's very similar, and uses some of the same constants, but has a
> different firmware. I assumed the firmware difference is enough to
> require it to be differentiated, but I wasn't sure. You are saying
> it does not? I just want to be clear.

If by "differentiated" you mean "incompatible", then depends:
1. You have firmware-name property to indicate the firmware to load and
then you can use one compatible to bind and just load different firmware,
2. If device variant is autodectable, it's compatible.

realtek,rtl8723ds-bt also was added to the driver uselessly...

Best regards,
Krzysztof

