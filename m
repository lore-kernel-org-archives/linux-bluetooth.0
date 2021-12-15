Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE13FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Dec 2021 22:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhLOW6m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhLOW6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 17:58:41 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D830C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 14:58:41 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id q74so59388574ybq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoW46Ghm0lT/pHbVSAMBLnBb1pMn9f2urxp5FpgKZh8=;
        b=cAAC82MFKaNm7tBkfHFAlKqZXaHhdaof3SXnSO1QVX1gYHtkpYfh351QB+XeRzw5JL
         Bu+wWSvycnRN4y+CI/y6CVHCxogjU4IB+PXv+PLVV34SSlgmD5/tZkCQMjyaHBcTsAxO
         /toDBOvAJCqJZaBu+M2V4ZFtG3Vcdq/SZdvPYbNNkz0vN6ZCo22sAJT589MMKxov7MYD
         WS8pKjmUgM7ceYe5qCMN1giUiGqFz0qcXoUFHUhh24IeOxKPpoAEBKhZLG+C/LTV/PO8
         LY24qNxSvPffm/AnB2u33vZ34+0iqNOlz7rHlcrAhJUwv3t2rydCXKiEShdkwYwk9p/Z
         BW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoW46Ghm0lT/pHbVSAMBLnBb1pMn9f2urxp5FpgKZh8=;
        b=xE6/8x5S+p9yaLJSzQln0X5gI+erilH/W6fgYFMyUeig0Jyl0owgnLWWEZf6BD7Drx
         zIII2MJCprWhPdY3dNaGCZ6ltZPHiO2n27C0+M1zRMxCs0CDkdVcIZMPj30AJcIjabfh
         pLamZT7BPzlRIg0xdaovvYanIHr2/J24uzm5c2RfBYn3ElxC+omc+uoJgaoWM7VlYnhI
         P+LyrFE6WLTakv/Zu6ZS6pBMAZEcQUVdQVhfpbgC7wzXeHXZXo18/Vp6f9eUY7oqBXVy
         9miw+tYe2EGo/9kPotiEk7SlU7lt8H4vwSbeS3VBBxC2o4kcrn4n/0sRp1UjXzi/EPRz
         vd1A==
X-Gm-Message-State: AOAM530JcTpBqClAKft+QSlKtUaExgxJw0l74TT/A2/96fztMZzPf2wV
        gfl2baNTUXio6IcRKpz1chqAuF/j+zNENh0ychJEV84M
X-Google-Smtp-Source: ABdhPJypBxIZHU+b89h68hW7GHq4mxdF66UA4VnIXIlAhJfAsvbXXeubQwCM3zzsITz1hh/yvBA3OkHzTPbGw0sLr+U=
X-Received: by 2002:a05:6902:722:: with SMTP id l2mr9528435ybt.573.1639609120382;
 Wed, 15 Dec 2021 14:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20211214073214.320397-1-hj.tedd.an@gmail.com>
In-Reply-To: <20211214073214.320397-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Dec 2021 14:58:29 -0800
Message-ID: <CABBYNZJVAEA_3+YL3ZthiB9rY0B_-4Jn8mG_6zPKTKngZ9yagg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel: Add missing quirks and msft ext for
 legacy bootloader
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Dec 14, 2021 at 3:14 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch add missing HCI quirks and MSFT extension for legacy
> bootloader when it is running in the operational firmware.
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 8f9109b40961..e1f96df847b8 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2498,10 +2498,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>         case 0x12:      /* ThP */
>         case 0x13:      /* HrP */
>         case 0x14:      /* CcP */
> -               /* Some legacy bootloader devices from JfP supports both old
> -                * and TLV based HCI_Intel_Read_Version command. But we don't
> -                * want to use the TLV based setup routines for those legacy
> -                * bootloader device.
> +               /* Some legacy bootloader devices starting from JfP,
> +                * the operational firmware supports both old and TLV based
> +                * HCI_Intel_Read_Version command based on the command
> +                * parameter.
> +                *
> +                * For upgrading firmware case, the TLV based version cannot
> +                * be used because the firmware filename for legacy bootloader
> +                * is based on the old format.
>                  *
>                  * Also, it is not easy to convert TLV based version from the
>                  * legacy version format.
> @@ -2513,6 +2517,20 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>                 err = btintel_read_version(hdev, &ver);
>                 if (err)
>                         return err;
> +
> +               /* Apply the device specific HCI quirks
> +                *
> +                * All Legacy bootloader devices support WBS
> +                */
> +               set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> +
> +               /* Valid LE States quirk for JfP/ThP familiy */
> +               if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
> +                       set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +
> +               /* Setup MSFT Extension support */
> +               btintel_set_msft_opcode(hdev, ver.hw_variant);
> +
>                 err = btintel_bootloader_setup(hdev, &ver);
>                 break;
>         case 0x17:
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
