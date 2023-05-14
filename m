Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4DC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 May 2023 09:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjENJzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 May 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjENJzs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 May 2023 05:55:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BC120
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 02:55:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-969f90d71d4so1034584466b.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684058144; x=1686650144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmnCd9zBSpzSRwFsU5TtJIOG/MCBXv4toD2D925k+2k=;
        b=AWNmy5FBccEuQgwM1II/lH3TjYuI1CWhObctyu4ktSINIKc1QgcniKjKgFNcNakdKm
         ZE+dHukU5YKKrCfW0AHAmhCxQwHu9NsH+M9YfTgrmdkwblST1Y2w8hXWM2CaMr4W9RHr
         d7o09e3odUGHjZ5EJDXocOHtyXS0gO9d0PnZM17ZU1xvffirHLPmBvvP8EZgCnRJ5lZh
         eVMlW+d/Qqdjr/G+MKZjx745hKuSKVgPyRF7ogv5HWhEl6SqK0Jr7FbPz6d1/IvotPOV
         Jm8WSxsLIS6jJdgINxct2xfQshwY5jy6Ljxfy/fZSNSMfg/Iq/GdOy1uhyDvk1YZbJGk
         koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684058144; x=1686650144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmnCd9zBSpzSRwFsU5TtJIOG/MCBXv4toD2D925k+2k=;
        b=Vl/h72wj+ZNzvUr38ts1iDJJg72ziHOvfIIA9RtlAQx80CtO/b0R5YcGhAzKShao49
         NpksM9gZqng+s01x2t+zyBBbNaRAT0GKy9Y9LDe2roYmFnWEBfRcz+ebHfR3tipfqHJ0
         zB7zIGuHz95+6YZHfwQV/DIYZKy4ht1dfSttO6Lu440PTkUrAwpjV5WxQQUljf4SLeXi
         g+dmlS0uWUqMwAemd6/vYuLxc4aajp0qYEuZfK2h8EZQRh8nTyTDuxjafLWMNLdrtbkI
         QdlaUhSTlpZzDUz8uvKca40eO3O17ujhJWNyJ66LW4qoOCfl2ulci8nwTswqe7sc7gUw
         UoZA==
X-Gm-Message-State: AC+VfDxjT3MSjAMVdpzWbldWXjGx6rhtBn9lSWKksBmuX1v/jSuPNxzr
        qVemW+BgI0owBiHut1EO59i0dQ==
X-Google-Smtp-Source: ACHHUZ7hRkuoxb1+sQp7/C83yF5sWrBdHlBQlIGqSszE7wlv1cUtZW6L2gB9QqiiPEPzG8C+ePthow==
X-Received: by 2002:a17:907:9810:b0:96a:861:a2ac with SMTP id ji16-20020a170907981000b0096a0861a2acmr16240193ejc.0.1684058144158;
        Sun, 14 May 2023 02:55:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:715f:ddce:f2ba:123b? ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7cb89000000b005021d210899sm5667044edt.23.2023.05.14.02.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 02:55:43 -0700 (PDT)
Message-ID: <51dbd824-7d90-8a69-902b-d643347abdf3@linaro.org>
Date:   Sun, 14 May 2023 11:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: tanix-tx6: Add compatible
 bluetooth
Content-Language: en-US
To:     Rudi Heitbaum <rudi@heitbaum.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org
References: <20230514074731.70614-1-rudi@heitbaum.com>
 <20230514074731.70614-4-rudi@heitbaum.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514074731.70614-4-rudi@heitbaum.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 14/05/2023 09:47, Rudi Heitbaum wrote:
> Tanix TX6 comes either with RTL8822BS or RTL8822CS wifi+bt combo module.
> Add compatible for RTL8822BS as it uses different firmware.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index 9a38ff9b3fc7..9460ccbc247d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -21,7 +21,7 @@ &uart1 {
>  	status = "okay";
>  
>  	bluetooth {
> -		compatible = "realtek,rtl8822cs-bt";
> +		compatible = "realtek,rtl8822bs-bt", "realtek,rtl8822cs-bt";

This neither matches bindings nor your commit msg. If device has
different chips, then you should not stuff all of compatibles together.
Please analyze the case. Maybe you need different boards for different
revisions?

Best regards,
Krzysztof

