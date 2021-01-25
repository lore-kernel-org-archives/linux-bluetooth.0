Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FDC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 01:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A067B22597
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 01:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbhAYThF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbhAYTgu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 14:36:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98936C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:10 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id r12so19681311ejb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaA5DzCUr1gMC2ZIX3M6uX3YVjkeLDbK5Bx2VQTR7BU=;
        b=au3dlO/iMpaCnvOJnvMn7W+D9Qh9iV3B1BUkb+l5oPCm2JMaZ75iaovnyqrjcvpRH7
         l3Jm6SLRSvtFjQFgkV7Vc5HyE2PtUJUvmBKci7PxO1/mon2ddmWKXjJw0nj7jffz6Sz1
         A1Z6A8MJmcl9XV7kIt6XMFGzcqUQ/j+BUoUpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaA5DzCUr1gMC2ZIX3M6uX3YVjkeLDbK5Bx2VQTR7BU=;
        b=Z7tLvX0/PkC/+gBHruffGkhcC74JmF8spFpzMIq7b7e3yOQfSQyeXXhve9EO6Ckvgr
         txRhF9TJ/xREVfsXZCZk76VJ9TxK3cPjebnn7O1gIl1FWaUa5AGUAIwg6ZhVSmSPfCBm
         IqVZ2kheJHzm9OviR4CCPKiu/EMp5fYkGlZwCLsMdMSLIuHYDMjqbjUeVPBdF9T7Eqbx
         LdMKz2wdEwTyaPFRuBWtsaYHHD1ppUHZNYiRRiBWmEPipV/w5xuOyVltZn/RSmyvmGcF
         QU9kuXInqOGuTtZ71wWXoesJ1Ev+miCeleHOJOLZ6KuV7LpvR2yYmASprmBgbuynSP7O
         HUUw==
X-Gm-Message-State: AOAM531hzeCCBhRyXfJOYTi9GvPGg2xjg/WGf3J0z5NYwPh5BBTms97c
        d4UAN127D8qXBppPjKk18ygfBD1JlcAPvg==
X-Google-Smtp-Source: ABdhPJz9KhFdN7tatJ5h4kFiB6nhrLyaopEYxaYN+s3At02KIYz/pZcUeESU1I1HsHSjychFRpNHpQ==
X-Received: by 2002:a17:907:7252:: with SMTP id ds18mr1329347ejc.239.1611603369082;
        Mon, 25 Jan 2021 11:36:09 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id di28sm11094932edb.71.2021.01.25.11.36.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:36:08 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id j18so479063wmi.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 11:36:08 -0800 (PST)
X-Received: by 2002:a05:600c:20c:: with SMTP id 12mr1514477wmi.125.1611603368239;
 Mon, 25 Jan 2021 11:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org>
 <20210122001326.14263-2-sonnysasaka@chromium.org> <CABBYNZJs_rzBSHOjvqg5F4u6gxX7LcNUc77KtzHEr5L7Y5Zd-A@mail.gmail.com>
 <CAO271mkMtmDm_MayCX-+Dddg3aL1uv=GD3egCGJ6gDCEHowp8g@mail.gmail.com>
In-Reply-To: <CAO271mkMtmDm_MayCX-+Dddg3aL1uv=GD3egCGJ6gDCEHowp8g@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 25 Jan 2021 11:35:56 -0800
X-Gmail-Original-Message-ID: <CAO271mkhpd8KOA=a3E66VpJUj01PONjmpS=m+U9MtwSWnUQ6BA@mail.gmail.com>
Message-ID: <CAO271mkhpd8KOA=a3E66VpJUj01PONjmpS=m+U9MtwSWnUQ6BA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] input/hog: Do not create UHID if report map
 is broken
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I have been trying to reproduce the issue again but it turns out to be
very rare. Let's defer this patch until I can get a clear log of what
is happening and why we get the corrupted cache.



On Thu, Jan 21, 2021 at 5:24 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> On Thu, Jan 21, 2021 at 4:37 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Thu, Jan 21, 2021 at 4:18 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > The report map in the cache could be dirty, for example when reading a
> > > report map from peer was cancelled, we should be able to detect it and
> > > not try to create UHID. Instead we will read it again from the peer.
> >
> > Don't we clean the cache if it had failed? Or you meant to say the
> > read long procedure was not complete so we got just part of the report
> > map?
> Looks like this is the case. It happened to me once when I cancel
> reconnection (trigger pairing mode during reconnection) from the
> keyboard side. It's hard to confirm since I have to get the timing
> right.
>
> > In that case we should have failed
> I agree. However it seems that the code already tries to fail by
> looking at the status inside report_map_read_cb, but somehow it still
> gets through. It could be the keyboard bug that we have to detect
> anyway?
>
> > also if we need to protect
> > uhid from malformed report map, which sounds like a kernel bug, then
> > we should at least have it inside bt_uhid instance so we can at least
> > attempt to have some unit testing done with broken report maps.
> >
> > > ---
> > >  profiles/input/hog-lib.c | 21 ++++++++++++++++++---
> > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> > > index 089f42826..d6a3bda4d 100644
> > > --- a/profiles/input/hog-lib.c
> > > +++ b/profiles/input/hog-lib.c
> > > @@ -946,7 +946,7 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > >         struct uhid_event ev;
> > >         ssize_t vlen = report_map_len;
> > >         char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
> > > -       int i, err;
> > > +       int i, err, collection_depth = 0;
> > >         GError *gerr = NULL;
> > >
> > >         DBG("Report MAP:");
> > > @@ -960,6 +960,14 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > >                         if (!long_item && (value[i] & 0xfc) == 0x84)
> > >                                 hog->has_report_id = TRUE;
> > >
> > > +                       // Start Collection
> > > +                       if (value[i] == 0xa1)
> > > +                               collection_depth++;
> > > +
> > > +                       // End Collection
> > > +                       if (value[i] == 0xc0)
> > > +                               collection_depth--;
> > > +
> > >                         DBG("\t%s", item2string(itemstr, &value[i], ilen));
> > >
> > >                         i += ilen;
> > > @@ -968,10 +976,15 @@ static void uhid_create(struct bt_hog *hog, uint8_t *report_map,
> > >
> > >                         /* Just print remaining items at once and break */
> > >                         DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
> > > -                       break;
> > > +                       return;
> > >                 }
> > >         }
> > >
> > > +       if (collection_depth != 0) {
> > > +               error("Report Map error: unbalanced collection");
> > > +               return;
> > > +       }
> > > +
> > >         /* create uHID device */
> > >         memset(&ev, 0, sizeof(ev));
> > >         ev.type = UHID_CREATE;
> > > @@ -1365,7 +1378,9 @@ static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> > >                          * UHID to optimize reconnection.
> > >                          */
> > >                         uhid_create(hog, report_map.value, report_map.length);
> > > -               } else {
> > > +               }
> > > +
> > > +               if (!hog->uhid_created) {
> > >                         read_char(hog, hog->attrib, value_handle,
> > >                                                 report_map_read_cb, hog);
> > >                 }
> > > --
> > > 2.29.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
