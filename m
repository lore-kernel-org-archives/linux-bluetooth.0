Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38044C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A3B2065D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1wiDErK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHRXw2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgHRXw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:52:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AFFC061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:52:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o21so19475250oie.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7ZFIgm4SrssRH25wt0REgaY4NV3G1qYm3x1OTRlzQw=;
        b=f1wiDErKi98kZp0IRCVCqe4xLdQ9GcAPFaI3gqTXefAmdBWCRrxvCegthDc5Nwtv1j
         C5Iap963G0j9vN0lZGtwxkC63ftP3CGaEUfeYEfH6/dluX6NUYBxS2UXBA12jGnR7vai
         vDXjqB2ptNMnOXoa3xn5z7Gu5heKxldbbjWbDwfyZZQEKZEcQUjXCAPzB2rlhK5bZuuQ
         JgI0h0tVbVEnOsCLXttpH2m0HqIv884efIuzJ81M9VKNsdI0ieYYJ9O1uUO8PlRR4JyS
         b34553udP6cookDx/3GEpr0NkMctRNKGoybLiGFZ0bncRHVdCnwP3A9cY9WrE20dW07d
         yDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7ZFIgm4SrssRH25wt0REgaY4NV3G1qYm3x1OTRlzQw=;
        b=jJ1jIAPM9iMzpS7iTsGekq5JEynh27LqmoIDgJnNuGtDwbuc5JBGKfv404+kfWdCuJ
         nHO3CPmSrWpmxV+S6m+vrkmyTlwVuIXl6azV+IpXkKFudyqN+hn3+4U94upwgdlWlZL+
         pdBu44NB+iZ/gEsjVpf1EjeR2Vo0mFO5OfvvUo1MNElNTfX8MGPrUWBA8RWRipZ6zw/2
         q+7RzrOoHtO+2wX1kemCZzdTbJq087FnsparKAywlk2BAj1KkfpoG/apfGy/U48JDv1e
         H6uNb7QtBpOvoYzpzng21i0Qk1soxQTj9oEE3NIjbPZojzoL8eycG4on4qFtA5q6BAV0
         nskQ==
X-Gm-Message-State: AOAM532Fqd0vcDE0FCzWYiuHZv4c1rNUjqomUKBPw0vrSc+XBzulPNQH
        5+MhR9U5/VxD9zNA0Up+zgTcXZFQaSE0hCP/azI=
X-Google-Smtp-Source: ABdhPJyX7YD6vmZMsJTwcT958nTvyuF54Nw92ktQLdnE2jjqyIDljGbSHBHLv4mcmGmEr6nFBvfITlfz1vTLCKAw6HQ=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr1637547oig.152.1597794746808;
 Tue, 18 Aug 2020 16:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200817231822.BlueZ.v3.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
In-Reply-To: <20200817231822.BlueZ.v3.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Aug 2020 16:52:16 -0700
Message-ID: <CABBYNZ+JLGtby19K0skYJj1r70tF=XwqdwhMP07tS89Wh76A4w@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] shared/ad: move MAX_ADV_DATA_LEN macro to the header
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

On Mon, Aug 17, 2020 at 11:23 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This moves MAX_ADV_DATA_LEN macro to src/shared/ad.h and rename it to
> BT_AD_MAX_DATA_LEN.
> ---
> Hi Maintainers,
>
> In order to avoid duplicate definition of the maximum data length of
> advertisement for the following series of advertisement monitor API,
> we'd like to reuse the one in shared/ad.
>
> Thanks,
> Miao
>
> Changes in v3:
> - Fix occurrences of MAX_ADV_DATA_LEN.
>
> Changes in v2:
> - Rename the macro to BT_AD_MAX_DATA_LEN.
>
>  src/shared/ad.c | 18 ++++++++----------
>  src/shared/ad.h |  2 ++
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 8d276842e..14a2709b1 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -33,8 +33,6 @@
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>
> -#define MAX_ADV_DATA_LEN 31
> -
>  struct bt_ad {
>         int ref_count;
>         char *name;
> @@ -257,8 +255,8 @@ static size_t name_length(const char *name, size_t *pos)
>
>         len = 2 + strlen(name);
>
> -       if (len > MAX_ADV_DATA_LEN - *pos)
> -               len = MAX_ADV_DATA_LEN - *pos;
> +       if (len > BT_AD_MAX_DATA_LEN - *pos)
> +               len = BT_AD_MAX_DATA_LEN - *pos;
>
>         return len;
>  }
> @@ -426,9 +424,9 @@ static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
>                 return;
>
>         len = strlen(name);
> -       if (len > MAX_ADV_DATA_LEN - (*pos + 2)) {
> +       if (len > BT_AD_MAX_DATA_LEN - (*pos + 2)) {
>                 type = BT_AD_NAME_SHORT;
> -               len = MAX_ADV_DATA_LEN - (*pos + 2);
> +               len = BT_AD_MAX_DATA_LEN - (*pos + 2);
>         }
>
>         buf[(*pos)++] = len + 1;
> @@ -478,7 +476,7 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
>
>         *length = calculate_length(ad);
>
> -       if (*length > MAX_ADV_DATA_LEN)
> +       if (*length > BT_AD_MAX_DATA_LEN)
>                 return NULL;
>
>         adv_data = malloc0(*length);
> @@ -586,7 +584,7 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
>         if (!ad)
>                 return false;
>
> -       if (len > (MAX_ADV_DATA_LEN - 2 - sizeof(uint16_t)))
> +       if (len > (BT_AD_MAX_DATA_LEN - 2 - sizeof(uint16_t)))
>                 return false;
>
>         new_data = queue_find(ad->manufacturer_data, manufacturer_id_data_match,
> @@ -723,7 +721,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
>         if (!ad)
>                 return false;
>
> -       if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
> +       if (len > (BT_AD_MAX_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
>                 return false;
>
>         new_data = queue_find(ad->service_data, service_uuid_match, uuid);
> @@ -942,7 +940,7 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
>         if (!ad)
>                 return false;
>
> -       if (len > (MAX_ADV_DATA_LEN - 2))
> +       if (len > (BT_AD_MAX_DATA_LEN - 2))
>                 return false;
>
>         for (i = 0; i < sizeof(type_blacklist); i++) {
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 19aa1d035..17e3b631b 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -27,6 +27,8 @@
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
>
> +#define BT_AD_MAX_DATA_LEN             31
> +
>  #define BT_AD_FLAGS                    0x01
>  #define BT_AD_UUID16_SOME              0x02
>  #define BT_AD_UUID16_ALL               0x03
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
