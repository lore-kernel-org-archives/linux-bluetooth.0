Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1BC61222
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhJDW7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhJDW7Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 18:59:16 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C310C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 15:57:27 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y28so7740012vsd.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 15:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fkc2Y9ruw1faWr45DIkpzS/cVcFXhn4I6Yfv8kja78w=;
        b=f9bTXWyRvsh2ArApHmiCYiQGH9XV+mYHO8zoEUdP0UKOLCu7EiyH7q1iXASYepgHtf
         5dROpvg0kbCWegCBRI9A9eIWSSpUz/84ZHmoIMP8Duftj/5rhX4rICsC71Cutaj6iFBe
         2/fVL7dQ6DwVXLJZJswEs2Vq4hgr41eR2g32NdVx3xfDp39mYqNGFB5ZPshzMAz2v9Sg
         li6bFH1FPL4F9uDZ7iiZIFNuzEms3hcd1wBCp3t8TncxJd4KedE+r/mfSYyg0pIUQw8+
         fE2ORI6zkbQ3cTAETjCZoJjeiHGDiJpnlAKGX7hVIjmuMEJLkVdgrtTr8ayTC0H6+3ZG
         0dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fkc2Y9ruw1faWr45DIkpzS/cVcFXhn4I6Yfv8kja78w=;
        b=PVS5bXH9Boh/xdicKUfis3nee3GqBBspeahLUhjp/C2Qa9A9WNPrNEFiAn2Hyv1HZN
         pnsCSGfaH0bisuszWMy9xs14vP4t5lu5jKdDf/qA5o+r+28JfeEV2bnGyy42H5FjGqkx
         qZHivS6g3TDHS24T7kVlHGoJWwSpLK4QbLlYlcKH5Ojk3a3EwQt9DN9+ZoR/YGZ1OXnw
         lNS1SD+mLNEins1LGJFv6sOUpkt35rBGVHu4dVLfNrPL/kRcDqAj5Tbaym6WMDVCeESO
         SdMnPY8EJbf6bh5A3qxZznb0brX2V5ja6vo8TsOny6D2AXeqeShKyZhFgQKpLC4zRTHj
         +Y/w==
X-Gm-Message-State: AOAM530wc3bYKMxoMtpDUz2TXYpbRGM4ALDudNJaouGSVzdtGSB3Lj7g
        bxMRB1OZqcTac+MiDCYzXndJ4XfbqknXi9TZSrcMvz1GYp8=
X-Google-Smtp-Source: ABdhPJxkw5EZ3lnjvAcLXnQoB7fLxRsghc7xPlx965nX/HbUCYFTW6HbKAx7UmeB4NysZY2Bw5Gr5Kg2ULM5k3CMYFI=
X-Received: by 2002:a67:d289:: with SMTP id z9mr6774483vsi.39.1633388246385;
 Mon, 04 Oct 2021 15:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211004170126.206054-1-hj.tedd.an@gmail.com>
In-Reply-To: <20211004170126.206054-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 15:57:15 -0700
Message-ID: <CABBYNZLcLouiQ_=hE+p_mdZ47fRYzPMU+UsMoOgLih2Pu91VXg@mail.gmail.com>
Subject: Re: [PATCH V2] Bluetooth: hci_vhci: Fix to set the force_wakeup value
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Oct 4, 2021 at 3:54 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch sets the wakeup state of the vhci driver when the
> force_wakeup is updated.
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/hci_vhci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index b45db0db347c..5fd91106e853 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -176,6 +176,8 @@ static ssize_t force_wakeup_write(struct file *file,
>         if (data->wakeup == enable)
>                 return -EALREADY;
>
> +       data->wakeup = enable;
> +
>         return count;
>  }
>
> --
> 2.25.1

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=43f51bd946dab69bb38b05863898dd711b7e4506

It already contains this change as well.


-- 
Luiz Augusto von Dentz
