Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DBBC282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB685206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoHatFbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgAGXs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:48:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44517 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgAGXs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 18:48:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so1078608oia.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 15:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5tb8jQaV/8b8j0bu/NJzReAUmpEqwaAqxY14NQSogU=;
        b=eoHatFbdLfkvVmRunP3AncZNnslfWfsGsYAVRjyM9b4pOhs5biRaWZKG3dP30DgWiA
         q4cpCCmF4s0s68KfR3nk7ZWxFi2k2qwvIbFqywuFlhzaTlfO8NjTAryZ4H7rA5uR7I0K
         1c382masQKhIp85MlEp9Er6TpBX950arl76aHiZiDV//clOw8qkuXfga78PV8k9bYjgu
         O5jpFjuP/WELLdTo44VkgzSZoPAVftsEURDUgtEEGIK/hz6umem1Xi/YM8AUsqcEVUaB
         aEc8BkXlQfw0BqlbOIAb0fDoqNfGJrfGCyyGujNdQ3B/aFRMmxClGJNsI2laKFCRWBFj
         CKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5tb8jQaV/8b8j0bu/NJzReAUmpEqwaAqxY14NQSogU=;
        b=jQ5adY36dL1TQMdw0VMYt8cNS/swBQEnd4L/S9Vy9WB5FGHQbOe2lJJVEYYubF6WAA
         NrRzBapoZ+5SZ86L7G6EaSrH9LNnp25zcJXH6PryskKGLQDOzKCHUmDRzActmpShpFcm
         WorOYSgLK+I6TO5iDhIDTeUhIAOfDk3zjlzBxVrydmyT8k+GhA2Qic8xx5Xq+ycLvWJ0
         qP4CxEgraLFA2q0s/aUdOO21QxmBry39fovNrfncMyDiygsMCZ3AX0Rvyn3oL09rmxY9
         juSrg3oabWT07PgOTEVnveLKneA9j4Z9CRNl6updUyo8Q4KcaHQhwDyg1ETO4GMzoJmn
         279Q==
X-Gm-Message-State: APjAAAXfFRov0cv8PODopFRe2qM98R7nAfwySraXegsKlasBHVOziGce
        L9trU7UfR1fU9OKZDnQ9U1K/g23QrlzCCoIJfZhoq6rf
X-Google-Smtp-Source: APXvYqwC/hyds7lin3z/6rxdpyhG5NzAWAYXOBAw5jLUlILLP7oqjj2JrCmZMggMAa9sS1+rDOanSlOc9kttaQoNuIg=
X-Received: by 2002:aca:4c15:: with SMTP id z21mr834411oia.8.1578440937200;
 Tue, 07 Jan 2020 15:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl> <20200107091833.14921-5-szymon.czapracki@codecoup.pl>
In-Reply-To: <20200107091833.14921-5-szymon.czapracki@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jan 2020 15:48:44 -0800
Message-ID: <CABBYNZ+Q+ekXuQM5Oe-SE-ATRZ1vGgsBA60Bo7EDQif7A4RuAQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] monitor: Decode LE Periodic Advertising Set Info
 Transfer command
To:     Szymon Czapracki <szymon.czapracki@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Tue, Jan 7, 2020 at 1:21 AM Szymon Czapracki
<szymon.czapracki@codecoup.pl> wrote:
>
> < HCI Command: LE Periodic Advertising Set Info Transfer (0x08|0x005b) plen 5
>        Connection handle: 1
>        Service data: 0x0000
>        Advertising handle: 0
> > HCI Event: Command Status (0x0f) plen 4
>      LE Periodic Advertising Set Info Transfer (0x08|0x005b) ncmd 1
>        Status: Unknown HCI Command (0x01)
>
> Change-Id: I4167e85f29e20304d1b72ec537ece70a68e8407e

Here as well.

> ---
>  monitor/bt.h     |  7 +++++++
>  monitor/packet.c | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index efaf80f55..f8422ccc9 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -2474,6 +2474,13 @@ struct bt_hci_cmd_periodic_sync_trans {
>         uint16_t sync_handle;
>  } __attribute__ ((packed));
>
> +#define BT_HCI_CMD_PERIODIC_ADV_SET_INFO_TRANS 0x205b
> +struct bt_hci_cmd_periodic_adv_set_info_trans {
> +       uint16_t handle;
> +       uint16_t service_data;
> +       uint16_t adv_handle;
> +} __attribute__ ((packed));
> +
>  #define BT_HCI_EVT_INQUIRY_COMPLETE            0x01
>  struct bt_hci_evt_inquiry_complete {
>         uint8_t  status;
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 06fd72537..3c3399c0c 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -7614,6 +7614,15 @@ static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
>         print_field("Sync handle: %d", cmd->sync_handle);
>  }
>
> +static void le_periodic_adv_set_info_trans(const void *data, uint8_t size)
> +{
> +       const struct bt_hci_cmd_periodic_adv_set_info_trans *cmd = data;
> +
> +       print_field("Connection handle: %d", cmd->handle);
> +       print_field("Service data: 0x%4.4x", cmd->service_data);
> +       print_field("Advertising handle: %d", cmd->adv_handle);
> +}
> +
>  struct opcode_data {
>         uint16_t opcode;
>         int bit;
> @@ -8413,6 +8422,9 @@ static const struct opcode_data opcode_table[] = {
>         { 0x205a, 326, "LE Periodic Advertising Sync Transfer",
>                                 le_periodic_adv_sync_trans, 6, true,
>                                 status_handle_rsp, 3, true },
> +       { 0x205b, 327, "LE Periodic Advertising Set Info Transfer",
> +                               le_periodic_adv_set_info_trans, 5, true,
> +                               status_handle_rsp, 3, true },
>         { }
>  };
>
> --
> 2.24.1
>


-- 
Luiz Augusto von Dentz
