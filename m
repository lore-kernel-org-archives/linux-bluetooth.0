Return-Path: <cyrus@holtmann.org>
Message-ID: <1339158454.19312.45.camel@novo.hadess.net>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Gustavo Padovan
	 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 13:27:34 +0100
In-Reply-To: <1339157251.1817.164.camel@aeonflux>
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
	 <1339156748.19312.37.camel@novo.hadess.net>
	 <1339157251.1817.164.camel@aeonflux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-06-08 at 21:07 +0900, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > > >> and I still have all the rights to do so.
> > > > > >>
> > > > > >> As long as we are still based on GLib, this will stay as it is. I am
> > > > > >> not
> > > > > >> jumping through any hoops, because David wouldn't respect prior art.
> > > > > >
> > > > > > How exactly would would have called a D-Bus implementation in GLib?
> > > > > 
> > > > > Well you could have called godbus as that is more a gobject binding
> > > > > than a pure glib/GMainLoop one.
> > > > 
> > > > GLib lives in a single tarball. It's only Marcel's hate for GObject and
> > > > the apparent need to be able to replace glib that spawned this thin
> > > > wrapper on top of libdbus you're using now.
> > > 
> > > plain fact is that our gdbus code was there first.
> > 
> > Nice comeback.
> > 
> > > If you wanna turn this into a GObject discussion now,
> > 
> > I don't. I'm merely pointing out that a file layout change might be a
> > good time to fix potential symbol clashes.
> > 
> > >  then please find a
> > > mailing list that cares. It is clearly not this one.
> > 
> > I think you've made this abundantly clear. I don't think this attitude
> > is helping BlueZ thrive, when it's far less friction to fix problems
> > higher up in the stack.
> 
> we will move away from GLib and libdbus (and also libnl) altogether at
> some point soon anyway. Then this discussion becomes mood.

Will you be implementing your own D-Bus library, or do you have plans to
switch to something completely different?

> Our problems are the memory footprint and the abstractions done purely
> for making this run on Windows.

The abstraction aren't there for Windows, they're there to allow for
better APIs, avoiding functional changes in the underlying system[1] and
making developer's lives easier.

>  With the embedded consumer electronics
> devices that we target this is creating more and more issues these days.

When consumer electronics are faster and faster, and with more and more
RAM, I doubt that GLib or GObject's memory footprint is a huge issue.
I'm not saying it's not an issue at all, but I doubt it's what causes
problems (versus missing features for example) when vendors select a
Linux Bluetooth stack.

[1]: the application developer shouldn't have to choose whether inotify,
fanotify or FAM is better suited for their file monitoring support for
example, or which one is going to work with which version of the kernel,
or which storage. Being able to use GIO for that purpose would have made
the adaptername plugin much simpler for example.
