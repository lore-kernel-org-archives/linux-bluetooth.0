Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sample protocol over L2CAP
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <437F87BC.2090907@gmail.com>
References: <437F87BC.2090907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1132431896.18447.8.camel@panic>
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
Date: Sat, 19 Nov 2005 12:24:56 -0800

Alfredo,

everything is done via sockets so just:

sock =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

look at the bluez-utils/libs sources

... Collin

On Sat, 2005-11-19 at 18:14 -0200, Alfredo Dal'Ava J=FAnior wrote:
> Hi All,
>=20
> I'm looking for a start point to develop a new protocol over the L2CAP.
> Any of you have a sample code?
>=20
> Thanks,
>=20
> []s
> Alfredo
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
Privacy in residential applications is a desirable marketing option.
(ETSI EN 300 175-7 Ch. A6)



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
