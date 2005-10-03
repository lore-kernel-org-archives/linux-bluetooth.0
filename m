Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <9307f5f20510020452n5bb6410p490ead0c5a018eb2@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
	 <1128011132.30743.8.camel@localhost.localdomain>
	 <e1effdeb050929122670827a96@mail.gmail.com>
	 <1128069460.4955.25.camel@localhost.localdomain>
	 <e1effdeb050930075263b62ffb@mail.gmail.com>
	 <1128092607.4955.93.camel@localhost.localdomain>
	 <9307f5f20510020452n5bb6410p490ead0c5a018eb2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128347832.22437.55.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 03 Oct 2005 15:57:12 +0200

Hi,

> I'm not new here, as I've already mentioned in other posts, this
> summer I've written both a dbus daemon (from scratch) and some python
> gui eye-candy stuff, since you seem interested in the latter, take a
> look  here :)
> 
> http://shackan.altervista.org/bluetools.png
> 
> it's still under heavy development, unfortunately university started
> last week and I don't have much time now, anyway I'll keep you
> informed if you want.

I like to have you on the time for bluetoothd and our D-Bus interface.
It seems also that you might be the one that will do the nice graphical
integration of Bluetooth into the GNOME Desktop. Please keep doing this,
because we need a lot more nice looking GUIs in the future. What do you
think if I create a bluez-gnome package in the CVS and you start working
there?

> ps: the problem is my dbus interface is different from yours, I might
> consider making it compatible if I have time to, but I'm going to
> redesign my api anyway so I might "rip" a good amount of suggestions
> from the way you and Claudio are doing it.

The design makes good progress and I am waiting for the first patches
from Claudio that I am going to include. This will help a lot. The next
release might have some inquiry interface over D-Bus.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
