Return-Path: <cyrus@holtmann.org>
Message-ID: <1339152010.19312.32.camel@novo.hadess.net>
Subject: Re: [RFC] Reorganizing the BlueZ source tree
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>,  linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 11:40:10 +0100
In-Reply-To: <CABBYNZKMHJ52-45uTamn48E6FDHYWZLDgQkhaKBX0=rmcn6aqw@mail.gmail.com>
References: <20120524081405.GA30941@joana>
	 <CABBYNZLhWfS6Ff0S8SkCwSXxzt61NzNCBH-K78hQB6dtpPvJ6Q@mail.gmail.com>
	 <1337852769.2115.47.camel@novo.hadess.net>
	 <1337853929.15105.84.camel@aeonflux>
	 <1338998206.19312.10.camel@novo.hadess.net>
	 <1339023575.1817.114.camel@aeonflux>
	 <1339148670.19312.23.camel@novo.hadess.net>
	 <CABBYNZKMHJ52-45uTamn48E6FDHYWZLDgQkhaKBX0=rmcn6aqw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-06-08 at 13:02 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien
> 
> On Fri, Jun 8, 2012 at 12:44 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Thu, 2012-06-07 at 07:59 +0900, Marcel Holtmann wrote:
> >>
> >> and I still have all the rights to do so.
> >>
> >> As long as we are still based on GLib, this will stay as it is. I am
> >> not
> >> jumping through any hoops, because David wouldn't respect prior art.
> >
> > How exactly would would have called a D-Bus implementation in GLib?
> 
> Well you could have called godbus as that is more a gobject binding
> than a pure glib/GMainLoop one.

GLib lives in a single tarball. It's only Marcel's hate for GObject and
the apparent need to be able to replace glib that spawned this thin
wrapper on top of libdbus you're using now.

GLib's APIs don't differentiate which shared library they come from.
