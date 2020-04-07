Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58CC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7D9206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUNN6qyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGXgw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:36:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36312 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDGXgv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:36:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id 184so3618336vsu.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bce2v6/t69xOCmtmI7IPC7+aOkFt4OpaJTtFJt/BxMg=;
        b=aUNN6qyczN1fNAvTLsZsHGN33eGV4xrex55JKSEPb79JMMXOmZcVddx/tMKT4P+fFo
         iROB2U2/ekkMFxFXCp5gJM7I3DQmVhuPBVZS8nj5opf2vosz+b+HvuiVRxL2oOg8LU/v
         WSI6oYUTeddocUSHCanGSzUz/qlNxFmtfiHq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bce2v6/t69xOCmtmI7IPC7+aOkFt4OpaJTtFJt/BxMg=;
        b=bsND5BQhUaGlHTo7XHooz/6XJ+f4MvkpMgn787Bc+0dTMPeZnSjB68L26a3To0+1bB
         8xv2+Nc9wYdK9CNu8CydUVO7Yxtsc8bHDwTOHPEh8w++Vvf87ZeQPtP+xHWbJ6QM4Dg+
         YbXjc+w+dAnt583+qhpO3a/NMsZkz8zmzLezDu7DA8FgSDnd3E6Foi9kmqPQSfXlLi3u
         yN7SfqE5feUHpb+KIhjOH8b6M34OiNNqWk/zo02Q4JFCsvdAvNHLBBU5T42tnVLvRJAy
         n3UgwyHtG2dpkK981LuY0086FP6YIpaTDtjjVYnlG2fk9Tj57S/UOww6IvTT2lgiq1iX
         H+/Q==
X-Gm-Message-State: AGi0PuZeK/QRQq2TZ1kwXgpENLu9C8djvRYC/ZmyyLpA42LYM5onrdXJ
        WLUTd3zYlJpArROoHJycvUZnmgD6uE4FtWyOW9wGZuLQ
X-Google-Smtp-Source: APiQypJLxhm8BRvJMRZBde1X52+uIDsvJu6SVoBNeIzwQ/wVDqyBPf9qmIzKsLW4kS4WcEj38QwjfdFq2nRH1kxRxj0=
X-Received: by 2002:a67:d49c:: with SMTP id g28mr4261668vsj.71.1586302606394;
 Tue, 07 Apr 2020 16:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200407211202.1008128-1-marcel@holtmann.org>
In-Reply-To: <20200407211202.1008128-1-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Apr 2020 16:36:34 -0700
Message-ID: <CANFp7mVOgoyM1HXPMbFwOuOopaizf6Dt_qd=-ghaoXhjkXAy=g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Translate additional address type correctly
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 7, 2020 at 2:12 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> When using controller based address resolution, then the new address
> types 0x02 and 0x03 are used. These types need to be converted back into
> either public address or random address types.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 6 ++++--
>  net/bluetooth/hci_core.c    | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 58360538d42b..74896536ebce 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2257,8 +2257,10 @@ struct hci_ev_le_conn_complete {
>  #define LE_EXT_ADV_SCAN_RSP            0x0008
>  #define LE_EXT_ADV_LEGACY_PDU          0x0010
>
> -#define ADDR_LE_DEV_PUBLIC     0x00
> -#define ADDR_LE_DEV_RANDOM     0x01
> +#define ADDR_LE_DEV_PUBLIC             0x00
> +#define ADDR_LE_DEV_RANDOM             0x01
> +#define ADDR_LE_DEV_PUBLIC_RESOLVED    0x02
> +#define ADDR_LE_DEV_RANDOM_RESOLVED    0x03
>
>  #define HCI_EV_LE_ADVERTISING_REPORT   0x02
>  struct hci_ev_le_advertising_info {
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 589c4085499c..fb210f7ab7ab 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3145,6 +3145,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
>  {
>         struct hci_conn_params *param;
>
> +       switch (addr_type) {
> +       case ADDR_LE_DEV_PUBLIC_RESOLVED:
> +               addr_type = ADDR_LE_DEV_PUBLIC;
> +               break;
> +       case ADDR_LE_DEV_RANDOM:

This seems to be a typo. Should it be `case ADDR_LE_DEV_RANDOM_RESOLVED`?

> +               addr_type = ADDR_LE_DEV_RANDOM;
> +               break;
> +       }
> +
>         list_for_each_entry(param, list, action) {
>                 if (bacmp(&param->addr, addr) == 0 &&
>                     param->addr_type == addr_type)
> --
> 2.25.2
>
