Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62F5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797E32078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="g09GrDyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgHTKhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:37:41 -0400
Received: from ns.omicron.at ([212.183.10.25]:36502 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbgHTKSR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:17 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2020 06:18:16 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07KAACRU007799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 12:10:13 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07KAACRU007799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597918213;
        bh=tHGzBdpZIrFsEwZDPMin6z/+uonkVMtBxKwEtWOjXkA=;
        h=Subject:From:To:CC:Date:In-Reply-To:References:From;
        b=g09GrDyiBS92zyF/HnCIQPYM4yuD7mZXKALGlqdNKKIl91ejo3g0TM/k6gxtYo/nG
         AtB3yBEY1hWvfHatINAaZQayjVV24orCbPnqwIHR1dppYnbaILev1LXhwgFHzjZc+j
         zsASQSgfFmcK1H5fcs1B1uirG2LovgmhbjSTvtxw=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id A0659A006D
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 12:10:11 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 9E2FFA0062
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 12:10:11 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07KAAC8d030797-07KAAC8f030797
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Thu, 20 Aug 2020 12:10:12 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 12:10:11 +0200
Message-ID: <3e98e7dae29ec7be6d67fca6af99f2e0f747375e.camel@omicronenergy.com>
Subject: Re: [PATCH BlueZ 2/2] src/profile.c: Add a GetProfileInfo method
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 20 Aug 2020 12:10:02 +0200
In-Reply-To: <CABBYNZ+OK4EY9KGHn7oasz4GRfBDJdWNcpOhr1GNGc3D+QtZ-g@mail.gmail.com>
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com>
         <2303f692-bb7c-4851-86fa-befde45b4b32@EXC04-ATKLA.omicron.at>
         <CABBYNZ+OK4EY9KGHn7oasz4GRfBDJdWNcpOhr1GNGc3D+QtZ-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC03-ATKLA.omicron.at (172.22.100.188) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-08-19 at 11:37 -0700, Luiz Augusto von Dentz wrote:
> Hi Mark,
> 
> On Wed, Aug 19, 2020 at 8:13 AM Mark Marshall
> <mark.marshall@omicronenergy.com> wrote:
> > 
> > Add a GetProfileInfo method to org.bluez.ProfileManager1
> > ---
> >  doc/profile-api.txt | 13 +++++++
> >  src/profile.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 106 insertions(+)
> > 
> > diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> > index 8c7d0a06d..d13703ab4 100644
> > --- a/doc/profile-api.txt
> > +++ b/doc/profile-api.txt
> > @@ -133,6 +133,19 @@ Object path        /org/bluez
> > 
> >                         Possible errors: org.bluez.Error.DoesNotExist
> > 
> > +               options GetProfileInfo(object profile, object adapter)
> > +
> > +                       This returns a dictionary of options for the
> > +                       profile.  Values returned are: UUID, Name,
> > +                       Path, Service, Mode and AddressType.  The
> > +                       adapter parameter is optional - if it is
> > +                       non-empty, then two additional values might be
> > +                       returned, if the profile is active on the
> > +                       specified adapter: PSM and Channel.
> > +
> > +                       Possible errors: org.bluez.Error.InvalidArguments
> > +                                        org.bluez.Error.DoesNotExist
> > +
> 
> If this is really required I would be willing to merge something like this:
> 
> https://github.com/Vudentz/BlueZ/commit/9e196f8830511a4102e990d82d06c2e0487b3ad9
> 
> It exposes service objects so you can control exactly what gets
> connect, though now given a second look at this seem to return details
> that the client can query directly on the socket itself like the
> Channel, PSM, Mode, etc, also not sure what is the point on retrieving
> things like UUID, Name, Path if the application is already in control
> of these when registering.
> 

I only returned a full dictionary of items here as I was trying to
match RegisterProfile, I don't actually need all of this info.  (I
also thought that the more verbose structure was more useful, but
it is wasteful).

The information that I really need is the PSM (or Channel) number.  
This information is needed on the server side, and the socket used
is not exposed to anything outside of bluetoothd, as far as I can
tell.  (This is the socket returned from bt_io_listen, in profile.c).

I have my profile auto-select a free PSM, which I thought was the
preferred method.  In the BR/EDR case, this number gets passed to the
peer (I assume through SDP), but in the LE case, where I want to use
LE-L2CAP, there is no defined mechanism to transfer the PSM.  My plan
was to expose it as a GATT attribute, but this mechanism is not
standardised, so I didn't think BlueZ would want to be involved?

Would a simpler interface that just returned the PSM or Channel number
be better?  Is there another way to find out the PSM of a listening
socket, on the server, before a connection is made?

(From my reading of the above patch, the service object is created
as a link between a "profile" and a "device".  In my case, I think
there is no service object yet, as I have no device connection?)


> >  Profile hierarchy
> >  =================
> > diff --git a/src/profile.c b/src/profile.c
> > index 10850f305..e287a66d7 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -2509,6 +2509,96 @@ static DBusMessage *unregister_profile(DBusConnection *conn,
> >         return dbus_message_new_method_return(msg);
> >  }
> > 
> > +static DBusMessage *get_profile_info(DBusConnection *conn,
> > +                                       DBusMessage *msg, void *user_data)
> > +{
> > +       DBusMessage *reply;
> > +       DBusMessageIter iter, dict;
> > +       const char *path, *adapter, *sender;
> > +       struct ext_profile *ext;
> > +       uint16_t u16;
> > +       GSList *l, *next;
> > +
> > +       sender = dbus_message_get_sender(msg);
> > +
> > +       DBG("sender %s", sender);
> > +
> > +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> > +                                  DBUS_TYPE_OBJECT_PATH, &adapter,
> > +                                  DBUS_TYPE_INVALID)) {
> > +               return btd_error_invalid_args(msg);
> > +       }
> > +
> > +       if (adapter && !*adapter)
> > +               adapter = NULL;
> > +
> > +       ext = find_ext_profile(sender, path);
> > +       if (!ext)
> > +               return btd_error_does_not_exist(msg);
> > +
> > +       reply = dbus_message_new_method_return(msg);
> > +
> > +       dbus_message_iter_init_append(reply, &iter);
> > +
> > +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> > +                                        "{sv}", &dict);
> > +
> > +       g_dbus_dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING,
> > +                                &ext->uuid);
> > +       if (ext->name) {
> > +               g_dbus_dict_append_entry(&dict, "Name", DBUS_TYPE_STRING,
> > +                                        &ext->name);
> > +       }
> > +       if (ext->path) {
> > +               g_dbus_dict_append_entry(&dict, "Path", DBUS_TYPE_STRING,
> > +                                        &ext->path);
> > +       }
> > +       if (ext->service) {
> > +               g_dbus_dict_append_entry(&dict, "Service", DBUS_TYPE_STRING,
> > +                                        &ext->service);
> > +       }
> > +
> > +       u16 = ext->mode;
> > +       g_dbus_dict_append_entry(&dict, "Mode", DBUS_TYPE_UINT16,
> > +                                &u16);
> > +
> > +       u16 = ext->addr_type;
> > +       g_dbus_dict_append_entry(&dict, "AddressType", DBUS_TYPE_UINT16,
> > +                                &u16);
> > +
> > +       if (adapter) {
> > +               for (l = ext->servers; l != NULL; l = next) {
> > +                       struct ext_io *server = l->data;
> > +                       const char *ctype;
> > +
> > +                       DBG("server:%p  %d %d psm:%d chan:%d",
> > +                           server, server->resolving, server->connected,
> > +                           server->psm, server->chan);
> > +
> > +                       next = g_slist_next(l);
> > +
> > +                       if (strcmp(adapter, adapter_get_path(server->adapter)))
> > +                               continue;
> > +
> > +                       if (server->proto == BTPROTO_L2CAP) {
> > +                               ctype = "PSM";
> > +                               u16 = server->psm;
> > +                       } else if (server->proto == BTPROTO_RFCOMM) {
> > +                               ctype = "Channel";
> > +                               u16 = server->chan;
> > +                       } else {
> > +                               continue;
> > +                       }
> > +                       g_dbus_dict_append_entry(
> > +                               &dict, ctype, DBUS_TYPE_UINT16, &u16);
> > +               }
> > +       }
> > +
> > +       dbus_message_iter_close_container(&iter, &dict);
> > +
> > +       return reply;
> > +}
> > +
> >  static const GDBusMethodTable methods[] = {
> >         { GDBUS_METHOD("RegisterProfile",
> >                         GDBUS_ARGS({ "profile", "o"}, { "UUID", "s" },
> > @@ -2516,6 +2606,9 @@ static const GDBusMethodTable methods[] = {
> >                         NULL, register_profile) },
> >         { GDBUS_METHOD("UnregisterProfile", GDBUS_ARGS({ "profile", "o" }),
> >                         NULL, unregister_profile) },
> > +       { GDBUS_METHOD("GetProfileInfo",
> > +                       GDBUS_ARGS({ "profile", "o" }, { "adapter", "o" }),
> > +                       GDBUS_ARGS({ "options", "a{sv}" }), get_profile_info) },
> >         { }
> >  };
> > 
> > --
> > 2.17.1
> > 
> 
> 

