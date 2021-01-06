Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D636C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4E823125
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAFTGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFTGy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 14:06:54 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2EC06134D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 11:06:13 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i6so4004539otr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NUSwnDHd185CSWmLsq5qLO6OLxljmsLDyEBlJc7cmPI=;
        b=EyrtLEzSB+paYgOWluG3v9a0Uj2IR+5XL9zwpIracUbjzLPEPwkfVGG5P3Nt7ZzV8D
         8WbwMW6N41JmLOgHguGzU8hbhssBWEFr+22zPGD4ROhy/ZIVodw1DxAC2Q8H9L85+GhU
         bPvks/nzKgZM6yH4F7yAK/raJA+EBp9kc10wJPFqr0bV39rXVu86RaK32DX7xmQf0WqE
         XDV45lEX3QWhI5j16hPAL49JwFzR3PILq9jNL+6VQ9Uq4IS6WRsuEhpxwE8KxP1H2tYJ
         aUKGx38+hKT1dykYegiRRQM2bi6woeVZnZLRSwoybdORw4yldUxGqagnFyUhL15XXo5C
         f7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NUSwnDHd185CSWmLsq5qLO6OLxljmsLDyEBlJc7cmPI=;
        b=FnAlDAYV0k33AHnikIt8xqRUARvjK8rga2HWoEkkYbPW465L8c4dsrhywKa7l/9qH/
         t7lN+udZIKCW5ZR8058QizoOTEC48A53y1u93NbcmfzAbBPJdmhsdPrf1UfZwyC8uXFL
         hjgm49chLVXbPFVqMNe/SvLJUL5Q7kWfxmPV5eo8RDlTyaJbVX1tia6Lceg6vWNWssRq
         Bht4pb4vk4A7S32DESStPlKnzqVWbZihB2SIzIlx87dqrWH00SvICAzpxJ2oKUddKm21
         Fw3HPqLuefxofB2glHq7k8/7CROlXzuZuZ/rE1NXiqO7Abf67NC+2qqIYu3mxqOIvzoS
         Gx6A==
X-Gm-Message-State: AOAM530HIBxEpXC6HcZwhFFbLd6ZwnWo4iIkoOheMDSkKvajeQkviJE7
        gec5HbgFvjEMN86kVR8VzrxO2rkGAof+fc0mPxq1zc0n
X-Google-Smtp-Source: ABdhPJw/4rmydgDzATz5nlJxGnFieJYM+Te1X2dBep/fP/vsfgMInf3yDpwxklCEO3te6AaW8JJyN1x/VwMofUncH2A=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr4111007ota.44.1609959973212;
 Wed, 06 Jan 2021 11:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20210106005556.3550549-1-luiz.dentz@gmail.com> <5ff51433.1c69fb81.875d.3746@mx.google.com>
In-Reply-To: <5ff51433.1c69fb81.875d.3746@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Jan 2021 11:06:02 -0800
Message-ID: <CABBYNZL-rRQjGdh9HTHRKnrazspaEFxW3LdurXt0Q-B0mgVbbw@mail.gmail.com>
Subject: Re: [BlueZ,1/2] shared/gatt-db: Introduce gatt_db_attribute_set_fixed_length
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jan 5, 2021 at 5:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=409691
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

Pushed.

-- 
Luiz Augusto von Dentz
