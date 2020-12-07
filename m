Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D16CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E69423442
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgLGNsg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGNsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 08:48:35 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8594C061A51
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 05:47:40 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id lb18so4836592pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0vLQ+8LVtce1Ort4/wvUzG2MmMnwEbkJ3EUCvQI9KI=;
        b=VuKqCSv/xYBhTIzFDMRo2jpxBzbhP7I1bCmSkzd4AEsI4H0rHeuOMwptn3mWewF04i
         G6VsKEDxG9rObtp9fpDC9BXuiWRIjFX1VzjKPmosATwDBTSjzQwplp2OPnMVHf4lm3eh
         x0FdplDwLXuqV4y7l1zO+AgcSX8Mpara0D/94+gXURo2UH3/hiNQ7KOnDQfkMVsBzHZN
         Bz5aN92YtCyMVyQarmD4+LgzxWlWsQuwcv+6G8jqaI8R7lVFPd3HV74MO1i2UTysXUCr
         xYjltl/YCujIz3cHcTM7jJLh73NcEKoXUTxr7yrh7VX7a2z2Kjk6jxLN9xxDn5vvbH1y
         WJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Z0vLQ+8LVtce1Ort4/wvUzG2MmMnwEbkJ3EUCvQI9KI=;
        b=sYpIBKYnyFoIB5GtO4EU68dkVeLh/N2KeiBNFzMqnT4CB8LD/CmJLDNrvhWba8FVUI
         w6sP0ZcWfi756uO8zp4pQ1mXeex4s5FSDYeLUNB2fBpaK8iQ0/4WJAU71LFrNtb5PVnO
         d1KPjP9auPZfs7dANTWkZgW/mpy9YGPSvGP7lnfBJd1YyZtoTv/LPqOeJtPw90P+MuQE
         yL5szGf9Jo6X3NE1PG1rFQzh8hCC8LQzEnuwz/Rx6/7Z/Dp187zSQrdxDnku1Dgn8H+F
         MTBULItZLkPATYt4H6EfuTazTIV2qF4X00AV99JAnFzs8tbWz2yT4I1OlRnhOwS4vnsq
         rPrw==
X-Gm-Message-State: AOAM531NCGbKmU+sEo0yYYyC7OZenwefzCMTtwiAHCoGFo7nKiYz0sQo
        6dBq5lzl4xT96lFQPh0myp8zV33v690nk/bA
X-Google-Smtp-Source: ABdhPJwZoN2qgjClP6GGLisahDMDvcBqMIEJn9xbuzi4sNoRiHDurcPVyFgdeJxTu6+iPMJ0u/DHGA==
X-Received: by 2002:a17:90a:c403:: with SMTP id i3mr9711825pjt.230.1607348860361;
        Mon, 07 Dec 2020 05:47:40 -0800 (PST)
Received: from localhost ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id f9sm4230687pfa.41.2020.12.07.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:47:39 -0800 (PST)
Date:   Mon, 7 Dec 2020 15:47:36 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Bluetooth entries
Message-ID: <20201207134736.GB10089@johnypau-MOBL2.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20201207100842.128579-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207100842.128579-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Dec 07, 2020, Marcel Holtmann wrote:
> Update the status to Supported to reflect the current state of affairs
> and add Luiz as additional maintainer.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
