Return-Path: <cyrus@holtmann.org>
Message-ID: <1339156003.1817.157.camel@aeonflux>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 20:46:43 +0900
In-Reply-To: <1339152010.19312.32.camel@novo.hadess.net>
References: <20120524081405.GA30941@joana>
	 <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
	 <1337852769.2115.47.camel@novo.hadess.net>
	 <1337853929.15105.84.camel@aeonflux>
	 <1338998206.19312.10.camel@novo.hadess.net>
	 <1339023575.1817.114.camel@aeonflux>
	 <1339148670.19312.23.camel@novo.hadess.net>
	 <CABBYNZKMHJ52-45uTamn48E6FDHYWZLDgQkhaKBX0=rmcn6aqw@mail.gmail.com>
	 <1339152010.19312.32.camel@novo.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > >> and I still have all the rights to do so.
> > >>
> > >> As long as we are still based on GLib, this will stay as it is. I am
> > >> not
> > >> jumping through any hoops, because David wouldn't respect prior art.
> > >
> > > How exactly would would have called a D-Bus implementation in GLib?
> > 
> > Well you could have called godbus as that is more a gobject binding
> > than a pure glib/GMainLoop one.
> 
> GLib lives in a single tarball. It's only Marcel's hate for GObject and
> the apparent need to be able to replace glib that spawned this thin
> wrapper on top of libdbus you're using now.

plain fact is that our gdbus code was there first.

If you wanna turn this into a GObject discussion now, then please find a
mailing list that cares. It is clearly not this one.

Regards

Marcel


