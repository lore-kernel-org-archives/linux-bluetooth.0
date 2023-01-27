Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9271C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjA0KYJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjA0KYI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 05:24:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FB28D3F
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 02:24:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q10so4530191wrm.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1g62FaAwzxRCWTCMBiuBoyOeT/DGaVIfmpUN4XH4l8=;
        b=WBlhHJ+QydO7/c8H/iv+cPA7WBy/euWH0c8rSU9mF1lm2EpoVxBq+pVtfH+47E98M6
         +LgVVY709ef+XJl6G++miNZIJFhxCswEpPlWqHNOnrYCd/THbh2EqLDQMAEIB2rcAkt7
         sUyrebJsnBw5YmDFJzjhYF4op3LYqIvJdPfISDfh/G4H/jmVQqbWxhBbcvK8PlgoX3O9
         7oQqATG5Y4noaKCX6g8Jd1lCqjY7c2/I5Hog7Of5ye+dSSyvMmOlPUHcNoI3yn/eWrgA
         kdGSqnAW1ZFawjT75+5dC1O/2bE17OJTDg45ix6c2eLnZ2r7nbMtK1/qbeaVhqENNKjy
         iLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1g62FaAwzxRCWTCMBiuBoyOeT/DGaVIfmpUN4XH4l8=;
        b=EOmaCm1oKPLpOjUdawQzH0IS1g/9Pq7cwuo6LFKTzDMuOIKC1WDpbZt/EUmc8fgMZi
         khMr/mom+uZeFQwdZwJn5MoEVrBKzoWyLP/1Fhk3KX80zfA3ypqXVP2SUKXCnD6F2GH2
         F5sFFgFnB2c0o6GB7zxSiTFkeqQVOxJynREJwFekeE9Ajgxu9iP1bZ5BW4kLGaEyEjBU
         O1XIKFnkCwc/VNu/zjmAjTeYVwMdGJYP67jbnjL4k+ipONhWTZ0PnWcAM5ol7M0Lna9Q
         iC86OdI+2/pGqXK/J15mJCQm4uPkcqppn46dEzcI5m/uT0d6c5ukVPRLh7FJwhzVEzg/
         ib2Q==
X-Gm-Message-State: AFqh2krrvhN+kJHAy0MmpCvCfnVyXcqtFjcDvQq1x1CdYKYBKnstYt3v
        wk82esALVle7BVoY1w9R5+BI8Q==
X-Google-Smtp-Source: AMrXdXte3GUMCRyW8iKhTS2WKAAQM1NZf4WbfuSy6VgAENXlAWYiUaqyjwMtBrRnpXlHV1p9vrcnBA==
X-Received: by 2002:a05:6000:5c2:b0:2bb:eb3d:8d20 with SMTP id bh2-20020a05600005c200b002bbeb3d8d20mr32682504wrb.43.1674815045619;
        Fri, 27 Jan 2023 02:24:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002be505ab59asm3704070wra.97.2023.01.27.02.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:24:05 -0800 (PST)
Message-ID: <02bddab6-4c63-bb39-9a11-8dab81322c28@linaro.org>
Date:   Fri, 27 Jan 2023 11:24:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH RFC 1/2] dt-bindings: net: realtek-bluetooth: Add
 RTL8821CS
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     devicetree@vger.kernel.org, alistair@alistair23.me,
        anarsoul@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
References: <20230126165529.1452252-1-macroalpha82@gmail.com>
 <20230126165529.1452252-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126165529.1452252-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 26/01/2023 17:55, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Based on your driver it is compatible with rtl8822cs, so you can
indicate it in the binding and use just one of_device_id entry.

Best regards,
Krzysztof

