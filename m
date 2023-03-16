Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FBBC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCPHzh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCPHzZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 03:55:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55EABAEF
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:55:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so3975733edb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBhQ9rbTJ90fnrse5eGonj91bUT1fcKYtnYFhIyOD4E=;
        b=Eg5h9g1gL9TTyY6moa624kELhzJupXcGiFZPRq1WsNLd0vS+0NqVOES/AXp2gMaRxP
         W3AqYr3wvv5X6LGBpHjbd7k57Wv6zBTXC5aqmApnv8HnlDLo9sS8D8WwZy5jx8Jb5Ue4
         iOeff0HU0VRzGCmPEBRFh9b0ZzxkvgvsdNJ+1x1+cM6MJYVeSFOAQeGZB7TVIxblh/jj
         5x1urNVFRpCxYxWkxmFYZYiodWR2fX7R87WyzA9SmQVgxVUkl+F1pjSQvIqKGNguFdRt
         cUYbIX4zAlucQ1htkLN6uSrgZ9ArIX+HuhKnwPrrjQqlu6apEewrGC4xYYE+wfOYV3KS
         R24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBhQ9rbTJ90fnrse5eGonj91bUT1fcKYtnYFhIyOD4E=;
        b=W1N/arangbzWEwiLcxkyJNQ85Yc0YwaTH5p+7bf/QzzbzsNdrSBPID8BIfss8GDY7Z
         IZX1W72bq9dULoQZRhpfuBEhvDTPTa5/bWkHAOzJiZkpsEEZf3MV6libqoU+iwNN7ZCO
         5pruAwx44S2rT1mfep1hGdeN1eOyblgaJXWL5XUer3LwuDqKNzCUyFWbvSqYdc8kPs3k
         2WNuh3Eb9Kb4E7+uLXodBtDdWhAZWd9j0rR35RBdZaoMB2dAv0eRjNhv2UFFsaQmGPet
         eV5a2y+ZZVIreuY3u3nEt2FNO2mApWE/plSX9R3iikk5E3ElFyIuHR2CmqbrWsJLtJwz
         CxOA==
X-Gm-Message-State: AO0yUKXoSIAK4IVpoMdHayocsN+KFPsgV4hsBsofwjElRgkOs/ATZloa
        Z5rGvqqf6gcTZkufO5aDBt4RrA==
X-Google-Smtp-Source: AK7set96dXWDVRar7/OG6wyOuQI1Iq7y3W+ECLittAY+3CNxxIdu0gFkxYLJsSc5KUMv/wh0zO9wGw==
X-Received: by 2002:a17:906:2603:b0:8b2:8876:6a3c with SMTP id h3-20020a170906260300b008b288766a3cmr10483022ejc.29.1678953314989;
        Thu, 16 Mar 2023 00:55:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906474600b00915d58e56f0sm3517152ejs.77.2023.03.16.00.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:55:14 -0700 (PDT)
Message-ID: <66c41be5-eeeb-9b3c-9bf1-414e03118578@linaro.org>
Date:   Thu, 16 Mar 2023 08:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3 V5] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20230315173657.28692-1-macroalpha82@gmail.com>
 <20230315173657.28692-2-macroalpha82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315173657.28692-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 15/03/2023 18:36, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for RTL8821CS for existing Realtek Bluetooth
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/net/realtek-bluetooth.yaml       | 24 ++++++++++++-------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

