Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C062074B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2aeuagi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgFEUqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgFEUqD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 16:46:03 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F7C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 13:46:02 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r9so3764992ual.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu/enQggfTDThya3I23l3QzzsMy6zVJQ7ZWkP0PiKUY=;
        b=E2aeuagiXgXPbVsTuiTocfP1iDNR1aJhJjV3AxAs3t3jhCD8PDucFKSeD4CgorDpI9
         UX+uqAMTY/w9aMRtd+/ciZ7M/YPqjnUafqBhy2384TK1QpYF+npYh7xcKEbmGDrpZNDJ
         XR7/+4sqprQrjHpDwtoOhTqooqJufrjKwdZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu/enQggfTDThya3I23l3QzzsMy6zVJQ7ZWkP0PiKUY=;
        b=CKBzXKYBuXmZnlusrpzjKsD4k51RsLnfxzPG3JkqfC402YUeZRr78TNmYhcgFtXYnH
         a5gc8Hr0wW3EzBDJ8abTGTobEphQDJ2qVGXtw9sUD/4stmchwS4aR5mh67QpjPPcRII6
         eLumIKvxanKR8ZHfE8nUX5kMzLb8gb8L+CjsRX4qBpRdEWyFv9H1NsXyumJijYMreOJO
         K7zUR5Hax5FW/OyF3wXM3W1HknVaqxAGI+WUZ7e/TH5tEUwV6D0IWQcq6+x5SrJjKUZT
         NFLAwjvz7acruV2l+tSJ7DXhtR0bNnXkY3m8Oqz4ro1jarVcKH/3NIVkdii6PxuC3vhm
         QE0A==
X-Gm-Message-State: AOAM530Iis3VTAlbVO11OCP6Aso8iwkwUKJjtA7xwCxY0DJLxs35DPLn
        U4ml+Tx3biG/xrQzZyEoSblbrXGpwL6MO/z4O/slqw==
X-Google-Smtp-Source: ABdhPJxb9oudsNAnmTq+vk55suB4sxT/Qzbrpq59/yGfvCTS3Q8PME/mrDvED0xxY+keptf9X8RLPzwUmpWDdixipGA=
X-Received: by 2002:ab0:710f:: with SMTP id x15mr8531596uan.90.1591389962168;
 Fri, 05 Jun 2020 13:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200605184611.252218-1-mka@chromium.org> <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
In-Reply-To: <20200605114552.2.I2a095adb2a9a98b15c11d7310db142b27f8cab28@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 5 Jun 2020 13:45:48 -0700
Message-ID: <CANFp7mU1BOg1huNRQS8fAnXd1aGo9aZGDb-D+Mq6O9uVAaYXjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Skip serdev wait when no transfer
 is pending
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
> qca_suspend() calls serdev_device_wait_until_sent() regardless of
> whether a transfer is pending. While it does no active harm since
> the function should return immediately it makes the code more
> confusing. Add a flag to track whether a transfer is pending and
> only call serdev_device_wait_until_sent() is needed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/bluetooth/hci_qca.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b1d82d32892e9..90ffd8ca1fb0d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2050,6 +2050,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
>         struct hci_uart *hu = &qcadev->serdev_hu;
>         struct qca_data *qca = hu->priv;
>         unsigned long flags;
> +       bool tx_pending = false;
>         int ret = 0;
>         u8 cmd;
>
> @@ -2083,6 +2084,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
>
>                 qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
>                 qca->ibs_sent_slps++;
> +               tx_pending = true;
>                 break;
>
>         case HCI_IBS_TX_ASLEEP:
> @@ -2099,8 +2101,10 @@ static int __maybe_unused qca_suspend(struct device *dev)
>         if (ret < 0)
>                 goto error;
>
> -       serdev_device_wait_until_sent(hu->serdev,
> -                                     msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> +       if (tx_pending) {
> +               serdev_device_wait_until_sent(hu->serdev,
> +                                             msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
> +       }
>
>         /* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is going
>          * to sleep, so that the packet does not wake the system later.
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
