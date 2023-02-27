Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A6C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB0Qjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB0Qjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 11:39:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F56901A
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 08:39:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so4213652wmi.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crbERNB/KRiPX3Ns+MACGOaRXuvcwQ4dJP1SUBpCJ8g=;
        b=Gdw1WjhW8fLA8jwW+s+geHgS3eG/p54KN9TXeayWH39nZnfmEv52LDFWQV2UBRD57L
         I6H+KGeaboGegcC363z2APwz2ABZuqCQ7ksqMdNcciFAQ5Fxik6FVfgCQytgljyejMAJ
         /R9av1khB9IWzoQMmBD+IF9MYWZWrQEvVEFLcE5dd/LNNEJGIOstujWzpT8gxWkYkVHD
         BzoUvkxWKR3w2N0J/FE+9p9NpZ0Ho0h5eaCm/LRXD9We7FYL5nfkHkA8kOKVM6zuE156
         AbZOtSR+Zm8FIZPdyTQrqU7U3ZdCg+9cHIICwLjzGp47OGEtuiUqTPFDHmxBBWdyDUn5
         T1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crbERNB/KRiPX3Ns+MACGOaRXuvcwQ4dJP1SUBpCJ8g=;
        b=vU4ftxkcdyvp4kSPEUOugUA5Y7Cvav3+yQs6jctAxWavtYCdahrVx7RGQE/Crlllv9
         nwD+atmfNd+fL0R9xVCvtJzkoLp+UTzkwVhq043wfRCijvvj7A8LGV6he5tQPVXwqNC+
         A7rS60Q+TGGjivcaSgJS59vAGkaFLeeBx2jBlucQHVdAdwH7XTQ57KGYiC94iV35Tlux
         6a5sDlSMh5o0Nk5hQb++eG8a4KUWrgOZiQeRds70Spzmpje44xdzUcdVMaQgYWWEOlPR
         Ixn0zM75EV2XarhqEVAm1X58GXyNY9HUZtPByYmMVfjw5W+auO4nh1zHzLsUIxSHBK7E
         BHXQ==
X-Gm-Message-State: AO0yUKWx5ADzG+G7idYiYnqJu9miiyFsO7XZB5uWvvWILbciSqvivufp
        VeX1m+NFX9QA6rmVDMZm04YxZA==
X-Google-Smtp-Source: AK7set8klad7bCsER3tYb5FwPiD6RW3fkao5lu6U9BHq6wZUQtRDDX+xscy8gxmRafyasXusCVWgcA==
X-Received: by 2002:a05:600c:3586:b0:3df:9858:c039 with SMTP id p6-20020a05600c358600b003df9858c039mr6870854wmq.14.1677515977564;
        Mon, 27 Feb 2023 08:39:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003dd1bd66e0dsm9630740wml.3.2023.02.27.08.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:39:37 -0800 (PST)
Message-ID: <a90451df-0191-a2fb-060d-66ce5afb55d2@linaro.org>
Date:   Mon, 27 Feb 2023 17:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3 V3] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20230227163027.130292-1-macroalpha82@gmail.com>
 <20230227163027.130292-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227163027.130292-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 27/02/2023 17:30, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/net/realtek-bluetooth.yaml       | 25 ++++++++++++-------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> index 143b5667abad..198c5dd1f257 100644
> --- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> @@ -4,24 +4,31 @@
>  $id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: RTL8723BS/RTL8723CS/RTL8822CS Bluetooth
> +title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
>  
>  maintainers:
>    - Vasily Khoruzhick <anarsoul@gmail.com>
>    - Alistair Francis <alistair@alistair23.me>
>  
>  description:
> -  RTL8723CS/RTL8723CS/RTL8822CS is WiFi + BT chip. WiFi part is connected over
> -  SDIO, while BT is connected over serial. It speaks H5 protocol with few
> -  extra commands to upload firmware and change module speed.
> +  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
> +  is connected over SDIO, while BT is connected over serial. It speaks
> +  H5 protocol with few extra commands to upload firmware and change
> +  module speed.
>  
>  properties:
>    compatible:
> -    enum:
> -      - realtek,rtl8723bs-bt
> -      - realtek,rtl8723cs-bt
> -      - realtek,rtl8723ds-bt
> -      - realtek,rtl8822cs-bt
> +    oneOf:
> +      - items:

Now you added items which were never here... You have only one item, so
no need for items.
Best regards,
Krzysztof

