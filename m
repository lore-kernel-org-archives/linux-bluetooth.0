Return-Path: <cyrus@holtmann.org>
Message-ID: <1339156748.19312.37.camel@novo.hadess.net>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Gustavo Padovan
	 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 12:59:08 +0100
In-Reply-To: <1339156003.1817.157.camel@aeonflux>
References: <20120524081405.GA30941@joana>
	 <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
	 <1337852769.2115.47.camel@novo.hadess.net>
	 <1337853929.15105.84.camel@aeonflux>
	 <1338998206.19312.10.camel@novo.hadess.net>
	 <1339023575.1817.114.camel@aeonflux>
	 <1339148670.19312.23.camel@novo.hadess.net>
	 <CABBYNZKMHJ52-45uTamn48E6FDHYWZLDgQkhaKBX0=rmcn6aqw@mail.gmail.com>
	 <1339152010.19312.32.camel@novo.hadess.net>
	 <1339156003.1817.157.camel@aeonflux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-06-08 at 20:46 +0900, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > >> and I still have all the rights to do so.
> > > >>
> > > >> As long as we are still based on GLib, this will stay as it is. I am
> > > >> not
> > > >> jumping through any hoops, because David wouldn't respect prior art.
> > > >
> > > > How exactly would would have called a D-Bus implementation in GLib?
> > > 
> > > Well you could have called godbus as that is more a gobject binding
> > > than a pure glib/GMainLoop one.
> > 
> > GLib lives in a single tarball. It's only Marcel's hate for GObject and
> > the apparent need to be able to replace glib that spawned this thin
> > wrapper on top of libdbus you're using now.
> 
> plain fact is that our gdbus code was there first.

Nice comeback.

> If you wanna turn this into a GObject discussion now,

I don't. I'm merely pointing out that a file layout change might be a
good time to fix potential symbol clashes.

>  then please find a
> mailing list that cares. It is clearly not this one.

I think you've made this abundantly clear. I don't think this attitude
is helping BlueZ thrive, when it's far less friction to fix problems
higher up in the stack.
