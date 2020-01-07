Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E5C282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C288206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIAfgUe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgAGXsC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:48:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44456 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgAGXsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 18:48:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so1076965oia.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5s6nrL1X4G/5uC4D3ZvBSG7k8eKevHX/FbIrsxOj9A=;
        b=fIAfgUe6eLEjpAfAQe3PkWWQYZ9Qx4pTHVDioEZYRd/Q1099aPA73oyf/+e7BFFk2D
         TJWw7boTjISm9zRaGMkA4V7AVPUEtznX1o63lE6GwPdzu6HkpAwOwCgJC9iW8rHgsMEX
         Da0eFt9fiUE15AXZ/E1ILJwcDBsQ5ezja4a/2ALg8MZdY98fyZ5mhY7z72y5LHf5SQ8M
         o6OROtDiRDkEGIUqy4OutVxdQZZ3tL/VCrWqI7v6QMEbRvn3ebGl6kXT8bnMUXEcUdyy
         dXyLoQAdnoPavOjUCc6ZhaUMten/td0QIIcyBL/bzDAJ6Kgjzo3cR1Xq4Bt3pRfHi2MT
         b2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5s6nrL1X4G/5uC4D3ZvBSG7k8eKevHX/FbIrsxOj9A=;
        b=qHpKQp2gnZgQivQgypGDaAj3cZBlBjGdh/3149fn6mE4amtJdvATDeSQZaOGJhhXTK
         W6GnixfOEeTlNvKAfIn+RhfRfJ9T3gZeNJsd+BawYbPX79CPfqvDmJzY//gMYlsdhH4b
         1tXxYGVVAb+ErK9iBHXf3WtzA7UDsiniA1ICJdLGQfLpaoBLyNUp0P80x1DTqPcB2pIl
         UXIwUlv6dBTKDap2j6k2iiUCmTfC3B2eSKnvVmf7d9lNnw3FVxpgm7oX1eaBwW9SEWfk
         ymJOJpAwuk9DglwA0tpp6pzsPvnUKg5v0RUCUKBgwxKa9Gb2aA6rVMPQfJvkXNOljztM
         0dLw==
X-Gm-Message-State: APjAAAVmYeWewS2cJVoRSFunKHN4YswByGQGKjrMNf9yt+xXYceWAwCd
        3unAnEWaB06jmxZ3pZi8JrqOB35QEBI2roEBuaim8TUn
X-Google-Smtp-Source: APXvYqyR8OCqsCVAhLR/zac8p2R3wJz9rtvvGurhPltzXjC8u7jGQDlHx6ie06Y9c6KCGO/QljiypT7a2txNuS4ZB3c=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr847920oif.82.1578440881228;
 Tue, 07 Jan 2020 15:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20200107091833.14921-1-szymon.czapracki@codecoup.pl> <20200107091833.14921-4-szymon.czapracki@codecoup.pl>
In-Reply-To: <20200107091833.14921-4-szymon.czapracki@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jan 2020 15:47:49 -0800
Message-ID: <CABBYNZKmOigzDcKW0SEfbE2fWZMV5FZypSRkr0aiUaLm3A8PTQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] monitor: Decode LE Periodic Advertising Sync Transfer command
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
> < HCI Command: LE Periodic Advertising Sync Transfer (0x08|0x005a) plen 6
>         Connection handle: 1
>         Service data: 0x0001
>         Sync handle: 1
> > HCI Event: Command Status (0x0f) plen 4
>       LE Periodic Advertising Sync Transfer (0x08|0x005a) ncmd 1
>         Status: Unknown HCI Command (0x01)
>
> Change-Id: I9009c6c2299cc5e56bb94ddd46e8accbacbcc800\

Looks like the gerrit Change-Id had sleep in.

> ---
>  monitor/bt.h     |  7 +++++++
>  monitor/packet.c | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index bb373b528..efaf80f55 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -2467,6 +2467,13 @@ struct bt_hci_cmd_set_periodic_adv_rec_enable {
>         uint8_t  enable;
>  } __attribute__ ((packed));
>
> +#define BT_HCI_CMD_PERIODIC_SYNC_TRANS 0x205a
> +struct bt_hci_cmd_periodic_sync_trans {
> +       uint16_t handle;
> +       uint16_t service_data;
> +       uint16_t sync_handle;
> +} __attribute__ ((packed));
> +
>  #define BT_HCI_EVT_INQUIRY_COMPLETE            0x01
>  struct bt_hci_evt_inquiry_complete {
>         uint8_t  status;
> diff --git a/monitor/packet.c b/monitor/packet.c
> index c1e449a68..06fd72537 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -4025,6 +4025,13 @@ static void status_rsp(const void *data, uint8_t size)
>         print_status(status);
>  }
>
> +static void status_handle_rsp(const void *data, uint8_t size)
> +{
> +       uint8_t status = *((const uint8_t *) data);
> +       print_status(status);
> +       print_field("Connection handle: %d", get_u8(data + 1));
> +}
> +
>  static void status_bdaddr_rsp(const void *data, uint8_t size)
>  {
>         uint8_t status = *((const uint8_t *) data);
> @@ -7598,6 +7605,15 @@ static void le_periodic_adv_rec_enable(const void *data, uint8_t size)
>         print_enable("Reporting", cmd->enable);
>  }
>
> +static void le_periodic_adv_sync_trans(const void *data, uint8_t size)
> +{
> +       const struct bt_hci_cmd_periodic_sync_trans *cmd = data;
> +
> +       print_field("Connection handle: %d", cmd->handle);
> +       print_field("Service data: 0x%4.4x", cmd->service_data);
> +       print_field("Sync handle: %d", cmd->sync_handle);
> +}
> +
>  struct opcode_data {
>         uint16_t opcode;
>         int bit;
> @@ -8394,6 +8410,9 @@ static const struct opcode_data opcode_table[] = {
>         { 0x2059, 325, "LE Periodic Advertising Receive Enable",
>                                 le_periodic_adv_rec_enable, 3, true,
>                                 status_rsp, 1, true },
> +       { 0x205a, 326, "LE Periodic Advertising Sync Transfer",
> +                               le_periodic_adv_sync_trans, 6, true,
> +                               status_handle_rsp, 3, true },
>         { }
>  };
>
> --
> 2.24.1
>


-- 
Luiz Augusto von Dentz
