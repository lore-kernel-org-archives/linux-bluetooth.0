Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] - BT HID message parsing framework and
	fixes for Keyboards in boot mode.
From: Matthew Grant <grantma@anathoth.gen.nz>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1103112320.2143.228.camel@pegasus>
References: <1103056217.6424.23.camel@localhost>
	 <1103112320.2143.228.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tFY9gRyUfUc537FJ5CrN"
Message-Id: <1103139137.12839.53.camel@localhost>
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
Date: Thu, 16 Dec 2004 08:32:17 +1300


--=-tFY9gRyUfUc537FJ5CrN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,=20

How are you?  I hope that you are coping with the upcoming Silly season
(Christmas, high pressure commercialism etc).  I am getting sick of the
same TV ads repeated every 10 minutes if not hourly... (I am a
person :-) ).

Please read, there is a lot in hear that you should look at and think
carefully about.

On Wed, 2004-12-15 at 13:05 +0100, Marcel Holtmann wrote:
> I only looked at the -rc3-bk6 patch, because as I said, this is what we
> gonna do first. I don't wanna see any debug specific changes in there. I
> will remove them anyway and this takes me only longer to merge this
> patch into my tree.

You have to appreciate this given that I will bw writing 500-1000 lines
more of code for net/bluetooth/hidp/core.c (maybe a seperate file) for
the control channel state machine:

o Your debug code in the hidp directory DOES NOT COMPILE!!!
I need working debug for the amount of work I am doing.  Please read
my patch and fix it!

o The code I am writing needs debug code so I can write it and get it
working.

o Extra debug code is needed in other places in the hidp directory to
support any general user debugging of the control channel state machine
code.

>  The rest of this patch looks fine and there is only
> one coding style issues that I might not mentioned last time. In a
> "switch" construct we normally add an empty line between "break" and the
> next "case".
>=20
> And another thing. What is the difference between ...ctrl_message()
> and ...ctrl_byte()? We don't need that. If data is NULL then both is the
> same.

...ctrl_message() is needed latter in the state machine work as some
control messages will be over 1 byte in size.  It will be used in phase
2.

You may also notice the 2 separate functions for queueing the sending of
control bytes  (..ctrl_byte() and ...ctrl_reply()), one from within the
hidp_session() kernel process, and one for use from the ioctl(s).  Here
is my reasoning for it. I take it that you do not want to put extra
schedule() calls in the middle of the hidp_session() while loop, between
the processing of individual received control packets, before even
processing the interrupt (high priority, basically  incoming HID events)
and the transmission queue.  Even if this inserted schedule() call is
conditional, 2 extra context switches for the hidp_session() thread get
introduced before received keystrokes/HID events are processed, and the
transmit queue gets looked at.  The BT HID spec says that the interrupt
channel should be processed at higher priority (and even before?) the
control channel.  Both ..ctrl_byte() and ...ctrl_reply() are needed
according to this.

Now about us working together, from your replies and comments about my
patches it has been obvious to me that you have not had much time to
look them over and think about things.  You comments on coding style are
appreciated, and I myself don't like being sloppy, and I know that the
netfilter people are way too sloppy for my own liking to.  But you are
holding on too tightly to the control of the BT HID code.  I need the
flexibility and autonomy of being the delegated lead developer there so
that my development can be speed along.=20

Could you please freeze the BT HID code in the kernel for 3 months
(apart from brown-paper bag stuff), and let me subsume the HID report
code in your mh* patches, and strip the net/bluetooth/hidp code from
your patches, and use my stuff instead so that I can efficiently get the
work done on improving it rapidly.  If changes are needed to the in
kernel stuff, please feed them my way and I will integrate them as
quickly as I can.  This should not be too hard, as it looks like there
has not been much activity in the BT HID area in the last few months
apart from my work.

I really want to work together with you on this, as cooperation will get
far more done in the bluetooth area of the kernel given the small user
base.  If the above arrangement is not suitable to you, please come up
with one that we do not have major code clashes when merging each others
code.=20

If you have doubts as to my ability, I am a professional router
programmer who got fired because I insisted on making my work bug-free,
robust, and high quality, with experience in OSPF, router device
driveers and IPX code.  My early CV reads like that of Alan Cox, and I
have been using Linux since 1993, with a bit work accepted into the
2.2.x kernel for ethernet bridging, 2.2.x security patches, and
2.2.x/2.4.x Sangoma driver fixes.  I will send you my resume if you want
to look it over (it is a little out of date).

My patience on this is starting to wear out.  If we can't work something
out soon, I am going to go ahead anyhow, and the merits of the work by
itself will warrant its inclusion in a few months time.

Looking forward to hearing back from you soon,

Best Regards,

Matthew Grant



--=-tFY9gRyUfUc537FJ5CrN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBwJFBuk55Di7iAnARArspAJ96XxV362sxBzRWnXouaMxXd0jEjgCdGYgZ
PY3kng/R2S6eVC7RAhOlFrc=
=+418
-----END PGP SIGNATURE-----

--=-tFY9gRyUfUc537FJ5CrN--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
