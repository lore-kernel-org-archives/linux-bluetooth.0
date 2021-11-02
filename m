Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B47EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8D060EDF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 09:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBJND (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 05:13:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07BC061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 02:10:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c4so2164022wrd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsDeslGfzneJWylkhs49aT8wbPp678a9lKNoJmw/U8A=;
        b=nTjfDIECjpb+ZauBMLbfldThBzGmXhciP5Z+kJL6abNeEywDqnEjgboejy3sBS+t9v
         PYiVojh2m8M3kgd+l7NMywurdcOFAAssSbBvF3n67NmoDRA9phEEzG1keyRzb02PvB4c
         wVbNhKVfyfvnYqln4YSfzyZsdpie6pKPYR413W3Rue07+0BQd25sBvN4d231sGmElL1y
         23oSpGyL8EQHdhGwVyPCG8Uery0EIcyEw+lAyd/T3/2MCbi8AVHuuIi/OgE6ynB/QbR/
         XKghEiJ2aazKg6MgIXpX0+h3yHppoP/vNM2ShhQ1xs3CT+4oFDuHa5FPYA1euMCmXLjK
         tISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsDeslGfzneJWylkhs49aT8wbPp678a9lKNoJmw/U8A=;
        b=zpfTHTUn2LzRjJ6s72eTrowq5s7GIacQry98bXx1lFGt8ByHYleUAhN4CLAqkSTW5x
         uevrEAg6gp5Roy2224jwBu99ZPjg6SEGw4/gnOuWIs1UG8/z2bu3S28MdZU5C2BhXveV
         1nNNtrwoBdQR0VTOhCVf2f59ZXSE/B0nK7FRwtF7Ag+BS653Z0oMt4nndkSSZHzlro5n
         IfT5hyzRXzc/rS3v0GHp5WODnhgBXT+Iyyl6wqIYK2+Mc79l0G6EauxkB+pMxrzL7mgs
         ak6VMPgtihlyawG4jnIl9PKYKIqgsXtxwc1gGk4zuHGZ2Ogp58IDs/6fiZ4MInr82irw
         6hrw==
X-Gm-Message-State: AOAM531w0H0QhQq6925yjD8YhJde3t5YB0+X1DtYotB3PxOzvcAt0ADz
        nxf1qgG++AIhCcPCf7vMPgj1TuzxqTQBw07MGOFYqA==
X-Google-Smtp-Source: ABdhPJzBXYvfSwo7/DDcWe+/8XUaIdqP9DzHdbrhZDNHBJ3WxcDWHds6DycB0tjdgG4KAhaUf7MnfSjoudGrMehzKSU=
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr46054643wri.398.1635844225029;
 Tue, 02 Nov 2021 02:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
 <CABBYNZJg=Acx_BLyq=RzbkvfWOj-Rik3t7B1Z-XZqemo2LMykQ@mail.gmail.com>
In-Reply-To: <CABBYNZJg=Acx_BLyq=RzbkvfWOj-Rik3t7B1Z-XZqemo2LMykQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 2 Nov 2021 17:10:14 +0800
Message-ID: <CAJQfnxHP0dRzahhcK2S6sN-e1ssk1S2BZB3Nzs+SCTXufBVfGA@mail.gmail.com>
Subject: Re: [Bluez PATCH 1/3] adapter: Use PeripheralLongTermKey to store LTK
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Tue, 2 Nov 2021 at 14:17, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Oct 31, 2021 at 11:06 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Introducing PeripheralLongTermKey group for storing LTK info to
> > replace the less inclusive term. Currently we still need to write/read
> > from both to ensure smooth transition, but later we should deprecate
> > the old term.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> >  src/adapter.c | 41 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 9 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index d0d38621b8..6b12c9e793 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -3868,7 +3868,11 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
> >
> >         DBG("%s", peer);
> >
> > -       ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> > +       /* Read from both entries. Later we should deprecate Slave. */
> > +       ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
> > +       if (!ltk)
> > +               ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
>
> If you find the old name being used you better replace it with the new
> one and erase the old.
>
> >         if (ltk)
> >                 ltk->central = false;
> >
> > @@ -8415,13 +8419,12 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
> >         bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
> >  }
> >
> > -static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > +static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
> >                                 uint8_t bdaddr_type, const unsigned char *key,
> > -                               uint8_t central, uint8_t authenticated,
> > +                               const char *group, uint8_t authenticated,
> >                                 uint8_t enc_size, uint16_t ediv,
> >                                 uint64_t rand)
> >  {
> > -       const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
> >         char device_addr[18];
> >         char filename[PATH_MAX];
> >         GKeyFile *key_file;
> > @@ -8431,11 +8434,6 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> >         char *str;
> >         int i;
> >
> > -       if (central != 0x00 && central != 0x01) {
> > -               error("Unsupported LTK type %u", central);
> > -               return;
> > -       }
> > -
> >         ba2str(peer, device_addr);
> >
> >         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> > @@ -8475,6 +8473,31 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> >         g_key_file_free(key_file);
> >  }
> >
> > +static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
> > +                               uint8_t bdaddr_type, const unsigned char *key,
> > +                               uint8_t central, uint8_t authenticated,
> > +                               uint8_t enc_size, uint16_t ediv,
> > +                               uint64_t rand)
> > +{
> > +       if (central != 0x00 && central != 0x01) {
> > +               error("Unsupported LTK type %u", central);
> > +               return;
> > +       }
> > +
> > +       if (central) {
> > +               store_ltk_group(adapter, peer, bdaddr_type, key, "LongTermKey",
> > +                               authenticated, enc_size, ediv, rand);
> > +       } else {
> > +               /* Store duplicates for now. Later we should deprecate Slave. */
> > +               store_ltk_group(adapter, peer, bdaddr_type, key,
> > +                               "PeripheralLongTermKey", authenticated,
> > +                               enc_size, ediv, rand);
> > +               store_ltk_group(adapter, peer, bdaddr_type, key,
> > +                               "SlaveLongTermKey", authenticated,
> > +                               enc_size, ediv, rand);
>
> In not following why you want to keep duplicate entries?
>
Based on the discussion in the other thread with Marcel, we don't want
to immediately remove the old entry since this would cause friction
when people are switching around between the newer and older version
of BlueZ.
Instead, for some time we would keep both entries alive, and only
after that we remove the old entry.

> > +       }
> > +}
> > +
> >  static void new_long_term_key_callback(uint16_t index, uint16_t length,
> >                                         const void *param, void *user_data)
> >  {
> > --
> > 2.33.1.1089.g2158813163f-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
