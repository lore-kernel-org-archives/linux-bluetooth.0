Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c050915091830e5a609@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with l2test, rctest
In-Reply-To: <1126792737.3505.6.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8325_25482431.1126801082502"
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
	 <becc9d2c05091506452748d6a0@mail.gmail.com>
	 <1126792737.3505.6.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 18:18:02 +0200

------=_Part_8325_25482431.1126801082502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
the client is on arm-based embedded linux box, and
when i try to compile hcidump i get these errors:


gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include -Wall -O2 -c `test -f '
parser.c' || echo './'`parser.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include -Wall -O2 -c `test -f 'lmp.=
c'=20
|| echo './'`lmp.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include -Wall -O2 -c `test -f 'hci.=
c'=20
|| echo './'`hci.c
hci.c: In function `write_ext_inquiry_response_dump':
hci.c:854: error: `write_ext_inquiry_response_cp' undeclared (first use in=
=20
this function)
hci.c:854: error: (Each undeclared identifier is reported only once
hci.c:854: error: for each function it appears in.)
hci.c:854: error: `cp' undeclared (first use in this function)
hci.c: In function `command_dump':
hci.c:1064: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first use i=
n=20
this function)
hci.c: In function `read_ext_inquiry_response_dump':
hci.c:1379: error: `read_ext_inquiry_response_rp' undeclared (first use in=
=20
this function)
hci.c:1379: error: `rp' undeclared (first use in this function)
hci.c: In function `cmd_complete_dump':
hci.c:1667: error: `OCF_READ_EXT_INQUIRY_RESPONSE' undeclared (first use in=
=20
this function)
hci.c:1694: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first use i=
n=20
this function)
hci.c: In function `extended_inq_result_dump':
hci.c:2229: error: `extended_inquiry_info' undeclared (first use in this=20
function)
hci.c:2229: error: `info' undeclared (first use in this function)
hci.c:2238: error: `EXTENDED_INQUIRY_INFO_SIZE' undeclared (first use in=20
this function)
hci.c: In function `event_dump':
hci.c:2393: error: `EVT_EXTENDED_INQUIRY_RESULT' undeclared (first use in=
=20
this function)
make[1]: *** [hci.o] Error 1
make[1]: Leaving directory `/root/bluez-hcidump-1.25/parser'
make: *** [install-recursive] Error 1



do you know what i miss ?




On 9/15/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Andrea,
>=20
> > trying these test program betweem 2 pc of mine i get
> > alway this error on the client side:
> >
> > > ./rctest -s 00:10:60:29:XX:XX
> > rctest[1672]: Can't connect: Function not implemented (38)
>=20
> run "hcidump -X -V".
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_8325_25482431.1126801082502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
the client is on arm-based embedded linux box, and<br>
when i try to compile hcidump i get these errors:<br>
<br>
<br>
gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include -Wall -O2=
 -c `test -f 'parser.c' || echo './'`parser.c<br>
gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include -Wall -O2=
 -c `test -f 'lmp.c' || echo './'`lmp.c<br>
gcc -DHAVE_CONFIG_H -I. -I. -I..&nbsp;&nbsp;&nbsp; -I/usr/include -Wall -O2=
 -c `test -f 'hci.c' || echo './'`hci.c<br>
hci.c: In function `write_ext_inquiry_response_dump':<br>
hci.c:854: error: `write_ext_inquiry_response_cp' undeclared (first use in =
this function)<br>
hci.c:854: error: (Each undeclared identifier is reported only once<br>
hci.c:854: error: for each function it appears in.)<br>
hci.c:854: error: `cp' undeclared (first use in this function)<br>
hci.c: In function `command_dump':<br>
hci.c:1064: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first use i=
n this function)<br>
hci.c: In function `read_ext_inquiry_response_dump':<br>
hci.c:1379: error: `read_ext_inquiry_response_rp' undeclared (first use in =
this function)<br>
hci.c:1379: error: `rp' undeclared (first use in this function)<br>
hci.c: In function `cmd_complete_dump':<br>
hci.c:1667: error: `OCF_READ_EXT_INQUIRY_RESPONSE' undeclared (first use in=
 this function)<br>
hci.c:1694: error: `OCF_WRITE_EXT_INQUIRY_RESPONSE' undeclared (first use i=
n this function)<br>
hci.c: In function `extended_inq_result_dump':<br>
hci.c:2229: error: `extended_inquiry_info' undeclared (first use in this fu=
nction)<br>
hci.c:2229: error: `info' undeclared (first use in this function)<br>
hci.c:2238: error: `EXTENDED_INQUIRY_INFO_SIZE' undeclared (first use in th=
is function)<br>
hci.c: In function `event_dump':<br>
hci.c:2393: error: `EVT_EXTENDED_INQUIRY_RESULT' undeclared (first use in t=
his function)<br>
make[1]: *** [hci.o] Error 1<br>
make[1]: Leaving directory `/root/bluez-hcidump-1.25/parser'<br>
make: *** [install-recursive] Error 1<br>
<br>
<br>
<br>
do you know what i miss ?<br>
<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 9/15/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Andrea,<br><br>&gt; trying these test program betweem 2 pc of mine i get=
<br>&gt; alway this error on the client side:<br>&gt;<br>&gt; &gt; ./rctest=
 -s 00:10:60:29:XX:XX<br>&gt; rctest[1672]: Can't connect: Function not imp=
lemented (38)
<br><br>run &quot;hcidump -X -V&quot;.<br><br>Regards<br><br>Marcel<br><br>=
<br><br><br>-------------------------------------------------------<br>SF.N=
et email is sponsored by:<br>Tame your development challenges with Apache's=
 Geronimo App Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_8325_25482431.1126801082502--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
