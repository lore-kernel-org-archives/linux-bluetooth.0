Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1159C43460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B547B61164
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 17:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbhDURMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:12:46 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39636 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbhDURMp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 13:12:45 -0400
Received: by mail-oi1-f182.google.com with SMTP id i81so43109173oif.6;
        Wed, 21 Apr 2021 10:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bMd7N0rt3H2tWJcdwavdRNyVrQYmCrkPGZcBKF39zwI=;
        b=l+JAxaGJdKRjIQeOKyetlQ/bup7k/1Gjcqmb3YtymN06Y+jL0t00Z2C6keudDhu14n
         PHeplDEH0f8V8zx6aSIpzKkWnuD+98Sejg7byAD77zyx8g/bVyw7YUAJgyzKlTzG4L9M
         Wn6COwtePyCsqlynHnfa8Y5ayqfZSdEq+XCz/YDx2pvA6MwxXtQYSS2Io0OBHZETYMGA
         /TDup3cSADLPfnH7RBTaDszyOxdjrQ2owU8W495qqv6oETKKKYmZ1VCMKa54U3kMrn4C
         yVUIc6enc1PEfDBVnEIPBecMreqpTSt8sC2J2Y/e7eLCeTIIdiGZeQAFB+aDZNMj5ZxN
         TENg==
X-Gm-Message-State: AOAM533IB6BToUqkIpnsMI3SGXXn4X2NSYqmtg0ZPPkIYkT8PQH6NIKN
        HnndTucFWqeoQopdQn003w==
X-Google-Smtp-Source: ABdhPJzi7CH4Rf+w3pIPiptNJi5mE9r2r/RXFC6iOAlcbnBfpnwUuNkHLSA6+1IsJ8DdgN04duoFyQ==
X-Received: by 2002:aca:eb55:: with SMTP id j82mr7100835oih.93.1619025131673;
        Wed, 21 Apr 2021 10:12:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g84sm605470oia.45.2021.04.21.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:12:10 -0700 (PDT)
Received: (nullmailer pid 1308964 invoked by uid 1000);
        Wed, 21 Apr 2021 17:12:09 -0000
Date:   Wed, 21 Apr 2021 12:12:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [PATCH v2 3/3] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn6750
Message-ID: <20210421171209.GA1307554@robh.at.kernel.org>
References: <1618936010-16579-1-git-send-email-gubbaven@codeaurora.org>
 <1618936010-16579-4-git-send-email-gubbaven@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618936010-16579-4-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 20, 2021 at 09:56:50PM +0530, Venkata Lakshmi Narayana Gubba wrote:
> This patch enables regulators and gpios for the Qualcomm Bluetooth wcn6750
> controller.
> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
>  .../bindings/net/qualcomm-bluetooth.yaml           | 54 +++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> index 55cd995..1ceb02b 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> @@ -21,11 +21,17 @@ properties:
>        - qcom,wcn3990-bt
>        - qcom,wcn3991-bt
>        - qcom,wcn3998-bt
> -      - qcom,qca6390-bt      
> +      - qcom,qca6390-bt
> +      - qcom,wcn6750-bt
>  
>    enable-gpios:
>      maxItems: 1
>      description: gpio specifier used to enable chip
> +
> +  swctrl-gpios:
> +    maxItems: 1
> +    description: gpio specifier is used to find status
> +                 of clock supply to SoC
>     
>    clocks:
>      maxItems: 1
> @@ -43,6 +49,30 @@ properties:
>    vddch0-supply:
>      description: VDD_CH0 supply regulator handle
>  
> +  vddaon-supply:
> +    description: VDD_AON supply regulator handle
> +
> +  vddbtcxmx-supply:
> +    description: VDD_BT_CXMX supply regualtor handle

typo

> +
> +  vddrfacmn-supply:
> +    description: VDD_RFA_CMN supply regulator handle
> +
> +  vddrfa0p8-supply:
> +    description: VDD_RFA_0P8 suppply regulator handle
> +
> +  vddrfa1p7-supply:
> +    description: VDD_RFA_1P7 supply regulator handle
> +
> +  vddrfa1p2-supply:
> +    description: VDD_RFA_1P2 supply regulator handle
> +
> +  vddrfa2p2-supply:
> +    description: VDD_RFA_2P2 supply regulator handle
> +
> +  vddasd-supply:
> +    description: VDD_ASD supply regulator handle
> +
>    max-speed: 
>      description: see Documentation/devicetree/bindings/serial/serial.yaml
>  
> @@ -85,3 +115,25 @@ examples:
>              firmware-name = "crnv21.bin";		
>          };
>      };
> +  - |
> +    uart {

serial {

> +
> +        bluetooth {
> +            compatible = "qcom,wcn6750-bt";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&bt_en_default>;
> +            enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +            swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> +            vddio-supply = <&vreg_l19b_1p8>;
> +            vddaon-supply = <&vreg_s7b_0p9>;
> +            vddbtcxmx-supply = <&vreg_s7b_0p9>;
> +            vddrfacmn-supply = <&vreg_s7b_0p9>;
> +            vddrfa0p8-supply = <&vreg_s7b_0p9>;
> +            vddrfa1p7-supply = <&vreg_s1b_1p8>;
> +            vddrfa1p2-supply = <&vreg_s8b_1p2>;
> +            vddrfa2p2-supply = <&vreg_s1c_2p2>;
> +            vddasd-supply = <&vreg_l11c_2p8>;
> +            max-speed = <3200000>;
> +            firmware-name = "msnv11.bin";
> +        };
> +    };
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
