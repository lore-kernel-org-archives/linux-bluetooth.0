Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA83DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB28A610CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 21:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhHYVRP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhHYVRO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 17:17:14 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EABC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:16:28 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id k124so229850vke.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR4ElYkdT7tPeYqK/2oAUQUgsahhSTlDjSrsO8TV1uE=;
        b=lCFvTVnp/bk2G7iwmvlnoOYFbjJoHt4BHTipJzs+nIGfpHO34aLE/ap9ojr/0Innx3
         hlkqRj/a7IN2HJY+X9PPqXo9iG+9Iw6ud/P/XnK0V5cYiaNn8+RPWZFX64d8Rn5JDWj8
         CXtOL02LGzGrhGfr0wE524xg+8I8Pv4KzuULAcPC229e21R0dDhqZPa4hNWjeodzR8Kq
         aoe8AlKrwihnM/wbHsyw40N3Ac1AWptgMv/gwjYrHMYKeCvZsuz8UxB7kcy95cpCWbUh
         7iEPLWtHmIK+FeMpl99EYssi6ScBMfiOwgmdLNxsLcFCq8aobMlgM4pvlhddahlJ5mJc
         a5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR4ElYkdT7tPeYqK/2oAUQUgsahhSTlDjSrsO8TV1uE=;
        b=O3FljgtL6MqB/IvnKSJdGC4tydVl8itKcsiM/lqZVypZIc3TkMTKVs1t5ce48WSz0Q
         /Q5lQtjeppOKI85igValkLWhbQvJVTLYuMDPrAvoNgUjNRWW6wyzCxyX5tgYFu64Wars
         4atjybuwc5iG3Ue/LQ9uTpw8GldNfoyzHR9OkEWbsbf+mRRF35qDRtLRybXkXQDzMHpq
         IgJu5o++tPdbRexRFHEYoX4lDSdFm5bV/JVEXJBNFs7GUpa5FET2nsj41A7mqZw0QmSf
         RiUju5CyYxlXoSLiC4syIAWmc0rPD9932yv5MFf63MPvjgtVOm3oKWaJ8pjl0cOXstQU
         I7Yw==
X-Gm-Message-State: AOAM5332LYNThuhwJx1wem5+MZHpXjJuL94GxRWBmhyklH/x9Edh7D8a
        pzhNg8PTou3s0sy5vY+wJUdQwfuEXBCkcw5Xe8yWih7x
X-Google-Smtp-Source: ABdhPJyvT1lTViNueK2dzhT8kecaUAnUcsMQoVsaMZoOfKmJRi5PnRJ5nLITa1rzDvFnVf/iYxWdl1DUObtR+6GMWZo=
X-Received: by 2002:a05:6122:925:: with SMTP id j37mr298410vka.21.1629926187530;
 Wed, 25 Aug 2021 14:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210824225202.826941-1-luiz.dentz@gmail.com> <0028fab2-5707-8011-d3f6-d14c7337d449@lechnology.com>
In-Reply-To: <0028fab2-5707-8011-d3f6-d14c7337d449@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Aug 2021 14:16:16 -0700
Message-ID: <CABBYNZLUo5wAATmUVYNoV-Nd1cUjC_zN0+tQQ7XSYywe6YSGcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Remove GATT Attribute when device is removed
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Wed, Aug 25, 2021 at 10:44 AM David Lechner <david@lechnology.com> wrote:
>
> On 8/24/21 5:52 PM, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes the GATT Attribute cache to be removed when device is removed
> > just like SDP ServiceRecords.
> >
> > Fixes: https://github.com/bluez/bluez/issues/191
> > ---
> Tested-by: David Lechner <david@lechnology.com>
>
> But wouldn't it be better to just delete the file altogether?
> This would prevent any future sections from being forgotten to
> be removed as well.
>
> I sent an alternative patch that does this: "device: delete
> cache file when device is removed"

We do like to keep some details such as the name, etc.

-- 
Luiz Augusto von Dentz
