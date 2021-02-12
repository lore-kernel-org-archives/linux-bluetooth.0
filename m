Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D097C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 10:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F087764E65
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 10:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBLKyz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBLKyy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 05:54:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C47EC0613D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 02:54:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e17so11023776ljl.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YHhSSO7Bfold1AOekyzb2HoIQujwCnUvaWEZgybZO4w=;
        b=EPFxRloiAe+Uwh+Mo7qwVn4hMr/YJg/ULEdfaQMl/edQ6H8UDhZnPXRht82PfOhuvC
         x8g9Q2I+KOuc/1f6Xt5dy9m1UiL6XcFWo7qobZZ9vcUp4uGMJ1obApm8/v2zuzwRSPzn
         YjEhNTSD5V9NbpNGDF7KdKtIFAhRBCuhrDflujnRqGgTEcwesnpnrMYzlcuHGxXDzcQK
         0drl1DUWZgsceQKhQzbpcpBBe46FcsjdAJpsrtO0nQlp6nl6WgzsJjGd/n38kP8MdBr8
         WOV7mq18ewMzSq2sRn0o+Mb6L6Fpo9Z7NUjjEMUFgNvsBHk+gySgdhlP7WrWUgrrdK4V
         laOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YHhSSO7Bfold1AOekyzb2HoIQujwCnUvaWEZgybZO4w=;
        b=G0OZZp5K8edaLnwpO+0cAxR53PVqi3149C3T9o5cIzxriDSx8slYH0/XEIDggii+GZ
         PKKE4L+7O6pZAtajs1oEmk3YB20VyGZiAMGExH57CykxYyFNAG8X5uLT9cf0fPloEqkY
         Fj3F7aJghIZImpz4zDfXkYWCklMVUG3E+ecag0Dxcyh/93h7KkJV4dp8C+E5TgHiI7dB
         MKkP2lz1r+MTFY5uE9WmDRxzt3ge/cCdIa+B2l1jtLmnasYaMdVWj8SFtDFwg8Z7ZdO7
         Bd6kW7Bm63Xf6jlom2uT74Dg426kVPjpb0M1puUVQFfq5a5EN3c9Q21dISetADn8k3Ft
         VU0A==
X-Gm-Message-State: AOAM530FaOx271TwNsUFbXj19AaJssc+2PGIg+IK36siwrljlX2yu1lK
        Uh6FBUAN6DMWPsvngMDv+UelYg==
X-Google-Smtp-Source: ABdhPJwpJVtPVED4aICVVwHtQANi0bJIK/KypWCX0gcGLX/IjGi5p9chaw3GugdcHiIIvb/aJGSn6Q==
X-Received: by 2002:a2e:2c09:: with SMTP id s9mr1342785ljs.136.1613127252738;
        Fri, 12 Feb 2021 02:54:12 -0800 (PST)
Received: from kynes (ip-222-98.ists.pl. [87.239.222.98])
        by smtp.gmail.com with ESMTPSA id v24sm1298085ljg.27.2021.02.12.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 02:54:12 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Fri, 12 Feb 2021 11:54:10 +0100
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ 3/4] test/test-mesh: Generate correct value for
 Device UUID
Message-ID: <20210212105410.rj4ctsih6blopw4d@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20210211222143.39986-1-inga.stotland@intel.com>
 <20210211222143.39986-4-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211222143.39986-4-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 02/11, Inga Stotland wrote:
> This ensures that the value of Device UUID when invoking
> Join method is compliant with RFC 4122.
> ---
>  test/test-mesh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/test/test-mesh b/test/test-mesh
> index 9e4783734..a478843a3 100755
> --- a/test/test-mesh
> +++ b/test/test-mesh
> @@ -889,6 +889,11 @@ class MainMenu(Menu):
>  
>  		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
>  		random.shuffle(uuid)
> +		uuid[6] &= 0x0f;
> +		uuid[6] |= 4 << 4;
> +		uuid[8] &= 0x3f;
> +		uuid[8] |= 0x80;
> +

https://docs.python.org/3/library/uuid.html


>  		uuid_str = array_to_string(uuid)
>  
>  		print(set_yellow('Joining with UUID ') + set_green(uuid_str))
> -- 
> 2.26.2
> 

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
