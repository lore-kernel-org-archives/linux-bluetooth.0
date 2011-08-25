Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Aug 2011 14:06:21 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Message-ID: <20110825170621.GB27645@samus.indt.org>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
 <1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
 <20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
 <1313709545.3373.196.camel@aeonflux>
 <20110819105802.b7f5eda46e58b32677fdb804@studenti.unina.it>
 <20110819210854.81dff694ad455da3ed0e6e96@studenti.unina.it>
 <20110825161454.45a0b27998f577a737a2e579@studenti.unina.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110825161454.45a0b27998f577a737a2e579@studenti.unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On 16:14 Thu 25 Aug, Antonio Ospite wrote:
> On Fri, 19 Aug 2011 21:08:54 +0200
> Antonio Ospite <ospite@studenti.unina.it> wrote:
> 
> > On Fri, 19 Aug 2011 10:58:02 +0200
> > Antonio Ospite <ospite@studenti.unina.it> wrote:
> > 
> > > On Thu, 18 Aug 2011 16:18:57 -0700
> > > Marcel Holtmann <marcel@holtmann.org> wrote:
> > > 
> > [...]
> > > > 
> > > > I rather have the Sixaxis plugin being an external plugin only then. So
> > > > you are not allowed to make this builtin.
> > > > 
> > > 
> > > Marcel, I guess that an _external_ plugin in BlueZ context is one which
> > > is not embedded in the bluetoothd binary but rather distributed as a
> > > shared object, isn't it? Are there examples of such a plugin in bluez
> > > tree I can copy from?
> > >
> > 
> > OK, I think I've got it, it is external-dummy, this is how I did it:
> > 
> > ---
> >  Makefile.am |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index 4bcff4d..ff33bf0 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -230,8 +230,10 @@ builtin_sources += thermometer/main.c \
> >  endif
> >  
> >  if SIXAXISPLUGIN
> > -builtin_modules += sixaxis
> > -builtin_sources += plugins/sixaxis.c
> > +plugin_LTLIBRARIES += plugins/sixaxis.la
> > +plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
> > +plugins_sixaxis_la_LDFLAGS = -module -avoid-version -no-undefined @UDEV_LIBS@
> > +plugins_sixaxis_la_CFLAGS = -fvisibility=hidden @DBUS_CFLAGS@ @GLIB_CFLAGS@ @UDEV_CFLAGS@
> >  endif
> > 
> 
> This is not enough, the external plugin can be compiled but I can be used
> at runtime because it is using functions from src/storage.c and others,
> which seem to be embedded inside bluetoothd only, so I get:
> 
> bluetoothd[23459]: Can't load plugin \
>   /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-peripheral.so: \
>   /home/ao2/Proj/PS3/PS3_sixaxis/bluez/plugins/.libs/playstation-peripheral.so: \
>   undefined symbol: write_device_name
> 
> I could link the needed object files like storage.o and company into the
> plugin binary, but definitely this doesn't look OK. Should a shared library
> provide those "utility" functions to bluetoothd _and_ external plugins?
> 
> This plugin is the first non-trivial external plugin I can see in the tree,
> so maybe this problem has never showed up before.

The problem is the visibility of the symbols, src/bluetooth.ver defines
which symbols should[1] be visible to plugins. Every plugin should only
depend on those methods from the "core".

If we want to keep the sixaxis plugin external we need to make the
symbols it need visible, but I wonder if that is right solution.

[1] Seems that with builtin plugins that visibility enforcement doesn't
work, right?

> 
> Thanks,
>    Antonio
> 
> -- 
> Antonio Ospite
> http://ao2.it
> 
> PGP public key ID: 0x4553B001
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?



Cheers,
-- 
Vinicius
