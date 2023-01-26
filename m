Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbjAZKBs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbjAZKBr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 05:01:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3043931
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 02:01:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b7so1211621wrt.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsWprYGbD2CwVtouO/ULFCeYkL3Y+haM/y2Caqpemeg=;
        b=Os1KoXQjpreDSiLtuaFezS6DeTwNWR4AfM2jEUgbJZkNEVRksxLtyeQCNovtFebOEh
         wOSKcgPr2DbKeI3tKATnADvslZ1FLjK7d/IFOuvFXJ4A4ves+HMDN03qGrQFA1q/Enk5
         bolq0rD1HKwV+X7Kqo+O0A2cBP7grN+0VQVRwasbM0lweMmEYTe8A7tiEPlEfGr8u4ki
         EvrcIBmP1CjInD4ZOzIelz2N48YF7KacnZgrtozKsl7GEeYLwRw+1qQcEjUNFEfRTmID
         wEXosltCx70IOHfZO0dB6rm8qqQKgq8ULcZ91FmA06uV/aKjQe/Ql2F1Pf4CUvpn2fr5
         dHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsWprYGbD2CwVtouO/ULFCeYkL3Y+haM/y2Caqpemeg=;
        b=s/YneCaeXvX80VIorKL9ytz0UPfzlBuPswDlJlnIPy11mZ+MMKhqJvaz+7S9SFJLO5
         ilKqe7EcwspjUQv9f2TOvx93b+PJHRwiuzLiErIKuNOtpPpejddQQ92DpJmk/lwPwDl0
         UZTg7kKpa+Tw5+Fm0uz867nzl5y6JhFWbRMW3YMoqjmUcIDQiYocuMDx/Q3+gsIMbX9V
         noCfri5WL6hN3b2OgGi62Tj9LCkuw9+VuXJikkgFxU8V+qDq7IE4a9rLWCLM+WCnieLp
         A3VligbQIT9P8nxdYzs8M9LkRB3l4mUEBTAxkRptwGaaH0HmNfLoxaaf8h24Z1Q/0Ap0
         /QMA==
X-Gm-Message-State: AFqh2kpJipW34JGKhqwBq5RwQZHjtS4agRb/CKOEoTJW7eQhlrDy/vIa
        3JBwGfUaJrnlYkbEiHDeUCzWgg==
X-Google-Smtp-Source: AMrXdXvCvQt1/kQ6w8atcLGXtdqYVKC9LQPXMiFfg0gMdaHu78to3mc/9L7myuVJ8vBjW3N9ZXLifw==
X-Received: by 2002:a5d:4fc8:0:b0:256:ff7d:2347 with SMTP id h8-20020a5d4fc8000000b00256ff7d2347mr38309901wrw.13.1674727304037;
        Thu, 26 Jan 2023 02:01:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm960081wri.34.2023.01.26.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:01:43 -0800 (PST)
Message-ID: <60d87ac5-ddd6-706d-e13a-3431024bca88@linaro.org>
Date:   Thu, 26 Jan 2023 11:01:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN
 triggers
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Lee Jones <lee@kernel.org>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com>
 <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 25/01/2023 20:23, Luiz Augusto von Dentz wrote:
>>>> While at it, move the mmc pattern comment where it belongs, and restore
>>>> alphabetical sort order.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
>>
>> Why are you taking LED patches through the Bluetooth tree?
> 
> I assume there isn't a tree dedicated to dt-bindings/leds, not to

dt-bindings patches are supposed to go via subsystem (with drivers) or
as fallback via Rob's DT tree. The subsystem here is LED, so the patches
should be picked by Pavel and Lee, as maintainers of LED subsystem.

If the subsystem was Bluetooth, then the patch would be for you. I hope
that clarifies.

Best regards,
Krzysztof

