Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662CC61D97
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjA0RCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjA0RCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 12:02:12 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BA1CACF
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 09:02:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3944726wmq.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEQT9k7sWf+g/ZpYayuVpltvbZFIeubyCWjxQvzBqW8=;
        b=EzmoTZgXbF7E9yTAP7uvBvmB8ZEvqSbhGe9ltsLMYaZKBiuwRpIYQY4vD5srlIoAX7
         FaYr1Uvr135FypDtf3bhtFzJIrqybabwI2k955Q1aOeLbUwcF1QdSAxhmU1ChlO7jwa1
         3YpqSbX1Uy1YQtR8qj60Qkyy5EJjZpU/QM1YZAzgT6anpbVyrHtENcmRJdTISowDKPNp
         maqdRlgRtDgcsR0BoeryfLkPUp394e76LTwIjztXtGDU5/2JB4FQdZTQdPbo7uEI4MxP
         JNhz/oujwuE1XbinNSi3aH+9VU8brP9uYNGi560tWjd4UGMeaxjhBLc+ZUc2wGmNSjNa
         nhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEQT9k7sWf+g/ZpYayuVpltvbZFIeubyCWjxQvzBqW8=;
        b=U2EcoywSOCgH8UfDHOGxk91ZY9BP+Li6unqu09gCGThmQMGEgGpjCxGY3jNmHo3+xY
         foTXqELiZ+LSMp5VZr1H6y/jnti1sGr/th1j8Hsl7VpPzPpF8YewivDDe8pl3+DebWee
         NDJkK6zOCxBhJSI0Ae7BOdRdrLlM+TDYgXRPY/Xy106zP7L7znrqx09rSQKvLlsTUYg7
         18ik6Q+zenzWghbwVmnJOrJeCqs3Rw0vZXwtTDaW2v3NdtXmwXlu+/cATgHK/Civd8O/
         ZYH0cUrH9Fxv6LOGJcTXGBaKw29Gj6ZXTT+oHwUPTl1/fkHypfGMfhz7jexNSw9tttNC
         Rx8w==
X-Gm-Message-State: AO0yUKXShEygJj60a9wnwUuqEVT8ElcFoXu5QuVKYbopnvJdjEQIgrWr
        +hOeck308EZ9x+0k5rqvNB8jPA==
X-Google-Smtp-Source: AK7set8MQMyC92Aaj2la+mEMNJNQNiSQvSJmb3p2RsoZ+EXzWKHTeAtwJC+6i/4+MMLGeQAeTr+OUw==
X-Received: by 2002:a05:600c:4688:b0:3dc:438a:c381 with SMTP id p8-20020a05600c468800b003dc438ac381mr432591wmo.28.1674838929278;
        Fri, 27 Jan 2023 09:02:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c4d9700b003cfa81e2eb4sm4856170wmp.38.2023.01.27.09.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 09:02:08 -0800 (PST)
Message-ID: <8cf45912-1fda-dd3e-4051-fa4930f8860d@linaro.org>
Date:   Fri, 27 Jan 2023 18:02:06 +0100
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
 <ed5fec12-1c86-d235-718f-f812e7461d94@linaro.org>
 <63d40318.050a0220.b303.8deb@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63d40318.050a0220.b303.8deb@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 27/01/2023 18:00, Chris Morgan wrote:
> On Fri, Jan 27, 2023 at 05:53:49PM +0100, Krzysztof Kozlowski wrote:
>> On 27/01/2023 17:46, Chris Morgan wrote:
>>> On Fri, Jan 27, 2023 at 11:24:03AM +0100, Krzysztof Kozlowski wrote:
>>>> On 26/01/2023 17:55, Chris Morgan wrote:
>>>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>>>
>>>>> Add compatible string for RTL8821CS for existing Realtek Bluetooth
>>>>> driver.
>>>>>
>>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>
>>>> Based on your driver it is compatible with rtl8822cs, so you can
>>>> indicate it in the binding and use just one of_device_id entry.
>>>
>>> It's very similar, and uses some of the same constants, but has a
>>> different firmware. I assumed the firmware difference is enough to
>>> require it to be differentiated, but I wasn't sure. You are saying
>>> it does not? I just want to be clear.
>>
>> If by "differentiated" you mean "incompatible", then depends:
>> 1. You have firmware-name property to indicate the firmware to load and
>> then you can use one compatible to bind and just load different firmware,
>> 2. If device variant is autodectable, it's compatible.
>>
>> realtek,rtl8723ds-bt also was added to the driver uselessly...
> 
> Gotcha.
> 
> They are incompatible, but the driver should be able to autodetect each
> device as best I can tell. In fact all of the devices listed in the
> bindings should be autodetectable by the driver (again, as best I can
> tell). Honestly though that's assuming I'm using the correct firmware,
> which is why I have this tagged as an RFC. I'm really hoping to get
> Realtek's attention for them to chime in to confirm I'm using the
> most recent firmware and under what license/terms the firmware can
> be redistributed so that the firmware may be added to linux-firmware.
> 
> Assuming everything is good though, I can resubmit V2 and instead of
> adding a new compatible just noting that the 8822CS and 8821CS use
> the same bindings.

They cannot use the same bindings. You always need specific compatible
and this was not discussed here. What's discussed is to drop the driver
change in of_device_id.

Best regards,
Krzysztof

