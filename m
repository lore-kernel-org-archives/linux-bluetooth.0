Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 10 Nov 2010 13:38:36 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/9] Fixing DBus error system in BlueZ
Message-ID: <20101110153836.GA3275@vigoh>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <20101108123330.GA1751@jh-x301>
 <20101108173133.GA18818@vigoh>
 <1289366622.9615.230.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289366622.9615.230.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-11-10 14:23:42 +0900]:

> Hi Gustavo,
> 
> > > On Mon, Nov 08, 2010, Gustavo F. Padovan wrote:
> > > > Here are some patches that try to fix the mess of reporting error to
> > > > DBus inside BlueZ. It follows the oFono and ConnMan error system.
> > > > 
> > > > The goal is to get ride of any directly call to g_dbus_create_error()
> > > > inside bluez code, changing that to __btd_error_*. This patch set
> > > > doesn't fix all of them yet, but is a very good start. Please review.
> > > > 
> > > > 
> > > > Gustavo F. Padovan (9):
> > > >   Create __btd_error_invalid_args()
> > > >   Add __btd_error_already_exists()
> > > >   Add __btd_error_not_supported()
> > > >   Add __btd_error_not_connected()
> > > >   Add __btd_error_in_progress()
> > > >   Add __btd_error_not_available()
> > > >   Add __btd_error_busy()
> > > >   Add __btd_error_does_not_exist()
> > > >   Add __btd_error_not_authorized()
> > > 
> > > The patches seem fine to me, but before pushing upstream I'd like to
> > > understand the reason for prefixing these with  with __btd instead of
> > > btd. What's the criteria used to decide what to use and when and why is
> > > __btd the correct choice for these new functions? My first guess would
> > > have been that __btd is for things only accessible by the core-daemon
> > > whereas btd is for functions exported to plugins, but that doesn't seem
> > > to be the case with your patches since many of these __btd functions get
> > > called from plugins.
> > 
> > I just followed oFono and ConnMan on this. That is the reason and I
> > didn't asked myself why have a __ in this case.. But I see your point.
> > Do you think that change that to btd_error_* will fit better inside
> > BlueZ? I can change that then.
> 
> so within ConnMan and oFono we make a difference between public symbols
> that are reachable from within plugins and other which are not.
> 
> In general btd_ should be public symbols available to plugins and __btd_
> for internal symbols that are no available to plugins.
> 
> For builtin plugins that makes no difference of course, but this is not
> about internal builtin plugins. It is for protecting against external
> plugins to not allow access to internal details.
> 
> That said, bluetoothd is not linked with the case to hide certain
> symbols anyway so that right now there is no real difference here.

So to make that more clear, I'll change these functions to btd_

-- 
Gustavo F. Padovan
http://profusion.mobi
