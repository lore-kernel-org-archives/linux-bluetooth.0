Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB333C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D3122D50
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAVAht (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhAVAhs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 19:37:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E9C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:37:07 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i30so3536833ota.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5i56K0I7ZdhnCIYqtGHUbHZDBLfP42ZPr3xc2gKRjE=;
        b=PN2YgnEd8nEjRWPNBHOlt6JDRyFhvIrMojpWgcRDjq78bjJ61qFmX/r8b7VjODXInT
         SoWlRddNmDZWZhHjrZi9X6eZaIcAebH1hh4s0HpH8PB7NEyJr9ZHtjlPPbwlsiWoD5Sy
         f7InGFqR2/Rc0jag+V0ncCYQ8EgO4x2DmJXdxxGUHnVv3F9VrTnDzQXThWvlMjjPO1pi
         qwLKD3jwGWjky3/xMx8BV0eHWtcU37WvU3jbJeUqfXSf9cKpW1Y5415TE+Ff4ldu1nuJ
         bUduFA5W0Pdcq//5nls8IxxRhPuTPdM00W+N41DcTjRnNPLBGcUP7SCCpFAiBjGVP5WZ
         NvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5i56K0I7ZdhnCIYqtGHUbHZDBLfP42ZPr3xc2gKRjE=;
        b=lcHQxJxtRdvoWJEM8SGx2aPY2QQ7PT0qqvXwmi5IwTxoYcggZT3QdILQp2dUEiqB3J
         o5OKqB6cGJTrHkScOZK88ZoZge1A4Ud5cYPPgJF2Kkqmg9IiBIPBydL8Bi0b+k/jonS6
         GBwxDIS+rUfeHy6fhvZ0R6ZG6fJPrAr+4YmcTg4LlMqOuoGn9SqO9xGoSp/bh6E1/FTt
         NTgjiueh8Oalmq09HJ/1/91tWTbeVmFwmzl/rwrdueSZXV1/SnXs+TzNn6CUEsDBwDHJ
         37hOsiAosTP8Hl4xLmDz5fGT5D1n0CCKGtqn3NBlh2LhfIvj09rkoiIksVsOXi2wHhQP
         AXmg==
X-Gm-Message-State: AOAM530mdpRX3IwIJ7p9cH/Z6aWCrcIa4yH6fORfLR8npIEBw+4+i36u
        VTJq7hEW6KUO0DMq+hQNs6KjLmb59+YUBI7VQ58=
X-Google-Smtp-Source: ABdhPJzdkIFxRnyuq6DVYtlwFWfDpl2+kDvxelwkVxlXK1PBNvGsUx2ITAhBXF2SNEtGHLpfHaSs4dpXLjKRpnP30+c=
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr1430413otp.240.1611275826358;
 Thu, 21 Jan 2021 16:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org> <20210122001326.14263-2-sonnysasaka@chromium.org>
In-Reply-To: <20210122001326.14263-2-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jan 2021 16:36:55 -0800
Message-ID: <CABBYNZJs_rzBSHOjvqg5F4u6gxX7LcNUc77KtzHEr5L7Y5Zd-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Do not create UHID if report map
 is broken
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Jan 21, 2021 at 4:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> The report map in the cache could be dirty, for example when reading a
> report map from peer was cancelled, we should be able to detect it and
> not try to create UHID. Instead we will read it again from the peer.

Don't we clean the cache if it had failed? Or you meant to say the
read long procedure was not complete so we got just part of the report
map? In that case we should have failed, also if we need to protect
uhid from malformed report map, which sounds like a kernel bug, then
we should at least have it inside bt_uhid instance so we can at least
attempt to have some unit testing done with broken report maps.

> ---
>  profiles/input/hog-lib.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 089f42826..d6a3bda4d 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -946,7 +946,7 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
>         struct uhid_event ev;
>         ssize_t vlen = report_map_len;
>         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> -       int i, err;
> +       int i, err, collection_depth = 0;
>         GError *gerr = NULL;
>
>         DBG("Report MAP:");
> @@ -960,6 +960,14 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
>                         if (!long_item && (value[i] & 0xfc) == 0x84)
>                                 hog->has_report_id = TRUE;
>
> +                       // Start Collection
> +                       if (value[i] == 0xa1)
> +                               collection_depth++;
> +
> +                       // End Collection
> +                       if (value[i] == 0xc0)
> +                               collection_depth--;
> +
>                         DBG("\t%s", item2string(itemstr, &value[i], ilen));
>
>                         i += ilen;
> @@ -968,10 +976,15 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
>
>                         /* Just print remaining items at once and break */
>                         DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> -                       break;
> +                       return;
>                 }
>         }
>
> +       if (collection_depth != 0) {
> +               error("Report Map error: unbalanced collection");
> +               return;
> +       }
> +
>         /* create uHID device */
>         memset(&ev, 0, sizeof(ev));
>         ev.type = UHID_CREATE;
> @@ -1365,7 +1378,9 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
>                          * UHID to optimize reconnection.
>                          */
>                         uhid_create(hog, report_map.value, report_map.length);
> -               } else {
> +               }
> +
> +               if (!hog->uhid_created) {
>                         read_char(hog, hog->attrib, value_handle,
>                                                 report_map_read_cb, hog);
>                 }
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
