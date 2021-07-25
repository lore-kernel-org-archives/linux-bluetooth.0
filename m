Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A21C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 05:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E88560F11
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jul 2021 05:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhGYFGu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Jul 2021 01:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFGu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Jul 2021 01:06:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E27C061757
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 22:47:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u20so6753087ljo.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Jul 2021 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8e7Gp5HxeOpcehiQLPyIgAHyPsg2I7uQHfjxb7bdJOg=;
        b=AHGJNfQBvuldmUYqRtpbbmca45b91Yzv0LyI8Ih0CieTiamu00hq5JZ70xw22rgtob
         dvHr5aCOKDpkVL+2OYFZ9D8prONdzJKmSUYfd2bn6rxauCP1/t3oWx5otmdhpU32XLhI
         8q7OfSDivdw0iAZyC8JPRle3OvjZL/6BZoP9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8e7Gp5HxeOpcehiQLPyIgAHyPsg2I7uQHfjxb7bdJOg=;
        b=JsBmk9s4bLglV3t973ZhG89AL3KG9xDmSCEN1enrtZ9vnmzB/GuAZARtjZN2+Jk7pv
         JXy4qqlD77f52z0WUmBR0WZHq3oz/japJN7+kBWXlbyqOi7uOqP+09BNZj/IOQCVQlbN
         m3E0k2t1KA1yp68jm2Ry0KFZ6NnuqHWaVTSoFM0KJ95IxpW+IuKtUFZ5i9tUCIKKbk1l
         qgxgF4zFieGcMh7W6f/O1KXbdxmXAD2Vjk6LCGdhCBPrvWEXPNBR/zjheGb/kQMGdrWW
         XJVwlzijDwmH07jJyDNcnD3vqPU/Ptdo9WhMk2v+VK27gHzoC7yOJvAE1asn2TIyvb+n
         D+7g==
X-Gm-Message-State: AOAM533czRiVTMinCwg/YdkQ2H8dibikxS/eEWBecIS9Cth6bssnD1sp
        m7ib2xMm8D2cQVgbj2t/BnWn4g==
X-Google-Smtp-Source: ABdhPJylGOR2pghbRozf84rafROJhprK2jzuEOeD/hzpjyS0kqGTyAZr4mT2kSaFW7kYmg7Q6kW5vQ==
X-Received: by 2002:a2e:9e44:: with SMTP id g4mr8379000ljk.289.1627192037988;
        Sat, 24 Jul 2021 22:47:17 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c30sm2660393lfv.19.2021.07.24.22.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 22:47:17 -0700 (PDT)
Date:   Sun, 25 Jul 2021 07:47:14 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pauli Virtanen <pav@iki.fi>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@google.com>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: check conditions before enabling
 USB ALT 3 for WBS
Message-ID: <YPz64lj6xXyXzGOB@larwa.hq.kempniu.pl>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
 <b86543908684cc6cd9afaf4de10fac7af1a49665.camel@iki.fi>
 <872F0B33-594E-4BD7-8B75-EA96DE8DBA8F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <872F0B33-594E-4BD7-8B75-EA96DE8DBA8F@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> > Some USB BT adapters don't satisfy the MTU requirement mentioned in
> > commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> > and have ALT 3 setting that produces no/garbled audio. Some adapters
> > with larger MTU were also reported to have problems with ALT 3.
> > 
> > Add a flag and check it and MTU before selecting ALT 3, falling back to
> > ALT 1. Enable the flag for Realtek, restoring the previous behavior for
> > non-Realtek devices.
> > 
> > Tested with USB adapters (mtu<72, no/garbled sound with ALT3, ALT1
> > works) BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3
> > works) RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling
> > ALT6). Also got reports for (mtu>=72, ALT 3 reported to produce bad
> > audio) Intel 8087:0a2b.
> > 
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > Fixes: e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> 
> before I will apply this, I need Tested-by or Ack-by people that confirm that this fixes their issues now.

For 8087:0a2b (with broken mSBC audio since e848dbd364ac):

Tested-by: Michał Kępień <kernel@kempniu.pl>

It would be nice to get this into the stable tree as e848dbd364ac got
there in v5.13.3 (as 15407b14e27b) and v5.10.51 (as 05298f1733c6).

Thanks!

-- 
Best regards,
Michał Kępień
