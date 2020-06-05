Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B12206E6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJvtCyE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFEUq1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgFEUq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 16:46:26 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DEC08C5C3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 13:46:26 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id t132so6090011vst.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll0PhFEEUTtkvVztwUOqDKrEYj1MeKb57EDVkpcBKeg=;
        b=TJvtCyE2ecjCdcx3X/dVNdgsldQax+W5sKXzqPr/qzmoHBE/P0uxL5+oM+1mneIhCI
         tg4w7Zh9gAcssCxOnJqecVtM6HUTaOt2y7MD31kL4E/bGJhziuoCB4uCaN91Q6bWNCmk
         Maoon86nawMnyrLtbr/H7n0HmjnH0H5rAjXik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll0PhFEEUTtkvVztwUOqDKrEYj1MeKb57EDVkpcBKeg=;
        b=cSbuyTcZbWG/qq8BL776sxLSZyuSfhMA7KjjoBZL9T8xlq8zFS3qGDXTjd75EkFjsy
         j3KWQ7j5QlJ5qwyvqL/QEe5H1NGAeZFIdPTAIIk0P8UHe3cZT/OyfW5j/8iPrcwInG7m
         sssyUsnVnOxphTFhDerOZJQarmnwSY+MM7zK8TDQzrnkRCfat4PllTsSW244EUVuAq8F
         ex2KwwsrrV9Pvb0xBI7R7oBBW/7mi4Zhc//WbPhzbDjE4UpOwXNuCsodxL3QTtP0z2mr
         2hDWzaNmCiE9Wz4mZ8hwdLCWZXzpHDc4wWiLkmpKA+Bk/2FNQ2QJ32Yt6G6/FhDZQJKx
         9fMQ==
X-Gm-Message-State: AOAM533GBsaYuM5wBYYHR5mUkMcWSRGbcsWnR00L0ItcalhYHK/uUfko
        AIYOtx7h4gPvMykWyPBbEfF21JlgD1GMGssHd+xI2Q==
X-Google-Smtp-Source: ABdhPJxSOz17ZrRN7AKLKK6hwckrU5bBeXBrfqvc0s/oXlExhsT6TODBSQYzq4pPyLRht3X8ThxUgYZs4VosUd6AdmE=
X-Received: by 2002:a67:3c6:: with SMTP id 189mr9191609vsd.71.1591389985717;
 Fri, 05 Jun 2020 13:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200605184611.252218-1-mka@chromium.org> <20200605114552.3.Ib9b5e6e81ea31cdc964cd0562ef4985a6c6c5154@changeid>
In-Reply-To: <20200605114552.3.Ib9b5e6e81ea31cdc964cd0562ef4985a6c6c5154@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 5 Jun 2020 13:46:11 -0700
Message-ID: <CANFp7mW1PJ0vdAveXcPdTe=LNnGmzJCkWwmwCfdcxmqYsDbxLA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: Refactor error handling in qca_suspend()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Fri, Jun 5, 2020 at 11:46 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> If waiting for IBS sleep times out jump to the error handler, this is
> easier to read than multiple 'if' branches and a fall through to the
> error handler.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/bluetooth/hci_qca.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 90ffd8ca1fb0d..cf76f128e9834 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2109,18 +2109,16 @@ static int __maybe_unused qca_suspend(struct device *dev)
>         /* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is going
>          * to sleep, so that the packet does not wake the system later.
>          */
> -
>         ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
>                         qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
>                         msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
> -
> -       if (ret > 0) {
> -               qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> -               return 0;
> +       if (ret == 0) {
> +               ret = -ETIMEDOUT;
> +               goto error;
>         }
>
> -       if (ret == 0)
> -               ret = -ETIMEDOUT;
> +       qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
> +       return 0;
>
>  error:
>         clear_bit(QCA_SUSPENDING, &qca->flags);
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
