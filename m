Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75807C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4380764DEE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBLBdg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 20:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBLBdd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 20:33:33 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63869C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:32:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h26so10994144lfm.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nj89cQuRKIcPXnHbHb/rKxRicegNWraFxjD6zIo0lWs=;
        b=X4MI5jy9ACGl6QaZ/9EQgP+YEAt+JauvJhvnmxqpRQrTbvUDMZItS8U/6rEipmLR+W
         lB8nwY9o+NF0YD6aR6TQsIlmK2wc/jXPrDl3Bj4AETAsy5qAzjHdekJKqrqGMGu8A3EV
         Spm9Arx6a8WIeele0F+h6fJmE1VPuptCcz6n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nj89cQuRKIcPXnHbHb/rKxRicegNWraFxjD6zIo0lWs=;
        b=LfQ9vFUS72xF+ZGFM7DtCwany6Rm8ALFqpK+C2I1iXrqtjIgMr/M1KzxvUbSI8x69k
         m7iQuSwMP7tzVc4IrQNylOa6qE6b7qT8FLXdhcUyy2qzCilGxDAVbu8BJ35ayfRqu0jl
         v/W/gxRUni2A4rotEnnaSDAyOu3ts6STIjHd/XneXswJwJJmefDqqrykpH+R//5nplbU
         bIWf4s4syDwg6EwbIo0/sMUYu99A7mbFfOg1pclvYf9QmMglC2JDDIIN+70AxYnX6n81
         bITn1PvKZT0dFmBxFRyV955ZwFz45Y7WB25TmKFLMvwIprAxHpDobpRPWcm6zzQWAEjX
         cskw==
X-Gm-Message-State: AOAM530fApzoMhVtXttkRVCyxOFYNQfy9Xc8gVnftPQi/KnuBqzX6XG8
        hojFWWPcjtYIEL56C55ygNWypgC8+tH3hPdXwv3AmBu3XLg=
X-Google-Smtp-Source: ABdhPJwvKOkQyR36s3nNOnMQZ34dP4tNNP4ifpFl7Sn1UNd3lW9iZJri78b31Szm10CUoAbSqaN2D187NAmdhnmOMew=
X-Received: by 2002:ac2:4186:: with SMTP id z6mr350092lfh.265.1613093571705;
 Thu, 11 Feb 2021 17:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20210127091600.v4.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
In-Reply-To: <20210127091600.v4.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 11 Feb 2021 17:32:40 -0800
Message-ID: <CABmPvSH+3E6NHLOSNcoNd8HQUnduk3n+Qb+n9R8ca2WcUnROVw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Keep MSFT ext info throughout a hci_dev's
 life cycle
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

A friendly ping on this patch. :)

Regards,
Miao

On Wed, Jan 27, 2021 at 9:17 AM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This moves msft_do_close() from hci_dev_do_close() to
> hci_unregister_dev() to avoid clearing MSFT extension info. This also
> re-reads MSFT info upon every msft_do_open() even if MSFT extension has
> been initialized.
>
> The following test steps were performed.
> (1) boot the test device and verify the MSFT support debug log in syslog
> (2) restart bluetoothd and verify msft_do_close() doesn't get invoked
>     and msft_do_open re-reads the MSFT support.
>
> Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4:
> - Re-read the MSFT data instead of skipping if it's initiated already
>
> Changes in v3:
> - Remove the accepted commits from the series
>
>  net/bluetooth/hci_core.c |  4 ++--
>  net/bluetooth/msft.c     | 21 ++++++++++++++++++---
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index eeafed2efc0da..8056f0d4ae172 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1764,8 +1764,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
>
>         hci_sock_dev_event(hdev, HCI_DEV_DOWN);
>
> -       msft_do_close(hdev);
> -
>         if (hdev->flush)
>                 hdev->flush(hdev);
>
> @@ -3844,6 +3842,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         unregister_pm_notifier(&hdev->suspend_notifier);
>         cancel_work_sync(&hdev->suspend_prepare);
>
> +       msft_do_close(hdev);
> +
>         hci_dev_do_close(hdev);
>
>         if (!test_bit(HCI_INIT, &hdev->flags) &&
> diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> index 8579bfeb28364..4465d018280eb 100644
> --- a/net/bluetooth/msft.c
> +++ b/net/bluetooth/msft.c
> @@ -73,16 +73,31 @@ static bool read_supported_features(struct hci_dev *hdev,
>
>  void msft_do_open(struct hci_dev *hdev)
>  {
> -       struct msft_data *msft;
> +       struct msft_data *msft = NULL;
>
>         if (hdev->msft_opcode == HCI_OP_NOP)
>                 return;
>
>         bt_dev_dbg(hdev, "Initialize MSFT extension");
>
> -       msft = kzalloc(sizeof(*msft), GFP_KERNEL);
> -       if (!msft)
> +       /* If MSFT data exists, reset its members */
> +       if (hdev->msft_data) {
> +               msft = hdev->msft_data;
> +               hdev->msft_data = NULL;
> +
> +               msft->features = 0;
> +               kfree(msft->evt_prefix);
> +               msft->evt_prefix = NULL;
> +               msft->evt_prefix_len = 0;
> +
> +       } else {
> +               msft = kzalloc(sizeof(*msft), GFP_KERNEL);
> +       }
> +
> +       if (!msft) {
> +               bt_dev_err(hdev, "Failed to init MSFT extension");
>                 return;
> +       }
>
>         if (!read_supported_features(hdev, msft)) {
>                 kfree(msft);
> --
> 2.30.0.280.ga3ce27912f-goog
>
