Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E4C49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2967820665
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM/EI7Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfIPLqg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:46:36 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34171 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIPLqg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 07:46:36 -0400
Received: by mail-ot1-f41.google.com with SMTP id z26so25990085oto.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xV9kqXi/dTX0oq8FzNyP31+mdEzikL/2RL+G1SS7ecw=;
        b=QM/EI7HywPqFAqAEhHLqX46p7Zw2kqLEeWhp+8VRzvjQbZmiIva2r4qi4DuSd6XaSr
         gjUHYYiGfyxZ/lSBulGwLojR6AOdwnOwXCBiLEnosA8GNcsf5kQvbwcw5niLgETR3bK2
         aA35owx7420GsjOYem9AQcNShlwmiGD5tWRE7+DooNK2oufakDJQTjF1NO1BIH8a0P5D
         WgNL7H3DnK+vXaOSrBPhdTcETJvvLN8j9xIq8jw6trbQ58WpD5VDQdSThssMLzQkDprp
         f8CS7kq3TZBlEPYwpT11ofHT/IP9M4e/gJGs9wK+BtVvH6oDjgpmA/CptTEjkBXArBSU
         ZiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xV9kqXi/dTX0oq8FzNyP31+mdEzikL/2RL+G1SS7ecw=;
        b=c9HAez+DqXpMLbhJ6bBosLNBVNnZQLXp2P+Cld7A7CvplhjPz1/MA0CgHhjoarugDn
         MFzrfUjGEMmLa8i3iAZ0h6hq+5JaGAL8FD8D6bwTQ55M2pwLU+xHQyhdXpYVpPiNU6do
         mUFNzx5vVGx5+8ioydMs2EQlQLGum2TFKtl0WGI7nhJL8xofoxLbJD4Af3+gDzo54ggK
         aQ+JKC9Vgtxe9UHqkeGxP5P8DG4fX7xyzqyzA61rvGA4V+HWpx1Cf90rPPLHikURrGHw
         ESfuyCj2+12br3p0bTgcRgUhY75NExkNWr0PerkiNEP+UOK3bpzlRWwzzfat3Y4gTENn
         fMdw==
X-Gm-Message-State: APjAAAU9XrULNeqEK1NbZzqIA1WhlbWuSx1Z240lyMImZIJJ/XQaZmND
        DE/K9VajJ6Hpv96QcuHzQrYnt/4BhXJ05WvMBMo=
X-Google-Smtp-Source: APXvYqyrOiGoJz9KLHTZ5CSmgB7/MFOjy18qUJagxcwD9vlSCUToMx9XtNvpgoHSij4fMhdiRe6HcoJ063rg4m2x6fQ=
X-Received: by 2002:a9d:58c7:: with SMTP id s7mr28421943oth.11.1568634394943;
 Mon, 16 Sep 2019 04:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
 <CABBYNZJ1k7vXEgyTwMPa_M_5Kpc_J9rFkR81JTz07vapf5aefA@mail.gmail.com> <CAHvDJkrCUP2J+znQquCB-XzpPJF3CLKR7j3dApqiS-ynw9LEyg@mail.gmail.com>
In-Reply-To: <CAHvDJkrCUP2J+znQquCB-XzpPJF3CLKR7j3dApqiS-ynw9LEyg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Sep 2019 14:46:22 +0300
Message-ID: <CABBYNZ+XhK5gOcYKWmPA0QMyM61u=pp5BNJugdEJyD+XqgbZMA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Properly set owner of filter data at start
 of client creation
To:     Sonny Sasaka <sonnysasaka@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Sun, Sep 15, 2019 at 8:38 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
>
> Hi Luiz,
>
> On Sun, Sep 15, 2019 at 10:14 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Sat, Sep 14, 2019 at 5:57 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
> > >
> > > Currently at the start of client creation (g_dbus_client_new), the
> > > |owner| in |filter_data| is not set until the |name| is resolved. This
> > > creates a time window where the filter doesn't work properly, i.e. it
> > > filters in more than it should. To solve this issue, this patch does the
> > > following:
> > > 1. At the start of client creation, set the |owner| in |filter_data|
> > > based on the current resolved |name| if any, or set it explicitly to
> > > unknown (empty string) as opposed to NULL otherwise. The unknown |owner|
> > > lets the filter reject any message, unlike NULL |owner| which accepts
> > > any message.
> > > 2. Step 1 above reveals another bug: message_filter fails to accept
> > > messages which have |sender| set directly to D-Bus service name rather
> > > than D-Bus address. Therefore this patch relaxes the filter requirement
> > > in message_filter to accept a message if its |sender| is equal directly
> > > to our filter's |name|.
> > > 3. After the initial service name resolution (after GetNameOwner)
> > > returns, immediately update our name cache with the result, otherwise
> > > the filters' |owner| would be stuck to unknown (empty string) until
> > > "NameOwnerChanged" signal arrives.
> > >
> > > ---
> > >  gdbus/watch.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/gdbus/watch.c b/gdbus/watch.c
> > > index 447e48671..2ae0fd5a7 100644
> > > --- a/gdbus/watch.c
> > > +++ b/gdbus/watch.c
> > > @@ -78,6 +78,8 @@ struct filter_data {
> > >         gboolean registered;
> > >  };
> > >
> > > +static const char *check_name_cache(const char *name);
> > > +
> > >  static struct filter_data *filter_data_find_match(DBusConnection *connection,
> > >                                                         const char *name,
> > >                                                         const char *owner,
> > > @@ -265,7 +267,10 @@ proceed:
> > >
> > >         data->connection = dbus_connection_ref(connection);
> > >         data->name = g_strdup(name);
> > > -       data->owner = g_strdup(owner);
> > > +       if (name)
> > > +               data->owner = g_strdup(check_name_cache(name) ? : "");
> >
> > I follow this it would ignore the owner address and use the cache name
> > or set "" to be resolved shouldn't that use the owner instead? If the
> > called don't have it resolved then it should optionally set the owner
> > resolution.
> if |name| is set, |owner| must be NULL (refer to if block before
> proceed: label above).

Right so the subsequent change is actually the result of owner being
set "", not a bug that existed before.

> >
> > > +       else
> > > +               data->owner = g_strdup(owner);
> > >         data->path = g_strdup(path);
> > >         data->interface = g_strdup(interface);
> > >         data->member = g_strdup(member);
> > > @@ -534,8 +539,12 @@ static DBusHandlerResult
> > > message_filter(DBusConnection *connection,
> > >                 if (!sender && data->owner)
> > >                         continue;
> > >
> > > -               if (data->owner && g_str_equal(sender, data->owner) == FALSE)
> > > +               if (data->owner &&
> > > +                               g_str_equal(sender, data->owner) == FALSE &&
> > > +                               data->name &&
> > > +                               g_str_equal(sender, data->name) == FALSE) {
> >
> > iirc messages never use the friendly name only the bus connection as
> > sender so I wonder if this really does make any difference, are there
> > any example of this not working? Perhaps it would be worth creating a
> > test case in unit/test-gdbus.c to capture this case.
> There is a case where the sender is D-Bus daemon itself. For example
> NameOwnerChanged signal is sent via a message which has
> sender="org.freedesktop.dbus" instead of a D-Bus address. I am not
> aware of any other case other than messages sent by D-Bus daemon.

We could perhaps have the check as if(data->owner && data->owner !=
'\0'... so we skip the check if it was not resolved yet, in that case
we would accept signals for watches which we do not have resolved
their bus name resolved yet, which I guess it is the real issue you
are trying to fix here.

> >
> > >                         continue;
> > > +               }
> > >
> > >                 if (data->path && g_str_equal(path, data->path) == FALSE)
> > >                         continue;
> > > @@ -627,6 +636,7 @@ static void service_reply(DBusPendingCall *call,
> > > void *user_data)
> > >                                                 DBUS_TYPE_INVALID) == FALSE)
> > >                 goto fail;
> > >

This is not needed btw, update_name_cache will just lookup the same
data and overwrite the owner with the same owner, well except if we do
have other data pointing to the same name which is normally not the
case of here, or is it? Also Im not sure how service_reply would be
triggered since data->owner will always going to be set to either the
cache or "", so it looks like this would only work because the bus
name is no longer matched.

> > > +       update_name_cache(data->name, data->owner);
> > >         update_service(data);
> > >
> > >         goto done;
> > > --
> > > 2.21.0
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
