Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1244214377.30768.2690.camel@cookie.hadess.net>
References: <1244107722.30768.837.camel@cookie.hadess.net>
	 <1244139239.23850.1.camel@localhost.localdomain>
	 <1244198560.30768.2403.camel@cookie.hadess.net>
	 <1244207191.23850.12.camel@localhost.localdomain>
	 <1244209974.30768.2600.camel@cookie.hadess.net>
	 <1244211333.23850.46.camel@localhost.localdomain>
	 <1244213300.30768.2668.camel@cookie.hadess.net>
	 <1244213775.23850.57.camel@localhost.localdomain>
	 <1244214377.30768.2690.camel@cookie.hadess.net>
Date: Sat, 6 Jun 2009 14:41:02 -0300
Message-ID: <2d5a2c100906061041n7f3793d4ud7bd80855c6788a8@mail.gmail.com>
Subject: Re: [PATCH] Add sixaxis cable-pairing plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

First I would like to know if splitting the current code of gudev into
udev-glib and udev-gobject would be a good idea to begin with. By
looking at connmand code it seems quite simple to integrate glib
mainloop with udev so if we were not adding any API to udev-glib it
seems like an unnecessary step, I heard that udev has some race
conditions so perhaps we could add some very basic watch registration
like we have done to libgdus. That way udev-object API doesn't have to
change much just depend on udev-glib.

On bluetoothd side, I would like to make udev code generic enough to
detect any bluetooth device not only sixaxis so we can do different
plugins to handle any device doing this cable association/cable
pairing thing.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
