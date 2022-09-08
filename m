Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B5FC6FA8A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHLQg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Sep 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIHLQd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Sep 2022 07:16:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A9C59F5
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Sep 2022 04:16:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y29so6873220ljq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Sep 2022 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WOxGa6HDdZTkz+qaFAMzvcgUAVFd9V45w/3KQDKwpCI=;
        b=QgYMkiugBcSQvEwKtmTDnsQFAgT1NHRFpcgN00InVwjf0e/82PfGO/50/cgJJNG+UE
         IDviNRSwAUJcjGNR848LdzZUgBzup5swhYKMCMMCulJwOo/fYt4s9SwobZGHP00rTU3G
         umbLymyj2oL6g1n4BHPInwe8bmP5sevNDdGM/1ivTzPSWxkbGmoMhVSB4j4FYQ4rM40M
         tlRjvhjm2EVqZiUHkC3QvZXzVqYJzDqpufO5x2fAYdrB6fVZJwGuGrqLTsU1rEHgPlrX
         nchASRVod92uw74+Ep/B4Tn7dU0WDJgcPXJnLL/gLQgOC8FQO2GEbXfvc+vC46IiHFQ7
         mDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WOxGa6HDdZTkz+qaFAMzvcgUAVFd9V45w/3KQDKwpCI=;
        b=ARf7AGjzFiXwiOKsmfL9qv5xA9mO9/E92x1cyLzoCtjCpDHcuhsNy7UDx+lmEyvpU5
         4fYiFhgix4YA2jabBq3vUowPEL7z2TcdNf/bdU+fNMmcl6XEkcKl5Qxj7UkyyEoIX7CP
         p/xchb2UuT1bLINQneCGWwabYrde47MzFTaLD8NEg48XtgSZzJMDrx1aECnQEr/3KOYs
         MIPR9uFAHkvSgtfLFyQanHoSr0WKGs6UMBbtHZCrIo8Pe7BBdCCTVgw/Dy3zjHnNEnVm
         /+NiFKRUB7Pfkpb/SAfEJjTubt+720ATj0kPYcWK7BT5vkKbU/f7X2yh8bHyJFBfzEgc
         Wlpw==
X-Gm-Message-State: ACgBeo3Okj3H/uYr8F+9Lm9YP/E0j8dQm0chvMMCGxNiV8dECQ79yt9D
        v5mX08FEEleCI97a8IC0MALVu02Rd2q4yA==
X-Google-Smtp-Source: AA6agR6kiJ4FX1LJJ/Uo44iVsHBip9Lv0pwLDM6D16vW1SGLhcD/fIU21n32DClqzX3EKl/GiPay4g==
X-Received: by 2002:a05:651c:c86:b0:25e:7181:e1a5 with SMTP id bz6-20020a05651c0c8600b0025e7181e1a5mr2260875ljb.492.1662635789973;
        Thu, 08 Sep 2022 04:16:29 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a9-20020a196609000000b004946274b7d6sm2992129lfc.166.2022.09.08.04.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:16:29 -0700 (PDT)
Message-ID: <35722313-6585-1748-6821-aebe0859ef6e@linaro.org>
Date:   Thu, 8 Sep 2022 13:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/5] dt-bindings: net: Add generic Bluetooth controller
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
References: <20220907170935.11757-1-sven@svenpeter.dev>
 <20220907170935.11757-2-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907170935.11757-2-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/09/2022 19:09, Sven Peter wrote:
> 
> Bluetooth controllers share the common local-bd-address property.
> Add a generic YAML schema to replace bluetooth.txt for those.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> changes from v1:
>   - removed blueetooth.txt instead of just replacing it with a
>     deprecation note
>   - replaced references to bluetooth.txt
> 
> checkpatch complains here because it thinks I do to many things at once,
> I think it's better to replace bluetooth.txt in single commit though.
> Let me know if you prefer this to be split into multiple commits
> instead.
> 
> .../bindings/net/bluetooth-controller.yaml    | 30 +++++++++++++++++++

I propose to keep it in net/bluetooth subdirectory. In next patch you
can move there other files.

>  .../devicetree/bindings/net/bluetooth.txt     |  5 ----
>  .../bindings/net/qualcomm-bluetooth.yaml      |  4 +--
>  .../bindings/soc/qcom/qcom,wcnss.yaml         |  8 ++---
>  4 files changed, 35 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth-controller.yaml b/Documentation/devicetree/bindings/net/bluetooth-controller.yaml
> new file mode 100644
> index 000000000000..0ea8a20e30f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth-controller.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bluetooth Controller Generic Binding
> +
> +maintainers:
> +  - Marcel Holtmann <marcel@holtmann.org>
> +  - Johan Hedberg <johan.hedberg@gmail.com>
> +  - Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^bluetooth(@.*)?$"
> +
> +  local-bd-address:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6

No need for minitems.



Best regards,
Krzysztof
