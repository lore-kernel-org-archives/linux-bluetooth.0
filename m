Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Nov 2009 14:33:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Susanne Goldammer <susanne.goldammer@gmx.de>,
	Bastien Nocera <hadess@hadess.net>,
	BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
Message-ID: <20091113123305.GA19514@jh-x301>
References: <4AF97659.2050807@gmx.de>
 <4AFBD3B6.6020706@gmx.de>
 <20091112131357.1106213e@strolchi.home.s3e.de>
 <4AFC05BD.40508@gmx.de>
 <20091112140840.1efa7475@strolchi.home.s3e.de>
 <4AFC1803.2080703@gmx.de>
 <1258037845.2158.0.camel@localhost.localdomain>
 <4AFC26C3.50006@gmx.de>
 <20091113113335.GA18325@jh-x301>
 <1258113521.3299.12.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258113521.3299.12.camel@violet>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 13, 2009, Marcel Holtmann wrote:
> > > Fixed. New patch attached.
> > 
> > The patch looks good except for two more white-space issues:
> 
> hold your horses.
> 
> Don't we create the SDP server with BDADDR_ANY. So if you wanna start
> your own one on top of it, you just can bind() it to the local adapter
> address and the kernel will use that one for that interface.

I just checked src/sdpd-server.c and you're right. So if it can indeed
be overriden like that it would certainly be a simpler solution.

Btw, what about making the SDP server a bluetoothd plugin in the future
so it could also be replaced by simply having a different plugin loaded
instead?

Johan
