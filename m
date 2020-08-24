Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D4C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D886D206F0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzziYW7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHXPpp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgHXPpB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 11:45:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E95C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 08:45:01 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p137so2002133oop.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2020 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0lKH1v1UT/weTPnocPDsO2ijkZqswvRGjCcgrrt8fM=;
        b=GzziYW7xfQM3wX2zjbXL8qQPPXUk1mZHgXAe19xyc3JcfsQCU6dWVwl82pOeMwB92k
         a/mcJHmCHN1hU63mG1lE4y5P2pkBrte0705xX1ds6li1foYu83FuRP4d6xbtpS1wi9UV
         NB4fz1pWxmaKKMTRHaLHcKckI05W7z0Lsf/XckkLr9Cc9BI1VDxQAth4t8WP1W2uZTOk
         EMwXXm4Ang4/dZwT8r2b9FhaHurIf4SqiBoCDH8695ArxNsA9M/+zx51z7oTUWZvWKAX
         /S40yFPF6BT+vynHMIXzJ0og4bukgbnFDTpQK6QNOAZWXHuyTzbysXB0iFpFDMzpe89z
         GXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0lKH1v1UT/weTPnocPDsO2ijkZqswvRGjCcgrrt8fM=;
        b=nWpLtF8TXb17sJuaXnaa4iwdQ3mgsMWp3EVm83NfMBPBgc0FVORLiypOIqj6EG4bI8
         Uvf5isSxK2Aj1M0KvVbLqUjYxmLy/BmTb9c8Onj5GY1c8UauVn7vpTvJn+OHUe0T921K
         tMPfcheTe0jy7qgv5OG9Xa/k9t4Sh5KIfIWaVqZk0VBo2YR6GQAKvQUscdP8+wejinfa
         GZ+V0/jnfddu7D6NHHoBmSlAiHBy78dEdZYgXBFShUgCsJYku98B0Mg8RQoQAEriLlNw
         6+nDqZu8K1/sWdAHTa9KFyjE4WGsUMo8BZ7JFM9gGsNwY0du91BvMO4uzMQILqRmgRjL
         ltpQ==
X-Gm-Message-State: AOAM533oaBIKCZTU/x6CmgCgHTgh/dEyA0dA+T99AAsmMqFb87Qrd3Kg
        FBS8vcYw+BF3QHBoeCFjrKkLZLZdZwv1lFdsdcE=
X-Google-Smtp-Source: ABdhPJzE/7ahCW1nGlt+rtwSMBeCkDTSQS+V4WHRWBc6AT7bXJ4/gK/QjIwgkw+qE/QdvC+1z3I4mw5o3pxqtEYESHE=
X-Received: by 2002:a4a:e88c:: with SMTP id g12mr4072053ooe.49.1598283900856;
 Mon, 24 Aug 2020 08:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com>
 <2303f692-bb7c-4851-86fa-befde45b4b32@EXC04-ATKLA.omicron.at>
 <CABBYNZ+OK4EY9KGHn7oasz4GRfBDJdWNcpOhr1GNGc3D+QtZ-g@mail.gmail.com>
 <3e98e7dae29ec7be6d67fca6af99f2e0f747375e.camel@omicronenergy.com>
 <CABBYNZ+U+Edyb42oKWgsqVKHCZZDzXR4HRRrK0Rb2vEL_A3aiA@mail.gmail.com> <6293792d2a4971529ff6f6e3327a2497ad7870c3.camel@omicronenergy.com>
In-Reply-To: <6293792d2a4971529ff6f6e3327a2497ad7870c3.camel@omicronenergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Aug 2020 08:44:50 -0700
Message-ID: <CABBYNZ+AduzcKtA1zshT+YpAXT_8fdymA6rgMFRfWvU=vpj-iw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] src/profile.c: Add a GetProfileInfo method
To:     Mark Marshall <mark.marshall@omicronenergy.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

On Mon, Aug 24, 2020 at 1:53 AM Mark Marshall
<mark.marshall@omicronenergy.com> wrote:
>
> On Thu, 2020-08-20 at 09:33 -0700, Luiz Augusto von Dentz wrote:
> > Hi Mark,
> >
> > On Thu, Aug 20, 2020 at 3:10 AM Mark Marshall
> > <mark.marshall@omicronenergy.com> wrote:
> > >
> > > On Wed, 2020-08-19 at 11:37 -0700, Luiz Augusto von Dentz wrote:
> > > > Hi Mark,
> > > >
> > > > On Wed, Aug 19, 2020 at 8:13 AM Mark Marshall
> > > > <mark.marshall@omicronenergy.com> wrote:
> > > > >
> > > > > Add a GetProfileInfo method to org.bluez.ProfileManager1
> > > > > ---
> > > > >  doc/profile-api.txt | 13 +++++++
> > > > >  src/profile.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 106 insertions(+)
> > > > >
> > > > > diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> > > > > index 8c7d0a06d..d13703ab4 100644
> > > > > --- a/doc/profile-api.txt
> > > > > +++ b/doc/profile-api.txt
> > > > > @@ -133,6 +133,19 @@ Object path        /org/bluez
> > > > >
> > > > >                         Possible errors: org.bluez.Error.DoesNotExist
> > > > >
> > > > > +               options GetProfileInfo(object profile, object adapter)
> > > > > +
> > > > > +                       This returns a dictionary of options for the
> > > > > +                       profile.  Values returned are: UUID, Name,
> > > > > +                       Path, Service, Mode and AddressType.  The
> > > > > +                       adapter parameter is optional - if it is
> > > > > +                       non-empty, then two additional values might be
> > > > > +                       returned, if the profile is active on the
> > > > > +                       specified adapter: PSM and Channel.
> > > > > +
> > > > > +                       Possible errors: org.bluez.Error.InvalidArguments
> > > > > +                                        org.bluez.Error.DoesNotExist
> > > > > +
> > > >
> > > > If this is really required I would be willing to merge something like this:
> > > >
> > > > https://github.com/Vudentz/BlueZ/commit/9e196f8830511a4102e990d82d06c2e0487b3ad9
> > > >
> > > > It exposes service objects so you can control exactly what gets
> > > > connect, though now given a second look at this seem to return details
> > > > that the client can query directly on the socket itself like the
> > > > Channel, PSM, Mode, etc, also not sure what is the point on retrieving
> > > > things like UUID, Name, Path if the application is already in control
> > > > of these when registering.
> > > >
> > >
> > > I only returned a full dictionary of items here as I was trying to
> > > match RegisterProfile, I don't actually need all of this info.  (I
> > > also thought that the more verbose structure was more useful, but
> > > it is wasteful).
> > >
> > > The information that I really need is the PSM (or Channel) number.
> > > This information is needed on the server side, and the socket used
> > > is not exposed to anything outside of bluetoothd, as far as I can
> > > tell.  (This is the socket returned from bt_io_listen, in profile.c).
> >
> > The file descriptor passed on NewConnection is the same socket the
> > daemon uses so you can query things like PSM, etc, using getsockopt
> > just like the daemon does, or do you need it before a connection is
> > made? In which case it might be preferable to write the PSM back to
> > the Property.Set method, that said perhaps it is better to have a PSM
> > set instead of leaving that to be auto allocated since you may not
> > want to change if you need to expose over GATT.
>
> The problem is that NewConnection is too late.  This only gets called
> after the remote side has connected.  The reason that I don't think it
> can be a property, is that the PSM is technically a "per adapter"
> number, it's possible (I think) for BlueZ to auto-allocate a
> different PSM for each adapter.

Right, though I think we would allocate the same PSM and bind to BDADDR_ANY.

> If I do choose a fixed PSM, are there chances of a collision?
> Would such a collision matter?  I have "complete" control over all
> software on the server, but the client devices are not mine.
> What is the best advice about picking a fixed PSM?

If you have full control then assigning a fixed PSM is probably the
best thing you can do here as you can guarantee no one else will be
attempting to register a service for the same PSM.

> >
> > > I have my profile auto-select a free PSM, which I thought was the
> > > preferred method.  In the BR/EDR case, this number gets passed to the
> > > peer (I assume through SDP), but in the LE case, where I want to use
> > > LE-L2CAP, there is no defined mechanism to transfer the PSM.  My plan
> > > was to expose it as a GATT attribute, but this mechanism is not
> > > standardised, so I didn't think BlueZ would want to be involved?
> >
> > BlueZ don't need to get involved directly but you can have vendor
> > specific GATT service that expose the PSM so the remote side can learn
> > about it and connect.
> >
> > > Would a simpler interface that just returned the PSM or Channel number
> > > be better?  Is there another way to find out the PSM of a listening
> > > socket, on the server, before a connection is made?
> >
> > For auto allocation I would make actually make the properties
> > writable, though it seems we don't have any properties on Profile1 so
> > we would need to create then in order to reflect the options that can
> > be passed over on RegisterProfile.
> >
> > > (From my reading of the above patch, the service object is created
> > > as a link between a "profile" and a "device".  In my case, I think
> > > there is no service object yet, as I have no device connection?)
> >
> >
> >
> > >
> > > > >  Profile hierarchy
> > > > >  =================
> > > > > diff --git a/src/profile.c b/src/profile.c
> > > > > index 10850f305..e287a66d7 100644
> > > > > --- a/src/profile.c
> > > > > +++ b/src/profile.c
> > > > > @@ -2509,6 +2509,96 @@ static DBusMessage *unregister_profile(DBusConnection *conn,
> > > > >         return dbus_message_new_method_return(msg);
> > > > >  }
> > > > >
> > > > > +static DBusMessage *get_profile_info(DBusConnection *conn,
> > > > > +                                       DBusMessage *msg, void *user_data)
> > > > > +{
> > > > > +       DBusMessage *reply;
> > > > > +       DBusMessageIter iter, dict;
> > > > > +       const char *path, *adapter, *sender;
> > > > > +       struct ext_profile *ext;
> > > > > +       uint16_t u16;
> > > > > +       GSList *l, *next;
> > > > > +
> > > > > +       sender = dbus_message_get_sender(msg);
> > > > > +
> > > > > +       DBG("sender %s", sender);
> > > > > +
> > > > > +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> > > > > +                                  DBUS_TYPE_OBJECT_PATH, &adapter,
> > > > > +                                  DBUS_TYPE_INVALID)) {
> > > > > +               return btd_error_invalid_args(msg);
> > > > > +       }
> > > > > +
> > > > > +       if (adapter && !*adapter)
> > > > > +               adapter = NULL;
> > > > > +
> > > > > +       ext = find_ext_profile(sender, path);
> > > > > +       if (!ext)
> > > > > +               return btd_error_does_not_exist(msg);
> > > > > +
> > > > > +       reply = dbus_message_new_method_return(msg);
> > > > > +
> > > > > +       dbus_message_iter_init_append(reply, &iter);
> > > > > +
> > > > > +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> > > > > +                                        "{sv}", &dict);
> > > > > +
> > > > > +       g_dbus_dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING,
> > > > > +                                &ext->uuid);
> > > > > +       if (ext->name) {
> > > > > +               g_dbus_dict_append_entry(&dict, "Name", DBUS_TYPE_STRING,
> > > > > +                                        &ext->name);
> > > > > +       }
> > > > > +       if (ext->path) {
> > > > > +               g_dbus_dict_append_entry(&dict, "Path", DBUS_TYPE_STRING,
> > > > > +                                        &ext->path);
> > > > > +       }
> > > > > +       if (ext->service) {
> > > > > +               g_dbus_dict_append_entry(&dict, "Service", DBUS_TYPE_STRING,
> > > > > +                                        &ext->service);
> > > > > +       }
> > > > > +
> > > > > +       u16 = ext->mode;
> > > > > +       g_dbus_dict_append_entry(&dict, "Mode", DBUS_TYPE_UINT16,
> > > > > +                                &u16);
> > > > > +
> > > > > +       u16 = ext->addr_type;
> > > > > +       g_dbus_dict_append_entry(&dict, "AddressType", DBUS_TYPE_UINT16,
> > > > > +                                &u16);
> > > > > +
> > > > > +       if (adapter) {
> > > > > +               for (l = ext->servers; l != NULL; l = next) {
> > > > > +                       struct ext_io *server = l->data;
> > > > > +                       const char *ctype;
> > > > > +
> > > > > +                       DBG("server:%p  %d %d psm:%d chan:%d",
> > > > > +                           server, server->resolving, server->connected,
> > > > > +                           server->psm, server->chan);
> > > > > +
> > > > > +                       next = g_slist_next(l);
> > > > > +
> > > > > +                       if (strcmp(adapter, adapter_get_path(server->adapter)))
> > > > > +                               continue;
> > > > > +
> > > > > +                       if (server->proto == BTPROTO_L2CAP) {
> > > > > +                               ctype = "PSM";
> > > > > +                               u16 = server->psm;
> > > > > +                       } else if (server->proto == BTPROTO_RFCOMM) {
> > > > > +                               ctype = "Channel";
> > > > > +                               u16 = server->chan;
> > > > > +                       } else {
> > > > > +                               continue;
> > > > > +                       }
> > > > > +                       g_dbus_dict_append_entry(
> > > > > +                               &dict, ctype, DBUS_TYPE_UINT16, &u16);
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       dbus_message_iter_close_container(&iter, &dict);
> > > > > +
> > > > > +       return reply;
> > > > > +}
> > > > > +
> > > > >  static const GDBusMethodTable methods[] = {
> > > > >         { GDBUS_METHOD("RegisterProfile",
> > > > >                         GDBUS_ARGS({ "profile", "o"}, { "UUID", "s" },
> > > > > @@ -2516,6 +2606,9 @@ static const GDBusMethodTable methods[] = {
> > > > >                         NULL, register_profile) },
> > > > >         { GDBUS_METHOD("UnregisterProfile", GDBUS_ARGS({ "profile", "o" }),
> > > > >                         NULL, unregister_profile) },
> > > > > +       { GDBUS_METHOD("GetProfileInfo",
> > > > > +                       GDBUS_ARGS({ "profile", "o" }, { "adapter", "o" }),
> > > > > +                       GDBUS_ARGS({ "options", "a{sv}" }), get_profile_info) },
> > > > >         { }
> > > > >  };
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > >
> >
> >
>


-- 
Luiz Augusto von Dentz
