Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB781C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB7860FDA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhJFQuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFQuN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 12:50:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049FEC061753
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 09:48:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i24so12285459lfj.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T5u+J7YA0xyzY2Zlfv0fcrmW+q1VsOAFPY6Ha0RmHOE=;
        b=u8L4jIMS/HGyekro207nIeVOIKfA1ny77lQmEPpWOo9LwShdKuQnJ81hp2wC8LOKuK
         LGtOhHR55N9EGyTsaboWrjeJVsyJytWoTlEYvyMuq+BBvoZkDw9gLMQIgYiFa+MsLU0S
         klwADza94UIFHPRMb60HUvztbhdNUd6NEGdx9qSNom5hhQXa9u7Xeb2KtxZF17AQviNS
         mSNzKkbK/AzkYKiaHscsG0VER7YuQWRKFxY0rGgLdcJV8SKbr1v9GlGpLeBPEYmxo1d7
         BtsG1ICumXRpZqFmXFFGfPPdOVTcopTn9Vbf3Oc3raTj3/1uAqwGChVYvdnjoIz8Fe46
         B00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T5u+J7YA0xyzY2Zlfv0fcrmW+q1VsOAFPY6Ha0RmHOE=;
        b=BpquRzyADLxpEWu30ACaiRTBvKYTVjCMbjWQHXd/kEJpeXFjMypifo8ZlpHO6g+xgp
         bZ73SuQ3N+X6MRaRe6TUXL7R+eJFgSG4ECpHgLWruOha1pHU5004Is4h82uByYiZvKh2
         vUXaLemtSaLSkbrTG7YVDrun4BglIjLIRezJdCafD6sfiQFjt7vlN+2Zs3//jhB3vXHv
         CfsFsioCSv0/iEERUOe2p+13DOlBXEEzBKF0DdKjluWPBtnwEpVItUjC+wSr9klrH/Sw
         vihscE45mF4LK0zo686X9BY0t1eAwVD7pq3FoXaOwgyQQdmASpegmYKDtW6qEajY5u0u
         qz3g==
X-Gm-Message-State: AOAM533PgwOBV7r69bbHzyHu6rhKVCw8jq5Em4VuhsOc3TwzoQMrSx9y
        ABCsqtPmftcK9eqSGl9wtKePcA==
X-Google-Smtp-Source: ABdhPJwykGa9j4WMyyGvBIei36WIcpCoX1P2RK6lI1Ho4lBv9Yss8vTWSq77ZmlujYErN9ZemHKcyg==
X-Received: by 2002:a2e:9012:: with SMTP id h18mr29776988ljg.336.1633538899360;
        Wed, 06 Oct 2021 09:48:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w13sm2313400lft.94.2021.10.06.09.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 09:48:18 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sc7280: update bluetooth node in
 SC7280 IDP2 board
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, bjorn.andersson@linaro.org,
        johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        pharish@codeaurora.org, abhishekpandit@chromium.org
References: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
 <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fee220ea-4d20-79a2-fe3a-4df09535eca1@linaro.org>
Date:   Wed, 6 Oct 2021 19:48:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/10/2021 15:30, Balakrishna Godavarthi wrote:
> This patch updates bluetooth node in SC7280 IDP2 board.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280-idp2.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> index 1fc2add..5c8d54b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> @@ -15,9 +15,15 @@
>   
>   	aliases {
>   		serial0 = &uart5;
> +		bluetooth0 = &bluetooth;
> +		hsuart0 = &uart7;

hsuartX does not follow existing aliases definition, so it was frowned 
upon by Rob Herring in the past.

>   	};
>   
>   	chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   };
> +
> +&bluetooth: wcn6750-bt {
> +	vddio-supply = <&vreg_l18b_1p8>;
> +};
> 


-- 
With best wishes
Dmitry
