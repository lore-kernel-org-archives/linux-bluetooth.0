Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alberto Garcia Hierro <tcpdevil@linuxlover.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hid2hci: No devices in HCI mode found
References: <3eef79ed04100803094fd88c74@mail.gmail.com> <1097234566.4407.1.camel@pegasus>
In-Reply-To: <1097234566.4407.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4030798.IYHRrjd9Lx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200410081543.46448.tcpdevil@linuxlover.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 8 Oct 2004 15:43:46 +0200

--nextPart4030798.IYHRrjd9Lx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Viernes, 8 de Octubre de 2004 13:22, Marcel Holtmann escribi=F3:
> Hi Sven,
>
> > running Gentoo Linux. I searched the web like crazy but did not get
> > much or even helpful information.
>
> don't care about that message, because not so much people have a HID
> Proxy Bluetooth dongle. Talk to the Gentoo package maintainer and tell
> him/her to use the -q switch to suppress this message.

Hi Sven and Marcel,
 I think there isn't any problems in the Gentoo package. I'm pretty sure th=
e=20
problem is a bad configuration. Change HID2DCI_ENABLE=3Dtrue to=20
HID2DCI_ENABLE=3Dfalse in /etc/conf.d/bluetooth and the message will=20
dissappear.

Regards,
 Alberto
=2D-=20
/* Alberto Garc=EDa Hierro (Skyhusker) */

--nextPart4030798.IYHRrjd9Lx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBZpmS4O6JklHkL2cRApHlAJ9MgZkb2rXRemI0XMYYVzBPVjyzagCfaHVO
SipKzHSyjszfdWv2qO91Riw=
=UUwA
-----END PGP SIGNATURE-----

--nextPart4030798.IYHRrjd9Lx--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
