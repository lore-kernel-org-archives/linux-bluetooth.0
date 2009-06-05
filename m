Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244139239.23850.1.camel@localhost.localdomain>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 11:42:40 +0100
Message-Id: <1244198560.30768.2403.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-06-04 at 20:13 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Works for me, comments welcome.
> > 
> > It uses gudev. See http://blog.fubar.dk/?p=106
> 
> no way. Please use just plain libudev and spare use the GObject
> overhead. I have used libudev before and it is just fine. Not that I
> have actually looked at your patch at all.

GObject overhead? Did you intend on building sixaxis support into a 5
year old phone that it would actually matter?

Anyway, that'll go way down my list of things to do, along with porting
the rest of the apps to libusb1, which I guess will be a problem as
well.

gudev lives in udev-extras, and udev-extras will most likely be merged
into udev itself. And it saves me from reinventing the wheel, and doing
my own mainloop integration (etc.).
