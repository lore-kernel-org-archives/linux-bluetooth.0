Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB20C28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiAZNps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:45:48 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51489 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiAZNps (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 08:45:48 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 3481240010;
        Wed, 26 Jan 2022 13:45:45 +0000 (UTC)
Message-ID: <61d3fea272805d6bfb1a6cf5883404ea7e294e7c.camel@hadess.net>
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
From:   Bastien Nocera <hadess@hadess.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 26 Jan 2022 14:45:45 +0100
In-Reply-To: <390473B8-2187-4C84-B319-9D4A8FB6ED0A@holtmann.org>
References: <20220126113638.1706785-1-hadess@hadess.net>
         <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
         <390473B8-2187-4C84-B319-9D4A8FB6ED0A@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2022-01-26 at 14:31 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Some patches from 2017 to use systemd lockdown. They've been used
> > for 5
> > years by Fedora and RHEL.
> > 
> > > As we will need those paths to lock down on them.
> > > ---
> > >  Makefile.am | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Makefile.am b/Makefile.am
> > > index e391d7ae8..2ba25e687 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -28,14 +28,14 @@ AM_CFLAGS = $(MISC_CFLAGS) $(WARNING_CFLAGS)
> > > $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
> > >                                 $(LIBEDATASERVER_CFLAGS)
> > > $(ell_cflags)
> > >  AM_LDFLAGS = $(MISC_LDFLAGS)
> > >  
> > > +confdir = $(sysconfdir)/bluetooth
> > > +statedir = $(localstatedir)/lib/bluetooth
> > > +
> > >  if DATAFILES
> > >  dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
> > >  dbus_DATA = src/bluetooth.conf
> > >  
> > > -confdir = $(sysconfdir)/bluetooth
> > >  conf_DATA =
> > > -
> > > -statedir = $(localstatedir)/lib/bluetooth
> > >  state_DATA =
> > >  endif
> > >  
> 
> seems I missed that one. Can you please be more specific what this
> change does.

This change specifically? Check the next patches in the series, and
you'll see pretty quickly.

For the rest of the patchset, check this man page for details on each
of the directives:
https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Security

There's a fair amount of other directives we could use on top of those
ones, but we can add them iteratively (and it makes bisecting easier,
in case we forget about a particular use case).

Cheers
