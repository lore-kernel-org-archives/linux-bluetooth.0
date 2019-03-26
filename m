Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D460C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C42064A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dlWjHUXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfCZStD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:49:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34170 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfCZStD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 14:49:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id j89so12122787ljb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2019 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtzN9uuKvwgRndtv0vOLne1QwtbZ6Hku5H3sjw5YEJA=;
        b=dlWjHUXV228mPKh9HrSrNE4Uf7hO/zOYy6X29KAne7+Jf+RT2rS97upskcjWK1Td9s
         uYf3JZjygel9u4Rs2HanylRlsZjYiOYwAnnJjGRzOKmcmg79641DBZxhu5lOPWzgFWCq
         6HY1M70AXIEWY2qQwqjYyxo1J0U/PotL0rV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtzN9uuKvwgRndtv0vOLne1QwtbZ6Hku5H3sjw5YEJA=;
        b=RE6Z59QJTJZtnGyTfSDVmk9ZkpSap9g5Tu0I+ucNSg8p/MtZLsnUZdIl2/7ppK045x
         nrUt/z7T0Gfp8/kDrqzEIVT1UD5xwc5aUxSZJHvMDI6xfyKfKOoArHPXiM8JyUau28ua
         1eRj7kWclNZPDH4+QhFP9A9mOCs5nKHv76EATmYGn2M1MQuW2ta5uUL6my5ATm6NTeu/
         NGHvYw06dXJufIPH/lNlIzbpLfrR0x9r54iJ30Pmmp+otxT0VW/5pMdkq5LTsxtCr8ir
         +sEcl8BrPec1nHYnJylYSx0cQYDNDOXnQBtmVRm8jX+r5vk2+vpoB4v1Ksez6TK3BMWO
         MZ+Q==
X-Gm-Message-State: APjAAAVY0CLKER7e5WBvgrSXehEf0V5cr9Na9z0/BMnvezdI3naEqHyL
        f+giMqlVzQ+T0qGlpS09G9ARcJ3FXMo=
X-Google-Smtp-Source: APXvYqwQnYVdgC4ipLZQwA4AXIAYRZ70i017JJKORtfpxi60jXrHvkG81KwCopjikUXSbFcl6akxNw==
X-Received: by 2002:a2e:9e9a:: with SMTP id f26mr16977378ljk.67.1553626141334;
        Tue, 26 Mar 2019 11:49:01 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a11sm4320352ljf.68.2019.03.26.11.48.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:49:00 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u68so9482352lff.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2019 11:48:59 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr17034550lfn.139.1553626139438;
 Tue, 26 Mar 2019 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190222003051.127006-1-briannorris@chromium.org>
In-Reply-To: <20190222003051.127006-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Mar 2019 11:48:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
Message-ID: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 21, 2019 at 4:30 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Badly-designed systems might have (for example) active-high wake pins
> that default to high (e.g., because of external pull ups) until they
> have an active firmware which starts driving it low. This can cause an
> interrupt storm in the time between request_irq() and disable_irq().
>
> We don't support shared interrupts here, so let's just pre-configure the
> interrupt to avoid auto-enabling it.
>
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Ping! v5.1 is enabling wake support on Scarlet, and without this
patch, that causes interrupt storms at boot. Please apply this patch
for v5.1-rc!

See also:
https://lkml.kernel.org/lkml/CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com

Brian
