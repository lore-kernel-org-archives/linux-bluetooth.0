Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E67C282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318942075A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk34hNPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAGXn5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:43:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42755 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAGXn5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 18:43:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so1784020otd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26Hs7bL3la0QaOPsspnfrAtVAW15s68Yo0RPHDwP+IE=;
        b=lk34hNPzDQ6G9emfUTyvjanAmbtVeSSE5GNPZmMaphYp0GfGvsdX51YZ6l0ZkU/bmE
         fqMbMGvTd37WW7Bl7tugBbF65AE4TEG1c3yFh1nnN7MPdS/AeErzC2AvharTwYf8dSiM
         u1mgzmhcvfe2gT7wIWF56kah56f9kEj5bUNOwScclCWTRGAqmECRDpmnyXvMSXvdQHSe
         3ZNqa9nI9m6iEnTBtIBKZ44Us4CgduLhOyDZbhamN1b44vw7gTLwS2QG3MsZy4hHQ4Ln
         MbTEgxC50pTEdHHA1HB/89Vlol6MW84oMZu8USbQec2hIovSD4b60BgOz6Ed3NLJukCR
         UcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26Hs7bL3la0QaOPsspnfrAtVAW15s68Yo0RPHDwP+IE=;
        b=sFiX+WZAcv3hmkNYfa6AWkpnZNtX3ZIxPJqDkHFLs5txgPQqLLSZ8GCU+mCW8+Yat4
         mlZJ+eNfJskPMSUx6Qp92QuScLJCgBWieKe2kgHBWx6ZSGfVh9y1ZhBI+WMu4uzjm0hV
         3N3rG5DY4M4qkIrXtm2BCPDSLHyrNhnVbpDpvZI+HjB5ybmfjRcz1MV9e311ukAToZoS
         k6WaC48Iz+xen8ZFRytMglv/BCAY/bHczrlZQgxb9CO8nVHA2WXPrzSfq4ScZPzum5Ds
         dqv3YKAhGxTjIiYygK5V3GJQfq60qbhH6FnkadhxAYYL+2dbOBCA0HCwisvR7ANifUV1
         10aA==
X-Gm-Message-State: APjAAAUegw68MW19PZEW9dTi3bJwv7Y4mgbXOukHLpenJRd5Gs7xtwjK
        kTRLRnbedT1oX9vrDpN6Bu3bOih4eXKBB8YBVVPFd+9v
X-Google-Smtp-Source: APXvYqw8N3NvIQGLZeDcBxeXdBNDn6Ae/x/DMa1bauNqp4dyXRgHLFtFVvFZoCnS+9rIYW6c7sr/P3BHrOD0g22w9P8=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr2020458oti.146.1578440636815;
 Tue, 07 Jan 2020 15:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl> <20200107091833.14921-2-szymon.czapracki@codecoup.pl>
In-Reply-To: <20200107091833.14921-2-szymon.czapracki@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jan 2020 15:43:44 -0800
Message-ID: <CABBYNZLwzscUwUwFgpUu4TjbY7XVCVOCXXccvFFtZiU7yLEjcQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] monitor: Decode LE Periodic Advertising Sync Transfer
 Received Event
To:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Tue, Jan 7, 2020 at 1:20 AM Szymon Czapracki
<szymon.czapracki@codecoup.pl> wrote:
>
> Change-Id: I5a7c2d36ca5aee61441c2aab6adeb16058ab062f
> ---
>  monitor/bt.h     | 14 ++++++++++++++
>  monitor/packet.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index ecf3782c9..e14c1771f 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -3140,6 +3140,20 @@ struct bt_hci_evt_le_chan_select_alg {
>         uint8_t  algorithm;
>  } __attribute__ ((packed));
>
> +#define BT_HCI_EVT_LE_PER_ADV_SYNC_TRANS_REC           0x18
> +struct bt_hci_evt_le_per_adv_sync_trans_rec {
> +       uint8_t  status;
> +       uint16_t handle;
> +       uint16_t service_data;
> +       uint16_t sync_handle;
> +       uint8_t  sid;
> +       uint8_t  addr_type;
> +       uint8_t  addr[6];
> +       uint8_t  phy;
> +       uint16_t interval;
> +       uint8_t  clock_accuracy;
> +} __attribute__ ((packed));
> +
>  #define BT_HCI_ERR_SUCCESS                     0x00
>  #define BT_HCI_ERR_UNKNOWN_COMMAND             0x01
>  #define BT_HCI_ERR_UNKNOWN_CONN_ID             0x02
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 64f75cf8e..76bb9f239 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -600,6 +600,12 @@ static void print_addr_type(const char *label, uint8_t addr_type)
>         case 0x01:
>                 str = "Random";
>                 break;
> +       case 0x02:
> +               str = "Public Identity Address";
> +               break;
> +       case 0x03:
> +               str = "Random Identity Address";
> +               break;

Usually the term Address is already part of the label so we don't need
to repeat here, Random Identity also doesn't sound right, it should
probably be Static Random or perhaps have Resolved Public and Resolved
Static Random to indicate they are actually resolved address from RPA.

>         default:
>                 str = "Reserved";
>                 break;
> @@ -9788,6 +9794,24 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
>         print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
>  }
>
> +static void le_per_adv_sync_trans_rec_evt(const void *data, uint8_t size)
> +{
> +       const struct bt_hci_evt_le_per_adv_sync_trans_rec *evt = data;
> +
> +       print_status(evt->status);
> +       print_field("Handle: %d", evt->handle);
> +       print_field("Connection handle: %d", evt->handle);
> +       print_field("Service data: 0x%4.4x", evt->service_data);
> +       print_field("Sync handle: %d", evt->sync_handle);
> +       print_field("SID: 0x%2.2x", evt->sid);
> +       print_addr_type("Address type:", evt->addr_type);
> +       print_addr("Addres:", evt->addr, evt->addr_type);
> +       print_le_phy("PHY:", evt->phy);
> +       print_field("Periodic advertising Interval: %.3f",
> +                                                       1.25 * evt->interval);
> +       print_clock_accuracy(evt->clock_accuracy);
> +}
> +
>  struct subevent_data {
>         uint8_t subevent;
>         const char *str;
> @@ -9871,6 +9895,9 @@ static const struct subevent_data le_meta_event_table[] = {
>                                 le_scan_req_received_evt, 8, true},
>         { 0x14, "LE Channel Selection Algorithm",
>                                 le_chan_select_alg_evt, 3, true},
> +       { 0x18, "LE Periodic Advertising Sync Transfer Received",
> +                                       le_per_adv_sync_trans_rec_evt, 19,
> +                                       true},
>         { }
>  };
>
> --
> 2.24.1
>


-- 
Luiz Augusto von Dentz
