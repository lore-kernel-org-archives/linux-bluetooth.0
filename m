Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100906061041n7f3793d4ud7bd80855c6788a8@mail.gmail.com>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
	 <1244209974.30768.2600.camel@cookie.hadess.net>
	 <1244211333.23850.46.camel@localhost.localdomain>
	 <1244213300.30768.2668.camel@cookie.hadess.net>
	 <1244213775.23850.57.camel@localhost.localdomain>
	 <1244214377.30768.2690.camel@cookie.hadess.net>
	 <2d5a2c100906061041n7f3793d4ud7bd80855c6788a8@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 06 Jun 2009 19:51:08 +0200
Message-Id: <1244310668.23850.76.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> First I would like to know if splitting the current code of gudev into
> udev-glib and udev-gobject would be a good idea to begin with. By
> looking at connmand code it seems quite simple to integrate glib
> mainloop with udev so if we were not adding any API to udev-glib it
> seems like an unnecessary step, I heard that udev has some race
> conditions so perhaps we could add some very basic watch registration
> like we have done to libgdus. That way udev-object API doesn't have to
> change much just depend on udev-glib.
> 
> On bluetoothd side, I would like to make udev code generic enough to
> detect any bluetooth device not only sixaxis so we can do different
> plugins to handle any device doing this cable association/cable
> pairing thing.

don't bother with udev-glib here. The native libudev integration with
mainloop is simple enough. If you need an example, look at ConnMan.

Regards

Marcel


