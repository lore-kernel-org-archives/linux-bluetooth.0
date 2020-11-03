Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1192EC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06DE22384
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyBcwqwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgKCMKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 07:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgKCMKz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 07:10:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524DC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 04:10:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e2so12538791wme.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 04:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vazudBETn9WMg30kdyh1Myx1h4A/gWU0W5rOQVap3Vo=;
        b=fyBcwqwvYvPzUzva531q9GwMWzv9aOUFF+rifmn7gBfy1XaNm89D8l+7dTQD0guddG
         mdbOTlM71CLLDaKyFVP6xbAF6AXem6chpkNkKqhSuBybRWjFuGtsbSd/0Mfa9Getmr85
         bT0fD01jsjDNOXzTFekX7z6nISRl9gF/y29KkXak728SizVEFBHFlwST6snaOOq53gj2
         T5sIpTGJiscymUjtXqC8EO+ul9s1wKywD2nJ+amhY9j5WRk5+r9O1mon2UuBkFouMF8/
         40glgUpUYw4cciJWNIY8FcuBSGzHsn86AMuos6/GKZ8Mogp0Ye+7Fa0pLOTQapsBw9v0
         giBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vazudBETn9WMg30kdyh1Myx1h4A/gWU0W5rOQVap3Vo=;
        b=ghxs90Txvn84Z/0zGSq/iBi3Kmbco0oZpzivnvA5tDHB7ppICERdcH4UAD/vgqTmKZ
         1KBF1O91bUz8ApGogIqkidewdzsY1VjDBjqRenPMgij9w4DNcCkFkAxu8c6Qgh4WPJ+R
         63xS8UkqJEVpSQ8Qbr3b5Xaph1zD/4WyU7xGfBktqevbO912cC12Tsv2j9wjq/KIdJTk
         eYMLc6GcH7OpnYc5UOy3RispoaDapg9bf19DVmGTedTCmDtSgFyMo/mXqEqAXUlijG/m
         3XuGzOPeP7nk54Safi0lSYHsk98ed9CT4dEcEnIr6ajEwCVVDWH/8M5Ty6e2kz18hHFN
         1FHA==
X-Gm-Message-State: AOAM530YtenouEdbEORIjYJzYFXSmIl8B1tfuTTmhZkr3Vy3pDLXz7cU
        +ghq850Lg5fleeFtsld2+v9gSglcGKZs0MT0
X-Google-Smtp-Source: ABdhPJyA9S/E+w/UMrhjjerjRU3v9+71kA2T5VgrGDP08KpYVt9iRrYeVeRn0olJV040mFJZ4idPxA==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr3210733wmh.41.1604405452469;
        Tue, 03 Nov 2020 04:10:52 -0800 (PST)
Received: from jurupari (firewall.seitwerk.net. [80.155.46.66])
        by smtp.gmail.com with ESMTPSA id z191sm2709286wme.30.2020.11.03.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:10:51 -0800 (PST)
Message-ID: <ecd1a31bb0c26947cce23a9c473fea834205a67e.camel@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
From:   Joschi 127 <127.joschi@gmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, usharma@chromium.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ujjwal Sharma <ryzokuken@igalia.com>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paul Stejskal <paul.stejskal@gmail.com>, usharma@chromium.org,
        ryzokuken@igalia.com
Date:   Tue, 03 Nov 2020 13:10:50 +0100
In-Reply-To: <847879c75cceebee9f2d414089b527cb5dcdcece.camel@gmail.com>
References: <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
         <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
         <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
         <20200516075340.3z37ejs3fuhctunl@pali>
         <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
         <20200518165011.jfarrp5mtqoy3mqz@pali>
         <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
         <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
         <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
         <20200604204343.eor47oe3fbzf6rbv@pali>
         <20200929210452.bus2qqbikvu2xtwy@pali>
         <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
         <847879c75cceebee9f2d414089b527cb5dcdcece.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Am Mittwoch, den 28.10.2020, 21:25 +0100 schrieb Joschi 127:
> Am Mittwoch, den 28.10.2020, 11:29 -0500 schrieb Paul Stejskal:
> > What can we do to get this published?
> > 
> 
> As far as I understand Pali is waiting for feedback for his updated
> suggestion from this email 
> https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/
> 
>  with this patch attached 
> https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/1.2-sco.patch
> 
> 
> And as soon as this approach is confirmed I guess he could provide a
> new updated patch in the required format and updated to the latest
> mainline kernel version?
> 
> @Pali: Not sure if I got it right. Maybe you can check yourself and
> confirm or correct me if I'm wrong.
> 
> Thanks to all!
> 
> 


Hi all,

sorry for pushing. I really think this would be so important for Linux
desktop or laptop environments.

What can we do to make progress on this?

@Pali: Can you check if my summary above is correct? What has to be
done to finalize this?

Thanks very much to everyone!

Joschi


