Return-Path: <SRS0=ezyT=XK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED7C4CEC7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744CA214AF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 17:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh8mrva6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfIORiq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:38:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42746 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfIORiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Sep 2019 13:38:46 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so73597860iod.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Sep 2019 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4EzxHKjqlXO7pxQZnmXbxAo7bm77sOegUes2h1I0UE=;
        b=Sh8mrva66gbEUJYGYTRIcO/Z9a31AMrCp9V4fEwR6kDaAEyw7EUYmPRo5GPZPedydK
         a+IdzLOk4xNUDjFZRxxMIFQf0FzwPkdjZ8ME9x49DtVPOUVqWQcYMKcpkPPQ1u+1R8C9
         qu4ZBAokm0IAjDIoIinWiwpZWM5XZZHeS9UktAAzOqwt0a4a9K2LvpfGoAUjYspZpB4A
         7GI4kMK8fGt+TU51uqO174d1jksUc9z4mzE06EddHfYhdil0BEJrImgvfor8FsBzR1bb
         z2qsdtZ4DhtedQbIAxI3/PN2lecKPi7D1h60ygY6RXMgBmSMy19aKAJV293dpggAzBBC
         36zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4EzxHKjqlXO7pxQZnmXbxAo7bm77sOegUes2h1I0UE=;
        b=Y1pS/TdwOFCjyjhZ+tzpmNDv4EEvlOKkb4BuUgbUMRrF4uNzYYG+Zp6GMqobCeGnZA
         oET0NoAK8CvHUuxxfeJfSamOkfQhTcYNFcBIDdA3M0P7LkbJriGl45mmjWkGXS80Mp2F
         LmKDVqZhNBgXGVSxldX4y1P1ziuttYi11mXPof4W5lDJZJ8Ct4SShnmL72Yg0QG3FGkU
         c5fHuejEvXpo9dzhyCXlYK7mz2jTZBntvhMHcNwQDQXuiExMQoMaG4URG/Svt0SqjCz5
         Vv+119MKDnEdaqafkPLgWGoQ/vz8+g/+LTq1UpAZC/Ryj68A0FB1+ECIE6R1iLSbYo3I
         6Wag==
X-Gm-Message-State: APjAAAU9lZ8UgS6wFuWpXa7KtlfRnrV4zAC5+9tGXA3p1vt5EELUFPRF
        En52EyStXKOqFzlwbnmZXzAw0EJXGiBY4EyFU4mNjQLk
X-Google-Smtp-Source: APXvYqyd5bflrrSx1WcVaDmG7XUZaZH22ew1AzIKDW+UUquwv1te3qO6NK/I/G6J0d134gICi5R7fY5buKvsIvvSk8M=
X-Received: by 2002:a6b:e302:: with SMTP id u2mr7837502ioc.135.1568569125131;
 Sun, 15 Sep 2019 10:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
 <CABBYNZJ1k7vXEgyTwMPa_M_5Kpc_J9rFkR81JTz07vapf5aefA@mail.gmail.com>
In-Reply-To: <CABBYNZJ1k7vXEgyTwMPa_M_5Kpc_J9rFkR81JTz07vapf5aefA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@gmail.com>
Date:   Sun, 15 Sep 2019 10:38:32 -0700
Message-ID: <CAHvDJkrCUP2J+znQquCB-XzpPJF3CLKR7j3dApqiS-ynw9LEyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Properly set owner of filter data at start
 of client creation
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Sun, Sep 15, 2019 at 10:14 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Sat, Sep 14, 2019 at 5:57 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
> >
> > Currently at the start of client creation (g_dbus_client_new), the
> > |owner| in |filter_data| is not set until the |name| is resolved. This
> > creates a time window where the filter doesn't work properly, i.e. it
> > filters in more than it should. To solve this issue, this patch does the
> > following:
> > 1. At the start of client creation, set the |owner| in |filter_data|
> > based on the current resolved |name| if any, or set it explicitly to
> > unknown (empty string) as opposed to NULL otherwise. The unknown |owner|
> > lets the filter reject any message, unlike NULL |owner| which accepts
> > any message.
> > 2. Step 1 above reveals another bug: message_filter fails to accept
> > messages which have |sender| set directly to D-Bus service name rather
> > than D-Bus address. Therefore this patch relaxes the filter requirement
> > in message_filter to accept a message if its |sender| is equal directly
> > to our filter's |name|.
> > 3. After the initial service name resolution (after GetNameOwner)
> > returns, immediately update our name cache with the result, otherwise
> > the filters' |owner| would be stuck to unknown (empty string) until
> > "NameOwnerChanged" signal arrives.
> >
> > ---
> >  gdbus/watch.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/gdbus/watch.c b/gdbus/watch.c
> > index 447e48671..2ae0fd5a7 100644
> > --- a/gdbus/watch.c
> > +++ b/gdbus/watch.c
> > @@ -78,6 +78,8 @@ struct filter_data {
> >         gboolean registered;
> >  };
> >
> > +static const char *check_name_cache(const char *name);
> > +
> >  static struct filter_data *filter_data_find_match(DBusConnection *connection,
> >                                                         const char *name,
> >                                                         const char *owner,
> > @@ -265,7 +267,10 @@ proceed:
> >
> >         data->connection = dbus_connection_ref(connection);
> >         data->name = g_strdup(name);
> > -       data->owner = g_strdup(owner);
> > +       if (name)
> > +               data->owner = g_strdup(check_name_cache(name) ? : "");
>
> I follow this it would ignore the owner address and use the cache name
> or set "" to be resolved shouldn't that use the owner instead? If the
> called don't have it resolved then it should optionally set the owner
> resolution.
if |name| is set, |owner| must be NULL (refer to if block before
proceed: label above).

>
> > +       else
> > +               data->owner = g_strdup(owner);
> >         data->path = g_strdup(path);
> >         data->interface = g_strdup(interface);
> >         data->member = g_strdup(member);
> > @@ -534,8 +539,12 @@ static DBusHandlerResult
> > message_filter(DBusConnection *connection,
> >                 if (!sender && data->owner)
> >                         continue;
> >
> > -               if (data->owner && g_str_equal(sender, data->owner) == FALSE)
> > +               if (data->owner &&
> > +                               g_str_equal(sender, data->owner) == FALSE &&
> > +                               data->name &&
> > +                               g_str_equal(sender, data->name) == FALSE) {
>
> iirc messages never use the friendly name only the bus connection as
> sender so I wonder if this really does make any difference, are there
> any example of this not working? Perhaps it would be worth creating a
> test case in unit/test-gdbus.c to capture this case.
There is a case where the sender is D-Bus daemon itself. For example
NameOwnerChanged signal is sent via a message which has
sender="org.freedesktop.dbus" instead of a D-Bus address. I am not
aware of any other case other than messages sent by D-Bus daemon.
>
> >                         continue;
> > +               }
> >
> >                 if (data->path && g_str_equal(path, data->path) == FALSE)
> >                         continue;
> > @@ -627,6 +636,7 @@ static void service_reply(DBusPendingCall *call,
> > void *user_data)
> >                                                 DBUS_TYPE_INVALID) == FALSE)
> >                 goto fail;
> >
> > +       update_name_cache(data->name, data->owner);
> >         update_service(data);
> >
> >         goto done;
> > --
> > 2.21.0
>
>
>
> --
> Luiz Augusto von Dentz
