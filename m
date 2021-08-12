Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C3C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 05:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E2E60FED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 05:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhHLFhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 01:37:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57810
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234377AbhHLFhq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 01:37:46 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 461F93F0FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 05:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628746641;
        bh=lLP3PSQ1cyi3LClcOEB98n6hc5vl9XavCsPRRMlIR60=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=R/RVHvfx3j2arhmzpcvWWxcXNI2ydCP9BDS/LtZZmKrxVoZXWtHyiVTqf2uYiPnld
         HotHtC7ru4TYDVkW2GHB8vqDvsJDGjfTv0ENwsVjxAX4TucRBH2LcqtR+kG69HqORO
         OrAQd85Ua/oQeRFj3t3B+DexoWDl8afbfSZklu/VDlXRUj18OjC8nbZS7oFXEL86D8
         ByTAhpKrRVJGL/dID9b+RqlYHy3tqpdfRXbIZvNgR2bv1qbtdcYQvOM7vKDFA97FQ3
         9wUE98cWBvGiqNgUApg+zu5I4BxQunGcF0fT7oGu+DStqAroaR5f3O/uzgjIlmOWee
         TS9h9+jhQ78Yg==
Received: by mail-oo1-f72.google.com with SMTP id w21-20020a4ad0350000b0290289b9284ee2so1661178oor.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 22:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLP3PSQ1cyi3LClcOEB98n6hc5vl9XavCsPRRMlIR60=;
        b=sdopFsKssNKBZQfoYcyqF66AaiLqeAwwjCDPTJjmziyz2Or8LWnK4+izTS9FZQwTGW
         r9wNRWWBduCh/H5GeSgKX3yCPRxPgq/3Cd0i1Rb1sZSZ4f6OlOOB47avouDYx6fIEz9G
         OV0NGr3PoNcYvfo5Flv/RieZAxzqdRg0/8Qo1MxqDdGp50L/Sfps79SwgKoAsWNUZekW
         x/DL78cDd/zhSr1slwOQxucdRfr7tI+WqmTJn5B7N6djXCBMfk2TpQdl+RkY6hJqf8I3
         xBZdKDS79EjaAC2culsdBpY2ln8GFsmnKma75ddZaCzf+fzoycauAZQlSsw2qYPtZok5
         rkTA==
X-Gm-Message-State: AOAM532WDwWGVb1Deq7eOYEN4Z+P5LrP8F6u4bkEDGmDERVSxq0gKoPf
        lKN81qo0IJFZaDh7LoOAic6bdwE4WImrdnACbXFYAWWaZRBWEiCixnC7LKJF/jzaLruZgvjOQu0
        ZhV8LvW87h+3pn0fKA0lcoLF6avg8OaWswMZzx4p50AK8ruOpU7rAT5pYRNUOBA==
X-Received: by 2002:aca:34c4:: with SMTP id b187mr2051540oia.139.1628746640188;
        Wed, 11 Aug 2021 22:37:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO0aGh6aGuBGFSPUJ1KmdjnWuWBwT62mHXtoJD+Vh2YxX7I5H1TaPq6pL5kWcNm5a7qcE/GBEKFY/LYmWnVGY=
X-Received: by 2002:aca:34c4:: with SMTP id b187mr2051524oia.139.1628746639935;
 Wed, 11 Aug 2021 22:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210812042305.277642-1-koba.ko@canonical.com> <4374EE78-86B9-43BF-B387-8C51C15CB943@holtmann.org>
In-Reply-To: <4374EE78-86B9-43BF-B387-8C51C15CB943@holtmann.org>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 12 Aug 2021 13:37:09 +0800
Message-ID: <CAJB-X+W22r8sDhKj0LwtLCu9h2f1f=mX65nQtAN9nr=UujjDSw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: msft: add a bluetooth parameter, msft_enable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Aug 12, 2021 at 1:29 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Koba,
>
> > With Intel AC9560, follow this scenario and can't turn on bt since.
> > 1. turn off BT
> > 2. then suspend&resume multiple times
> > 3. turn on BT
> >
> > Get this error message after turn on bt.
> > [ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
> > [ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)
> >
> > Remove msft from compilation would be helpful.
> > Turn off msft would be also helpful.
> >
> > Because msft is enabled as default and can't turn off without
> > compliation,
> > Introduce a bluetooth parameter, msft_enable, to control.
> >
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> > include/net/bluetooth/hci_core.h |  1 +
> > net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> > net/bluetooth/msft.c             | 30 +++++++++++++++++++++++++++++-
> > 3 files changed, 46 insertions(+), 1 deletion(-)
>
> NAK.
>
> This is for the Intel guys to figure out. Otherwise I am going to disable MSFT extension for AC9560 completely. What is your hw_variant for that hardware?
Would you please guide to dump hw_variant? thanks
>
> Regards
>
> Marcel
>
