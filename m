Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA992074B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jDx3+OJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgFEUo3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgFEUo1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 16:44:27 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD051C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 13:44:25 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id f126so2534844vkb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2jwp5Jdt1LwRP60G2WA0yRjCJZkBybyWS8pPFid5o4=;
        b=jDx3+OJhfpVTwFya+TZjWK2jUysWhkvbRJyh7c3/1rOwDGPDNPTVdSIpYywZ24+j/x
         F5vQ2NOVL6kr42+PCigk4+QIbY6QU5fPWhzYQhXDR2tPW7D0eghgxD4yktVCypPN4pw0
         ynuzSaCDghrGXktlXHFJ4QsHsahY9UC7tfrrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2jwp5Jdt1LwRP60G2WA0yRjCJZkBybyWS8pPFid5o4=;
        b=iAcqO+iop20OPK5Obwe9va3ZuVgZq5nJSkaX3IOJgHRsvte3EKw0uC+e8Wnvbw7T43
         rudWlD7WSn5LbINCdAKGsVgdNC7i1srokApsJd8GkbVEujxW/opHKt00KMShlLSsZNr+
         dnZfNpWc3/tPNB6zIZQeuMMSd2tJgl0Rxp+ZI3GtORrld5bkN/ni3SRmJtuneayoOq9M
         EMGa6q6iUA0uaELfsFFdVux01QaTRkalclNBN7PTH8IoNjEnmbTZRjqJuwwnnY7Sf5ZW
         nIlWvgrlzvEF2p3EilW9HftIvBeboosXtGxtf3nj/iWv07z9HjNU8p1R0T//Zv/STJTn
         nuvA==
X-Gm-Message-State: AOAM532VMbGeJ+cU87AYm7wn6QkKWolBAeaSRXcSE6IOB9PQFi906KSv
        6Wt+waxy31ga8evmV5F/ZeJQD3kjx/t6asarKJyDGw==
X-Google-Smtp-Source: ABdhPJzBibPDwZh8XwmvQmtrU43XZVsSjbXub6jOXo2Z/6nAInxYbIqb9e5c9R98mvijV5cyJCUTHx+isDFcsquQt1c=
X-Received: by 2002:a1f:abc9:: with SMTP id u192mr9001738vke.17.1591389864762;
 Fri, 05 Jun 2020 13:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200605184611.252218-1-mka@chromium.org> <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
In-Reply-To: <20200605114552.1.I7bcad9d672455473177ddbc7db08cc1adcdee1dc@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 5 Jun 2020 13:44:10 -0700
Message-ID: <CANFp7mW48xUkdH2OS4UFWyqB-EeoD1NMdtwcNSV8xSxUjwgy2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_qca: Only remove TX clock vote after
 TX is completed
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

Hi,

On Fri, Jun 5, 2020 at 11:46 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> qca_suspend() removes the vote for the UART TX clock after
> writing an IBS sleep request to the serial buffer. This is
> not a good idea since there is no guarantee that the request
> has been sent at this point. Instead remove the vote after
> successfully entering IBS sleep. This also fixes the issue
> of the vote being removed in case of an aborted suspend due
> to a failure of entering IBS sleep.
>
> Fixes: 41d5b25fed0a0 ("Bluetooth: hci_qca: add PM support")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ece9f91cc3deb..b1d82d32892e9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2083,8 +2083,6 @@ static int __maybe_unused qca_suspend(struct device *dev)
>
>                 qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
>                 qca->ibs_sent_slps++;
> -
> -               qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
>                 break;
>
>         case HCI_IBS_TX_ASLEEP:
> @@ -2112,8 +2110,10 @@ static int __maybe_unused qca_suspend(struct device *dev)
>                         qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
>                         msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
>
> -       if (ret > 0)
> +       if (ret > 0) {
> +               qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
>                 return 0;
> +       }
>
>         if (ret == 0)
>                 ret = -ETIMEDOUT;
> --
> 2.27.0.278.ge193c7cf3a9-goog
>

I checked the order of calls and it looks correct per commit message.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
