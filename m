Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jun 2022 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiFTP5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbiFTP5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jun 2022 11:57:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640411DA6B
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 08:57:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z11so9577832edp.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BLJok6X/XP9rRP7OVZBxo2FoWIuF2yxnMwl8P3cexO4=;
        b=Xt7y5Qe7+Wa7yYibcVvdOfwMtbLwRTN0Zq/M6R55v21ht1WGi/IPChYQ+SvJSe5Brc
         B6UA+MJObyH2Fm+8VXqwNRvg1mfurkHWqw8Xbq8NPqQmqVIqnya1L4ZahflvmPBtyeXD
         VR938s9+lVuSDM/XmiZewPLFp4twSGcwligcvSmIjjVgtuPVp18bhkKjkYllVesSTaZs
         Jp3PInwjuiJ6YQT3OjVPWlrCjvSeG8i4XyiMH2ryEGFTehrTgAEF1eroWKXB3auLr8r4
         rBXbBgtscJ94JK8zvmoHlBJtsNtdaiYDWxMtwmVzVyGytdzcjzV4nZS7ol/DknUXGzjx
         5TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BLJok6X/XP9rRP7OVZBxo2FoWIuF2yxnMwl8P3cexO4=;
        b=yjlDc/RSWzKeDlL4K0QGvOpSX+a5lGgClIVZxaztoLh5H2wZXUVxC8Ow+pAnkDjiin
         T813M9b/3qfljuKRb0u8kqmL5NsmdCBRQ4TnoowyrRboT6Psu8us/PN9LoG/nRivXPRi
         1RwNsGgyect0SxhKQmwo8uXOW5wnD6LdDaXnILLmDM+UuEhOzaAZhXPrIRT3wCyV+x/l
         yyAzOMmnCrcUMIeHbfhmXs01L8tox3KU34vUyABpJ1gt9MuGTJS+1c4TOYCIZgGM/Bfg
         sRNnGHTj+meSmMzgwtXPjvMMG4S6JYg3M89UfVGsHGTiV89vEmtppP/rjMGDrwVNhXf0
         jT7A==
X-Gm-Message-State: AJIora8uCxy2DyHHqDF86l72IFqg7kJiPwP8pmpMWqk8Vgvq9zTJeVjE
        SNEaV+QKlfA+FcSPrH4vcR8VFDgIXbem2A==
X-Google-Smtp-Source: AGRyM1vB4w9kMQvsDMIwngcwm/lZJao/j8ndNodHf3Z/j1CnWv4Tx74ZUtC1ToZcNlh2DUsmeckxOQ==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr30285866edx.101.1655740622007;
        Mon, 20 Jun 2022 08:57:02 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e1-20020a056402148100b004357171dcccsm5866342edv.12.2022.06.20.08.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:57:01 -0700 (PDT)
Message-ID: <bc3268e1-2a6e-8faf-3d3b-a8841569a42f@linaro.org>
Date:   Mon, 20 Jun 2022 17:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: net: broadcom-bluetooth: Add CYW55572 DT
 binding
Content-Language: en-US
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <cover.1655723462.git.hakan.jansson@infineon.com>
 <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 20/06/2022 14:01, Hakan Jansson wrote:
> CYW55572 is a Wi-Fi + Bluetooth combo device from Infineon.
> Extend the binding with its DT compatible.
> 
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
