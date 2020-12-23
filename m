Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9BEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F97522202
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 18:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLWSez (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 13:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWSez (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 13:34:55 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3CC061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Dec 2020 10:34:14 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l207so46760oib.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Dec 2020 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSp26sts64PcUDmaIsFhMyZSSLpOnNFlWritDLrxujc=;
        b=h0TJcADztBuBdW1P/6EJa/vJ1h0loP9aGff5D8+izQuPm5wp07b/5FcoKchlCVzirZ
         sz4q/ka1ZE2mNMl/RvaXBHRpWLQH34YUrFnJfp+We9rwDO5FxzKi+WfRC4mSUfl/0wPJ
         sRzVSRRW7GGk4Of2pSxdKgsBHe9EsV9n09+8CnLea5YlLFb8fNIoUddr3O4koH//pY3F
         LJkLQyhsbx0p0yZFFZj6C1OuR0/+IClRvBaBs5Mb9mfQs9KDMVNAj3ukUMamjmkRxr+n
         R5ocd6Zg18+ATKC+2Tt/c5JchCp14fP4txG7ml3xVuMhvzC+KSOAdsu3CphKhIAozZU/
         Kwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSp26sts64PcUDmaIsFhMyZSSLpOnNFlWritDLrxujc=;
        b=Cf1YquyJxFZXN9CzcJeY+lkrkGQUDQ6jhDHJaHrdspFho1r1TDJjDnLBawG/S75ZT/
         8hNAbOX+bDEEaQ/Isg0gNfCUxCq0qUoMqC4rknnyg9tcJkPQ7puk7dwzyvUP/TJt8+I6
         z5yROSu7+UyRq4I6yj8Ihax4filfb87Q/8VchzmY/winnHETCiISxNltvU6KUw2Tx9uA
         00RrAdZMBNkkcI8SHOC55y22y0nXPrj9MBgwnh7+AKLSmY0d/BJbWK00QKYgp4rHzE+q
         iAUeFeF1L1cwbpJATh9m80Sxr9gZuilL2KCv5SYDobZkPRe79J1J81xTiP+v32Y+Pm2B
         g8oA==
X-Gm-Message-State: AOAM530rRzcTg9aAli8JvSUWuJrz/F2dCwjgaS1pcZ8iMDKJyVOieyhp
        6a92P0GUiiuVAY/Ht6+ZN+lBxg6MrIoq+ReFQg8OHXkN
X-Google-Smtp-Source: ABdhPJwqkvzMAuya04OK7ysSgKxYNIoX/ZtWNBtUEfwzM/czNTHyzeB3bvP0gTmQH1hxYy3PbO9L+vELsaC8shmrLXw=
X-Received: by 2002:aca:efc6:: with SMTP id n189mr721377oih.161.1608748452708;
 Wed, 23 Dec 2020 10:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20201223002633.187612-1-tedd.an@intel.com> <5fe29c85.1c69fb81.c9750.b446@mx.google.com>
In-Reply-To: <5fe29c85.1c69fb81.c9750.b446@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Dec 2020 10:34:01 -0800
Message-ID: <CABBYNZJ25hgKDmru4NAFk0rwdMUSU91goN9_cm3wdAEvVM+RMQ@mail.gmail.com>
Subject: Re: [1/3] tools/mgmt-tester: Update sample data for adv features
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     hj.tedd.an@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Dec 22, 2020 at 5:28 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405549
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
