Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D077EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF426610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhJFR2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbhJFR2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 13:28:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C9C061753
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 10:26:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2907080pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqLlaNKEqm+ZaZ2LpC7pTVMRjKSj866cBde1zhwsrc8=;
        b=L+m7bOJXYDagzEMZMZkAbBAUxAG85edgM/ThRb3FqDHqXUbdg5j5bl25wq8XWfVGLS
         c6cLTS1VU7uI50OX7QaBiRYgdEbA2pBoM5YfcF6nSMDlVDR9bzQHBdkcwxxjUINOM/q4
         D8in3PNdHmcPD3B57uZ9nUGIqkEnyYK2Vd4bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqLlaNKEqm+ZaZ2LpC7pTVMRjKSj866cBde1zhwsrc8=;
        b=U87caqgAAZZA/fkV9ZwgPHzsBjVcu1yO+ENO5G4ZbH7kziVCVcouszpDsDI95QkL0b
         07QEW+pcNn8GLc5UQOFLViBGRmzXgsU0WO0tI6tiX4td8DfzA4X1xvboPwab6WfwowZN
         pHDdnFiWnEghu4EQ1HHelQ74oklORadgyshJZK1DW7dKZWAdmziIu9iqiK+vpY2keuiC
         K7n2/P1lMA+QC4SOOey5S815iITxlfJQnR1/pUhD6dmAS6p1ZjiCQK3bi1SNQrB+93lM
         2KRM5VWtQd/41vj/X4OMUQ4oOWqj9/B3xVIA8yNh1iM3LCoVT142Su9gxVihiXTHi8Me
         1sBA==
X-Gm-Message-State: AOAM531I+90I17VnZ5XgY0SMtw5S/zT7HriU9MeRdxHZAFfDGRxQIpfK
        tZZXxg+JrVtqTafbEmk3MHLxRQ==
X-Google-Smtp-Source: ABdhPJwgaHkRHDL6O0EIejciabO58pF3AjAOBXmYCssuQCdYIo5SWfJHNGO6RTWTopp5Dpn3rcLaYg==
X-Received: by 2002:a17:90a:5ac2:: with SMTP id n60mr12214033pji.184.1633541210450;
        Wed, 06 Oct 2021 10:26:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a463:ae21:d1fc:ddfd])
        by smtp.gmail.com with UTF8SMTPSA id fz20sm5440964pjb.31.2021.10.06.10.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 10:26:49 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:26:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, bjorn.andersson@linaro.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        pharish@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 IDP board
Message-ID: <YV3cVzI4aVeCjMt2@google.com>
References: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 06, 2021 at 06:00:02PM +0530, Balakrishna Godavarthi wrote:
> Add bluetooth SoC WCN6750 node for SC7280 IDP board.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  2 ++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 64fc22a..d3f5393 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -17,6 +17,8 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		bluetooth0 = &bluetooth;
> +		hsuart0 = &uart7;

Sort aliases alphabetically.

Also 'hsuart' should not be used, as Dmitry already pointed out on
patch 2/2. I suppose it should be 'serial1', as in 'second serial
port of the board'.

>  	};
>  
>  	chosen {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 272d5ca..05aa729 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -393,6 +393,24 @@
>  				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> +
> +	bluetooth: wcn6750-bt {
> +		compatible = "qcom,wcn6750-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en_default>;

Do we also need a pinctrl entry for 'swctrl' ?

> +		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>; /* BT_EN */
> +		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>; /* SW_CTRL */

The comments aren't useful, the property names say the same.

> +		vddio-supply = <&vreg_l19b_1p8>;
> +		vddaon-supply = <&vreg_s7b_0p9>;
> +		vddbtcxmx-supply = <&vreg_s7b_0p9>;
> +		vddrfacmn-supply = <&vreg_s7b_0p9>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p9>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p8>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p2>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p2>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		max-speed = <3200000>;
> +	};
>  };
>  
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
> @@ -504,6 +522,19 @@
>  		 */
>  		bias-pull-up;
>  	};
> +
> +	bt_en_default: bt_en_default {

	bt_en: bt-en {

> +		pinmux {
> +			pins = "gpio85";
> +			function = "gpio";
> +		};
> +		pinconf {
> +			pins = "gpio85";
> +			drive-strength = <2>;
> +			output-low;
> +			bias-pull-down;
> +		};

No pinmux & pinconf nodes, see configuration for other pins.
