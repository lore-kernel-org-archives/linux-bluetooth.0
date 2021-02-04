Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F7EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A638C64F44
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhBDQ5g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbhBDQxK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 11:53:10 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBAEC06178A
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 08:52:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m13so4356600oig.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtuZOhMi4hQjT2dJo5KrrumoG23OPJ3RaM+8xUkroQQ=;
        b=n1TOOG006NIj0Y3TcJdHbFv2dD1K9E2nJ7AOOKK1divBndlQQHW5V35LuRHXJnsg2X
         LOa3mx6EGZqj05cj9pZmKkYIN7lvQiFqIcM4zo4y7wzFnqsWPB/ka0bRMhErBy2MjBHF
         o1wp8hcxOC77B2GFKL5fRECi/MymMzHXuDom7ymj4gXBt62iPEwpTmkV759QovGa3m4u
         h7p9bAtfth10oXf/TsUt3qlWKS2nQ7N7fUIQpB68QW077ENlmqvbCzWs1ozzRT5cAo8n
         BpTS1TARxapzJN3iJaZFxNOs6OGcgjxgYMWMiZnMs5RZrYpCl/1L2hIRNQWg3h52VkqV
         B0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtuZOhMi4hQjT2dJo5KrrumoG23OPJ3RaM+8xUkroQQ=;
        b=KYRFHZxjApj3HoH3HxvPgySSH5khhs28YxfvFbh6AW//cmyQkCNT1INdvXpT0Xx/3E
         wKFiHvsIFgNZ7AWuZewNVujuGmpC+zyXF9HRYkXcY7r6DKVCuwLoHIqw/6aOlJ7VqnkJ
         LPoWeLQ1w/Z64QNYYCErcs0kr3Rfom2g1d0l0keGDI27Cl+P5YAUUSdIvhHLrS/9kCPE
         OH3KH/hawRyHYp0YhVNzdA7su1f/t9i/Q6lCpjUNIkpxpVtOO1a24IHIC25vyKjF/Rn9
         XN0l5dQbHNBlSTPoTUR2LGzQxglYx1dDuM3fFuuCLESP8es6fJTaMygMo5YuEXjTK1DP
         7K0A==
X-Gm-Message-State: AOAM531G+/sue02VAoZxM8+hB21QN9AJjSnCXssGhOMVmAf3GE/jPFIE
        9anEtKhMta2275MeLDpOQqpeVywQwxYuAQB5SGk=
X-Google-Smtp-Source: ABdhPJxCTko1izSk0tcabiwU0tj9dCvN89X9FL/6np8By+jShxm1UYOJj7HteEUgk4y8q85mOGPCqg8WU0ElbCYb7Zg=
X-Received: by 2002:aca:c693:: with SMTP id w141mr248126oif.58.1612457549740;
 Thu, 04 Feb 2021 08:52:29 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NaGXXVcZ_mDf9=QFp18BT7Ke-nduUCgx9u4zMOxuW0yeA@mail.gmail.com>
In-Reply-To: <CAC9s0NaGXXVcZ_mDf9=QFp18BT7Ke-nduUCgx9u4zMOxuW0yeA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Feb 2021 08:52:19 -0800
Message-ID: <CABBYNZJh8y8NJ2b=wOo33Zp1pqD52uA47ORw_bO2F97QOcccYA@mail.gmail.com>
Subject: Re: How to disable cache?
To:     Kenny Bian <kennybian@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Wed, Feb 3, 2021 at 9:20 PM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hello,
>
> In "/etc/bluetooth/main.conf", there seems a way to disable the cache:
> [GATT]
> Cache = no
>
> What does exactly the "disable cache" mean? It means the
> "/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder won't be created?

That means it won't cache any GATT attribute found when discovering,
the cache folder has other information as well.

> We tried to disable the cache by changing the
> "/etc/bluetooth/main.conf". It seems the
> "/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder is still created even
> if it was deleted.
> However, we noticed that the "[Attributes]" section in
> "/var/lib/bluetooth/[MAC_ADDRESS]/cache/[iPHONE_MAC]" file is gone.
> Does it mean the "disable cache" is working? Does it mean the handles
> used between the bluetooth and the mobile app won't be cached?

Yes, that is the result of not caching anything.

-- 
Luiz Augusto von Dentz
