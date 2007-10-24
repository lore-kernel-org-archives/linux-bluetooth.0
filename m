Return-Path: <cornelia.huck@de.ibm.com>
Date: Wed, 24 Oct 2007 10:43:52 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Jiri Kosina" <jikos@jikos.cz>,
        linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Subject: Re: [BUG] rfcomm]
Message-ID: <20071024104352.294d3b03@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <9e0cf0bf0710231155n71cf38fey4d1edae6401db173@mail.gmail.com>
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<Pine.LNX.4.64.0710232004260.18815@twin.jikos.cz>
	<1193163905.6184.214.camel@violet>
	<9e0cf0bf0710231127o485a52e1sc7a06df7c8bc0189@mail.gmail.com>
	<1193164210.6184.221.camel@violet>
	<9e0cf0bf0710231155n71cf38fey4d1edae6401db173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 23 Oct 2007 20:55:54 +0200,
"Alon Bar-Lev" <alon.barlev@gmail.com> wrote:

> On 10/23/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > the code in net/bluetooth/rfcomm/tty.c contains two calls to
> > device_move(). Please comment these out and try again. At least then we
> > know that it is in issue on how we use the driver model.
> 
> No bugs...
> Looks OK, although I don't know what removed :)

Hm, this might be similar to
http://marc.info/?l=linux-kernel&m=119124209009812&w=2. To confirm,
could you try with CONFIG_DEBUG_DRIVER and CONFIG_DEBUG_KOBJECT set
(and the device_move() calls in again)?
