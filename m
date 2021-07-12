Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5631AC07E96
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C2D6103E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 03:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhGLDXI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Jul 2021 23:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhGLDXH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Jul 2021 23:23:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA4C0613DD
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 20:20:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bu12so31679090ejb.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBGwT55KZMW6nT6ccK0tHsaonJzQURHuXC6ZcLj6PCA=;
        b=Z9DbHsHuRGEdkHa29KGQbj3lpHcyAR6M+3BjpEqj3wGErxHcgK5RHg5ABPnoQmcIiT
         6tdTkJcwMVlCCim5KLEgpMgwDrDPf2sua83bI/ddo6oswksgX8PIzOGvQIBDfP3fGEwf
         ZXeqhHIJ8UztlqznJnc8gK/aQpTgwk90fgtuEUe6jscprQlwa7SKogSCmc4Ex7dZTgkP
         i4yK3XW559zX9F4lbQvkMzcNGW/gfzTbn5CZy1R5xEBLgfVqDIJifg4XCEXxl0ClOJxJ
         retBWaMcyo8OWH+tyFWMBlrx2M0HNxLpQx5srIvsBJp1C6moJIlgWHg+ehXKrtQ+0gi0
         pcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBGwT55KZMW6nT6ccK0tHsaonJzQURHuXC6ZcLj6PCA=;
        b=aGcZ5C10c6oDFtQ1l6KMDJWv9/hy3u+ZeZr3kpQKh8hDWLClBKzXpr4hyFkbeZOJf9
         CAc5KfKVtEsx0oLyUNKb9pPaOBGeD5r/iSfDeZZYCUtzdZik18gXZluCrsCnPsXj0LBK
         yGe25CinbEnkGndHvynidQnuzZTDsjNyzDsXFe7bQb/Efz3gPyIZzVDnWZyPrMUTOcBy
         jML0l9x0XMsASCevMQAOH+o+q8ksvMnlcrXHCUN19+890UA0bfZlEyAm/NO95h/rnOC5
         fh5vfShnqS750AZn4PFXrr4ci19Emr21bHM5pGPy9z2K0GCFEOItEVJoM3RL5l3I0laH
         rRqw==
X-Gm-Message-State: AOAM532W8Lc5vpqacu+FdatLxHHGm3q5KiJ9XKvQYBqC8LB8BFpQGqW1
        s/vv9uUfLo7z6A8P6Cv9peueN7m0jl56mHw/4n5llA==
X-Google-Smtp-Source: ABdhPJxSfNsbm7HNvR9O2PbRJ1RKapDv84LTOg7b031O+q+eqpa36nAuZRKa03AOdDVDchoSG+Us9PaPKjRSvNM8cSA=
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr49799717ejz.151.1626060017895;
 Sun, 11 Jul 2021 20:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
 <20210708142059.Bluez.v1.1.I69278fab3bf86adb578c5cba0a39e5bcf7f9581e@changeid>
 <CABBYNZKjc+2ur81SR2_jTiba6SgxNQh9piXqhmfKro511=QN8Q@mail.gmail.com>
In-Reply-To: <CABBYNZKjc+2ur81SR2_jTiba6SgxNQh9piXqhmfKro511=QN8Q@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Mon, 12 Jul 2021 11:20:06 +0800
Message-ID: <CAPHZWUe4XGpAhCCHquZynbEw_btw9LHM52V9-_N4pY_5a4xvBA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 01/14] lib: add hash functions for bt_uuid_t
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Got it. Will move bt_uuid_hash and bt_uuid_equal to src/adapter.c

On Fri, Jul 9, 2021 at 1:21 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
> >
> > This adds function GHashFunc and GEqualFunc for bt_uuid_t.
> > With these functions, we can add uuids into a GHashTable with bt_uuid_t
> > format.
>
> We will likely move away from GLib dependency so I wouldn't want to
> introduce a dependency to it specially as part of libbluetooth.
>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> >  lib/uuid.c | 27 +++++++++++++++++++++++++++
> >  lib/uuid.h |  3 +++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/lib/uuid.c b/lib/uuid.c
> > index 3d97dc8359c7..a09f5c428b87 100644
> > --- a/lib/uuid.c
> > +++ b/lib/uuid.c
> > @@ -16,6 +16,7 @@
> >  #include <string.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > +#include <glib.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "uuid.h"
> > @@ -120,6 +121,32 @@ int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2)
> >         return bt_uuid128_cmp(&u1, &u2);
> >  }
> >
> > +guint bt_uuid_hash(gconstpointer key)
> > +{
> > +       const bt_uuid_t *uuid = key;
> > +       bt_uuid_t uuid_128;
> > +       uint64_t *val;
> > +
> > +       if (!uuid)
> > +               return 0;
> > +
> > +       bt_uuid_to_uuid128(uuid, &uuid_128);
> > +       val = (uint64_t *)&uuid_128.value.u128;
> > +
> > +       return g_int64_hash(val) ^ g_int64_hash(val+1);
> > +}
> > +
> > +gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2)
> > +{
> > +       const bt_uuid_t *uuid1 = v1;
> > +       const bt_uuid_t *uuid2 = v2;
> > +
> > +       if (!uuid1 || !uuid2)
> > +               return !uuid1 && !uuid2;
> > +
> > +       return bt_uuid_cmp(uuid1, uuid2) == 0;
> > +}
> > +
> >  /*
> >   * convert the UUID to string, copying a maximum of n characters.
> >   */
> > diff --git a/lib/uuid.h b/lib/uuid.h
> > index 1a4029b68730..e47ccccb9fd2 100644
> > --- a/lib/uuid.h
> > +++ b/lib/uuid.h
> > @@ -17,6 +17,7 @@ extern "C" {
> >  #endif
> >
> >  #include <stdint.h>
> > +#include <glib.h>
> >
> >  #define GENERIC_AUDIO_UUID     "00001203-0000-1000-8000-00805f9b34fb"
> >
> > @@ -167,6 +168,8 @@ int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
> >
> >  int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
> >  void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
> > +guint bt_uuid_hash(gconstpointer key);
> > +gboolean bt_uuid_equal(gconstpointer v1, gconstpointer v2);
> >
> >  #define MAX_LEN_UUID_STR 37
> >
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
>
> --
> Luiz Augusto von Dentz
