Return-Path: <SRS0=tYwc=UC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A9EC04AB5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882BF2808F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jun 2019 10:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2VLqzkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFCKMO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:12:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41989 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfFCKMO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jun 2019 06:12:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so14532065otr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2019 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S2m2hL69k1HEgZYF8JZAhpToxs/d9BIMlLdbdqg2zN4=;
        b=X2VLqzkCxQHsla5e33nzi0OTdmwHw9U5709VBULoQ3dP3egHvKM0XQ5mChBy3C4CKe
         MJtWbQfFUHm8HnEpntDpGprFEDtevJNPTehmXGRzNl/jbic2HIuJ4uQavr6GQF8s1Ebn
         9ifHwWcWswTBoO7yw5S4+cvN09cWXf3aL333QLDO8oltZhMRV0nSLIvpxU4XV8dKBvZ4
         ocXzBrdxi4oIoaHDcmlStkEq6RmToD6UvVRROL9nbcEAgPHZ1CLd8JDM+92hS/lMtLNf
         /ruAh7KveY/tPhQ1TmAyZGxPFIKfGDfDvVNAUORYHvtsotcSZOw4qIQpjKtbFvblNlyn
         DFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S2m2hL69k1HEgZYF8JZAhpToxs/d9BIMlLdbdqg2zN4=;
        b=sDHMitwl694ldLe34c7pQeYr4Q7jCTw7UbYrESCCrBaSxiB3Qt9DK9hYco5XxFXi1R
         83LDvJbt5pqn7akeEMt0Jx1bQFZuMdbqEI7Shour84m7lInmHr3QInOGqU1ij9CFg6sK
         sGt2QOWpe8CvxjbrAWsnPZE12gxTcdIRJl7UxMpK0rpkHwZoEb3fzDfmzbqZlUb6hL3N
         v0VRw7UOW+IB1WZct51bmkxtFx+fHqlhgDuyCjGrPkgMgiRW1Tjl5y+ecbGGQJLy1M1A
         iddMi3mbrwT6JG5ia6eYBGTwqZbKYplALSH/kD1x91uZw8aU9RB0POUfOYen9RZUc/86
         LipQ==
X-Gm-Message-State: APjAAAV3j0enJdCE2nD38WNbcuGtQajpiR0gneoWMUz/+P5ce6iWRuT2
        fm5MpcMqQDY3BCXpJ5hPDK+ZQymmaLU03MmY3ZwcK9C4woA=
X-Google-Smtp-Source: APXvYqzPB73JJXK5fN+nTnKCz51QnvoAWdFNJS5tS7A8HFY5EcWmKyzhNEE0ybIhwMiiZtBDqE0rmRWAw9UKjJqJbG0=
X-Received: by 2002:a9d:6a15:: with SMTP id g21mr622026otn.28.1559556733272;
 Mon, 03 Jun 2019 03:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190529121405.18357-1-luiz.dentz@gmail.com>
In-Reply-To: <20190529121405.18357-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 3 Jun 2019 13:12:01 +0300
Message-ID: <CABBYNZL84du-OQdpbtuDa_t_MShF24Lm8ccPjDtCSm0fBT0Dpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] main.conf: Make ReverseServiceDiscovery work with LE
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, May 29, 2019 at 3:14 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes ReverseServiceDiscovery work properly with LE connection by
> disabling the GATT client functionality which makes one able to setup a
> system to operate in peripheral role only mode.
> ---
>  src/device.c  | 9 +++++++--
>  src/hcid.h    | 2 +-
>  src/main.c    | 4 ++--
>  src/main.conf | 8 +++++---
>  4 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 8ddfa28ff..263f60aea 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4933,6 +4933,11 @@ static void gatt_client_init(struct btd_device *device)
>  {
>         gatt_client_cleanup(device);
>
> +       if (!device->connect && !main_opts.reverse_discovery) {
> +               DBG("Reverse service discovery disabled: skipping GATT client");
> +               return;
> +       }
> +
>         device->client = bt_gatt_client_new(device->db, device->att,
>                                                         device->att_mtu);
>         if (!device->client) {
> @@ -5814,7 +5819,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>                 bonding_request_free(bonding);
>         } else if (!state->svc_resolved) {
>                 if (!device->browse && !device->discov_timer &&
> -                               main_opts.reverse_sdp) {
> +                               main_opts.reverse_discovery) {
>                         /* If we are not initiators and there is no currently
>                          * active discovery or discovery timer, set discovery
>                          * timer */
> @@ -5858,7 +5863,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
>
>         dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
>
> -       if (state->svc_resolved || !main_opts.reverse_sdp)
> +       if (state->svc_resolved || !main_opts.reverse_discovery)
>                 cb->idle_id = g_idle_add(svc_idle_cb, cb);
>         else if (dev->discov_timer > 0) {
>                 g_source_remove(dev->discov_timer);
> diff --git a/src/hcid.h b/src/hcid.h
> index 1eb3c5ac2..adea85ce2 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -43,7 +43,7 @@ struct main_opts {
>         uint32_t        discovto;
>         uint8_t         privacy;
>
> -       gboolean        reverse_sdp;
> +       gboolean        reverse_discovery;
>         gboolean        name_resolv;
>         gboolean        debug_keys;
>         gboolean        fast_conn;
> diff --git a/src/main.c b/src/main.c
> index 696728320..1a6ab36a3 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -367,7 +367,7 @@ static void parse_config(GKeyFile *config)
>                 DBG("%s", err->message);
>                 g_clear_error(&err);
>         } else
> -               main_opts.reverse_sdp = boolean;
> +               main_opts.reverse_discovery = boolean;
>
>         boolean = g_key_file_get_boolean(config, "General",
>                                                 "NameResolving", &err);
> @@ -456,7 +456,7 @@ static void init_defaults(void)
>         main_opts.class = 0x000000;
>         main_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
>         main_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
> -       main_opts.reverse_sdp = TRUE;
> +       main_opts.reverse_discovery = TRUE;
>         main_opts.name_resolv = TRUE;
>         main_opts.debug_keys = FALSE;
>
> diff --git a/src/main.conf b/src/main.conf
> index b2f843c75..40687a755 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -30,9 +30,11 @@
>  #DeviceID = bluetooth:1234:5678:abcd
>
>  # Do reverse service discovery for previously unknown devices that connect to
> -# us. This option is really only needed for qualification since the BITE tester
> -# doesn't like us doing reverse SDP for some test cases (though there could in
> -# theory be other useful purposes for this too). Defaults to 'true'.
> +# us. For BR/EDR this option is really only needed for qualification since the
> +# BITE tester doesn't like us doing reverse SDP for some test cases, for LE
> +# this disables the GATT client functionally so it can be used in system which
> +# can only operate as peripheral.
> +# Defaults to 'true'.
>  #ReverseServiceDiscovery = true
>
>  # Enable name resolving after inquiry. Set it to 'false' if you don't need
> --
> 2.21.0

Applied.

-- 
Luiz Augusto von Dentz
