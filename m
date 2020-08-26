Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF03C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B89C2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YE0+JXZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHZUUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZUUf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:20:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F1EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:20:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f24so2893265edw.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FyQMjwrR+qRwgsTKniSyNPE9tsU8qToAWdwd9jIpxg=;
        b=YE0+JXZ5I6p6VvmcTEaMyNIjoxXKBn76HlWhC0VHuRKEO2r4wJwLb+dD0yV7zkLQOR
         pyGV1q5xxrS62T0DV+TbIHzGfQyjcGpvE9wBljO8JW+uPchwBAM62shW0JrCjx0arZX8
         dOCQSypaoSJHZWOHN8aXnc29UvrTTWl79SmVzvUx3SKjAldDmcMYdrBVAYZAu+Csl8So
         u2zrNabp6bHcg2liyjT0c/+2mLazSiHAh7vES69jx/jaGT8T+VBo/+YQ0zECHV23WLuP
         e+0fII1iKUJU6y+v0UUfm4jyfJY+jW0vW7QR3lYjOBy9vAQofAUY5nyd5tR+8hA+ixuu
         kJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FyQMjwrR+qRwgsTKniSyNPE9tsU8qToAWdwd9jIpxg=;
        b=OzpV/n11Cl8varc1UnAD+d7NPbVacHtXeWi2F2AJRwC30I7nWc3Txt4TLobqe0zxKx
         m+bnlVKeJSipW/DsksBeHlkBw/khKf7gdA1MIdLyDWZpQO4X0FxSVwqkvBE32+a4EdrN
         VkBMjQFMfZ10n12lCn6bHxDyO+a2VT63mHT5C9jcZ+E+Yyq4FEVUq3mKU2kIvEA7Bx/X
         Y0vwooj8PuZbftYkpw0dr9VYURBpTpC3kO9XxMzVzp6L3gsTNgw/FTicLOZVd2RwW17M
         4AAmnf4vn/e8QXgPE8O0GBo/nx5Ib/jompXNNijrNJJAS/fz0oeJoZzT1t97lpp1Tb3R
         yXOg==
X-Gm-Message-State: AOAM532Uc+m4vYx+hhMxiMOUg1qJCxKSRsQNPePP1bbGEkhCaWbBWBc0
        TQdq5pNQlidMvM2JYwpSd1+qFEiZdTwpStKofZfWDe9uwn3BLw==
X-Google-Smtp-Source: ABdhPJzziPcDQuz4TQjblMZD1JAXNMLMZpjQmJsS9Rx6AMjaqVgCdPZNzGN0u40sjDCVeQWUx6Dv6ENIvf73m5OaCmk=
X-Received: by 2002:aa7:df84:: with SMTP id b4mr16204047edy.75.1598473232696;
 Wed, 26 Aug 2020 13:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826201715.1911816-1-danielwinkler@google.com>
In-Reply-To: <20200826201715.1911816-1-danielwinkler@google.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Wed, 26 Aug 2020 13:20:21 -0700
Message-ID: <CAP2xMbsk8FO2KM-aBGG7gZoAsmJnmTk_7h+35JOb3bo0SZFKuQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 0/3] Expose extended adv feature support via
 bluez API
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers, I accidentally sent a patchset with PRE-UPSTREAM
commit tags on the commit headings. I have sent another version
without, so please ignore the former. Thanks for your understanding.

Best regards,
Daniel


On Wed, Aug 26, 2020 at 1:17 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hi Maintainers,
>
> This change adds a SupportedFeatures member to the LEAdvertisingManager
> interface, which allows us to expose support for hardware offloading and
> setting TX power on advertisements.
>
> Best,
> Daniel
>
>
> Daniel Winkler (3):
>   PRE_UPSTREAM: advertising: Add SupportedFeatures to
>     LEAdvertisingManager1
>   PRE_UPSTREAM: advertising: Add adv SupportedFeatures to bluetoothctl
>   PRE_UPSTREAM: advertising: Add adv SupportedFeatures to doc
>
>  client/main.c           |  1 +
>  doc/advertising-api.txt | 18 +++++++++++++
>  lib/mgmt.h              |  2 ++
>  src/advertising.c       | 56 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 75 insertions(+), 2 deletions(-)
>
> --
> 2.28.0.297.g1956fa8f8d-goog
>
