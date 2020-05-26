Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B015220723
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhaJhRtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgEZO5w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgEZO5v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 10:57:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340BC03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:57:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r125so12455109lff.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dOBMXdnmfj6Q0O+nJ9WjTu7+Mm1dWjFRhqxkQonC8k=;
        b=MhaJhRtxTu129l8Ry9xvBqt4zolq0y28S7AZZtx7QMvhtqS13ysYgjnSoKSddrff8z
         Aawn8q6OVYEZCyHULq6yS/FhMhpd9CpJ2AkNNFYx+TZFwfnNjpvlisyYy8UBhcunh4TR
         Q/sayylz3xdHPnixpMHt6tVZV8o++RS2l74Z4vWNdSr16AypPyzx/XcSSadlgE/pzyK0
         Z/8utcqqjSMRvj0W0teH/ZR6XZOb2ULaesG/zNBA0PDd/3R08OgtVZD1SumufATvy1Bd
         haXzGWQM3ih6XBFP63YxYRHoJj87iH63sUZeqYI+8A63+9L5lEY0c8Yrs1AsNlnoKHKs
         9oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dOBMXdnmfj6Q0O+nJ9WjTu7+Mm1dWjFRhqxkQonC8k=;
        b=ik75aaUIFg/F1B3bMCfV/xqKUl5wts3zms6mgD074dMUoFPFxktcBmq7Wh4j0Hl7JL
         E1i3++3mnK5qNGBM21MLAGF0Zfoyu7O6VpXY7rY5qRw3AiZRqVS8wogjPODtLvC7AZIi
         9H3y1fPz4aQSGME3wx0B9aN/r2wn0vnDfj8XkurAHzCa2r1BJslvFlS7kzj+IXGCoKLX
         TAte+mx1aGp4kBI0QQxrS3js6Fv7K2yfANKxS1yxDj0q2Fsc/Lllp9TiniztFUOYR0Tw
         0ozJuuhTebFvVXcBvmvfQSAGMmyApCNB5TmOG2JP9NmHIuk9UQnif1gJNDXBaGo53sES
         Z7Uw==
X-Gm-Message-State: AOAM531AktN7W0D7Z7hBcqd5ukgUioXnBacHEHKgj/+hLBmlEXdynw3u
        wVQvq+CABOc1F6ab909Uq1SM4N3oQp1bC+DiYrh+6w==
X-Google-Smtp-Source: ABdhPJy0DEKO9wxhb/nEaemK5RpQbAuNWluGMqr5McN4pINx4JOy2iE12c93QdsU50QQdt6QL2agWR+Om6yYRrLswWQ=
X-Received: by 2002:a19:c751:: with SMTP id x78mr728559lff.82.1590505069163;
 Tue, 26 May 2020 07:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
In-Reply-To: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 26 May 2020 10:57:36 -0400
Message-ID: <CALWDO_W+8SDCOn_b_4_FB-KR43xjyYB8u+kSgQ1YVx1Mp_FG=g@mail.gmail.com>
Subject: Re: UUIDs for every single physical peripheral's service and characteristics?
To:     Christopher de Vidal <cbdevidal.jk1@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christopher,

The term "unique" will vary based on context.  In the context of a
Gatt Service and Characteristic, it is intended to uniquely identify
the "contract" defined by the service/characteristics.  For example a
Temperature Service would have a UUID that universally defines the
contract/interface defined by that service.

So for your custom service, you'll need to define a set of 20 128 bit
UUID (16 bit uuids are reserved for SIG defined uuids) that uniquely
identify the contract that's defined by your service/characteristics.
The devices can uniquely be identified/addressed by their respective
addresses.

I hope this is helpful.

Thanks!
Alain

On Tue, May 26, 2020 at 10:38 AM Christopher de Vidal
<cbdevidal.jk1@gmail.com> wrote:
>
> Help a newbie? I'm seeking to build a niche product for sale, a
> Raspberry Pi-based device which during the initial setup acts a BLE
> peripheral. (Python using dbus to Bluez.) It has a single service and
> 19 characteristics. I get that the first "U" in UUID stands for
> unique. Must that be unique among each physical product, or may it be
> unique among the product line?
>
> So if I sell 1,000 units (which would be a success), would I need to
> obtain 1,000 service UUIDs and 19,000 characteristic UUIDs? Or just 20
> total, for the entire product line?
>
> The goal is so that the iOS/Android app can have that pre-set in the
> code and quickly discover the device, pair it automagically.
>
> I suppose the risk is of a conflict of two similar devices which are
> in the same vicinity of the phone, and both set into peripheral mode
> at the same time. But that would be a minimal risk which I could
> accommodate for.
>
> Christopher de Vidal
>
> Would you consider yourself a good person? Have you ever taken the
> 'Good Person' test? It's a fascinating five minute quiz. Google it.
