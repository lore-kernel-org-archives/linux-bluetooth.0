Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67BC6113E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhJFRvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbhJFRv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 13:51:28 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB3C061766
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 10:49:35 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id t200so1601567vkt.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/uXVZ4kV0+4p8tFMAx5VW4bfoUHipEsA9ifiIxF+oQ=;
        b=N+dvk+6kHDQYxcCQbaMSeKcOrgv7LU0xWTo8CnfI3aYKyvWOt7VaoPzB/1lJ9bfJbl
         KCXwWo6T5v6I7efjxavSZMDt7UX3bQ9CEjGYNy2Iup4X/eu6w/Hasr20G8aWm8UlMVij
         Nd7nghgiZQpYzLuETE6KWmcyO8rIe15GJFI0P3szQPfdWRVnXlZZkjsam5hHhhMU6hwD
         ULoZBt7EHLagqmlpCLyNLtvFllTDFrzFds9a2CvA2VtpQtqHGBGRZolA06zzgr5Vhu57
         gCtggs57FHCpbwSvjan3x5XDoLGpleI8pLqUhwpEJ9gcvE2kj832eOqfcX7Y6oDmoLVz
         GPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/uXVZ4kV0+4p8tFMAx5VW4bfoUHipEsA9ifiIxF+oQ=;
        b=79qDAv8AYG5EbT7Gk9z6Nq8Ms8yw7R3yyD38PLndGJe04M7o1/GEiw0N1zRLcj8jl3
         xtB8w5Bvcfw3we/0U9IypJ5fObCGtsbPx/6HyzvDCrZvwGG9S/O84tjZgsxYoxvZutMS
         b7dHtfrm2Fasc3uH+a7fXbkIsWQZjQn/0wCUwMTVxGU4XJDDIw3jEkn82uq+CykYP8T3
         Lp6x2gjREFg7fUUibvw2VBq+aAR78N0tXvjbATqd0ynRB/4UNQYwPExablafn3KlBHYU
         NAkuJtBbQeUhOcqlShdKhu+FEFdjZWcGpXsEW4ZiP4JOH9TYyj5C2txBY4DCe26cuMlc
         MaTA==
X-Gm-Message-State: AOAM533dTTR2P6bwRV/nXaKd86zUJHu3+Pzzezb7mmrjGo7GIoc3PSPJ
        6tHvYNnz6MXxRpJNjtPqusu1ZIAV4I/o44mYDS4WqOONfrs=
X-Google-Smtp-Source: ABdhPJz0JIwA8Cj7m7/lKLLp5dZoeDrmFJZIsol9GV61JIVvsQyfY1J9Pon6C2YtYsxzlXDqlbDhXUHU5QSwkYFi858=
X-Received: by 2002:a1f:d782:: with SMTP id o124mr26534715vkg.6.1633542574586;
 Wed, 06 Oct 2021 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211005042613.9946-1-kiran.k@intel.com> <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
In-Reply-To: <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Oct 2021 10:49:23 -0700
Message-ID: <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kiran K <kiran.k@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Oct 6, 2021 at 1:52 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Kiran,
>
> > Intel Read Verision(TLV) data is parsed into a local structure variable
> > and it contains a field for bd address. Bd address is returned only in
> > bootloader mode and hence bd address in TLV structure needs to be validated
> > only if controller is present in boot loader mode.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 19 +++++++++++--------
> > 1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 9359bff47296..d1703cc99705 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2081,14 +2081,16 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
> >       if (ver->img_type == 0x03) {
> >               btintel_clear_flag(hdev, INTEL_BOOTLOADER);
> >               btintel_check_bdaddr(hdev);
> > -     }
> > -
> > -     /* If the OTP has no valid Bluetooth device address, then there will
> > -      * also be no valid address for the operational firmware.
> > -      */
> > -     if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> > -             bt_dev_info(hdev, "No device address configured");
> > -             set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> > +     } else {
> > +             /*
> > +              * Check for valid bd address in boot loader mode. Device
> > +              * will be marked as unconfigured if empty bd address is
> > +              * found.
> > +              */
> > +             if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> > +                     bt_dev_info(hdev, "No device address configured");
> > +                     set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> > +             }
> >       }
> >
> >       btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
> > @@ -2466,6 +2468,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> >               goto exit_error;
> >       }
> >
> > +     memset(&ver_tlv, 0, sizeof(ver_tlv));
>
> this change is not described in the commit message. Why is that now out of a sudden needed?

I guess this is just to make sure the ver_tlv is initialized so its
otp_bd_addr be set to all zeros (BDADDR_ANY) otherwise the code above
doesn't work as it attempts to compare to BDADDR_ANY.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
