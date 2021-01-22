Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2356C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D37239D4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 01:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbhAVBZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbhAVBZv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 20:25:51 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC01C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 17:25:11 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so5330854ejf.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 17:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RX3QzdG1HcUYf4YnKTPVMeGoosIWX5F2L1DcMIUrtLg=;
        b=AsYOrRe+QpzFCBf8UtSgBtV647mcEmA2iKssqWvJxTO2qDmBNpk2DFJnbty61NQLie
         m1v/mQff3BsNSscE7Onlm5CcUu2Z4XIQjJebACkv3PmA1e8z/NYJVSdz1K7aqON5ECWy
         Gy06qVqr2+iGVwmzeDgxHwkC0fMXtLBEP4swk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RX3QzdG1HcUYf4YnKTPVMeGoosIWX5F2L1DcMIUrtLg=;
        b=Hc2NOG2fmkjeR9beTBzpI/MJr4N87oCKoBN6KFe93VVbVermYQzgFAJP3qrycppdjq
         IyRmEb3gXrbijFNJUpZ3CYGzkwTbnO5+/T1M2GPQqBOKm52ug562kqFedB61MG+grdWI
         Kc6aVZDNxevr6Zg2+9n6iQb/xoD70kTZTpj/DoLjTrpFmwfrIoYJLILgu9ls/TpI/7Gl
         dO4Khrfp1PuTS8AKdT69wBZA1TK9IJmsFfT2u1ehl1LG6QgdF4bkp3+2iw4QwcHGeZX2
         g5Pm2rmXqb0TYrw4RtMQkr3KAS9xhMmqrbf8snsn9U3wxl4jpCfJAkwFZJwmHG9lVAA1
         mugw==
X-Gm-Message-State: AOAM531nWrCCduyIAfw1DEHAkFKQEtGMY90TYKNe+J18pQ5DFfmyrYB6
        yolVV/829YUAVGfFpfZ6XQdANeQUOAAMWg==
X-Google-Smtp-Source: ABdhPJw7/6iQUIyC+Kj1+YrdogvKhxZNifjDkdGAWyT4O+wI92xwYXC1n7szKJ2e0emoAIUGrxm3hg==
X-Received: by 2002:a17:907:94c8:: with SMTP id dn8mr1437163ejc.512.1611278709893;
        Thu, 21 Jan 2021 17:25:09 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id fi12sm3189789ejb.49.2021.01.21.17.25.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 17:25:09 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id l12so3582955wry.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 17:25:09 -0800 (PST)
X-Received: by 2002:adf:f891:: with SMTP id u17mr1994878wrp.253.1611278708834;
 Thu, 21 Jan 2021 17:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org>
 <20210122001326.14263-2-sonnysasaka@chromium.org> <CABBYNZJs_rzBSHOjvqg5F4u6gxX7LcNUc77KtzHEr5L7Y5Zd-A@mail.gmail.com>
In-Reply-To: <CABBYNZJs_rzBSHOjvqg5F4u6gxX7LcNUc77KtzHEr5L7Y5Zd-A@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 21 Jan 2021 17:24:56 -0800
X-Gmail-Original-Message-ID: <CAO271mkMtmDm_MayCX-+Dddg3aL1uv=GD3egCGJ6gDCEHowp8g@mail.gmail.com>
Message-ID: <CAO271mkMtmDm_MayCX-+Dddg3aL1uv=GD3egCGJ6gDCEHowp8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Do not create UHID if report map
 is broken
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Jan 21, 2021 at 4:37 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Jan 21, 2021 at 4:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > The report map in the cache could be dirty, for example when reading a
> > report map from peer was cancelled, we should be able to detect it and
> > not try to create UHID. Instead we will read it again from the peer.
>
> Don't we clean the cache if it had failed? Or you meant to say the
> read long procedure was not complete so we got just part of the report
> map?
Looks like this is the case. It happened to me once when I cancel
reconnection (trigger pairing mode during reconnection) from the
keyboard side. It's hard to confirm since I have to get the timing
right.

> In that case we should have failed
I agree. However it seems that the code already tries to fail by
looking at the status inside report_map_read_cb, but somehow it still
gets through. It could be the keyboard bug that we have to detect
anyway?

> also if we need to protect
> uhid from malformed report map, which sounds like a kernel bug, then
> we should at least have it inside bt_uhid instance so we can at least
> attempt to have some unit testing done with broken report maps.
>
> > ---
> >  profiles/input/hog-lib.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > index 089f42826..d6a3bda4d 100644
> > --- a/profiles/input/hog-lib.c
> > +++ b/profiles/input/hog-lib.c
> > @@ -946,7 +946,7 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> >         struct uhid_event ev;
> >         ssize_t vlen = report_map_len;
> >         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > -       int i, err;
> > +       int i, err, collection_depth = 0;
> >         GError *gerr = NULL;
> >
> >         DBG("Report MAP:");
> > @@ -960,6 +960,14 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> >                         if (!long_item && (value[i] & 0xfc) == 0x84)
> >                                 hog->has_report_id = TRUE;
> >
> > +                       // Start Collection
> > +                       if (value[i] == 0xa1)
> > +                               collection_depth++;
> > +
> > +                       // End Collection
> > +                       if (value[i] == 0xc0)
> > +                               collection_depth--;
> > +
> >                         DBG("\t%s", item2string(itemstr, &value[i], ilen));
> >
> >                         i += ilen;
> > @@ -968,10 +976,15 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> >
> >                         /* Just print remaining items at once and break */
> >                         DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> > -                       break;
> > +                       return;
> >                 }
> >         }
> >
> > +       if (collection_depth != 0) {
> > +               error("Report Map error: unbalanced collection");
> > +               return;
> > +       }
> > +
> >         /* create uHID device */
> >         memset(&ev, 0, sizeof(ev));
> >         ev.type = UHID_CREATE;
> > @@ -1365,7 +1378,9 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> >                          * UHID to optimize reconnection.
> >                          */
> >                         uhid_create(hog, report_map.value, report_map.length);
> > -               } else {
> > +               }
> > +
> > +               if (!hog->uhid_created) {
> >                         read_char(hog, hog->attrib, value_handle,
> >                                                 report_map_read_cb, hog);
> >                 }
> > --
> > 2.29.2
> >
>
>
> --
> Luiz Augusto von Dentz
