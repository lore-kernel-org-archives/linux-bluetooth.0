Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB791904709391B@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Philip Blundell'" <pb@nexus.co.uk>
Cc: "'Bluez-devel@lists.sourceforge.net'"
	 <Bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] pan on zaurus
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Thu, 18 Mar 2004 16:39:11 +0100


mystery dissolves, when you watch it byte-wise and in hex notation !


thanks for the "strace" tip. I found the error soon:

 9687  bind(5, {sa_family=3D0x1f /* AF_??? */,
sa_data=3D"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"...}=
, 10)
=3D 0

pand initialises the l2a-struct with "0"s, before binding.
	static bdaddr_t src_addr =3D *BDADDR_ANY; // where BDADDR_ANY is
{0,0,0,0,0,0}
	l2a.l2_bdaddr =3D src_addr;
    if (bind(sk, (struct sockaddr *) &l2a, sizeof(l2a)))


thats what I forgot, a simple=20
  memset(&l2a, 0, sizeof(l2a));
makes the code working.

the padding seems to make no problems.

Matthias




> -----Urspr=FCngliche Nachricht-----
> Von: Philip Blundell [mailto:pb@nexus.co.uk]=20
> Gesendet: Donnerstag, 18. M=E4rz 2004 01:40
> An: Kutschenreuter Matthias
> Cc: 'Bluez-devel@lists.sourceforge.net'
> Betreff: Re: [Bluez-devel] pan on zaurus
>=20
>=20
> On Wed, 2004-03-17 at 19:28, Kutschenreuter Matthias wrote:
> > Now I cannot understand, why my software fails on Zaurus,
> > using the same commands as the official PAN, that doesnt fail.
>=20
> I suggest you run both programs under strace and look for=20
> difference in the syscalls that they make.  There should be=20
> nothing special about the ARM other than the=20
> structure-packing issue that you mentioned.
>=20
> p.
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
