Return-Path: <SRS0=4Cvn=PD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A82C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Dec 2018 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345532171F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Dec 2018 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtykMLje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLZGXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:23:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38331 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeLZGXn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Dec 2018 01:23:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7215021pgc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Dec 2018 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mflq4Pjnyn/7adHXTA6Ektc1kttwO8pVE6xndZe56/k=;
        b=QtykMLje4R97yQvxyoJrmhohPtoDLv0DbgDRF4jz9EeN0u5/JSkqZilmBw3wJ1MVSn
         tKnd3X2mylskmND7egSIZbm1DC6S+2+4NnR/qVS4ydR5K6qx+TUSr4uvX/4EfWYvAmbs
         Fvafex0paGqs4jQbUezA7z8pYRzTCwiVGuNIIn5jgcraLiTYKF+w18F8rbmF6GENC2pp
         GekSxaAQe3JyyMsqIV8UG7258kn6gLOOfE7TQ07Yu/O5+6NCs2pX8pjO18QruBJPxqSI
         k8gKX5IZtTlARdvn5oZn1Mzj4un28C4Tc56xpmRHZ1ESbsWVzz9EVGQRE4orefcqBW9H
         M5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mflq4Pjnyn/7adHXTA6Ektc1kttwO8pVE6xndZe56/k=;
        b=tbKyoYINlWMUxQI9PNingCtIUiPJBhe7RFeimvG4xadxhE7vGvt5uRrKevgOXbbifn
         v9locu3L9Z8tsLRFxpiiN4OVjTpjiqgvHEM3VYWMXb4N7cnIjqLslOkIZKpP5bFnOaCE
         9GY6l9xke7Mw81q850Pyb5fcrF77raZIrOsy5dHzlP3B1O4c+VeYtWkbss4jbHITOIK0
         igfli005VKEgTGoqy3S1aboDb9XW/Y6oVqkIo24TeDXR6XHh5ZMi8OHQGZSiOK9nuUIV
         Ueo1kyyyzOEbtBplBTd6Rpu3FquDVzZe7dzOXgAYzR2Bz9Zv86SLKD70hGINhXxM0mIQ
         vM1A==
X-Gm-Message-State: AJcUukedG3Qs0Q18o6+F0Yfe1r+B37Ky964H6xUIWWxWe2T8b1QgCCeH
        wioJemyZR/hbl6CYwH20IYvgUtU=
X-Google-Smtp-Source: ALg8bN5vcI4L0HDuj4OGCygq4EnRV4WM/WakaXgSanAazMcWZ/OMo09XtxzkQ5A0qgdIYQPhw1fW5A==
X-Received: by 2002:a65:448a:: with SMTP id l10mr17902080pgq.387.1545805422040;
        Tue, 25 Dec 2018 22:23:42 -0800 (PST)
Received: from [10.0.0.16] (c-98-210-227-32.hsd1.ca.comcast.net. [98.210.227.32])
        by smtp.gmail.com with ESMTPSA id t3sm43211704pgv.31.2018.12.25.22.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 22:23:41 -0800 (PST)
From:   Cinaed Simson <cinaed.simson@gmail.com>
X-Google-Original-From: Cinaed Simson <Cinaed.Simson@GMail.COM>
Subject: Re: kernel requirements
To:     Barry Byford <31baz66@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
References: <7875abc6-0dba-4085-32a2-733e70661427@GMail.COM>
 <CAAu3APb38QxPgXN-CwhmrK8ecQ5OSgKdxkAbe5jL4dWVitvZkw@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=Cinaed.Simson@GMail.COM; prefer-encrypt=mutual; keydata=
 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
 FDV1prVcSN66lXaF
Message-ID: <f41d8d73-483a-2f77-29ed-ab94f6526579@GMail.COM>
Date:   Tue, 25 Dec 2018 22:23:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAu3APb38QxPgXN-CwhmrK8ecQ5OSgKdxkAbe5jL4dWVitvZkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/25/18 5:09 AM, Barry Byford wrote:
> 
>       Does this tutorial from the Bluetooth SIG help?
> 
> 
>       Learn how to Deploy BlueZ v5.50 on Raspberry Pi3
> 
> 
> https://www.bluetooth.com/develop-with-bluetooth/build/developer-kits?utm_campaign=developer&utm_source=internal&utm_medium=blog&utm_content=bluez-on-pi3&_ga=2.37082720.1552822759.1545736153-974409013.1541013728
> 

Hi Barry - yes, that was exactly what I was looking for - thanks!

-- Cinaed

> 
> On Tue, 25 Dec 2018, 10:25 Cinaed Simson <cinaed.simson@gmail.com
> <mailto:cinaed.simson@gmail.com> wrote:
> 
>     Hi - I'd interested in playing mesh on 4 arm processors running stretch
>     with 4.18.8 kernel and the latest git version of bluez and ell.
> 
>     What loadable modules do I need to enable in the kernel for a mesh using
>     asymmetic encryption - similar to the ssh Diffie Hellman key exchange -
>     where the password is similar the PIN - at least that's how I
>     remember it.
> 
>     And I believe I have to enable other modules too since some of bluetooth
>     user space stuff has been moved to the kernel.
> 
>     Any help would be greatly appreciated.
> 
>     Thank you.
> 
>     -- Cinaed
> 

