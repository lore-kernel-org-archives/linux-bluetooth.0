Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB99C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B4761353
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 13:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGVMt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhGVMt1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 08:49:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1944C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:30:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b29so7308249ljf.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K50UM44t9GAaQZgPnCYhVE7fSQ5Q/CV9jvKhzEHueaI=;
        b=t1ToD0bXy8cKUXOxyF97QxKVQREthQFd6bTC3wZ3lq3S+zXVvUFaaC0eqEr1Z3DIRd
         2IVO3hkyAk54pDRziuYS4sdm1hXFicpLQQFC4gfSPOXFV4+lLw0+jxP3mPGDe51S1/tE
         f2TRPqAwcqhvsW3VpAj+lnWaIwIDEkXpZ7QiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K50UM44t9GAaQZgPnCYhVE7fSQ5Q/CV9jvKhzEHueaI=;
        b=USBBS5AFmsURI91jzWgN7BHjMV8/9In4w2vg2Nv2/wc3fEDQ76w5fYaG9fj0H+Kmmw
         58cBGOB99iHDPpKIkuLRywSqA6rgLMHkM7DJwiBGbjLvj0dml2vRqB33o/Px7QEAX8Py
         sfO85z6z2G9/oH2myy0ZyzlK5AJCZ6F2wcCjO8zakMc0VAJS4U5au/h9OSm0QuXouNDC
         FR22/QuX+yaud/ukqeqi5unDmU0RU+k/PcJWtSIKUAEZN/KICRIRSbqHGHnql75ugzPt
         332Fv3X/B1uZptGMaIM0xOVAlGd1XKdynKJfzwPc44hdUIaXbaR9UYy0nD59j7VNY2kx
         clnw==
X-Gm-Message-State: AOAM5313foWIqWQQOE4NK4V1wGhD+t4dVJcBvg/VWzfEmVAHlq3gRCQL
        zmwjQUS9VArBQbtiFO/fGlpglg==
X-Google-Smtp-Source: ABdhPJxtVQ1oqIoMQ2cfPLs3zR4SFW46eSHCDNb24NiBOlPMtqPlEQH+ZlEaJPezhs9ET7BWYqGzQw==
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr24692555ljl.227.1626960600279;
        Thu, 22 Jul 2021 06:30:00 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id n4sm1926092lfu.113.2021.07.22.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 06:29:59 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:29:57 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>
Subject: Re: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT
 3 for WBS
Message-ID: <YPly1RR8V33T3odj@larwa.hq.kempniu.pl>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

Thank you for your work on this patch!

> Some USB BT adapters don't satisfy the MTU requirement mentioned in
> commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> and have ALT 3 setting that produces no/garbled audio. Check that the MTU
> condition is satisfied, and fall back to ALT 1 if not.
> 
> Tested with USB adapters (mtu<72, produce sound only with ALT1)
> BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3)
> RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling ALT6).

Commit e848dbd364aca44c9d23c04bef964fab79e2b34f causes garbled mSBC
audio on my Bluetooth adapter (8087:0a2b), so I gave your patch a try.

Unfortunately, the patch in its current shape does not seem to be enough
to fix things for this adapter, which reports an SCO MTU of 96 bytes and
produces garbled mSBC audio with ALT 3.

For the record, reverting e848dbd364aca44c9d23c04bef964fab79e2b34f on
top of v5.14-rc2 makes mSBC work again with my adapter.

I am no Bluetooth expert, but I will be happy to perform any additional
debugging and/or testing.

-- 
Best regards,
Michał Kępień
