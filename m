Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462AD20758
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4RlF/R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHSSqZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSSqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 14:46:23 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20BC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:46:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e6so21923523oii.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rza0knQ+4qFyNiTQ/EJ8ffuPpXoUjwzb3Do+frC985s=;
        b=d4RlF/R6xsf6XqJtDBQ9FNf0F2VFYYmAuFKA9PNNGb1Wq6P2TXRX+QRKetsdbNGuiF
         xxOjREYYMAPQXVzfKWE0ZyNHhBh3nRO3mGlf9cb8gBefXXtaLOXB9Wy5O6ug6BtEJwpp
         HfovPOJrWExJs2q1d6ci+sa2cbZTm3Y4n8nDPQWxdo61sLxwbBotoxNhrKJY1S+mD7Qo
         XSCEuJCjbO2mOIIB8x3GbUJs8icBLTJvrr3yC9HyJABduiJ2x7TOzh7SlokDPkYyz3aw
         YX5x92/yEPpjSdbL8qMKkI99fIU5XB7r/bI7qfomM34cgbucF0+4JRb3k5Ia+RGVU1lv
         xtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rza0knQ+4qFyNiTQ/EJ8ffuPpXoUjwzb3Do+frC985s=;
        b=MQ3FySScGdxns+6CIOHabJnODLU/80CwYwtroIIcwOqve55YeuTQhzUDws4EqIo6rR
         RVQvfCA2ewZ6PYVK7n8ILpLfZDrh80kbHIy++lqJqGX5xI3BhJopAD2qWHDyN4SScNmF
         OLi3O9Aoqz+lTlYLNJQ68WxU4R7vx1M1RkPgDcCrEKcRJYj5ocm+fE0udbOXYd2buXmO
         haBdoGm/M4aY7ofGrxi6h1MOwIMzqzK/ccsMumTz24r1ZplhRWit7O3/5IzWIBBDKmve
         HwVOap32NMujkIThLap1XDNJ0HpNgoeQcgBJGcJh3/IUXCneQ85lRx9CFOuhcDzzokMv
         fNGQ==
X-Gm-Message-State: AOAM5333ozTItVtP+FE32IFA8e3DShZsHMXtwH+z23M1wR3Jo0rkrQ1g
        0KB7Dzof+vR2i5PMzOgQdkkeQM1jkhNKglTyg2T4GXrRj4o=
X-Google-Smtp-Source: ABdhPJxXDR9bGSMsrW19/YSJoFTto5iF5ZH1aM9nZhnkyP1SowI8liR3Odpk6v9N/BLX14zr2EenLM+0NtKC1fEySIo=
X-Received: by 2002:aca:f504:: with SMTP id t4mr4229734oih.137.1597862781982;
 Wed, 19 Aug 2020 11:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com> <98fed7ef-1975-48ca-9ea3-1482d938a806@EXC04-ATKLA.omicron.at>
In-Reply-To: <98fed7ef-1975-48ca-9ea3-1482d938a806@EXC04-ATKLA.omicron.at>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Aug 2020 11:46:11 -0700
Message-ID: <CABBYNZLyv_B4CtnqtHXdKnyEKx0Xo8Ta=Y--sOEu+yokaV_U=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] src/profile.c: Allow the "Address Type" to be set
To:     Mark Marshall <mark.marshall@omicronenergy.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

On Wed, Aug 19, 2020 at 8:13 AM Mark Marshall
<mark.marshall@omicronenergy.com> wrote:
>
> This allows us to have profiles that use LE L2CAP connections.
> ---
>  doc/profile-api.txt | 10 ++++++++++
>  src/profile.c       | 18 +++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> index 183c6c11a..8c7d0a06d 100644
> --- a/doc/profile-api.txt
> +++ b/doc/profile-api.txt
> @@ -112,6 +112,16 @@ Object path        /org/bluez
>
>                                         Profile features (for SDP record)
>
> +                               uint16 AddressType
> +
> +                                       Allows the Address Type to be
> +                                       selected, can be either
> +                                       BDADDR_BREDR, BDADDR_LE_PUBLIC
> +                                       or BDADDR_LE_RANDOM.  If an LE
> +                                       address is selected and the
> +                                       device is not found, the other
> +                                       sort of LE address is tried.

This sounds like a good idea but aren't we missing the GATT service
that actually exposes the PSM for the client to connect to? We should
probably make RegisterApplication accept Profile1 interfaces in such
cases so one can register both at the same time. Also note that this
should be consistent with Device.AddressType which uses a string to
not a uint16.

> +
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.AlreadyExists
>
> diff --git a/src/profile.c b/src/profile.c
> index 6961a107b..10850f305 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -677,6 +677,7 @@ struct ext_profile {
>         guint id;
>
>         BtIOMode mode;
> +       uint8_t addr_type;
>         BtIOSecLevel sec_level;
>         bool authorize;
>
> @@ -1173,9 +1174,16 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>         struct btd_service *service;
>         struct ext_io *conn;
>         GIOCondition cond;
> +       uint8_t addr_type;
>         char addr[18];
>
> -       device = btd_adapter_find_device(server->adapter, dst, BDADDR_BREDR);
> +       addr_type = server->ext->addr_type;
> +       device = btd_adapter_find_device(server->adapter, dst, addr_type);
> +       if (device == NULL && addr_type != BDADDR_BREDR) {
> +               addr_type ^= (BDADDR_LE_PUBLIC | BDADDR_LE_RANDOM);
> +               device = btd_adapter_find_device(server->adapter, dst,
> +                                                addr_type);
> +       }
>         if (device == NULL) {
>                 ba2str(dst, addr);
>                 error("%s device %s not found", server->ext->name, addr);
> @@ -1350,6 +1358,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
>                 io = bt_io_listen(connect, confirm, l2cap, NULL, &err,
>                                         BT_IO_OPT_SOURCE_BDADDR,
>                                         btd_adapter_get_address(adapter),
> +                                       BT_IO_OPT_SOURCE_TYPE, ext->addr_type,
>                                         BT_IO_OPT_MODE, ext->mode,
>                                         BT_IO_OPT_PSM, psm,
>                                         BT_IO_OPT_SEC_LEVEL, ext->sec_level,
> @@ -1567,6 +1576,8 @@ static int connect_io(struct ext_io *conn, const bdaddr_t *src,
>                 io = bt_io_connect(ext_connect, conn, NULL, &gerr,
>                                         BT_IO_OPT_SOURCE_BDADDR, src,
>                                         BT_IO_OPT_DEST_BDADDR, dst,
> +                                       BT_IO_OPT_SOURCE_TYPE, ext->addr_type,
> +                                       BT_IO_OPT_DEST_TYPE, ext->addr_type,
>                                         BT_IO_OPT_SEC_LEVEL, ext->sec_level,
>                                         BT_IO_OPT_PSM, conn->psm,
>                                         BT_IO_OPT_INVALID);
> @@ -2285,6 +2296,11 @@ static int parse_ext_opt(struct ext_profile *ext, const char *key,
>                 dbus_message_iter_get_basic(value, &str);
>                 free(ext->service);
>                 ext->service = bt_name2string(str);
> +       } else if (strcasecmp(key, "AddressType") == 0) {
> +               if (type != DBUS_TYPE_UINT16)
> +                       return -EINVAL;
> +               dbus_message_iter_get_basic(value, &u16);
> +               ext->addr_type = u16;
>         }
>
>         return 0;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
