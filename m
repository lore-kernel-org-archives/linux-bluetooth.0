Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24542C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0657020708
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWvOhgSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGGSDD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGSDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 14:03:03 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422E3C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 11:03:03 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id q10so4782897ooo.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRr6+HaeKxg8lQrgjOjqWdjOvlKqY55Ck1+poPqVOdg=;
        b=bWvOhgSborB6tGvsTQNao1iQjpbnR5188qmB+yS0gmdkrXna8/lJvMPMDYki5AHeTx
         qYX+4ArReBbrkApxLaDV7h52dEBFm/UggzX9/OLDIVIZHN4ar2Z1GnVJyEWDxb6SEhPH
         5Jcxk6CtzFZaJTfIMTMX3bf31d+gaX1wKEBbNV3uLG9HsQs69jcmYF4nz8p9ZaVcLnCY
         Hev38AJyV3PPNEx+D3mvMwyqsrQofFa5OasHYs5rRhugKtKLRtmr13bJa7Y+zDgIBgHO
         yaP2DAngjEI8nNMpipgTkwLnwfQS5CCVuR3hDN/Fa3h9YTvPhM3VXwpSk5Ee7AEEX1C0
         ng0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRr6+HaeKxg8lQrgjOjqWdjOvlKqY55Ck1+poPqVOdg=;
        b=dzYxpeTaoCPk2248C/9KkGuL2oyLacNj08FaQJhfKCRB3cDK8AlaJ+XVsxdtJcVb9v
         2nw1SeZzN194jWVXrsvrrN3CtPlih/wZ4m0vQ5jaqoPF/npX1/Rav2D5JXJFtS1IfUrq
         SfiUmvqhqrLOkI870vANrIarJLD3lIngvqhZeCAxrwMutXTrYTAxnakYZYFzdrxwwsWG
         nhRx+tFTtAXcJ915lzl5j9hl/IHga9xtwcarEHGzEfw9txA8NsQ0xOGmspHEWLn90s1+
         beXSlNfwV4vCVypHOUYdVAqjcf/9Z55qS+p48Z2W3wh+2fSXg/6kBQ0laVuttorbuRmX
         jQog==
X-Gm-Message-State: AOAM531oVuePyIn6QG2DZhF0FG/sEbjoRw3cPeKrkBrR7QXM9VgCTd4k
        nz3qALhyGuI7rja/CXkIi3ptUrqMU3fhYEgQkvg=
X-Google-Smtp-Source: ABdhPJxLuqeUaA9U3qKfBl+u0p9rqAtkOGEfNNrgxcMU4dpOBSAXjYnYUBEHKxHYLEtbBgibGMiIMRib3CUwic+IYiA=
X-Received: by 2002:a4a:b284:: with SMTP id k4mr9428648ooo.49.1594144982497;
 Tue, 07 Jul 2020 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
In-Reply-To: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jul 2020 11:02:51 -0700
Message-ID: <CABBYNZ+8bZW7qjzVNsSv7Sc_3h-ZwbSa6Hnz=dAX+2AxmWV9Dw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: add device_remove_bonding function
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sat, Jun 27, 2020 at 8:54 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This patch splits the "bonding removal" function in device.c,
> because we need to remove bonding information when receiving
> "virtual cable unplug" in HID profile.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v2: None
>
>  src/device.c | 25 +++++++++++++++----------
>  src/device.h |  1 +
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 7b0eb256e..9fb0e018c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4162,6 +4162,17 @@ static void delete_folder_tree(const char *dirname)
>         rmdir(dirname);
>  }
>
> +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type)
> +{
> +       if (bdaddr_type == BDADDR_BREDR)
> +               device->bredr_state.bonded = false;
> +       else
> +               device->le_state.bonded = false;
> +
> +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> +                                                       bdaddr_type);
> +}
> +
>  static void device_remove_stored(struct btd_device *device)
>  {
>         char device_addr[18];
> @@ -4170,17 +4181,11 @@ static void device_remove_stored(struct btd_device *device)
>         char *data;
>         gsize length = 0;
>
> -       if (device->bredr_state.bonded) {
> -               device->bredr_state.bonded = false;
> -               btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> -                                                               BDADDR_BREDR);
> -       }
> +       if (device->bredr_state.bonded)
> +               device_remove_bonding(device, BDADDR_BREDR);
>
> -       if (device->le_state.bonded) {
> -               device->le_state.bonded = false;
> -               btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> -                                                       device->bdaddr_type);
> -       }
> +       if (device->le_state.bonded)
> +               device_remove_bonding(device, device->bdaddr_type);
>
>         device->bredr_state.paired = false;
>         device->le_state.paired = false;
> diff --git a/src/device.h b/src/device.h
> index 06b100499..907c7c5c4 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -49,6 +49,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
>  uint16_t btd_device_get_vendor_src(struct btd_device *device);
>  uint16_t btd_device_get_product(struct btd_device *device);
>  uint16_t btd_device_get_version(struct btd_device *device);
> +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
>  void device_remove(struct btd_device *device, gboolean remove_stored);

Is there any particular reason why device_remove is not enough here? I
don't see any reason to leave the device object around after removing
its bonding.

>  int device_address_cmp(gconstpointer a, gconstpointer b);
>  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Luiz Augusto von Dentz
