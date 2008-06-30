Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100806301527y21f80385vc75acdf9da62029c@mail.gmail.com>
Date: Mon, 30 Jun 2008 19:27:00 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <035501c8dab3$5596b380$6701a8c0@freqonedev>
MIME-Version: 1.0
References: <1214593557.6131.26.camel@bongo>
	<1214606647.4435.71.camel@cookie.hadess.net>
	<031301c8da4d$0bce3720$6701a8c0@freqonedev>
	<1214813891.4435.149.camel@cookie.hadess.net>
	<035501c8dab3$5596b380$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Wizard patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello David,

> I read the docs and when the code works as expected it is good enough.
> However, I have had a number of problems making the code work (partially
> implemented "experimental" 4.x features in release 3.33 and before).

You should first understand that the documentation in doc/ are dbus
specifications, they are not normal method calls or gobject signals.
You seems to be confused by using dbus-glib and not really knowing
what dbus is doing, we don't document how to use the API in terms of
language bindings, because it is open to the application developer to
choose between the bindings and the binding itself should document how
it map the different signatures.

> Also, figuring out how to handle some of the formats (e.g., the "dict"
> with variant) are a bit hard to figure out without a code example.  SO,
> I often have to dig into the actual code and figure out just what is
> going on.

See my point here, just because dbus-glib maps the signature a{sv}
(that is the real "dict") to a GHashTable using a GValue doesn't mean
any other binding will do the same. It's up to the binding to provides
this kind of documentation not the dbus API which should not be tied
to a single binding.

This tutorial should cover what you want:
http://dbus.freedesktop.org/doc/dbus-tutorial.html

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
