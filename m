Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DFCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 00:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhLQArZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhLQArY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Dec 2021 19:47:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF90C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 16:47:24 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y68so1873322ybe.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Dec 2021 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/UKOf/X8V4oIdbaajlAoPFMhtFekOOVcaaQaTznUcA=;
        b=R5XdRJEtdCoGCA5Yj06/ohzsj6NNA8K8aLB1wT5yxBLjSVAC//7tNfTRQVbb8YeIsR
         wM4q8+dXYrc7fF7KQ+4DT4b4tm0dk5QCxbuP3+Un4BvefSFN4gaJFDo/r2IAdDsy/9eA
         Ph7ed1yn1+ddswRTdb2kUJax2DGolBnKy/CPNpV3U3d0z3jEf2Qpth80/A7M6UlwZPwb
         wxO0ORwhWYEvHLKbU4v3jdSrQJDkRCN3LvzvUCFr0PIkmPaAmFwff93D5nWQHV+XGDy0
         AAdZcBy1/wSateOkzjqCpaWCooU/s1YMMWqyEzAQk1YX+PdGWH/QBXxjxyK7Zg7Ktboc
         1dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/UKOf/X8V4oIdbaajlAoPFMhtFekOOVcaaQaTznUcA=;
        b=VwYOdkIhjaf8iV9Yf+MhLwwKdcisqxuOU0Tkr3AihpO6fhmP+z6yibRWS55Il7joy4
         4woV/9Ooc6K7yIW5Gum5+Wi3UQjTssZk8QbizUS/8UKCwb2xiH6XsN+v0L6cZ/Z2BCvq
         uY8wiNvckRlXBTOEiJJgmyzq53aefDa7Vf7Q5amYPnmTdAlQpSjycIzjHlyu/9gHg8fL
         kKBYS2RngP9D7yozCovtUc1RU27z+sG1O2SyIFTeHwS/AyMpZIuFBSgHdfTPxq43/WoB
         Rucjt/baJmEkbnXGiJ9uKohe/wTBkm+DPPfHF4+7QJIeYmKS+Obz03LQphiyJz6l1buA
         4zog==
X-Gm-Message-State: AOAM533m6ROzRbJQ64gVumWTs5tu3cFmokYURckpdN0cfkc4hJ+79RhS
        PjYpBQ/aCqmRsIXryGom6XF36VYbALxH2iELCQvTkdNe
X-Google-Smtp-Source: ABdhPJz817wXx5Rl0AUpU5hdOW9GgTWdoZNgL8GxMa6nIqxhlag7F/dF9drUZ9WTxMfn9hitsPSL2b8WrsL6cBnL/uU=
X-Received: by 2002:a25:3dc2:: with SMTP id k185mr918788yba.733.1639702043234;
 Thu, 16 Dec 2021 16:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20211216210958.62129-1-hj.tedd.an@gmail.com>
In-Reply-To: <20211216210958.62129-1-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Dec 2021 16:47:12 -0800
Message-ID: <CABBYNZKYvcEe5RHA337U_MrJyr3xZ2BEENQ38ZG2twwenrznXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Bluetooth: btintel: Fix broken LED quirk for
 legacy ROM devices
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Dec 16, 2021 at 4:04 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch fixes the broken LED quirk for Intel legacy ROM devices.
> To fix the LED issue that doesn't turn off immediately, the host sends
> the SW RFKILL command while shutting down the interface and it puts the
> devices in an asserted state.
>
> Once the device is in SW RFKILL state, it can only accept HCI_Reset to
> exit from the SW RFKILL state. This patch checks the quirk and sends the
> HCI_Reset before sending the HCI_Intel_Read_Version command.
>
> The affected legacy ROM devices are
>  - 8087:0a2a
>  - 8087:0aa7
>
> fixes: ffcba827c0a1d ("Bluetooth: btintel: Fix the LED is not turning off immediately")
>
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 13 ++++++-------
>  drivers/bluetooth/btusb.c   | 10 ++++++++--
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e1f96df847b8..75f8d7aceb35 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2355,8 +2355,13 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>          * As a workaround, send HCI Reset command first which will reset the
>          * number of completed commands and allow normal command processing
>          * from now on.
> +        *
> +        * For INTEL_BROKEN_LED, these devices have an issue with LED which
> +        * doesn't go off immediately during shutdown. Set the flag here to send
> +        * the LED OFF command during shutdown.
>          */
> -       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD)) {
> +       if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
> +                               btintel_test_flag(hdev, INTEL_BROKEN_LED)) {
>                 skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
>                                      HCI_INIT_TIMEOUT);
>                 if (IS_ERR(skb)) {
> @@ -2428,12 +2433,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>                                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
>                                         &hdev->quirks);
>
> -                       /* These devices have an issue with LED which doesn't
> -                        * go off immediately during shutdown. Set the flag
> -                        * here to send the LED OFF command during shutdown.
> -                        */
> -                       btintel_set_flag(hdev, INTEL_BROKEN_LED);
> -
>                         err = btintel_legacy_rom_setup(hdev, &ver);
>                         break;
>                 case 0x0b:      /* SfP */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d1bd9ee0a6ab..c6a070d5284f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_WIDEBAND_SPEECH  0x400000
>  #define BTUSB_VALID_LE_STATES   0x800000
>  #define BTUSB_QCA_WCN6855      0x1000000
> +#define BTUSB_INTEL_BROKEN_LED 0x2000000

I wonder why we haven't been using BIT macro here and did we make a
mistake and leave one bit behind? Or something else was at this bit
position?

>  #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
>
>  static const struct usb_device_id btusb_table[] = {
> @@ -382,9 +383,11 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>         { USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
>                                                      BTUSB_INTEL_BROKEN_INITIAL_NCMD },
> -       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> +       { USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> +                                                    BTUSB_INTEL_BROKEN_LED },
>         { USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
> -       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED },
> +       { USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> +                                                    BTUSB_INTEL_BROKEN_LED },
>         { USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
>
>         /* Other Intel Bluetooth devices */
> @@ -3724,6 +3727,9 @@ static int btusb_probe(struct usb_interface *intf,
>
>                 if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
>                         btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
> +
> +               if (id->driver_info & BTUSB_INTEL_BROKEN_LED)
> +                       btintel_set_flag(hdev, INTEL_BROKEN_LED);

I wonder if wouldn't be simples to have a flag e.g. INTEL_NEED_RESET
instead of replicating the quirks as flags since in either case the
actual outcome is to send a reset.

>         }
>
>         if (id->driver_info & BTUSB_MARVELL)
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
