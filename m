Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3365C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12B123133
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAFSZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFSZ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 13:25:27 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF9C06134C
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 10:24:47 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 11so3821547oty.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bu9H0suo47TzgQ20iNCXea4xr1Hbw2bLgxg2UBMBMGA=;
        b=bgG/rq81QvcFYjc4ifFMvSc6ChG7phnBn4g5TKuh5Z/4kfxmt9CPJwMUoqZMKjpR2B
         xm0O/TtqEe63Vh98ftlhRsUJshKduKbeM6JF+ReFWP5Z2LAr8aVTKKc84OW8EpNA8hfr
         3P/84II9T73Sq+8Yqe0umBMuuONXjauTftW/GO9PYicze/qCYLgCSzCGgvDMc1a0xq26
         P5OdHWH/XSFI0bSTnXbjDB9m32xNqYCr+RvbmT8RpPRpjlHetv15VhytBSQ0bqA6XfQJ
         o8RJnRmww43VWTV/LPYiDPWlzBQbr0J6aw3WO7l0MP+kucnC+hXjUXEPhKkTlVjTJV8q
         xNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bu9H0suo47TzgQ20iNCXea4xr1Hbw2bLgxg2UBMBMGA=;
        b=EJfTDqetXCtZH5yez5RmNf3efpgWqGMUjObczcnPxo9qp3d1FZDImdg2cpkq+HJRCj
         MeIBnvIFAAJvIVCNQ641IYIKtFHPdnUL2p3xubegy5wq/yjt7NhaccyqZZUmVdekNWNx
         /QH8HIG4ye+Zp8nxLN1pJSM37xZau9JBL3vRnndZslHhdVu2Bcw1EWK4rxjRVeVXqbKW
         l5ZG+VWmeAppgS36Zk4C3krnv5ryuTywJApnU/+CIZKvtTySP9WM4QVgmpHuxgWn5q4g
         R8CIYr+Dh1Ok7PE6nJpwgNJ3cV0ubRTu0yrMCqH6zYBUC3RSJKBZuYmVpKzvuGP/2Y+s
         RmkQ==
X-Gm-Message-State: AOAM530NWvB+5gWwGIVD7ErT0PtmKjm2AaPacCWmiDN5HBUw8S7YFXaN
        ae1S+sal3FgatMzKQVADbmYG/DiT3zaEJ1d4Aw11qU9K
X-Google-Smtp-Source: ABdhPJy2O34i6961jkWvukTpR8vn6fJZYlBmcgGL/t5WHuVn1717T5OIMT5YSE7PZ+HAUQxXe7PnwBAX7XNMd603xV0=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr3992335ota.44.1609957486220;
 Wed, 06 Jan 2021 10:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
In-Reply-To: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Jan 2021 10:24:35 -0800
Message-ID: <CABBYNZK6fZ=rFqbhZeKC2ftoBdwrpZAeR_Pp2-4CYLB8hXzLDg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Remove temporary devices before power off
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jan 6, 2021 at 1:27 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> If adapter is powered off when a currently connected device is
> being removed, there is a possibility that we haven't finish waiting
> for the disconnection but the adapter is already powered down.
>
> When this happens, the kernel would fail to clean the device's
> information, for example the pairing information. This causes
> disagreement between the user space and the kernel about whether the
> device is already paired, because the device is successfully removed
> from the user space's perspective.
>
> This patch enforces the removal of such devices before allowing the
> adapter to power off.
> ---
>
>  src/adapter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ec6a6a64c5..92d1cb2232 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -517,6 +517,7 @@ static void adapter_stop(struct btd_adapter *adapter);
>  static void trigger_passive_scanning(struct btd_adapter *adapter);
>  static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                                                         uint8_t mode);
> +static void remove_temporary_devices(struct btd_adapter *adapter);

I would have the function above declared just before the first user
that way we don't have to use a forward declaration like above.

>  static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
>  {
> @@ -622,6 +623,8 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>         switch (mode) {
>         case MGMT_OP_SET_POWERED:
>                 setting = MGMT_SETTING_POWERED;
> +               if (!mode)
> +                       remove_temporary_devices(adapter);
>                 break;
>         case MGMT_OP_SET_CONNECTABLE:
>                 setting = MGMT_SETTING_CONNECTABLE;
> @@ -2888,8 +2891,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>                 param = &mode;
>                 len = sizeof(mode);
>
> -               if (!mode)
> +               if (!mode) {
>                         clear_discoverable(adapter);
> +                       remove_temporary_devices(adapter);
> +               }
>
>                 break;
>         case MGMT_SETTING_DISCOVERABLE:
> @@ -5304,6 +5309,19 @@ static void remove_discovery_list(struct btd_adapter *adapter)
>         adapter->discovery_list = NULL;
>  }
>
> +static void remove_temporary_devices(struct btd_adapter *adapter)
> +{
> +       GSList *l, *next;
> +
> +       for (l = adapter->devices; l; l = next) {
> +               struct btd_device *dev = l->data;
> +
> +               next = g_slist_next(l);
> +               if (device_is_temporary(dev))
> +                       btd_adapter_remove_device(adapter, dev);
> +       }
> +}
> +
>  static void adapter_free(gpointer user_data)
>  {
>         struct btd_adapter *adapter = user_data;
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
Luiz Augusto von Dentz
