Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Matthew Grant <grantma@anathoth.gen.nz>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1101987344.15615.109.camel@pegasus>
References: <1101930555.6182.15.camel@localhost>
	 <1101933187.15615.54.camel@pegasus>  <1101982200.6274.24.camel@localhost>
	 <1101987344.15615.109.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EzTJGISm5m6SSzLSLrNc"
Message-Id: <1102315086.6245.1.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] - for BT HID fixes + beginning of ctrl handling
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
Date: Mon, 06 Dec 2004 19:38:05 +1300


--=-EzTJGISm5m6SSzLSLrNc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Busy weekend.  Remotely upgrading a Debian box, and upgrading its
hardware, having to take it one step at a time. I have started editing
the code to put in the style changes you recommended. Should be able to
get something to you tomorrow.

On Thu, 2004-12-02 at 12:35 +0100, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> as a side note: Finally decide if you are going to discuss this in
> private with me or on the mailing list. Don't switch back and forth.
>=20

Probably bets to discuss this matter on bluez-devel.

> > At times the hidp_send_message gets called from within the context of
> > the running kernel thread when responding to received messages with
> > error handshakes, and you want to keep processing if possible until the
> > original hidp_schedule() after the transmission of messages.  The aim i=
s
> > to keep the execution flow as you planned it originally.
> >=20
> > Do you think a separate function is needed, without the schedule call a=
t
> > the end?
>=20
> Actually a schedule should not harm in any way. If you think we really
> need it then I would prefer the same as a looked() versus __unlocked()
> functions.

Like you I want to keep things simple here, but I want to also avoid the
effects of giving up the processor to readily.  Also I want to avoid the
complications of more locks.  The reply messages are being sent inside
the global? Bluetooth HID lock.  We have to be careful about the context
that this is all happening within.  If you are that concerned about the
third function schedule parameter, I will create 2 separate control
message sending functions as they are only 3-4 lines long.

> > Thinking about how best to look after all the code and patching.
> > Putting all the BT code into a version control system here is looking t=
o
> > be quite sensible to make the patching easier to handle.  If we were no=
t
> > patching core.c for the report mode support, this would be a lot easier
> > and cleaner.
>=20
> I don't see any need for it at the moment. Once we get your HIDP core
> stuff ready, I will try to merge it back mainline as soon as possible.
> Every change after that should be minimal.
>=20

This first patch is only phase 1 in a 3 stage process.  Next 2 steps
will be just as big and invasive.  After this probably half of the BT
HID may be changed around quite significantly.  Please accept Debug code
code changes I make, as I need these to get debug code to compile for my
own use.  The version control system is so that I can more easily keep
track of what I am doing.

As I write this, I am making changes you suggested to my code so that we
can get it merged.  I still have a lot of this work on the machine in
Bangladesh to deal with for the next couple of nights till I can put it
on hold for a week or two before their final upgrade from woody to
sarge.

Best Regards,

Matthew Grant

--=-EzTJGISm5m6SSzLSLrNc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBs/5Muk55Di7iAnARAj0SAKCGrztZbuN94SE+F7TqhArDgJbnYQCghX8a
6a3gN2Z3DHs5DYAiZhMJk8U=
=gHgg
-----END PGP SIGNATURE-----

--=-EzTJGISm5m6SSzLSLrNc--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
