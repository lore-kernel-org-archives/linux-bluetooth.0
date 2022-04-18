Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 22:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiDRWoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiDRWoP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 18:44:15 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9652AC78
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 15:41:35 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-d39f741ba0so15643137fac.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Apr 2022 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t20p9CTXRS0D96VY3spv3fQTiJWvjqQMMKXLS5ZiET8=;
        b=GFtLsB/axWJZ7OJqjHYisHqeeeNoATtoSbGdkwm1v/xedgDHodkARebE7eRUGM5iYR
         7EtywBnDDp/zJNZxPsrwkgo5GTXCGCpe8xptItgoHdvkfaiQ4JiUZV7LMDwTwpx15SIv
         AvxgLyiJxTbSc7GbXuxdawys9m1CyS8ZF3M+12iwh/XFY7JoPF2UfQPIrrBm+SV5ZZPd
         UKFBS4cqQeGrgiEMktFsVNHNgS5NHXlj7SNynledLTpQbVLjEf2HnUlJt+HJO7wASz8r
         uswPrOiEFG6CMNNI5eOKw16+Fj7Hr6pHlf0eC4a3uNJxc5wT8Bqtn8mUBUuCrr0v1L5G
         rEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t20p9CTXRS0D96VY3spv3fQTiJWvjqQMMKXLS5ZiET8=;
        b=KSD0ywiori7WIioG1wdCnrQy3dFmbbA09JEwe6384NRijTxB7KEdrwZnIYEQ5YK1oQ
         Vr8YDLPwPIhnbNukvzonQWc6tycesTBTasEw4Twl7QV3+cmMhZjKb3kZ1hjZLeIxq3iO
         MbkQ56lOZnDAaTmZ8PCG3URQOwgY/3Wr+xbcDf5XjRuV9erz8ZM8NHWWyxiHD621nDiO
         Fi4vEygG6tm5LjKvS6RBBYQrWrtWfr2vveg1sryhSe9v6on11HnlQbvAi8teadbO9H0l
         1eV2zIIH+OHcsoEZTcwqmWfNGpEGfhedD0u7oX9Dbq5JTgMs/FPdRBIoWPGcaPkPxMGZ
         o79Q==
X-Gm-Message-State: AOAM530xzbBemVFaCAKX6H+A4iW4HRytsz5FN1FQAggx0f1E1lKhLG6e
        7ORRajzeyn5pHBGi/NqKgtUPRX902CZysixhxBVwbi8M
X-Google-Smtp-Source: ABdhPJww2i5P0SYQJzJnIr/hcLs/3WpoOb4lYBlBd0ZJviMT7AVPDSZkA58siVWWPpuv8LhdNiH5ClMavVJIYwMz1F0=
X-Received: by 2002:a05:6870:4598:b0:e5:bffa:56fb with SMTP id
 y24-20020a056870459800b000e5bffa56fbmr4508820oao.85.1650321694779; Mon, 18
 Apr 2022 15:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com> <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
In-Reply-To: <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 18 Apr 2022 15:41:23 -0700
Message-ID: <CABBYNZL7YZFch1ExcgsFV1AJV2ZBq_dXSyQFR=Zhb9Xjyk66Jg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: Add "Bonded" flag to dbus property
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Mon, Apr 18, 2022 at 10:49 AM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Add "Bonded" to dbus device property table. When setting the "Bonded
> flag, check the status of the Bonded property first. If the Bonded
> property is changed, send property changed signal.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
>
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
>
> Changes in v2:
> - Move one variable declaration to the top following C90 standard
>
> Changes in v1:
> - Add "Bonded" to D-Bus interface
> - Send property changed signal if the bonded flag is changed
>
>  doc/device-api.txt |  4 ++++
>  src/device.c       | 40 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 4e824d2dec17..6162755f954c 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -171,6 +171,10 @@ Properties string Address [readonly]
>
>                         Indicates if the remote device is paired.
>
> +               boolean Bonded [readonly]
> +
> +                       Indicates if the remote device is bonded.

It is probably a good idea to add a description about Bonded vs
Paired. Btw, API documentation should be in a separate patch.

> +
>                 boolean Connected [readonly]
>
>                         Indicates if the remote device is currently connected.
> diff --git a/src/device.c b/src/device.c
> index 8dc12d026827..868c41f025d9 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1042,6 +1042,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean dev_property_get_bonded(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *dev = data;
> +       dbus_bool_t val;
> +
> +       if (dev->bredr_state.bonded || dev->le_state.bonded)
> +               val = TRUE;
> +       else
> +               val = FALSE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
> +
> +       return TRUE;
> +}
> +
>  static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -3120,6 +3136,7 @@ static const GDBusPropertyTable device_properties[] = {
>         { "Icon", "s", dev_property_get_icon, NULL,
>                                         dev_property_exists_icon },
>         { "Paired", "b", dev_property_get_paired },
> +       { "Bonded", "b", dev_property_get_bonded },
>         { "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
>         { "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
>         { "LegacyPairing", "b", dev_property_get_legacy },
> @@ -6114,17 +6131,30 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
>
>  void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
>  {
> +       struct bearer_state *state;
> +
>         if (!device)
>                 return;
>
> -       DBG("");
> +       state = get_state(device, bdaddr_type);
>
> -       if (bdaddr_type == BDADDR_BREDR)
> -               device->bredr_state.bonded = true;
> -       else
> -               device->le_state.bonded = true;
> +       if (state->bonded)
> +               return;
> +
> +       DBG("setting bonded for device to true");
> +
> +       state->bonded = true;
>
>         btd_device_set_temporary(device, false);
> +
> +       /* If the other bearer state was already true we don't need to
> +        * send any property signals.
> +        */
> +       if (device->bredr_state.bonded == device->le_state.bonded)
> +               return;
> +
> +       g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                               DEVICE_INTERFACE, "Bonded");
>  }
>
>  void device_set_legacy(struct btd_device *device, bool legacy)
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>


-- 
Luiz Augusto von Dentz
