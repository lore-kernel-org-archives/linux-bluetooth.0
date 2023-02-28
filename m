Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D40C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 15:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjB1P0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjB1P0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 10:26:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714E31E3D
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 07:25:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so1054590wms.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIFCjFemZc/gnj7ICZYhdDftYGP5figYg0g5fTPNeTw=;
        b=LIVWIyTGzTBjBpwDGxSOtz2Y7+CLoKbkR1x2Gbj4+Ij0RxmXMzoyMMslo0RdfXodZ/
         3r8hass89maPnpLnUnd4LF5uMN5V6ka6UXghDmocE9Lc9olsNfMPX11R1ivIShCiAHj2
         TY3Gs+k+wiGK40DAvmYoD3KNDx9FA84ZYZBknICVEYctQjLR6UVSPXK0pPumRBY0r0xm
         IIiH7Mo4hmrbpcZDw21Jz6LA0dsLeA2dJ6yd5FaibLtOJSOzy2vdaPTvZf8vBRE12Co9
         UR5FvvoIFsZWT2NTXR4Dn5Xgdj3wWcw3O3JxEuL0V9GRIW3YIgQCQp4TFvrbseMG87jg
         iG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIFCjFemZc/gnj7ICZYhdDftYGP5figYg0g5fTPNeTw=;
        b=1JtVM3jEi/7K5r9npjLH69UiyHDtav/0S0Keqvxs1phh2gXonLIcYXG8N1ttxx/zr4
         w0g2Q6Ff1/ggIdqC6mgqhZ+M/ofCRV4S5oZBAGbFeaSzrm8UW6B+QdhrDTNHZJRpi3iZ
         lL+Nmulbx48rFR3IR9SAdNybVDLmXRajxR3akkGmqbInq5bOeS49lj9Go38o4CuMpDGY
         IhkGkyH/VElEIoOrr9RDYrs8A/zzukSadxZXOKfy39t/t6JW/fDldHqMQnBNUVPrJFpC
         tdhw88rST/oSgLHGWB7mxHzAceuS2i1Oldsa40lZOtRTVuwZHo2Ob59N0+o/CpknxFr9
         uIhQ==
X-Gm-Message-State: AO0yUKUHZ7guKEySOAOPBZwsrF3N7yHDtgWa/M/2yiha7te/8eoaspHk
        ERbctEifgLXXyRGHGemn5Nw1BA==
X-Google-Smtp-Source: AK7set/K4l+xYcE5378bcbvSHyaphz8hiqb+3QqaW38tDT0j7mqQBm0kpoUx1ZkQgB0shFS5bdO8Qw==
X-Received: by 2002:a05:600c:491d:b0:3e2:6ec:7fb7 with SMTP id f29-20020a05600c491d00b003e206ec7fb7mr2453066wmp.0.1677597924827;
        Tue, 28 Feb 2023 07:25:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c379300b003e2052bad94sm16134455wmr.33.2023.02.28.07.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:25:24 -0800 (PST)
Message-ID: <9f03c575-a11e-3125-cb07-e0434c517e25@linaro.org>
Date:   Tue, 28 Feb 2023 16:25:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3 V4] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20230228152205.133582-1-macroalpha82@gmail.com>
 <20230228152205.133582-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228152205.133582-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 28/02/2023 16:22, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

