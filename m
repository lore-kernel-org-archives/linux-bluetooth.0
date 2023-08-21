Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89863EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjHUSAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 14:00:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D8A110
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:00:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bbbda48904so39041101fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692640827; x=1693245627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP8zqiKP2hGHJo3TmxzH0aRVwVwv3QMmOI7bKKbW/GU=;
        b=UWBBDfuoZvmwRCn6Fz5CByx7gAD+tf2Da3lJ+pgwkZ4vQbyYFEhZzLNg1w+kZKq0fq
         73QVFHrya8Iv1SUV2afddAthjRGCIfjDvltsWZnl3Mf1VYF4W0Difw7FVRix7J4JE1mY
         mwF8zspkcmCYwj8nrKsJWuHHnJ7IGZEMxIPoGaprPe9Z5+3MAk0+Be44TNkoxLk871BX
         fxzyQCS0/b8jcqwaG+qSRJ56wvVaGr7ONhQK2Uf8Evr2yneZHJ1lC6v49rmX7efmICyh
         kGrDSqN+fWVPJquekojmOHNkOl1WfPgsLX0Vp5Zdz8x/rLt21gW5rizdPrDEW5tBW5ZD
         npRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640827; x=1693245627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP8zqiKP2hGHJo3TmxzH0aRVwVwv3QMmOI7bKKbW/GU=;
        b=MQGeqgosgJpXADIUYyrxYTRsNePfBEbfZ5C7y4PJDehAF5R52An4uN0lLU4eqHjlny
         LHT7HTf0gdsD3J+KtoNgz5qHcezc6B5R2RI9XT22t0X3CsVjqIJ6skY6KSPFcU6Xh6is
         4+VJCMrLBCKAyRmSPciRvQoA0fm/PSfZGydYMnx9VrU5LuRWE7LYHlRMJzQzpfTB2Mf4
         gzceQsEPoGztpR7w0uhZrku/xUMIvlOgRsjDoYT90daLosmEIrCkIBRhnNktABAC122f
         MQMQaLH9JbyO3kIBCK30bClm4vFlsOPZQJvGPHRUhavAzoxf9d888GL//I4HBHI9ldOK
         u1Ig==
X-Gm-Message-State: AOJu0YzSkEJqZlzmR5YYI+B/6QwpEeNd6aWxjpNt+yDTJ9ZJS54WT8R6
        EjhlENDjf8Y3X/ACvx8Z69wTbar9SH5geR87+r0JU5NQ+rM=
X-Google-Smtp-Source: AGHT+IER6TJ/794u1erdOZMUfykeF4mYlkvDlk2AieMZFfSlmsNtv9cyah4kQraMYW6Wzw3Kz6ZtPcSwI+nLb/lSA/0=
X-Received: by 2002:a2e:b0cd:0:b0:2b0:297c:cbdf with SMTP id
 g13-20020a2eb0cd000000b002b0297ccbdfmr5625060ljl.1.1692640826997; Mon, 21 Aug
 2023 11:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
In-Reply-To: <20230821102810.Bluez.v1.1.Ib819b0964a5b8339305d94611acab85774a6c8ce@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Aug 2023 11:00:14 -0700
Message-ID: <CABBYNZK8SW9aMHL-yrCQUN+72z_rDZWK83wAdutMA8xG-Zdo9A@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: check wake_override when setting device privacy
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 10:28=E2=80=AFAM Zhengping Jiang <jiangzp@google.co=
m> wrote:
>
> For the device using a RPA, hog_probe sets wake_override to true, but
> the command to set remote wakeup fails because the device has not been
> added to the kernel and the connection with the public address cannot be
> found.

This is actually not true, hog_probe does call
device_set_wake_support, also note that I had a fix on how we handle
RPA with remote wakeup because that depends on LL Privacy/RPA
Resolution:

commit 7a4b67f9caa6bdc004c910f3a52108744a8cab74
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu May 12 16:40:49 2022 -0700

    device: Fix enabling wake support without RPA Resolution

    If device uses RPA it shall only enable wakeup if RPA Resolution has
    been enabled otherwise it cannot be programmed in the acceptlist which
    can cause suspend to fail.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215768


> When setting the device privacy flag, the wakeup flag should be set
> according to the wake_override, instead of the current flags.

Afaik wake_override is only set by the user via WakeAllowed, plugins
shall not be using it directly, so it really sounds like this doesn't
apply to current upstream.

> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
>
> Changes in v1:
> - Add function to fetch wake_override value
> - Set the remote wakeup bit if privacy mode is used when setting flags
>
>  src/adapter.c | 2 ++
>  src/device.c  | 5 +++++
>  src/device.h  | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 004062e7c..f63018495 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5520,6 +5520,8 @@ static void add_device_complete(uint8_t status, uin=
t16_t length,
>         if (btd_opts.device_privacy) {
>                 uint32_t flags =3D btd_device_get_current_flags(dev);
>
> +               if (device_get_wake_override(dev))
> +                       flags |=3D DEVICE_FLAG_REMOTE_WAKEUP;

We shall only use override if wake_support is set.

>                 /* Set Device Privacy Mode has not set the flag yet. */
>                 if (!(flags & DEVICE_FLAG_DEVICE_PRIVACY)) {
>                         adapter_set_device_flags(adapter, dev, flags |
> diff --git a/src/device.c b/src/device.c
> index 9b58e0c4e..ae75f2fd1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1545,6 +1545,11 @@ void device_set_wake_override(struct btd_device *d=
evice, bool wake_override)
>         }
>  }
>
> +bool device_get_wake_override(struct btd_device *device)
> +{
> +       return device->wake_override;
> +}
> +
>  static void device_set_wake_allowed_complete(struct btd_device *device)
>  {
>         if (device->wake_id !=3D -1U) {
> diff --git a/src/device.h b/src/device.h
> index 3252e14ef..79377a13a 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -141,6 +141,7 @@ void device_set_wake_support(struct btd_device *devic=
e, bool wake_support);
>  void device_set_wake_override(struct btd_device *device, bool wake_overr=
ide);
>  void device_set_wake_allowed(struct btd_device *device, bool wake_allowe=
d,
>                              guint32 id);
> +bool device_get_wake_override(struct btd_device *device);
>  void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean re=
moval,
> --
> 2.42.0.rc1.204.g551eb34607-goog
>


--=20
Luiz Augusto von Dentz
