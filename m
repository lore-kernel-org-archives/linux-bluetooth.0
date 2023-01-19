Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B16C004D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 11:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjASLqJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 06:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjASLpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 06:45:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AD51DB94
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 03:45:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1045791wmq.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EegNtTy/sMvWBoyNWhH9yCq0I9Ve3LXWODIPFxTqqBU=;
        b=zclGPs8dfnB2v94HoRUfyCsXQnZE9vaqOARUnsItTYOj/BZ8EW/trKTeUrvR1DCYHJ
         VzmyzZLQ+trGjlmZLVL2ooBYGvFTtps/DYb3Lq56srB+EZSPMcJLaHxAaJUbdhWoZDV5
         aUvgzz5HEgMRxhNr45BF1iWmY5aIc3P5ibh5lKoO6QxPq02ERq4LCnCXJrRCi3AU515f
         8Y9GQQOeBLdV4o0v/9lKzDfBA8klXxifAqJKn+rMdzgq3tkqFVVsOe67qfmPjNtupZog
         i/s6VzEGYu+m/EQYJp8jmxQdgVCm3L2ubdG8NIWjrMv0kgoFUCHHHvBIi3peraRAJbK6
         CovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EegNtTy/sMvWBoyNWhH9yCq0I9Ve3LXWODIPFxTqqBU=;
        b=oYneXrrodUocYTBlg7Y4tOJ1/yGgvVKQpy4ponaB4PQSrgLh3DyLjxt/L8www1nUVw
         D7Ygw63HOU/VleZIsJVsSZRXNqHDP81LmOsQrePSu71MpfYTCWiPIjSaSiLwGWu8jltp
         PsScr9sc6JpnPyyt5Q71Yf0dlg5NinxAXBYjZJmU9P+3X6E39nc4qdWhccmbh9hk/jz1
         paQNvmAUe6xG53FsbVSzrf8+ymmLopTPELJ/+b/Gcf2/8TXIqn0+NEYvLy+wcrjokZgk
         VLwzcEHoaR/2a/exivQ1jzhcRMWVN+mxsO7C8Lz6DYhJyUNUxGMxwk2xXtETcNDzcW/L
         w/Kg==
X-Gm-Message-State: AFqh2kppwxu4QTpxn85wZLJHXxNzqkmJcGmluOkxOJfaihlYk82GTdJB
        49te0lC8cDKcHjyEBIT/frHcvg==
X-Google-Smtp-Source: AMrXdXvvILwOluVAOsH2m1VZJBTVlAxx87YaERZAYpsns382Rz32yl41uxvU8muTuIj0ImWPTBVf/Q==
X-Received: by 2002:a05:600c:1ca0:b0:3db:1ded:1769 with SMTP id k32-20020a05600c1ca000b003db1ded1769mr2214997wms.10.1674128749227;
        Thu, 19 Jan 2023 03:45:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r6-20020a1c2b06000000b003a6125562e1sm4489912wmr.46.2023.01.19.03.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:45:48 -0800 (PST)
Message-ID: <77e5fbd2-636c-70a9-f4bf-3df631413a6d@linaro.org>
Date:   Thu, 19 Jan 2023 12:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 2/4] dt-bindings: bluetooth: marvell: add max-speed
 property
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20230118122817.42466-1-francesco@dolcini.it>
 <20230118122817.42466-3-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118122817.42466-3-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 18/01/2023 13:28, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The 88W8997 bluetooth module supports setting the max-speed property.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../bindings/net/marvell-bluetooth.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml b/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
> index 83b64ed730f5..2fccea30c58d 100644
> --- a/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
> @@ -19,9 +19,25 @@ properties:
>        - mrvl,88w8897
>        - mrvl,88w8997
>  
> +  max-speed:
> +    description: see Documentation/devicetree/bindings/serial/serial.yaml
> +
>  required:
>    - compatible
>  
> +allOf:
> +  - if:
> +    properties:

Wrong indentation, missing two spaces.

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

