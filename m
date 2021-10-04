Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B338561131
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 22:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhJDW3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhJDW3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 18:29:11 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DEC061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 15:27:20 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 188so21579291vsv.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzsoDfL5TbsUHKc+xJthg9t1Fetv2C21Qknd4IE5Lhs=;
        b=h8eX5GoDKyW3lBPgDWnM2GltaPx5+GhVqMN+X/+tJMgmCmkuYuiY4UudyeHaS8mbfU
         /18T3PodGCZUL3R/6Dnw0dVHj2VtqV+qY6uEmHUoqz32A8fe1TerPsOua45zbAyL7sxP
         QBuh7EbCiE/9HBuC/m4vfqv1oHXN2pSpMGQ3NMcDnazcYJQSaPtfDrxLIbpuqJMuNP7f
         LPGO0V8MlPudLUogSgEGll/CbvNyK3ODbtOkvMS8LGnVGIs55aeTEDrxH85lrVlsF9D3
         /XVO2wk8fjgDHvG7smZeATdOpgSOrT3sNkpNvtOVyBoDPbWaUVvnvbiZifrXCg9dgMjj
         vmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzsoDfL5TbsUHKc+xJthg9t1Fetv2C21Qknd4IE5Lhs=;
        b=7LAJw3fPtROGGjUjmgodgcbjQWZo/XfWNBWPDl9iOI0ZtHPB6y7xH8xCfz4vTGvMQm
         wPEBDptMVz8t9t/yy9CXsfGrO6T/Jem22sczs7D19Bd2t69OzA5sC8By77psDlwpiGSu
         0gN2ijC966TLXwOCPDeHigMrdkcgBfhA9J93lqNDcfgTADBC/+StkVhvbmn791oX7Ivi
         4MARlzg3oo/Sf31VLlVN6XSe0uWkv0GKER3M3Z+WM2tV2CTSbTXJlI/AgpHTud9+I8a9
         Ov4Bk4fgO4eU4Ep4Y+AHrvpV4K7RUnjqF1aN0aXoK1yB23vDMrsMrKJJ7y7Gh0RZ5L6B
         uKug==
X-Gm-Message-State: AOAM5327QjRMmpOioDEJW5korO8g40TwFfqSmQ2Kg8Xn3QRXfbDxYEIX
        1c6tdkN8/Z91GSoWPEGIZwNMtbM/zTiOR+BEkxs=
X-Google-Smtp-Source: ABdhPJz/cJP/9n+sr6yIC5nqluvxH37vBi4HdhzBnEG0q0ux9aCXDyNYhhPxHnDAATljeDT/LMjK0Oots94ChiRblXs=
X-Received: by 2002:a05:6102:21d0:: with SMTP id r16mr16165699vsg.39.1633386439675;
 Mon, 04 Oct 2021 15:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211002182109.165456-1-hj.tedd.an@gmail.com> <86E45D71-62B4-4ED0-A31A-FB021D86F9B3@holtmann.org>
In-Reply-To: <86E45D71-62B4-4ED0-A31A-FB021D86F9B3@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Oct 2021 15:27:08 -0700
Message-ID: <CABBYNZJp5phSoGwOZ7yUQ0o9E9Pf5wi-Kh3u1WjAf_1iDk2Bhw@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: hci_vhci: Fix to set force_wakeup value
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Tedd,

On Sat, Oct 2, 2021 at 2:04 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Tedd,
>
> > This patch sets the wakeup value in the vhci driver data after reading
> > the value.
> >
> > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > ---
> > drivers/bluetooth/hci_vhci.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index b45db0db347c..5fd91106e853 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -176,6 +176,8 @@ static ssize_t force_wakeup_write(struct file *file,
> >       if (data->wakeup == enable)
> >               return -EALREADY;
> >
> > +     data->wakeup = enable;
> > +
> >       return count;
>
> patch looks good, but the commit message is confusing.

Ive ended up fixing the original patch since I had to force push due
to the pull request problem with committer/sign-off problem.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
