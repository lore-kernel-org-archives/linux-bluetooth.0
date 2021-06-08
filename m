Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D9CC47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F6061351
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhFHS5L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhFHSzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 14:55:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0BFC061787;
        Tue,  8 Jun 2021 11:50:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b13so31667257ybk.4;
        Tue, 08 Jun 2021 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7M9VFsKxrdlHw7/FHmSJbgO0028h75HscQCU07Ex82A=;
        b=r8sOulUb+7Oo4UIhwZeOlhEmOVKFUnbKJdPHPpvItasm9l1e/OuimK82WismH5johH
         eFH6ziz3Eic9iwreIahg0F34U6Cq5pGhPBvXtP7/lVk+ex3XTG34z4oG2j4Os/vPzhHG
         p5bpBobMFS2yi+POFP7nWQy9q9DeS0itQmgEDqWv4r7QiobKh7nZUu7PaHl+nbOn5fj+
         tK4JNVrtMPyAB5/TgPrzY0qpS2tObfgjWiG/ClAQoLkE5mOHSk3NCtjqhJOjOoSgGfI4
         P+2Ks/3iD1L2MKPTRAE+tXUGD3fxoNYCt2oZ0EpBJtjbGOyMu5eK2l45GOT4hY/Zzls/
         XOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7M9VFsKxrdlHw7/FHmSJbgO0028h75HscQCU07Ex82A=;
        b=b90Z5c6GDD8nk8FzOE8py0JJ0PphuWhgHyV8RwRi04KZpYK02tD9RVMrthitc0Vs5+
         FQMnHcwRpRa8YhvZr6yjYGVCpCCKwMXsUuGl5eRzTJUwVd1x3WGFNfpjFk7DZcSkvKty
         qkXAwd8N69i6v2Zx+K5qZ2hr8bAZkRgvYQqq8FYsvfY1laCxmrRhkkG7jX/clj/hUtD4
         Iqmc/4SLQN0KTazmq5NS1z9xzgDxlfS8PE+WkxvfejxRofroYSYStSYdl35Jr1ybyw20
         I3HFSQbWjnyoD1s4JUhMtWX3dhJvUYKEqi8cMEgP0JIvBKIV6sRUOiSJFWFqG0lzC32F
         /cOg==
X-Gm-Message-State: AOAM530LmyBHH6GTpddZeiFfhl87/uTP9Ct2f0Cgkf6XpJxWWnsf/Z1K
        Dxs2aHR4o+z521zTw8K1AnUa64K5yGoAKfno5J5264uU
X-Google-Smtp-Source: ABdhPJz3xMma3vSOQfDOk0uVSq7V1AQYYr07TtsGqokzUkZW8FU1/kPpaxcikO29kCtIOjTZ1gDrgUc7jNIWu0ECDIc=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr35693284ybu.282.1623178224957;
 Tue, 08 Jun 2021 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603215249.1048521-1-luiz.dentz@gmail.com>
In-Reply-To: <20210603215249.1048521-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Jun 2021 11:50:14 -0700
Message-ID: <CABBYNZJqBbq0pMRt9w7XLLw0MnxmavokT2t6_PqwGVf4YfdnNA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2021-06-03
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David, Jakub,

On Thu, Jun 3, 2021 at 2:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> The following changes since commit 62f3415db237b8d2aa9a804ff84ce2efa87df179:
>
>   net: phy: Document phydev::dev_flags bits allocation (2021-05-26 13:15:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2021-06-03
>
> for you to fetch changes up to 1f14a620f30b01234f8b61df396f513e2ec4887f:
>
>   Bluetooth: btusb: Fix failing to init controllers with operation firmware (2021-06-03 14:02:17 -0700)
>
> ----------------------------------------------------------------
> bluetooth pull request for net:
>
>  - Fixes UAF and CVE-2021-3564
>  - Fix VIRTIO_ID_BT to use an unassigned ID
>  - Fix firmware loading on some Intel Controllers
>
> ----------------------------------------------------------------
> Lin Ma (2):
>       Bluetooth: fix the erroneous flush_work() order
>       Bluetooth: use correct lock to prevent UAF of hdev object
>
> Luiz Augusto von Dentz (1):
>       Bluetooth: btusb: Fix failing to init controllers with operation firmware
>
> Marcel Holtmann (1):
>       Bluetooth: Fix VIRTIO_ID_BT assigned number
>
>  drivers/bluetooth/btusb.c       | 23 +++++++++++++++++++++--
>  include/uapi/linux/virtio_ids.h |  2 +-
>  net/bluetooth/hci_core.c        |  7 ++++++-
>  net/bluetooth/hci_sock.c        |  4 ++--
>  4 files changed, 30 insertions(+), 6 deletions(-)

We are hoping we could merge these before the release.


-- 
Luiz Augusto von Dentz
