Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F1C388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 23:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38839221EB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 23:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go0SdB8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJ3XsQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 19:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ3XsQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 19:48:16 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43EC0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 16:48:16 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k65so8364192oih.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3GLeg3mDnjzFxQHxcB87R4951IFQPTLILz6FZ97bJI=;
        b=Go0SdB8JiHah+tD9FnL2Eg1L44kYCLiLqtpVD/CtlZOlG2pN5HUypjQpZPq60+67uj
         VOxXmxjLoIZEkFldFD9QIGNTq9eUOFDkA7eytIZsvnPBoUreIDfql/vzO2jNDfkMzaxV
         HkBiPGvQq9rzDlmwzFUTlDiAaSRAXmxFwHdzyrTdWbJvtH0NSi4rzcNTlB09Xv9vBjvI
         ZYuSe5ON9A8p3RMkCyjDumeeTgFKAx4/903dESXRzoSWX/h1Tr4qFNcfs2Qk59ujgIBD
         BCgCT4sBkKRueN0Krl8f6jPnxvIwzb4eKDOfNSM+3O0HUXQhERdDdZCuMLG+FfQre9XZ
         1x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3GLeg3mDnjzFxQHxcB87R4951IFQPTLILz6FZ97bJI=;
        b=tNGsYhz7/7xypeosFdaDnsSS6e4YrPHwjGYn66VFXJqVhXxH67jCHCUgRDNn0gU8KQ
         CRFE4vkmH3yZV3uCH3hI3KMIw0PxskpsraJ07Rv/TCgd9smkDOZeC49TBmM6INBhmaiT
         E0LmnghknOxZqQBg9Bxc5e/8IBVung6gDcmY0nNCvbpY0DufoeX7JW3tcQeZRPd8URV9
         TYtzYDBSqlZRdSGxoYqlha1KsFNlB1CqF5QnnuEH8zb/bIXMHDqo9vctmOt1RccMbf2c
         DO8ou1OQGQt43Gd+SqLQXDkYX4KjgtJRUMHq+9u2Bb6E2t5eZ7lcUFng28FLFJia9Pve
         uoag==
X-Gm-Message-State: AOAM533khBPajeSbVVelF/ElK1Y70CYYg92OYGuhZ5u4gol8rj22OSIP
        Hc0y9G67z+SxNJLBubI8dCWAA3v04mS0YbG7kuo=
X-Google-Smtp-Source: ABdhPJxmWMsbiEEs7mdApuNjTeh0ab4kv9UgPKtSXXFN3RhN8msfMU4Mo+//20JDBt0FXKuZmGVjy8mDt/cBh2U9mZ0=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr2723872oif.58.1604101695923;
 Fri, 30 Oct 2020 16:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201030160833.BlueZ.v1.1.Ia45f3edc48142d9db0dc4b315c84ab60a149697f@changeid>
In-Reply-To: <20201030160833.BlueZ.v1.1.Ia45f3edc48142d9db0dc4b315c84ab60a149697f@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Oct 2020 16:48:05 -0700
Message-ID: <CABBYNZKck6MFew6r-pEJgh2CLWUNmrKf4KO5z-nzBVJUBVcSmQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Fix a crash caused by lingering
 discovery client pointer
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

On Fri, Oct 30, 2020 at 4:13 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This cleans up the lingering pointer, adapter->client, during powering
> off the adapter. The crash occurs when a D-Bus client set Powered
> property to false and immediately calls StopDiscovery() when there is
> ongoing discovery. As a part of powering off the adapter,
> adapter->discovery_list gets cleared, and given that adapter->client
> refers to one of the clients in adapter->discovery_list, adapter->client
> should be cleared along with it.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
>  src/adapter.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c0053000a..74bfb0448 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1507,8 +1507,10 @@ static void discovery_free(void *user_data)
>                 client->discovery_filter = NULL;
>         }
>
> -       if (client->msg)
> +       if (client->msg) {
>                 dbus_message_unref(client->msg);
> +               client->msg = NULL;
> +       }

This shouldn't make any difference as the whole list is freed and so
is the client.

>
>         g_free(client->owner);
>         g_free(client);
> @@ -5301,6 +5303,19 @@ static void free_service_auth(gpointer data, gpointer user_data)
>
>  static void remove_discovery_list(struct btd_adapter *adapter)
>  {
> +       DBusMessage *msg;
> +
> +       if (adapter->client) {
> +               msg = adapter->client->msg;
> +               if (msg) {
> +                       g_dbus_send_message(dbus_conn, btd_error_busy(msg));
> +                       dbus_message_unref(msg);
> +                       adapter->client->msg = NULL;
> +               }
> +
> +               adapter->client = NULL;

Shouldn't you call discovery_free as well here? Or perhaps we could
move the lines above inside discovery_free so it detects if the
adapter->client is pointing to a client that is being freed.

> +       }
> +
>         g_slist_free_full(adapter->set_filter_list, discovery_free);
>         adapter->set_filter_list = NULL;
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
