Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiDKVHA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbiDKVG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 17:06:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6B2AC49
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 14:04:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso12135152otj.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77PX79Y9IPAg5eHYXNxxfMPoxrPEosfgIY3QM8YJll8=;
        b=HIkQz44wBum19qdatUG526f4XiRWheHtHVxCYhxfaqqiEtuH7WwWxZFamXzz+JtPju
         0VL/DG2XsnoF8crLKPRzng22wuqnKv1jFHYcE0nfRina9YGLEziQigyZ9zgcapaUqWmL
         tpcRMrF0WOTRhrxTDoN7wh/oDuu9PlXbRIDKDglMpud+OyWhQYPFRQbZiAz0HAD0RjPS
         2ga8Qtn/MnguZjyUfG+OLq80Wb8tvC3z/qZ9dCNnjcnlRDXGPonmfx+aAA8zn/OmrzQi
         KU0KwgwzX5DLw4bMxg1VAwSacniZGQH7EhWC6sJ89kog6hR2frMO5TByrUcHVWs28Dd9
         ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77PX79Y9IPAg5eHYXNxxfMPoxrPEosfgIY3QM8YJll8=;
        b=W1haZz92p8W9+Mbo/nWf761eyJs0DvTgkhUmGEMDvogv+4l6/iTH0nW/afiZL4uqU1
         DnRZ5Erag9e6MrihOgJIMmcK0j7S6lD3xxPYXvmmJG1flFhlIfHBr/6RxwwoMoJa74ge
         Hqs/fCLSWtEqXRg/5CSclffDkggKS49OsEKKmQdBvd5S/pmGV//AH5h2i/4KzzUHv/0Y
         V7K+nWRwHlIPLWMcs8aTsd0oXv9OAZSsqVndaORK1N0t5jWJh7laPvwLgfkAq6nUd4M3
         sTwYPoK1CEZwsywUZqxCaDjoT0X6PO43c7GXvAMELyqK0BMioebXe31J30/c5l89gxO2
         /ZFg==
X-Gm-Message-State: AOAM531/X4f5lelBML6h2Gw3ha2TvEwCrE3nyauW5HZ+DbBPhkql0YLQ
        BPXa+3xd45m8hv5iYSHjlkI56A==
X-Google-Smtp-Source: ABdhPJzbt+6r3bUkdCzVZS8rMIyYxfN0BphKqVhmcZuHTHMoVlPWzuKcs4sx10u/Py/5hjORnkewrA==
X-Received: by 2002:a05:6830:d8:b0:5b2:553d:2cf8 with SMTP id x24-20020a05683000d800b005b2553d2cf8mr12021675oto.156.1649711083390;
        Mon, 11 Apr 2022 14:04:43 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id i28-20020a9d4a9c000000b005ce06a77de2sm13366637otf.48.2022.04.11.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:04:42 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:04:40 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        mcchou@chromium.org
Subject: Re: [RESEND v3] arm64: dts: qcom: sc7280: Add IO regulator handler
 in SC7280 CRD platforms
Message-ID: <YlSX6AvqoZafn2Kn@builder.lan>
References: <1647937864-25661-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647937864-25661-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue 22 Mar 03:31 CDT 2022, Sai Teja Aluvala wrote:

> Add IO regulator handler in SC7280 CRD based platforms.
> As IO regulator varies in different SC7280 platforms
> updating this handler in individual platform bluetooth node.
> 

To me a significant part of this change is "bluetooth", yet it's not
mentioned until the very end of the commit message.

Please update your $subject to be more to the point and to include
"bluetooth", and please don't repeat $subject as the first line in your
commit message.

Thanks,
Bjorn

> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
> v3: Updated commit text to reflect the change
> v2: updated reviewer comments.
> v1: intial patch
> ---
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index cd2755c..53ea3b4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -23,6 +23,10 @@
>  	};
>  };
>  
> +&bluetooth {
> +	vddio-supply = <&vreg_l18b_1p8>;
> +};
> +
>  ap_tp_i2c: &i2c0 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
> 
