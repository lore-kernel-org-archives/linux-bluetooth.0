Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511358531.16347.46.camel@hadess.net>
Subject: Re: [PATCH BlueZ] gdbus: Fix not emiting PropertiesChanged
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 22 Nov 2017 14:48:51 +0100
In-Reply-To: <CABBYNZLwY+KHx95DXDLKFGcfxJK2n1Vpte=YtOYhZ2O4Q8To2Q@mail.gmail.com>
References: <20171121200436.17576-1-luiz.dentz@gmail.com>
         <1511301906.16347.42.camel@hadess.net>
         <CABBYNZLy-ei67BuDApNvK4KWhtKPWM__4ynM9F8REgCWFgO7WA@mail.gmail.com>
         <CABBYNZJbXm9Wy1b3L1pv_0YLyM5sDOrcAwRcpvGsi=PhOSVk6g@mail.gmail.com>
         <1511357983.16347.44.camel@hadess.net>
         <CABBYNZLwY+KHx95DXDLKFGcfxJK2n1Vpte=YtOYhZ2O4Q8To2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-22 at 15:43 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Wed, Nov 22, 2017 at 3:39 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Wed, 2017-11-22 at 15:38 +0200, Luiz Augusto von Dentz wrote:
> > > Hi,
> > > 
> > > On Wed, Nov 22, 2017 at 11:14 AM, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > > Hi Bastien,
> > > > 
> > > > On Wed, Nov 22, 2017 at 12:05 AM, Bastien Nocera <hadess@hadess
> > > > .net
> > > > > wrote:
> > > > > > Re: [PATCH BlueZ] gdbus: Fix not emiting PropertiesChanged
> > > > > 
> > > > > emitting.
> > > > > 
> > > > > On Tue, 2017-11-21 at 22:04 +0200, Luiz Augusto von Dentz
> > > > > wrote:
> > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > 
> > > > > > If and interface is removed while properties are pending it
> > > > > > would cause
> > > > > 
> > > > > "an interface".
> > > > > 
> > > > > > process_properties_from_interface to clear data-
> > > > > > >pending_prop
> > > > > > when it
> > > > > > should only clear the iface->pending_prop.
> > > > > 
> > > > > I prefer my version, which allows the pending properties to
> > > > > be
> > > > > cleared
> > > > > out if the pending ones were for that interface. I also
> > > > > prefer
> > > > > the
> > > > > subject line I used, describing the actual problem it fixes,
> > > > > and
> > > > > the
> > > > > commit message going more into details.
> > > > 
> > > > I guess this one is simpler to maintain, also notice that
> > > > iterating
> > > > in
> > > > the data->interfaces to check if there are no other
> > > > pending_prop
> > > > has
> > > > almost the same effect as process_property_changes, what would
> > > > make
> > > > a
> > > > difference would be to prevent process_changes but that has to
> > > > run
> > > > anyway to propagate the interfaces added/removed. Also notice
> > > > that
> > > > data->pending_prop is clear earlier than the original fix for
> > > > duplicated signals, the one that introduced this problem, that
> > > > way
> > > > we
> > > > don't reintroduce the original problem.
> > > > 
> > > > Regarding the commit message, we usually avoid BlueZ specific
> > > > description there as gdbus is shared with other projects.
> > > > 
> > > > > 
> > > > > But up to you.
> > > > > 
> > > > > Cheers
> > > > > 
> > > > > > ---
> > > > > >  gdbus/object.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/gdbus/object.c b/gdbus/object.c
> > > > > > index afb458764..5c8ad7a55 100644
> > > > > > --- a/gdbus/object.c
> > > > > > +++ b/gdbus/object.c
> > > > > > @@ -1659,8 +1659,6 @@ static void
> > > > > > process_properties_from_interface(struct generic_data
> > > > > > *data,
> > > > > >       DBusMessageIter iter, dict, array;
> > > > > >       GSList *invalidated;
> > > > > > 
> > > > > > -     data->pending_prop = FALSE;
> > > > > > -
> > > > > >       if (iface->pending_prop == NULL)
> > > > > >               return;
> > > > > > 
> > > > > > @@ -1722,6 +1720,8 @@ static void
> > > > > > process_property_changes(struct
> > > > > > generic_data *data)
> > > > > >  {
> > > > > >       GSList *l;
> > > > > > 
> > > > > > +     data->pending_prop = FALSE;
> > > > > > +
> > > > > >       for (l = data->interfaces; l != NULL; l = l->next) {
> > > > > >               struct interface_data *iface = l->data;
> > > > > > 
> > > 
> > > Applied.
> > 
> > You could at least have applied fixes to the 2 typos I mentioned :(
> 
> You mean the one typo in the description, and instead of an, or did I
> miss something in the code?

There's a typo in the commit subject and another in the commit body. I
mentioned both of those in my initial review.
