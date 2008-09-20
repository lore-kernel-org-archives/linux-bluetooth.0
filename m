Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100809200035g67fc524bre4fc3c7f2a44bcc5@mail.gmail.com>
Date: Sat, 20 Sep 2008 00:35:44 -0700
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Nick Pelly" <npelly@google.com>
Subject: Re: Data on eglib vs glib, implications for embedded use of bluez
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	"Iliyan Malchev" <malchev@google.com>,
	"Brian Swetland" <swetland@google.com>
In-Reply-To: <35c90d960809191823h47b491fegb0efd29d15f166df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <35c90d960809191520n2067753cs71c07d37ea83b28@mail.gmail.com>
	 <1221871191.6782.79.camel@californication>
	 <35c90d960809191823h47b491fegb0efd29d15f166df@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

+1 to maintain eglib out of BlueZ code, we already have enough trouble
with releases because eglib, this is not really a problem of BlueZ
using glib but glib being bloated so fixing glib by distributing eglib
on its place might fix everybody problems. If we got a replacement for
glib we would probably stick to it since glib is at least unreadable,
there is even a case where a 'if (0)' was being used in its code (I
really meant glib not eglib).

I remember Marcel commenting about a library which Lennart was
supposed to implement, something I would like libdbus itself supports,
which would be a low level dbus api + mainloop + helpers which most
system daemons would be using to get into dbus system bus. All daemons
require mainloops (including dbus-daemon itself) so this may probably
be an opportunity to get this done and remove glib dependency from
dbus system daemons space.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
