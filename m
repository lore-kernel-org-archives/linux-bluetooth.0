Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] The future of Bluetooth HID
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1070526591.8282.9.camel@bluez.bueche.ch>
References: <1070482368.24159.110.camel@pegasus>
	 <1070526591.8282.9.camel@bluez.bueche.ch>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070544281.24162.165.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 04 Dec 2003 14:24:41 +0100

Hi Charles,

> after being only a few days into Bluetooth, I'm very happy with Marcel'=
s
> work and the high quality of this list. I have now my Logitech MX900
> almost working.

my new code was not as bad as I expected and so it is already committed
to CVS. I will look at the patches from Olivier and include them as soon
as possible. This should make the MX900 working perfect and fix some
keyboard layout problems.

For everyone who wants to play with the new HID code, you must be aware
that you need the new Bluetooth library and this can actually break some
of your setups. The second thing is the uinput driver that is already
present in 2.6 and for 2.4 you have to pick my patch from LKML.

We should now concentrate on getting a full featured HID parser. The
most thing that I miss at the moment is that the LED events are not
reported back to the HID device. I would appreciate if someone can look
at it and send me a patch.

> I will therefore donate 20=A4 or 20$ to Marcel for helping buying the
> missing hardware he needs to complete his implementation. If some among
> you do the same effort, Marcel will be able to purchase the hardware
> needed. Please participate !
>=20
> Marcel, please let us say how you want the money delivered (which
> currency, wheter paypal is OK, or note in an envelope, etc).

I have a PayPal link on my German UpTimes article. Thanks for the offer.

	http://www.holtmann.org/papers/bluetooth/uptimes2003.html

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
