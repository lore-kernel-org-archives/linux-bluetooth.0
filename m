Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F57C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A13207E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHKpKu2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgG1NTG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgG1NTF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 09:19:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114AEC061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 06:19:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q7so21099885ljm.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHyjrA+5bTHGOMjecP6wQzfdSf8jJn8fGl2/bDi+ny4=;
        b=WHKpKu2yFN3kOV1u5Da9POVyeeIw0r/VFUYpd7Xp79gqtuHCS4R8F5ZndJEEHgaG9l
         Vbbwc7UkU67GHo/AGc40v0xDg7uMKo16Zm9INxR1JZZdZ18U4QHAvqs5p5rFatJiF/b4
         SZAWvLp8uzQPMa6PRmJaqR+jOcmytjGeo8HCSACQlxYv2ODQXkQ5vWbHJ4cv7w5js9L4
         2E5D+QyI7ZxrPzkyVOBkyWZUTYdl+n0QXsWbEO1VnM/5sCEx1K/9omNY4z79hbmtENh3
         QPl4Du2PyDIk4VFkKisq43nQKzhH2JWoWNaVfnzX4fWJWpdPhiPqL+1O32l8GIj6waU0
         cQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHyjrA+5bTHGOMjecP6wQzfdSf8jJn8fGl2/bDi+ny4=;
        b=OpKmql7e0GokiRm2aPHGw+QjJd6JnY05Q1O18rkBZVvnS+vE3XotOkwKvQHvs+1KHk
         eZ8w4krIb+ZewMJ80/mzEcDy70hJ0doVHoQqH5rvggw1xBmXMy5GMP4JnlyEkC6cOIRq
         7aDk77YB6Wl1Uwu5jdiTeq+oYTD68ixI1lD2n/5SRsgQKP10umGk6LYLTv12jZrdQCYp
         uU0bNspzCCCceWnrMawUkOuItnEIIo8nv7fQ4XUfuvxxadj5Yb7/ek015eGqo0GcqNST
         QY0W0DMDjH3cwsCKo6UEUAj7wdI+mdCHGL9mKjQtP9dSGFcLjk0eQcv/aLMJ2iXCEh93
         IKlw==
X-Gm-Message-State: AOAM531FiYrqQiViengZ3k/sqibmxakgLTJYbh61PC2nFaFQB9sWBvwj
        aKro0BqIGNkUVjqXtSBmg7rBjeikG84+OZ/CN+HjwA==
X-Google-Smtp-Source: ABdhPJxi0k7kH39QUMobzIvOkUJDJ5bKx1N7wCtfX2/pIt3G1drs62J1umYbZfi51HEJvmI4HE2GGG4hjFr7Kb9l+Nk=
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr13833054ljg.344.1595942343232;
 Tue, 28 Jul 2020 06:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
In-Reply-To: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 28 Jul 2020 09:18:52 -0400
Message-ID: <CALWDO_UsrzyLFkmxcnE59zaZPjP8ByN3sSOLDse6LwwpTA=ZsQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/2] device: add device_remove_bonding function
To:     Archie Pusaka <apusaka@google.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendly ping to maintainers on this one.

Thanks,
Alain

On Thu, Jul 16, 2020 at 2:04 PM Archie Pusaka <apusaka@google.com> wrote:
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
> Changes in v3:
> - Call device_set_temporary on device_remove_bonding
>
> Changes in v2: None
>
>  src/device.c | 28 ++++++++++++++++++----------
>  src/device.h |  1 +
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 226216235..b23ecb7fd 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4356,6 +4356,20 @@ static void delete_folder_tree(const char *dirname)
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
> +       if (!device->bredr_state.bonded && !device->le_state.bonded)
> +               btd_device_set_temporary(device, true);
> +
> +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> +                                                       bdaddr_type);
> +}
> +
>  static void device_remove_stored(struct btd_device *device)
>  {
>         char device_addr[18];
> @@ -4364,17 +4378,11 @@ static void device_remove_stored(struct btd_device *device)
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
> index cb8d884e8..956fec1ae 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -50,6 +50,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
>  uint16_t btd_device_get_vendor_src(struct btd_device *device);
>  uint16_t btd_device_get_product(struct btd_device *device);
>  uint16_t btd_device_get_version(struct btd_device *device);
> +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
>  void device_remove(struct btd_device *device, gboolean remove_stored);
>  int device_address_cmp(gconstpointer a, gconstpointer b);
>  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> --
> 2.27.0.389.gc38d7665816-goog
>
