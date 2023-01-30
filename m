Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65AFC54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjA3Shj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbjA3Sgi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228930DC
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675103744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lt1BSrHjqGxTuQATN1FHlMVFUULtc3t75DalFc1DJkQ=;
        b=JEtEz2asMjZzViwxC1OxGMe6wC9uRmlq+vxMm0OChc4zaeSgjLaHcoNqF3Aj5OW/wqTtOm
        KklljaeG4nerYz3hUBNHAaMMVmqdffqX6jXVV0ZpGFl9nQ9vVWZRlkGJKdmDQis/eOaAG0
        TRhRamA0VN8fLxweg4gi6AyIUawi2Cc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-5EJJCK6tPcetQp5pz0RZhA-1; Mon, 30 Jan 2023 13:35:35 -0500
X-MC-Unique: 5EJJCK6tPcetQp5pz0RZhA-1
Received: by mail-qt1-f200.google.com with SMTP id x16-20020ac87ed0000000b003b82d873b38so3447306qtj.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt1BSrHjqGxTuQATN1FHlMVFUULtc3t75DalFc1DJkQ=;
        b=7UBDNgY5DKPT/grY5xs54syQtpBuiVC5K4HbMRA8GTSEyiO9IPXXfw/zncnCTK+G/F
         UACvrI9KEp4w5gtAdmtQNI8mJ7o/KTcUSx2unDzDB/bGOMH1UfFnyJj+lnwvU54uro5s
         /1FMsc4H09LrVSQCU4J+EopsiS+iV9Sti4vpWDBQ/qVLBwi6H7Gllxgg3pbMc+U2nDpj
         40HZJr0SmUOqoozdeRCK4h7WGB0z/zZZ8GvzdtjgMWl/c+nUAK+bY9p/XY4+AgJFZAvA
         NJhmG2FX08RMddLUfwvLvpkRdEzLVqNG6cuhTcNd//xUesUpVRKHN+SsI/LPhCl/j82M
         N+NA==
X-Gm-Message-State: AO0yUKVKuSthpX3U1n9N7Urm7ZPUXTKZIUY4bODBy3s1SRfmAbNxoGI4
        1pjbNqrhcjV4eOE+yii8Kvpiun9x1h1rpxTjYQPzyjkiwtcczDD4Niwr4kglufOVKp3h1IAOCoE
        hUu4UAw24dgmz3EbGvZaoK7nmmAcu
X-Received: by 2002:a05:6214:5086:b0:537:7335:144f with SMTP id kk6-20020a056214508600b005377335144fmr33146798qvb.24.1675103734842;
        Mon, 30 Jan 2023 10:35:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/FPPbNpiUIaqVWHe+TRyIn3OsGXWnrIppmyHYJIz3KP+w5i9mRZLJBY8tMr/xBanz2UMPsXg==
X-Received: by 2002:a05:6214:5086:b0:537:7335:144f with SMTP id kk6-20020a056214508600b005377335144fmr33146764qvb.24.1675103734613;
        Mon, 30 Jan 2023 10:35:34 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a0d4400b006ea7f9d8644sm8448062qkl.96.2023.01.30.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:35:33 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:35:32 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Enable BT
Message-ID: <Y9gN9IKAr6y3xzh7@x1>
References: <20230129215136.5557-1-steev@kali.org>
 <20230129215136.5557-2-steev@kali.org>
 <20230129215136.5557-3-steev@kali.org>
 <20230129215136.5557-4-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129215136.5557-4-steev@kali.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Jan 29, 2023 at 03:51:29PM -0600, Steev Klimaszewski wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

You should also add your Signed-off-by. Also the title of the patch
should be updated to say define uart2 instead of enable BT.

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 122afa03bb40..2d98687fb1ea 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1244,6 +1244,20 @@ spi3: spi@98c000 {
>  				status = "disabled";
>  			};
>  
> +			uart2: serial@988000 {

This node needs to go after spi2 instead of spi3.

Everything else looks good to me.

Brian

