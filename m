Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C6761184
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhKIX2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhKIX2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 18:28:06 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC81C061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 15:25:19 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id l43so1039282uad.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 15:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Q9KlSQsVuxGdYPlI3UsH4SKJK6EK9wyOLpEPFWMbWo=;
        b=WZwUc/6eBMpyIuqq+0EIdUROBYIG5lnWLBwkCm+FN0kjaq8oC6l/cU4q7xeduGkjIv
         yvDxDuZZJvCFw+rJ5yc0pD6zG/4QNkm0rBNJQpotz58L5+BYUQukkyL4y6OZlgUHq8Ag
         +cnbXhWiNE1gTgp/5h5EkBESbMcB7n2w3shxwW6WWkOxtCxp/4b1NAEPhpsCg/ako3Fd
         9QNxIPFB8yEJ6cNwAsstq39iEw9kIQLWwPeXpx3x2UnfFh7VuObxkrxGYH86glF4Nmgj
         EPeeYbeZm90lNhrrta1dy3a3wyAUFOitJ5zSmSEDy/jYt0AADK6DKsO45zAnHtehF2kA
         +7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Q9KlSQsVuxGdYPlI3UsH4SKJK6EK9wyOLpEPFWMbWo=;
        b=nl/9LhLFx0bTptmkUL98oge5m2O+D6RWMjmvpiuCycJe6FU5Zd6Cnr9qv6J/fvqMl2
         3MeNmTZivqLMx0TUBUX/LmHc5QSrQIrOOdtLMvS8XRXCyadFebXJZc9kvZORVMSY3TxM
         JuGdO+EKqPVr3f1Fg/Bhp+9K8pR10IOTVulX2hYo8TiTQ+pDQia7b/mcpDPHP/8WpVF7
         g9WL9UJcIIuc/xTJxSxyAMg5FGj7RmBWWVLL0vrGmYJxYlk+77IbpdFMVy/mqahQNrOu
         0AwxvYuJ1D606VBK5n0aecW+ViclG6ezbAnG4PRhyfxx0uNCWhQkEHjUWvwrOjCpKUiN
         NcVg==
X-Gm-Message-State: AOAM533jd4nDYOHWnd3pLEIL8sc4Vj+rwumD+cxppFBZpY6EvH01/1j/
        nV9OYjX1piFZv20jv++SiWgkV00+A8juQGU91xk=
X-Google-Smtp-Source: ABdhPJyu7qEFX4IG0VIAy07ta+ZfR6u3Zazv4RF9OVTUWd54uB3ccHV3H8CJNkjcILms0b82VzaX5sSxtZry7i6qFGo=
X-Received: by 2002:ab0:5b99:: with SMTP id y25mr15518526uae.47.1636500318626;
 Tue, 09 Nov 2021 15:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20211109164113.65981-1-benjamin@sipsolutions.net> <20211109164113.65981-5-benjamin@sipsolutions.net>
In-Reply-To: <20211109164113.65981-5-benjamin@sipsolutions.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 15:25:07 -0800
Message-ID: <CABBYNZ+W61=tPNrPp2zEcFrGFimf-djPG9HgJ-ZMOtBkHge9KA@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: btusb: Signal URB errors as TX failure
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Benjamin Berg <bberg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Benjamin,

On Tue, Nov 9, 2021 at 2:35 PM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <bberg@redhat.com>
>
> Call the TX failure handler when transmission of URBs fail. This is done
> both for failures to send an URB and also when the interrupt URB used to
> retrieve a response fails.
>
> This approach is sufficient to quickly deal with certain errors such as
> a device being disconnected while synchronous commands are done during
> initialization.
>
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> ---
>  drivers/bluetooth/btusb.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c257..0c4fe89c6573 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -924,6 +924,8 @@ static void btusb_intr_complete(struct urb *urb)
>                 if (err != -EPERM && err != -ENODEV)
>                         bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
>                                    urb, -err);
> +               if (err != -EPERM)
> +                       hci_tx_error(hdev, -err);
>                 usb_unanchor_urb(urb);
>         }
>  }
> @@ -967,6 +969,8 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
>                 if (err != -EPERM && err != -ENODEV)
>                         bt_dev_err(hdev, "urb %p submission failed (%d)",
>                                    urb, -err);
> +               if (err != -EPERM)
> +                       hci_tx_error(hdev, -err);
>                 usb_unanchor_urb(urb);
>         }
>
> @@ -1322,10 +1326,12 @@ static void btusb_tx_complete(struct urb *urb)
>         if (!test_bit(HCI_RUNNING, &hdev->flags))
>                 goto done;
>
> -       if (!urb->status)
> +       if (!urb->status) {
>                 hdev->stat.byte_tx += urb->transfer_buffer_length;
> -       else
> +       } else {
> +               hci_tx_error(hdev, -urb->status);
>                 hdev->stat.err_tx++;
> +       }

Looks like we are reusing the btusb_tx_complete for all endpoints but
the likes of hci_tx_error/hci_cmd_sync_cancel only applies to commands
(e.g:  alloc_ctrl_urb), perhaps there is a way to detect if this is
actually a control urb or not so we can skip this for bulk transfers,
or actually if a bulk transfer fails we may actually need to resend
depending if the error is recoverable since the bulk transfers can
actually contain fragments rather than the entire packet, but I'd
leave that for another patch since it is probably not what you are
trying to fix in this set.

>  done:
>         spin_lock_irqsave(&data->txlock, flags);
> @@ -1348,10 +1354,12 @@ static void btusb_isoc_tx_complete(struct urb *urb)
>         if (!test_bit(HCI_RUNNING, &hdev->flags))
>                 goto done;
>
> -       if (!urb->status)
> +       if (!urb->status) {
>                 hdev->stat.byte_tx += urb->transfer_buffer_length;
> -       else
> +       } else {
> +               hci_tx_error(hdev, -urb->status);
>                 hdev->stat.err_tx++;
> +       }
>
>  done:
>         kfree(urb->setup_packet);
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
