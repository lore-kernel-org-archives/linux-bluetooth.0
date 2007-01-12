Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Sat, 13 Jan 2007 09:25:06 +1300
References: <4f436aae0701110833m5aa4155bxbbc61920f5421f3c@mail.gmail.com>
	<200701120955.24082.thomas.kear@gmail.com>
	<4f436aae0701120859o16d8f9cbxeaa75202b818a147@mail.gmail.com>
In-Reply-To: <4f436aae0701120859o16d8f9cbxeaa75202b818a147@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200701130925.10232.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] Profiles on Bluez
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0868088256=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0868088256==
Content-Type: multipart/signed; boundary="nextPart17194112.JLrQEf0Gbn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart17194112.JLrQEf0Gbn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have to confess, at this point, some of my knowledge on this subject come=
s=20
from Wikipedia; http://en.wikipedia.org/wiki/Bluetooth_profile

You'll need to clarify OBEX, as there are a number of services built on it
GOEP, "Generic Object Exchange Profile" is one of them, I know nothing more=
=20
about it than wikipedia can tell you (not much).  It doesn't appear to be a=
=20
user-accessable feature so much as a basis for other profiles.
OPP I mentioned in my last email, is the one-way sender-initiated file=20
transfer protocol.
=46TP is similar(ish) to OPP, but usually reciever initiated, and supports =
file=20
browsing, deleting, etc on the remote host.  As mentioned last time, KDE's=
=20
bluetooth services offer it, I forgot to mention obexftp however:=20
http://triq.net/obex

There are likely daemons to facilitate OPP recieves other than KDE or GNOME=
's=20
bluetooth packages, but the names of any of these are escaping me.


The HID protocol, compared to most, is simple.  bluez-utils=20
provides /usr/bin/hidd, which in general is all you need to use it.  Its ma=
n=20
page, HIDD(1) contains very little information (as of bluez-3.7), but the=20
commands are intuitive enough:
'--server' starts a server for inbound HID connections (for example, my=20
cellphone (Sony Ericsson K750i) has a feature it calls "remote control" tha=
t=20
works with hidd in this way)
'--connect 00:00:00:00:00:00' connects to an active bluetooth input device.=
 =20
most keyboards/mice work like this.
'--search' looks for active devices and tries to connect to them=20
automatically.


Someone else will have to fill in the details about DUN, bluez provides a=20
binary called 'dund', but I don't have a clue how it works.


SPP is handled by rfcomm, which is also simple.
# rfcomm bind rfcomm0 00:00:00:00:00:00 [bluetooth channel]
will create /dev/rfcomm0 as a serial port to the chosen device, which can b=
e=20
used by any app (you might need to check permissions, naturally).


# rfcomm release rfcomm0
will delete the device again.


I think that covers just about everything you asked for, feel free to ask f=
or=20
clarification on anything.

=2D-Thomas


On Saturday 13 January 2007 5:59 am, you wrote:
> Hi Thomas,
>
> Thank you for the help.
>
> I also found that BlueZ supports PAN and BNEP inherently.
>
> can I please ask about more profiles and protocols like goep, obex, spp,
> hid, dun, spp ?
>
> Are they supported ? by whom,where ?
>
> Thanks again !!!!
> Choi.
>
> On 1/11/07, Thomas Kear <thomas.kear@gmail.com> wrote:
> > SCO (handsfree), A2DP and AVRCP are supported by the bluetooth-alsa
> > driver http://bluetooth-alsa.sourceforge.net
> >
> > BPP, depending on which way you want to use it, is a bit of an issue at
> > the moment.  I haven't yet found a server that lets my PC accept print
> > requests from mobile devices and print them through CUPS.  However
> > working the other way, CUPS has a bluetooth backend that supports adding
> > queues for bluetooth printers (I believe using HCRP).
> >
> > OPP and FTP are handled just fine by KDE's 'kdebluetooth' package, if y=
ou
> > have it installed, bluetooth:/ in a konqueror view should give you a
> > device listing, double clicking a device icon should display supported
> > profiles, FTP is called "OBEX File Transfer".  In OPP's case, sending a
> > file from a device to the PC should automatically open a dialogue to
> > facilitate recieving it. Sending files is as easy as right clicking them
> > in a konqueror view and selecting "Actions> Send with Bluetooth...".=20
> > Gnome's bluetooth utilities should have similar funtionality, I cannot
> > comment further as I've never used them.
> >
> > --Thomas
> >
> > On Friday 12 January 2007 5:33 am, Choi Sonim wrote:
> > > Hello ppl!
> > >
> > > What Bluetooth profile do BlueZ support ?
> > > I found some OBEX utilities (which both gnome and kde provides),
> > > and the builtin BNEP support. but that;s it. no hands-free, bpp,
> > > opp,a2dp,ftp, nothing ?
> > >
> > > I know it is high-level and everything can be written on top of bluez
> > > but i wonder what is already supported ?
> > >
> > > Thank You ppl,
> > > Choi.
> > >
> > > ---------------------------------------------------------------------=
=2D-
> > >-- Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to sha=
re
> > > your opinions on IT & business topics through brief surveys - and earn
> > > cash
> > > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CI=
D=3DDEVD
> > >EV _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> > -----------------------------------------------------------------------=
=2D-
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your opinions on IT & business topics through brief surveys - and earn
> > cash
> > http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users

--nextPart17194112.JLrQEf0Gbn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFp+6m8/Qi7qeDfygRAmQaAJ9iZgCJeXRpVRiRXIjX+Ndxbhv/YQCgt+4d
YE4/0yEjnitlC/biXlsmV18=
=N6fd
-----END PGP SIGNATURE-----

--nextPart17194112.JLrQEf0Gbn--


--===============0868088256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0868088256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0868088256==--
