Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E3C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D201217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7iEtajV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfI0Inm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:43:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38441 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0Inm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 04:43:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so1586555otl.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2019 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8KQOHA1DMMmvc0q9c4Va5UTjhKlLyeaO9I6sPpAoIE=;
        b=o7iEtajVohbpr9lVpZfhZGHi7W9tuRQGgS/gYPuRSkNPGE+gGY2EEwjHmr+xC7sSpy
         hcYHCu6OE4na0Ujl6zUYcrhNdt7u8scAIJzaoT2BUWt9VVM0QrBBgAfNRBufe2dOEjdK
         O+5OfZdGIvti/4YdL7AAOIkXOK34sjk5/B5ahogk4Vm/qtnlC48caIohqdieFMvUt8RS
         L5OE2pYiiM95/UN6yhUlmQ3FgIYDRWDPFS2xX9AOdDGp+9H3mfjsN01JQSM41WEvfYQB
         mFtjP024QshnHV7VuRqXD8MUrwztQ9N9sS0a7Q/Ye6cynhqBkKMJj0wHg6rRfK0tUklj
         M/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8KQOHA1DMMmvc0q9c4Va5UTjhKlLyeaO9I6sPpAoIE=;
        b=LsmFB+aJP01MuddIvsdDnsXfWtZTyptIIbUEh55s4f7KWcA6PnsjIc2VuMOAlT3+MS
         TYU67/OwQGTPsqGrDoOC/SZqnS6Uv4AQBbasIJDTQdJpCXwxr0u/CSMD4gGMwtov9y2Y
         BcwMTYsIWtPQMx/7o1U2zrZ1opCsDkSUc9Wb6qfdPA0oL/XU3LXtcvB0M0mQMWPfaDoY
         SZj1LW9B+qQn2l+oN/295r/SlF8NrDzltTsrks9/yEkIXk380k6vNDx19Jjc9L0ogB5P
         mRiSYcZN/owGCS6Y/vYQOjfEk+pGImkIRV+7If64ClRDJKaFLtHMi2NhoGwRIWUVy0O9
         thXA==
X-Gm-Message-State: APjAAAWLes6B7N8cNWJq6yyRm9PfIUfplY30XMC5LAvfkSEmgjTc6w2l
        ztCWsXhINdjvMSOCQK8wwyETEV7QG1z5daLa17w=
X-Google-Smtp-Source: APXvYqzmZRPV4PBJfYv1ZFzJBjMSR3JcuBWU2skNQU4QiMSvTZPlTdDDCdT2wjdc8aGUqj3kaMgaHz5zfo2u9U5g+r4=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr2242492otb.11.1569573820621;
 Fri, 27 Sep 2019 01:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHvDJkrdcTCDM9cpeD5ZdMF-whR8jk8ZGdayaeQoU1BO14wwgA@mail.gmail.com>
 <CABBYNZJ1k7vXEgyTwMPa_M_5Kpc_J9rFkR81JTz07vapf5aefA@mail.gmail.com>
 <CAHvDJkrCUP2J+znQquCB-XzpPJF3CLKR7j3dApqiS-ynw9LEyg@mail.gmail.com>
 <CABBYNZ+XhK5gOcYKWmPA0QMyM61u=pp5BNJugdEJyD+XqgbZMA@mail.gmail.com>
 <CABBYNZJnx7bSyryQy-wXRCQH=56Njk7jb6ofz8AkAXfNCmU4+Q@mail.gmail.com> <CAHvDJkq8Mu1Ymk6_uO6Gx60_He99CC3Hzg=gMJapLS-Jonzg5Q@mail.gmail.com>
In-Reply-To: <CAHvDJkq8Mu1Ymk6_uO6Gx60_He99CC3Hzg=gMJapLS-Jonzg5Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Sep 2019 11:43:26 +0300
Message-ID: <CABBYNZL7=OgB32MC+UhR93YAfytXJkj2Zqp8jtpk3=GXJRzTmw@mail.gmail.com>
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

On Fri, Sep 20, 2019 at 10:48 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
>
> Hi Luiz,
>
> Sorry for the late reply. Yes I think this should be fixed. My comments below.
>
> On Thu, Sep 19, 2019 at 12:51 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Mon, Sep 16, 2019 at 2:46 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Sun, Sep 15, 2019 at 8:38 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Sun, Sep 15, 2019 at 10:14 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Sonny,
> > > > >
> > > > > On Sat, Sep 14, 2019 at 5:57 PM Sonny Sasaka <sonnysasaka@gmail.com> wrote:
> > > > > >
> > > > > > Currently at the start of client creation (g_dbus_client_new), the
> > > > > > |owner| in |filter_data| is not set until the |name| is resolved. This
> > > > > > creates a time window where the filter doesn't work properly, i.e. it
> > > > > > filters in more than it should. To solve this issue, this patch does the
> > > > > > following:
> > > > > > 1. At the start of client creation, set the |owner| in |filter_data|
> > > > > > based on the current resolved |name| if any, or set it explicitly to
> > > > > > unknown (empty string) as opposed to NULL otherwise. The unknown |owner|
> > > > > > lets the filter reject any message, unlike NULL |owner| which accepts
> > > > > > any message.
> > > > > > 2. Step 1 above reveals another bug: message_filter fails to accept
> > > > > > messages which have |sender| set directly to D-Bus service name rather
> > > > > > than D-Bus address. Therefore this patch relaxes the filter requirement
> > > > > > in message_filter to accept a message if its |sender| is equal directly
> > > > > > to our filter's |name|.
> > > > > > 3. After the initial service name resolution (after GetNameOwner)
> > > > > > returns, immediately update our name cache with the result, otherwise
> > > > > > the filters' |owner| would be stuck to unknown (empty string) until
> > > > > > "NameOwnerChanged" signal arrives.
> > > > > >
> > > > > > ---
> > > > > >  gdbus/watch.c | 14 ++++++++++++--
> > > > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/gdbus/watch.c b/gdbus/watch.c
> > > > > > index 447e48671..2ae0fd5a7 100644
> > > > > > --- a/gdbus/watch.c
> > > > > > +++ b/gdbus/watch.c
> > > > > > @@ -78,6 +78,8 @@ struct filter_data {
> > > > > >         gboolean registered;
> > > > > >  };
> > > > > >
> > > > > > +static const char *check_name_cache(const char *name);
> > > > > > +
> > > > > >  static struct filter_data *filter_data_find_match(DBusConnection *connection,
> > > > > >                                                         const char *name,
> > > > > >                                                         const char *owner,
> > > > > > @@ -265,7 +267,10 @@ proceed:
> > > > > >
> > > > > >         data->connection = dbus_connection_ref(connection);
> > > > > >         data->name = g_strdup(name);
> > > > > > -       data->owner = g_strdup(owner);
> > > > > > +       if (name)
> > > > > > +               data->owner = g_strdup(check_name_cache(name) ? : "");
> > > > >
> > > > > I follow this it would ignore the owner address and use the cache name
> > > > > or set "" to be resolved shouldn't that use the owner instead? If the
> > > > > called don't have it resolved then it should optionally set the owner
> > > > > resolution.
> > > > if |name| is set, |owner| must be NULL (refer to if block before
> > > > proceed: label above).
> > >
> > > Right so the subsequent change is actually the result of owner being
> > > set "", not a bug that existed before.
> > >
> > > > >
> > > > > > +       else
> > > > > > +               data->owner = g_strdup(owner);
> > > > > >         data->path = g_strdup(path);
> > > > > >         data->interface = g_strdup(interface);
> > > > > >         data->member = g_strdup(member);
> > > > > > @@ -534,8 +539,12 @@ static DBusHandlerResult
> > > > > > message_filter(DBusConnection *connection,
> > > > > >                 if (!sender && data->owner)
> > > > > >                         continue;
> > > > > >
> > > > > > -               if (data->owner && g_str_equal(sender, data->owner) == FALSE)
> > > > > > +               if (data->owner &&
> > > > > > +                               g_str_equal(sender, data->owner) == FALSE &&
> > > > > > +                               data->name &&
> > > > > > +                               g_str_equal(sender, data->name) == FALSE) {
> > > > >
> > > > > iirc messages never use the friendly name only the bus connection as
> > > > > sender so I wonder if this really does make any difference, are there
> > > > > any example of this not working? Perhaps it would be worth creating a
> > > > > test case in unit/test-gdbus.c to capture this case.
> > > > There is a case where the sender is D-Bus daemon itself. For example
> > > > NameOwnerChanged signal is sent via a message which has
> > > > sender="org.freedesktop.dbus" instead of a D-Bus address. I am not
> > > > aware of any other case other than messages sent by D-Bus daemon.
> > >
> > > We could perhaps have the check as if(data->owner && data->owner !=
> > > '\0'... so we skip the check if it was not resolved yet, in that case
> > > we would accept signals for watches which we do not have resolved
> > > their bus name resolved yet, which I guess it is the real issue you
> > > are trying to fix here.
> It should be the opposite: If name is not yet resolved, we don't want
> to accept anything because that would be receiving messages from
> anybody, which is wrong.

Got it, I though the problem was the opposite.

> > >
> > > > >
> > > > > >                         continue;
> > > > > > +               }
> > > > > >
> > > > > >                 if (data->path && g_str_equal(path, data->path) == FALSE)
> > > > > >                         continue;
> > > > > > @@ -627,6 +636,7 @@ static void service_reply(DBusPendingCall *call,
> > > > > > void *user_data)
> > > > > >                                                 DBUS_TYPE_INVALID) == FALSE)
> > > > > >                 goto fail;
> > > > > >
> > >
> > > This is not needed btw, update_name_cache will just lookup the same
> > > data and overwrite the owner with the same owner, well except if we do
> > > have other data pointing to the same name which is normally not the
> > > case of here, or is it? Also Im not sure how service_reply would be
> > > triggered since data->owner will always going to be set to either the
> > > cache or "", so it looks like this would only work because the bus
> > > name is no longer matched.
> This is needed because there might be another filter_data which does
> not have the name resolved, so we should update them all with the
> resolved name.

Weird, I though we already grouped the filter_data so the had be
updated altogether or is this really for different path, interface,
etc?

> > >
> > > > > > +       update_name_cache(data->name, data->owner);
> > > > > >         update_service(data);
> > > > > >
> > > > > >         goto done;
> > > > > > --
> > > > > > 2.21.0
> >
> > Are you still planning on working on this, it seems to be valid fix we
> > just have to work on the details and I hope I didn't demotivate you
> > with my comments.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
