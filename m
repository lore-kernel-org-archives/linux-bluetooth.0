Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47142C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F09C61372
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhJDTqj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbhJDTqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 15:46:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958EC06174E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 12:44:49 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 24so23153004oix.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lPwZ+iwsuPnoAxmrkeLnm/5OtvoYrkkwPtp9yTV4PE=;
        b=hgF1ZS5hnGhwUx2jX7oe2GHCphP61nmlCP4jO1u7qYsCENPZl9Qq27TGGNB+bkKiac
         jdQn2fj8+mXEEmTTF6pL+5RGN3fhZ9Mc5u6QUYrdVHMefiUrfQvD3gfU4n6+G0lQThA5
         g+MynwqkJ3Y7M+fZUlMYwhxFJU8oRv1d5a5USP7B1XsA0TjlUPEtd2l2VyabrC8owMJT
         1ae6r6JkuwqaaK5hC6lHMiG4iAM7Umrh2CRIEjUwLH0VH0mt7+X76isPUD6aUXldQV1j
         KvISpuM2NO8ZbrBKQyIohf6z9eiKHATGZe2xJACeqb2PiuDlaYzUnn5XiXQM9Gi3hMRT
         5WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lPwZ+iwsuPnoAxmrkeLnm/5OtvoYrkkwPtp9yTV4PE=;
        b=iInWo4HF6PYYvwr2UMvkZ+0Brt6OXwCwANhWoUKg6hsV3zD4r4bz/wgbIW3Obe9c3w
         VaqzUehQBLPbuf/WyE7vDNE8bTd0UbwCZTQTvxVuAtgWxLcf5ZdI7DI4BCFdJhuUtsT9
         ayNfXjHDPE5e9QxdXQ26CRv6Jsz2hBReaG60Fp5rVNUeU7uKF1ard4qyfVNuCH8Svz+h
         8uGgJOiztlUkazrBBVGXzcWkpLl7p7Cx7pHRPgNOaEdw8ORvP/jaggZcmyPbLoRy+cCT
         KHZoQbJs9HiGlowvXmqjkkRY9GiG61ex1+rmNzRTb5uu2e58sJmJcRVrqY4+Sf+hHMHp
         CaVw==
X-Gm-Message-State: AOAM531k/HOky7eVN17FSa6nh+1SpREoIkqcFSEHnl9WUeKTPuf8Hc1E
        vY6OnQcp6JXHlLKz/skBGWKnwg==
X-Google-Smtp-Source: ABdhPJwI92lYk3R3FU/4z6wR+/EiRyFE+2CPENxQiTRDE+M3rjZ6qwYRkxV0gelImXKGjpQ2x+ZpAQ==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr13729435oih.37.1633376688632;
        Mon, 04 Oct 2021 12:44:48 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j10sm2972251oog.39.2021.10.04.12.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:44:48 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:46:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Andy Gross <agross@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next -v2] ./drivers/bluetooth/btqcomsmd.c: remove
 superfluous header files from btqcomsmd.c
Message-ID: <YVtaF1YD/T9r8Ucy@ripper>
References: <20210928200811.22059-1-liumh1@shanghaitech.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928200811.22059-1-liumh1@shanghaitech.edu.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue 28 Sep 13:08 PDT 2021, Mianhan Liu wrote:

If you run a "git log --oneline -- drivers/bluetooth/btqcomsmd.c" you
will see that the appropriate prefix would be "Bluetooth: btqcomsmd: "

In other words, a better $subject would be:

[PATCH v2] Bluetooth: btqcomsmd: remove superfluous includes

> btqcomsmd.c hasn't use any macro or function declared in linux/of.h
> and linux/slab.h.
> Thus, these files can be removed from btqcomsmd.c safely without
> affecting the compilation of the ./drivers/bluetooth module
> 
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
> 
> ---

Here is an excellent place to state "Changes since v1" and mention that
you no longer remove btqca.h and you added your S-o-b.

>  drivers/bluetooth/btqcomsmd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 2acb719e5..e556d96a4 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -5,9 +5,7 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/slab.h>
>  #include <linux/rpmsg.h>
> -#include <linux/of.h>
>  

This looks reasonable.

Regards,
Bjorn

>  #include <linux/soc/qcom/wcnss_ctrl.h>
>  #include <linux/platform_device.h>
> -- 
> 2.25.1
> 
> 
