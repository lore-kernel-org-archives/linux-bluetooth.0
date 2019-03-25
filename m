Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4EDC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826520828
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 16:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JNyPp0jO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYQ3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:29:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44787 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfCYQ3h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 12:29:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so567621pfm.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKA+/wTp0okAnhyMF1ccWYL4MyNqU1Yv+j11H+WCHyU=;
        b=JNyPp0jOx2S75Y7uSySiXbWEWf9+0C6llPOPqzr07Ohx5rLI1VFnl6haf+yH/4oByN
         xF0HT54fbIy18RH/LCu5BKZ2WJNfpZ395olAJzqAi6oK4kSdJtEGIq7lqT5dpyg0p7F2
         pHoFChnelpu4KpIN2WPhqqHGx4YjpOIDcXFNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKA+/wTp0okAnhyMF1ccWYL4MyNqU1Yv+j11H+WCHyU=;
        b=GvYwFEeRPRZhq8uMX/G3E7muxJwdM+gAlARh6pcqRI5JsObfaj0Sw4aXpvrrQGfSBJ
         voe4NeHympf9ohCUK2mc0OCfj5qauzmVS59sgoXAalQcDkg3UWraE2Du8B/Vg/FlhPJp
         XA9wR7Yg9L8gSEp8kWe6ufoy4+wV6pOCqM00thEg7a+KgaST2VQqQj1dkfQ/VZhbiNgP
         fCVop7CktKJ5OTgQ93GyCgzIGb4TRoFYk3L7ANOb/kimpZUoZ7VUt1NoxTGiOIOsflTe
         mqOyOr1FVRF8bUcZPwcrhJRgmuxOlkXdlFsKQfy3n6QwGmJidomduokWPPXsfddv7uNY
         ttKg==
X-Gm-Message-State: APjAAAXotYaYhME2kMd5+xjf7WUGCr7cEj3+GIzMDFw7noNzjOVLsyRg
        jNK1oz35YiWbC2Xn0tacUbws7A==
X-Google-Smtp-Source: APXvYqxvDla/2Jn6yBLoezy1lmRyD6E/pUwhktHe8lr3lJvYIrcXabrUIG1eXN7VWyAxgRz9kZZ9mQ==
X-Received: by 2002:a62:482:: with SMTP id 124mr22339586pfe.191.1553531376100;
        Mon, 25 Mar 2019 09:29:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z127sm21482979pgb.77.2019.03.25.09.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:29:35 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:29:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
Message-ID: <20190325162935.GW112750@google.com>
References: <1553513800-27611-1-git-send-email-c-hbandi@codeaurora.org>
 <1553513800-27611-3-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553513800-27611-3-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Mar 25, 2019 at 05:06:40PM +0530, Harish Bandi wrote:
> This patch enables regulators for the Qualcomm Bluetooth WCN3998
> controller.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> Changes in V4:
> - Removed new compatible WCN3998
> - changed wcn3990 to wcn399* to represent wcn399* family
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 824c0e2..de9cefa 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -11,20 +11,21 @@ Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
>     * "qcom,wcn3990-bt"
> +   * "qcom,wcn3998-bt"
>  
>  Optional properties for compatible string qcom,qca6174-bt:
>  
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Required properties for compatible string qcom,wcn3990-bt:
> +Required properties for compatible string qcom,wcn399*-bt:

I think in Linux drivers the use of 'x' is more common as a wildcard
for a single letter than an asterisk. It is also in line with the
function name in the driver, so I would suggest to keep thinkgs
consistent and call it wcn399x everywhere.

>  
>   - vddio-supply: VDD_IO supply regulator handle.
>   - vddxo-supply: VDD_XO supply regulator handle.
>   - vddrf-supply: VDD_RF supply regulator handle.
>   - vddch0-supply: VDD_CH0 supply regulator handle.
>  
> -Optional properties for compatible string qcom,wcn3990-bt:
> +Optional properties for compatible string qcom,wcn399*-bt:
>  
>   - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
>  
> @@ -44,7 +45,7 @@ serial@7570000 {
>  
>  serial@898000 {
>  	bluetooth {
> -		compatible = "qcom,wcn3990-bt";
> +		compatible = "qcom,wcn399*-bt";

Typically wildcards aren't used in DT examples as Marcel already
mentioned on v3. IMO the wildcard degrades the value of the example,
rather than enhancing it. I think just listing the compatible string
is enough, no need for an wcn3998/x specific example since it's
essentialy the same as wcn3990.

Thanks

Matthias
