Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF5C35246
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB0E20705
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbj+68nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAaWga (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:36:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42531 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgAaWg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so708329plt.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2020 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9bjOIz1ZoWIt3WH97jOSDUlwhKrTSs9Z8cHSgbUrkY=;
        b=hbj+68nhZTVhE7I5O0WiC8/gmPXXA2ajfPWRycFgp38z3tUZtkqjW79aSvtSlD/HLj
         5gJdZSoT1e8wOmxDCdIPQsxE6H12Y3VYCzrTWMoePrF4SzUrYe5fxQY1DgkYSg+wgNp4
         J2RD4T441ME7ha7dC4p7qD/I6bCN4kFDGrTtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9bjOIz1ZoWIt3WH97jOSDUlwhKrTSs9Z8cHSgbUrkY=;
        b=rbD0X2dGIvjxJWrDKsPwW88Nbc+A41+c6VIhjpuCALOhEJOJ5BZctajmAVsDpBS/fp
         joLcE6L2Vnl5Y4IafLRL9kXWMOxsO137aha8M+XIcQdPLcNxUCUV2cR61vRL2skkZR5K
         HrE0pWJBIgeEy5aB7lUhmu6TJ67lmJehfEGON0IG0cO58Kre1TWRdyGmnlSBv+ZHukwa
         JNVy23HUpNOl6/VL4V4BR0IqWHqpY50jMbyEJ01L+JcBIebPSMYs2EIdmQ/555ndiMJ1
         7CrD75RUmNs9YVIXY44E+BCT11/gx2Vh0VT0khp8MnJHMjkQZZbl+ZMG9agrMPtRawmh
         AiHw==
X-Gm-Message-State: APjAAAWJYjPX4yRVi1KEXb+iPMEQERyjyPPpG8LQkcFsDWDGE5CDnUIt
        s2N27qo7Q5AUDgAVzJthPZrKKg==
X-Google-Smtp-Source: APXvYqwjuzhS3BpKt6xGsva6ZfgbAYrcRNVn+3vmUXd3bKzT1b/K98vAVksO/LvuPRUEO+sF5cmBLA==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr15273352pjq.8.1580510188785;
        Fri, 31 Jan 2020 14:36:28 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a9sm11359539pfo.35.2020.01.31.14.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:36:28 -0800 (PST)
Date:   Fri, 31 Jan 2020 14:36:26 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        robh@kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org, rjliao@codeaurora.org,
        yshavit@google.com, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3991
Message-ID: <20200131223626.GA237926@google.com>
References: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
 <1580456335-7317-2-git-send-email-gubbaven@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580456335-7317-2-git-send-email-gubbaven@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ DT folks

On Fri, Jan 31, 2020 at 01:08:55PM +0530, Venkata Lakshmi Narayana Gubba wrote:
> Add compatible string for the Qualcomm WCN3991 Bluetooth controller
> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 68b67d9..e72045d 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -11,6 +11,7 @@ Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
>     * "qcom,wcn3990-bt"
> +   * "qcom,wcn3991-bt"
>     * "qcom,wcn3998-bt"
>  
>  Optional properties for compatible string qcom,qca6174-bt:
> @@ -30,6 +31,7 @@ Optional properties for compatible string qcom,wcn399x-bt:
>  
>   - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
>   - firmware-name: specify the name of nvm firmware to load
> + - clocks: clock provided to the controller
>  
>  Examples:
>  
> @@ -56,5 +58,6 @@ serial@898000 {
>  		vddch0-supply = <&vreg_l25a_3p3>;
>  		max-speed = <3200000>;
>  		firmware-name = "crnv21.bin";
> +		clocks = <&rpmhcc>;

That specifies a clock controller, not a clock.

For a device with the SC7180 SoC we use this:

		clocks = <&rpmhcc RPMH_RF_CLK2>;

>  	};
>  };
