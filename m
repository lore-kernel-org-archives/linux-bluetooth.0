Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 00:27:09 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Alexander Orlenko <zxteam@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [GSoC'10] : New Command Line Tool(s) for bluez
Message-ID: <20100817032709.GA5523@vigoh>
References: <AANLkTimnLyeZqNvNecognr_U9alZiC9bKNUOWjX9H_Hq@mail.gmail.com>
 <1274360918.27274.3302.camel@localhost.localdomain>
 <AANLkTik3d0rY2QNrhevwzPz28VQwKuj7A5s-9l152H4Y@mail.gmail.com>
 <AANLkTimW1SmfZ+j=F7kTSwosdz=kh+g9ofcqdTeGE7CB@mail.gmail.com>
 <1281951653.9775.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281951653.9775.7.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* Bastien Nocera <hadess@hadess.net> [2010-08-16 10:40:53 +0100]:

> On Mon, 2010-08-16 at 10:24 +1100, Alexander Orlenko wrote:
> > Hi everyone,
> > 
> > I updated project info page at http://hostisdown.org/gsoc/projects/bluez-tools
> > Created project home page: http://code.google.com/p/bluez-tools
> > Current release available for download: 0.1.18-6432
> > 
> > Code of my project does not based on non-GTK parts of
> > libgnome-bluetooth. I wrote glib gobjects for all bluez dbus
> > interfaces.
> 
> Shame, but I won't hold you against that :)
> 
> > I will continue developing my project after end of GSoC.
> 
> Hopefully people will package it for distributions so we don't get as
> many requests for command-line pairing agents :)

What about put this inside the bluez source instead of keeping it
separated? I think it's a good a idea ship this together with
bluetoothd.

-- 
Gustavo F. Padovan
http://padovan.org
