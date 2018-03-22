Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] gatt: Mark Includes property of org.bluez.GattService1 as optional
Date: Thu, 22 Mar 2018 13:18:02 +0100
Message-ID: <1955404.AOsejSYyjx@ix>
In-Reply-To: <CABBYNZ+Ai=Mm=mL9sigyZVVxbA=4=MjBGJzC1mAORhEVnX_uVA@mail.gmail.com>
References: <20180322100613.28536-1-szymon.janc@codecoup.pl> <CABBYNZ+Ai=Mm=mL9sigyZVVxbA=4=MjBGJzC1mAORhEVnX_uVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thursday, 22 March 2018 11:28:20 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Thu, Mar 22, 2018 at 12:06 PM, Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > If property is not present treat it as no Include Services present.
> > ---
> > 
> >  doc/gatt-api.txt    | 2 +-
> >  src/gatt-database.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> > index f58de23c3..60a997cbf 100644
> > --- a/doc/gatt-api.txt
> > +++ b/doc/gatt-api.txt
> > @@ -45,7 +45,7 @@ Properties    string UUID [read-only]
> > 
> >                         belongs to. Only present on services from remote
> >                         devices.
> > 
> > -               array{object} Includes [read-only]
> > +               array{object} Includes [read-only, optional]
> > 
> >                         Array of object paths representing the included
> >                         services of this service.
> > 
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index c1ae91211..2e1c20d78 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -1676,8 +1676,9 @@ static bool parse_includes(GDBusProxy *proxy, struct
> > external_service *service)> 
> >         DBusMessageIter array;
> >         char *obj;
> > 
> > +       /* Includes property is optional */
> > 
> >         if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
> > 
> > -               return false;
> > +               return true;
> > 
> >         if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> >         
> >                 return false;
> > 
> > --
> > 2.14.3
> 
> Ive pushed a similar patch about an hour ago:

OK. And what about v3 change? should we failed to register if Includes are not 
in valid format?

-- 
pozdrawiam
Szymon Janc


