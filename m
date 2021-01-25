Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19877C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 21:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD9222573
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbhAYVyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732753AbhAYVvq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 16:51:46 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F7C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 13:51:05 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 63so14328303oty.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 13:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTA3kB/Mydaw2KlrLqqpgLE+MoVNDdVc9J2h89r6tlM=;
        b=PMKkXmbk8O6VgmemFY1N3BZztCRiX9hDnJSGbjFE4bcjz3wvUlREHJYJRs2hSjMp2j
         CZOVBrEkCCPeJ+7mRQrR2WpBjM1IFGB/jhTiyd7flLQzQj1GgTKR1X+e5NmR24zT0Kn0
         iAR3Spk+fiLqrkcxykIKLuPihhlsidAMZtI7WMHj3UkhBuISWpvbVBzDcrsGxRIuEmHs
         rLql0qCU35qaTLxQhTKPnyzVXbg5yD3/9CbUS4fVJk6KHkJ54tEfWd6rO1pm5YymqtTo
         5c45bRlbizbZHdW8A2FvPljVyxZaz5c7W+ItZpw/AuL1fwH8r17KNpKWoTD0Zs53GyfU
         vX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTA3kB/Mydaw2KlrLqqpgLE+MoVNDdVc9J2h89r6tlM=;
        b=mwQY6c48z6AawWwoD68GOVy64mEehMgAWpnoT6ZylStn862/ExjOFrtt7517wOk3HM
         7ggBmMY/nqkefDAcPV5gpRjgcXDnoUPnqUukuSd1P697c/jzWmLAoj4CNVtr+plBBUXh
         r9pd4kts56lronkj4kmNo5QiveV7BHmsDrLJgFf4x53hwDa5KUDfY1TIfjBdtyl5X6AL
         pu37mgvrThWlZjnONrSQ1efCbTefJH3w+nu+lHKdGYsgN2mfsI7y8ebGaM+AwgxAdUjF
         Tl4aDc1Dyyphc4iaCnWpQd8VvpLjaDwilM7bxYR3AeWfq3w3/imdVCGKjQURu6w3On49
         twcQ==
X-Gm-Message-State: AOAM531AOYYVcUkI5CKvJ00PCSXWlzoOZIya8xZOtJ+3VfuJ7J9/phP2
        uMmVvLVJ4HmKIGD1YvYZ+d9LmfrfPZmd+reJARU=
X-Google-Smtp-Source: ABdhPJzltjrJ2iUEZeXqxQZYRsSPcuatLmXmitijpiseaGD1gfiwN341nqpCH6z98Kr5y92JmOp5Wc/NmikrZteZmeU=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr1757874ota.44.1611611465271;
 Mon, 25 Jan 2021 13:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org>
 <20210122001326.14263-2-sonnysasaka@chromium.org> <CABBYNZJs_rzBSHOjvqg5F4u6gxX7LcNUc77KtzHEr5L7Y5Zd-A@mail.gmail.com>
 <CAO271mkMtmDm_MayCX-+Dddg3aL1uv=GD3egCGJ6gDCEHowp8g@mail.gmail.com> <CAO271mkhpd8KOA=a3E66VpJUj01PONjmpS=m+U9MtwSWnUQ6BA@mail.gmail.com>
In-Reply-To: <CAO271mkhpd8KOA=a3E66VpJUj01PONjmpS=m+U9MtwSWnUQ6BA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Jan 2021 13:50:54 -0800
Message-ID: <CABBYNZ+GazVResDzTtP4Oyt+duG4iNnPEC7CDu8JB5iPsrfzCw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Do not create UHID if report map
 is broken
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Jan 25, 2021 at 11:36 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> I have been trying to reproduce the issue again but it turns out to be
> very rare. Let's defer this patch until I can get a clear log of what
> is happening and why we get the corrupted cache.

Ok, let me update in the pw, if you see this again let me know.

>
>
> On Thu, Jan 21, 2021 at 5:24 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, Jan 21, 2021 at 4:37 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Thu, Jan 21, 2021 at 4:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > The report map in the cache could be dirty, for example when reading a
> > > > report map from peer was cancelled, we should be able to detect it and
> > > > not try to create UHID. Instead we will read it again from the peer.
> > >
> > > Don't we clean the cache if it had failed? Or you meant to say the
> > > read long procedure was not complete so we got just part of the report
> > > map?
> > Looks like this is the case. It happened to me once when I cancel
> > reconnection (trigger pairing mode during reconnection) from the
> > keyboard side. It's hard to confirm since I have to get the timing
> > right.
> >
> > > In that case we should have failed
> > I agree. However it seems that the code already tries to fail by
> > looking at the status inside report_map_read_cb, but somehow it still
> > gets through. It could be the keyboard bug that we have to detect
> > anyway?
> >
> > > also if we need to protect
> > > uhid from malformed report map, which sounds like a kernel bug, then
> > > we should at least have it inside bt_uhid instance so we can at least
> > > attempt to have some unit testing done with broken report maps.
> > >
> > > > ---
> > > >  profiles/input/hog-lib.c | 21 ++++++++++++++++++---
> > > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > > > index 089f42826..d6a3bda4d 100644
> > > > --- a/profiles/input/hog-lib.c
> > > > +++ b/profiles/input/hog-lib.c
> > > > @@ -946,7 +946,7 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > > >         struct uhid_event ev;
> > > >         ssize_t vlen = report_map_len;
> > > >         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > > > -       int i, err;
> > > > +       int i, err, collection_depth = 0;
> > > >         GError *gerr = NULL;
> > > >
> > > >         DBG("Report MAP:");
> > > > @@ -960,6 +960,14 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > > >                         if (!long_item && (value[i] & 0xfc) == 0x84)
> > > >                                 hog->has_report_id = TRUE;
> > > >
> > > > +                       // Start Collection
> > > > +                       if (value[i] == 0xa1)
> > > > +                               collection_depth++;
> > > > +
> > > > +                       // End Collection
> > > > +                       if (value[i] == 0xc0)
> > > > +                               collection_depth--;
> > > > +
> > > >                         DBG("\t%s", item2string(itemstr, &value[i], ilen));
> > > >
> > > >                         i += ilen;
> > > > @@ -968,10 +976,15 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > > >
> > > >                         /* Just print remaining items at once and break */
> > > >                         DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> > > > -                       break;
> > > > +                       return;
> > > >                 }
> > > >         }
> > > >
> > > > +       if (collection_depth != 0) {
> > > > +               error("Report Map error: unbalanced collection");
> > > > +               return;
> > > > +       }
> > > > +
> > > >         /* create uHID device */
> > > >         memset(&ev, 0, sizeof(ev));
> > > >         ev.type = UHID_CREATE;
> > > > @@ -1365,7 +1378,9 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> > > >                          * UHID to optimize reconnection.
> > > >                          */
> > > >                         uhid_create(hog, report_map.value, report_map.length);
> > > > -               } else {
> > > > +               }
> > > > +
> > > > +               if (!hog->uhid_created) {
> > > >                         read_char(hog, hog->attrib, value_handle,
> > > >                                                 report_map_read_cb, hog);
> > > >                 }
> > > > --
> > > > 2.29.2
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
