Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A83CC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 14:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F5020836
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf6fTGN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfLKOc0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:32:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfLKOc0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 09:32:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so24332982ljc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 06:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8M28FWZ9VlZq7WswPyp5ZMZgtOL+Dx4QRXiP5F3k1k=;
        b=Xf6fTGN1bsyfksNaPXduo8Pc2qK2PU0q2PzWvELovU8f8HXOxIfpr5Dqrf65B8bNEs
         yjzr0CkaE4PxebeOHz7k4hzRA0Egt6WubaBhy5dGsfem7FTtxIXkn8dIS6PHlaURMWKR
         zg8ODzl7RqHYPhTJUetsPWl6BM6JtF4ioWq+WAjQP7Tlu8X9/7Xnhn6TyKbahRTizLpH
         NCFFry0hj5uZgwFaKksBh3JqsMnkuoWrFM5CtYVdjmKnVDsr33X3aEVjN1PCq/PkxpR4
         gArn2RfUb6wRd1sn2hMQtKQRHYhTi1ZJgfWZ/VCPQjHvHprSyVrNMYa+LBYhYg+WB5Dp
         Lx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8M28FWZ9VlZq7WswPyp5ZMZgtOL+Dx4QRXiP5F3k1k=;
        b=Yezv/NEfZmVJssAGpTVaiWFB4Ao4/H0L8D3+WcawdN/FKGm3Poh4HMqzfED4pcZpWN
         9zPlGEHWldETyP486y65Y5ofYthVsmRBurGumAmR8urqzPdrCfhusSIqphpWHe5mhBOq
         hbHr7Y8btyKLmPb6se8mKXPk01OHNEvuPDbu3yHF7+2xDgepzIxr4uXCIDYclWz7hrSR
         KutUUOe9KwsHoFFVr4F1jMYB/6oHndT0kmzRZok9x20j8KNGLplPoyLI7RGnanWaFRUH
         xqfjw18bE3d7mqVuRk+0HNTTKygFPLJAq6pGFZAnX6KOXE5JOUsE2yV32ObFbqjhww+L
         wExA==
X-Gm-Message-State: APjAAAWLl1oT+n6c95/r6Tja56zcP/BmCRXn//qRW6SsYu6EiX/qxcVQ
        Omd0OIttAk01xUSXC3LqoDSOv3YcH3+Dmvt0oZS7nUsl
X-Google-Smtp-Source: APXvYqwZXX6tCAobmee4T2P8Sz8vQXSI7AmeEhfNscwXntYEC5jzlCjEnDeSTZKfj9cfDXUt6kwz1P8Qaw8jEw477zw=
X-Received: by 2002:a2e:2418:: with SMTP id k24mr2380872ljk.49.1576074743447;
 Wed, 11 Dec 2019 06:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211103436.15369-1-marcel@holtmann.org>
In-Reply-To: <20191211103436.15369-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 11 Dec 2019 09:32:12 -0500
Message-ID: <CALWDO_Xw_rniqTCwF3u1UYh2EgQy8T7aa=p_w-XFz3if4ip7gA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove usage of BT_ERR_RATELIMITED macro
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

looks good to me.  Thanks for picking it up, I was about to this morning :)

On Wed, Dec 11, 2019 at 5:34 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> The macro is really not needed and can be replaced with either usage of
> bt_err_ratelimited or bt_dev_err_ratelimited.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  4 +---
>  net/bluetooth/hci_event.c         | 14 ++++++--------
>  2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index bd2675266859..e42bb8e03c09 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -138,8 +138,6 @@ void bt_err_ratelimited(const char *fmt, ...);
>  #define BT_ERR(fmt, ...)       bt_err(fmt "\n", ##__VA_ARGS__)
>  #define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
>
> -#define BT_ERR_RATELIMITED(fmt, ...) bt_err_ratelimited(fmt "\n", ##__VA_ARGS__)
> -
>  #define bt_dev_info(hdev, fmt, ...)                            \
>         BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>  #define bt_dev_warn(hdev, fmt, ...)                            \
> @@ -152,7 +150,7 @@ void bt_err_ratelimited(const char *fmt, ...);
>  #define bt_dev_warn_ratelimited(hdev, fmt, ...)                        \
>         bt_warn_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>  #define bt_dev_err_ratelimited(hdev, fmt, ...)                 \
> -       BT_ERR_RATELIMITED("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +       bt_err_ratelimited("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
>
>  /* Connection and socket states */
>  enum {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c1d3a303d97f..1941f120a376 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5451,7 +5451,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>         hci_dev_unlock(hdev);
>  }
>
> -static u8 ext_evt_type_to_legacy(u16 evt_type)
> +static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
>  {
>         if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
>                 switch (evt_type) {
> @@ -5468,10 +5468,7 @@ static u8 ext_evt_type_to_legacy(u16 evt_type)
>                         return LE_ADV_SCAN_RSP;
>                 }
>
> -               BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
> -                                  evt_type);
> -
> -               return LE_ADV_INVALID;
> +               goto invalid;
>         }
>
>         if (evt_type & LE_EXT_ADV_CONN_IND) {
> @@ -5491,8 +5488,9 @@ static u8 ext_evt_type_to_legacy(u16 evt_type)
>             evt_type & LE_EXT_ADV_DIRECT_IND)
>                 return LE_ADV_NONCONN_IND;
>
> -       BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
> -                                  evt_type);
> +invalid:
> +       bt_dev_err_ratelimited(hdev, "Unknown advertising packet type: 0x%02x",
> +                              evt_type);
>
>         return LE_ADV_INVALID;
>  }
> @@ -5510,7 +5508,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>                 u16 evt_type;
>
>                 evt_type = __le16_to_cpu(ev->evt_type);
> -               legacy_evt_type = ext_evt_type_to_legacy(evt_type);
> +               legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
>                 if (legacy_evt_type != LE_ADV_INVALID) {
>                         process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
>                                            ev->bdaddr_type, NULL, 0, ev->rssi,
> --
> 2.23.0
>
