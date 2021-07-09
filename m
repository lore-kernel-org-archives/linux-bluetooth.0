Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C6C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0512561442
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhGIFYA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhGIFX7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 01:23:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF8C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 22:21:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o139so12719044ybg.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7glaz09LYK1wgJStu1fhPymyoFrPcqtPcZcOpaCWbGE=;
        b=lSQLveN6qOBiYywViZLOtei7SSgIciQqrbVMcJWZK9uYXBfSYcwj5ivEmMqXohVc05
         X2q+6Z+b/Bd5zDo3sT5toZ9kaMZEjPS3QOCEbUf5PQq7NSISUETS1pkxayC/13jSyVNS
         /inLuvulmcPiTO9ozcztiFTMxzKK+Luj75HHLz9pzuoEYmMr9UXlxNK4m/d41KA7bT7I
         J4XPaNtZC8KTDUvTJwBn3XAvkmUa6E2GABcT9p7f9+f7SK9hHUNurT9MVKtDMhYqdUos
         8j2OPJZqLZGfCL3VZkZIOTPa7Lx4JoidKB4MtvNw0o4g9ZfFASURPMFxV0zBpq0A15EH
         bxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7glaz09LYK1wgJStu1fhPymyoFrPcqtPcZcOpaCWbGE=;
        b=jC1FV1AY8WcLL7ZQTAYbW+Bol010mtaL27qQg25Vz+0+GFl/RLPs/Xom9MAK/ulNnf
         bTXqP425wRreN9yW6O3VVtOFYb8jnsoaOH2Ee2SB+pACHZDUKn8FExtmhiGJOs3BFT1K
         ZbN3iDFgDRbC5I1TGqI4nghbIiANyPH2n/hhGO+V+p/QxD7It/N9+AofN+xZ6F3JDHha
         OVb0DYHy62xmvimFf8mV+1HootdI+X2ps/yCLmPcoNt9K/kS4wEv0aMZpA3W6aWo0hxD
         nscBlOhi4gsGmodR5e5RoFDwnGP0weaLX3DIFRsJ8vYKgJ7phBSWd2vcsv7Dqav+F/Th
         g6mA==
X-Gm-Message-State: AOAM531Ou71uHand2WFWbrqEkThAakvksS/Mpj5oKeVu0y/Q4Nk/VfgA
        IGQk4EF+z/B5Xpai5o+w2ZQrLUICsqQOZ5QH47I=
X-Google-Smtp-Source: ABdhPJwbRduPDHCE480o0O8emYt6e7Sw5/PJ+Av88QE1s/0MrEl/2vzCJgnpHAV8XPNPEj9kOjYf4unOWSoskxZqvuk=
X-Received: by 2002:a25:b741:: with SMTP id e1mr45646724ybm.347.1625808075135;
 Thu, 08 Jul 2021 22:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com> <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
In-Reply-To: <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jul 2021 22:21:04 -0700
Message-ID: <CABBYNZKjc+2ur81SR2_jTiba6SgxNQh9piXqhmfKro511=QN8Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 01/14] lib: add hash functions for bt_uuid_t
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
>
> This adds function GHashFunc and GEqualFunc for bt_uuid_t.
> With these functions, we can add uuids into a GHashTable with bt_uuid_t
> format.

We will likely move away from GLib dependency so I wouldn't want to
introduce a dependency to it specially as part of libbluetooth.

> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
>  lib/uuid.c | 27 +++++++++++++++++++++++++++
>  lib/uuid.h |  3 +++
>  2 files changed, 30 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 3d97dc8359c7..a09f5c428b87 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -16,6 +16,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <errno.h>
> +#include <glib.h>
>
>  #include "lib/bluetooth.h"
>  #include "uuid.h"
> @@ -120,6 +121,32 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
>         return bt_uuid128_cmp(&u1, &u2);
>  }
>
> +guint bt_uuid_hash(gconstpointer key)
> +{
> +       const bt_uuid_t *uuid = key;
> +       bt_uuid_t uuid_128;
> +       uint64_t *val;
> +
> +       if (!uuid)
> +               return 0;
> +
> +       bt_uuid_to_uuid128(uuid, &uuid_128);
> +       val = (uint64_t *)&uuid_128.value.u128;
> +
> +       return g_int64_hash(val) ^ g_int64_hash(val+1);
> +}
> +
> +gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
> +{
> +       const bt_uuid_t *uuid1 = v1;
> +       const bt_uuid_t *uuid2 = v2;
> +
> +       if (!uuid1 || !uuid2)
> +               return !uuid1 && !uuid2;
> +
> +       return bt_uuid_cmp(uuid1, uuid2) == 0;
> +}
> +
>  /*
>   * convert the UUID to string, copying a maximum of n characters.
>   */
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 1a4029b68730..e47ccccb9fd2 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -17,6 +17,7 @@ extern "C" {
>  #endif
>
>  #include <stdint.h>
> +#include <glib.h>
>
>  #define GENERIC_AUDIO_UUID     "00001203-0000-1000-8000-00805f9b34fb"
>
> @@ -167,6 +168,8 @@ int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
>
>  int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
>  void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
> +guint bt_uuid_hash(gconstpointer key);
> +gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2);
>
>  #define MAX_LEN_UUID_STR 37
>
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
