Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040922104057.17401.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "abhay b" <abhay7182@rediffmail.com>
Reply-To: "abhay b" <abhay7182@rediffmail.com>
To: bluez-devel@lists.sourceforge.net
Content-type: multipart/alternative;
	boundary="Next_1095849657---0-203.199.83.37-17383"
Subject: [Bluez-devel] "iobase" pcmcia?
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
Date: 22 Sep 2004 10:40:57 -0000

 This is a multipart mime message


--Next_1095849657---0-203.199.83.37-17383
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0A&nbsp; <BR>=0Ahi i got the code of Bluetooth driver for the Anycom Bl=
ueCard (LSE039/LSE041)in this code and some other codes i have seen there i=
s a parameter called &quot;iobase &quot;<BR>=0Aits being used in many palce=
s like<BR>=0A outb(0x08 | 0x20, iobase + 0x30);<BR>=0Asoem functions take i=
t as argument but i dont know how we r getting a partcular address as nowhe=
re its intialized to some address.<BR>=0Ai want to know what this address i=
s? is it base address of io window? is the pcmcia memory is part of io memo=
ry? how we get a value for tha parameter &quot;iobase&quot;<BR>=0Athanks<BR=
>=0Aabhay=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients.r=
ediff.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/RealMe=
dia/ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSP=
ACE=3D0 HSPACE=3D0></a>=0A
--Next_1095849657---0-203.199.83.37-17383
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 =A0=0Ahi i got the code of Bluetooth driver for the Anycom BlueCard (LSE03=
9/LSE041)in this code and some other codes i have seen there is a parameter=
 called "iobase "=0Aits being used in many palces like=0A outb(0x08 | 0x20,=
 iobase + 0x30);=0Asoem functions take it as argument but i dont know how w=
e r getting a partcular address as nowhere its intialized to some address.=
=0Ai want to know what this address is? is it base address of io window? is=
 the pcmcia memory is part of io memory? how we get a value for tha paramet=
er "iobase"=0Athanks=0Aabhay
--Next_1095849657---0-203.199.83.37-17383--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
