Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55976C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0826122207
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGrspViE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgIPXo4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXoz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:44:55 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C5C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:44:54 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g26so120877ooa.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY7OPE1F+WqL1N+o17129KaKPHeO1x4YyMh0/VE8XNE=;
        b=kGrspViE6B7bAbfSfrMwb16hypxheTzqdjGxecGWtUKcz/Wh448xtcgDZ5cW1Jwet4
         rDX3oRGQE8R2DJrckc72VPyXKrwfFYpu46z4m99D1sZejtV5hJkGtzJr1IaBCNtvxNkn
         TBmTsPHzBGYCsS6GQCe5YHg+Kj+0Gy/0og209lV1vcAh+6XFTVchKRrh0qyA5FCOUBw/
         eywvQgZyjXlsMGacykHzwIHXyJ9DewmKebKBTXdRTyqOWXHci3mu+rWCT9ZQ1purt/i0
         U+qcFhmHljGFkePIMNhtND4hSe0a5ymkTAgt6QubjdNbexjsiHsB88mKn51jC4pT7M/w
         an5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY7OPE1F+WqL1N+o17129KaKPHeO1x4YyMh0/VE8XNE=;
        b=PVAMdG70lnRlFkRsZ9BuDmQCKs/6zYOU32kbMyumgmFn/xXcowxfVFXtKwNEOvtZ0p
         AZ91K+cgVhwGW3XoaHtK4am1wuPHeM/4Qd9y5cM5LmrEeqI+5WP5uWcENl41hotm4CPN
         OOokXaBE96fCx9BPKP7l4q0COSuOIbCuDjs7xRMuwemDmWGFhc7b/6vsLtuJ3Me6B26P
         WnkLmrt1rFrvxTkNfZcqCkzDhwvZlJ7Lt+WMw5RJMpODyqBu1Tguvp+TB7p6VM6RT9vN
         WOvscz9lqOnxuJuNoPc4myKkhOTIbPzMGq1j0UmBs9b54GroGQ+Uhe8WCoYsVXNSSnej
         POjA==
X-Gm-Message-State: AOAM530zqwgjYyEfVVKC0NmNR4PlaXXqVVHSiEHppxaJ5xP/GsRYgvmM
        308sM9vYOfjqOEoRBlgnbvIqOiqEI/xz94a+Ckw=
X-Google-Smtp-Source: ABdhPJyWy9x+nSAtZierqgirLVBHfm7i6uwczsjOZspYd6gjMtYtvUrwAR7+mzQAwh1ZF9JVx7T4OQpx/XpvnWWgS6Q=
X-Received: by 2002:a4a:8dd5:: with SMTP id a21mr19277607ool.17.1600299892243;
 Wed, 16 Sep 2020 16:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com> <20200916162155.Bluez.1.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
In-Reply-To: <20200916162155.Bluez.1.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Sep 2020 16:44:40 -0700
Message-ID: <CABBYNZJ5KrfkdTDWP_ugqcb_ybzrF2nAUeP=cE37cm86VG4GZQ@mail.gmail.com>
Subject: Re: [Bluez PATCH 01/10] advertising: Detect if extended advertising
 mgmt commands are supported
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Wed, Sep 16, 2020 at 4:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> We need to know if kernel supports the new MGMT interface. To do so, we
> call MGMT_OP_READ_COMMANDS when our manager is created and check if the
> new commands are available. This will then be used to route our requests
> for new advertisements.
>
> The change is tested by manually verifying that the correct MGMT
> commands are used when the feature is and is not available in kernel.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
>  src/advertising.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index e5f25948d..172a83907 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -57,6 +57,7 @@ struct btd_adv_manager {
>         uint8_t max_ads;
>         uint32_t supported_flags;
>         unsigned int instance_bitmap;
> +       bool extended_add_cmds;
>  };
>
>  #define AD_TYPE_BROADCAST 0
> @@ -1407,6 +1408,51 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
>                 remove_advertising(manager, 0);
>  }
>
> +static void read_commands_complete(uint8_t status, uint16_t length,
> +                                  const void *param, void *user_data)
> +{
> +       struct btd_adv_manager *manager = user_data;
> +       const struct mgmt_rp_read_commands *rp = param;
> +       uint16_t num_commands, num_events;
> +       size_t expected_len;
> +       int i;
> +
> +       if (status != MGMT_STATUS_SUCCESS) {
> +               error("Failed to read supported commands: %s (0x%02x)",
> +                                               mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       if (length < sizeof(*rp)) {
> +               error("Wrong size of read commands response");
> +               return;
> +       }
> +
> +       num_commands = btohs(rp->num_commands);
> +       num_events = btohs(rp->num_events);
> +
> +       expected_len = sizeof(*rp) + num_commands * sizeof(uint16_t) +
> +                                               num_events * sizeof(uint16_t);
> +
> +       if (length < expected_len) {
> +               error("Too small reply for supported commands: (%u != %zu)",
> +                                                       length, expected_len);
> +               return;
> +       }
> +
> +       for (i = 0; i < num_commands; i++) {
> +               uint16_t op = get_le16(rp->opcodes + i);
> +
> +               switch (op) {
> +               case MGMT_OP_ADD_EXT_ADV_PARAMS:
> +                       manager->extended_add_cmds = true;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +}

I wouldn't duplicate the handling of MGMT_OP_READ_COMMANDS, so I would
move this to adapter.c and instead use btd_has_kernel_features in
advertising.c

>  static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>                                                 struct mgmt *mgmt)
>  {
> @@ -1426,6 +1472,7 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>         manager->mgmt_index = btd_adapter_get_index(adapter);
>         manager->clients = queue_new();
>         manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
> +       manager->extended_add_cmds = false;
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         adapter_get_path(manager->adapter),
> @@ -1442,6 +1489,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>                 goto fail;
>         }
>
> +       /* Determine if kernel supports extended advertising add command. We
> +        * don't care if this request fails, as we will fall back to legacy
> +        * add_advertising by default
> +        */
> +       mgmt_send(manager->mgmt, MGMT_OP_READ_COMMANDS, MGMT_INDEX_NONE, 0,
> +                 NULL, read_commands_complete, manager, NULL);
> +
>         return manager;
>
>  fail:
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
Luiz Augusto von Dentz
