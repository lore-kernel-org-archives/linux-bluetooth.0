Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C32CA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C972083E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfJ2UcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:32:23 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:50856 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 16:32:22 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id B3FE630088;
        Tue, 29 Oct 2019 22:32:19 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 56E7636C0F6; Tue, 29 Oct 2019 22:32:19 +0200 (EET)
Date:   Tue, 29 Oct 2019 22:32:19 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Remove experimental flag for remote
 MediaEndpoint
Message-ID: <20191029203218.GM28704@reaktio.net>
References: <20191018105339.1297-1-luiz.dentz@gmail.com>
 <CABBYNZJc_Z_w2tTOrWj8RhfOgtvx72dFn7hFE=HehcKKUBX-fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJc_Z_w2tTOrWj8RhfOgtvx72dFn7hFE=HehcKKUBX-fw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Now that A2DP codec switching related APIs are declared stable in bluez git,
I'd like to request bluez 5.52 release soon.

This is because feature freeze for PulseAudio 14.0 is scheduled for 2019-12-13,
so It'd be nice to have a bluez release before that.. Also to try to avoid 
distros shipping bluez 5.51, where MediaEndpoint API isn't stable yet..


Thanks a lot,

-- Pasi

On Sat, Oct 19, 2019 at 03:03:19PM +0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Fri, Oct 18, 2019 at 1:53 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This makes the MediaEndpoint and stable API for remote endpoints which
> > aligns with RegisterApplication API which is already stable.
> > ---
> >  profiles/audio/a2dp.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index f98ec8505..e8262cdfe 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -1761,7 +1761,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >  }
> >
> >  static const GDBusMethodTable sep_methods[] = {
> > -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
> > +       { GDBUS_ASYNC_METHOD("SetConfiguration",
> >                                         GDBUS_ARGS({ "endpoint", "o" },
> >                                                 { "properties", "a{sv}" } ),
> >                                         NULL, set_configuration) },
> > @@ -1837,14 +1837,10 @@ static gboolean get_device(const GDBusPropertyTable *property,
> >  }
> >
> >  static const GDBusPropertyTable sep_properties[] = {
> > -       { "UUID", "s", get_uuid, NULL, NULL,
> > -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > -       { "Codec", "y", get_codec, NULL, NULL,
> > -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > -       { "Capabilities", "ay", get_capabilities, NULL, NULL,
> > -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > -       { "Device", "o", get_device, NULL, NULL,
> > -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > +       { "UUID", "s", get_uuid, NULL, NULL },
> > +       { "Codec", "y", get_codec, NULL, NULL },
> > +       { "Capabilities", "ay", get_capabilities, NULL, NULL },
> > +       { "Device", "o", get_device, NULL, NULL },
> >         { }
> >  };
> >
> > @@ -1862,9 +1858,6 @@ static void register_remote_sep(void *data, void *user_data)
> >         sep->chan = chan;
> >         sep->sep = rsep;
> >
> > -       if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
> > -               goto done;
> > -
> >         if (asprintf(&sep->path, "%s/sep%d",
> >                                 device_get_path(chan->device),
> >                                 avdtp_get_seid(rsep)) < 0) {
> > --
> > 2.21.0
> >
> 
> Pushed.
> 
> -- 
> Luiz Augusto von Dentz
