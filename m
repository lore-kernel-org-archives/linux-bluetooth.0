Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <453C3732.00005F.08492@bj126app50.126.com>
Date: Mon, 23 Oct 2006 11:29:54 +0800 (CST)
From: "device_driver" <device_driver@126.com>
To: "bluez development" <bluez-devel@lists.sourceforge.net>
References: <453447B2.000105.05297@bj126app48.126.com>
	<1161192019.30606.20.camel@localhost>
In-Reply-To: <1161192019.30606.20.camel@localhost>
Subject: Re: [Bluez-devel] BGB204 Can't init d evice hci0: Connection timed
 out (110)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1048231054=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1048231054==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_UKJRWcUkVNwPefddWcVewBfTbwBH"


--Boundary-=_UKJRWcUkVNwPefddWcVewBfTbwBH
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply, Marcel.
I have tried as your instruction, i.e.,=20
=2E/hciattach ttyS1 any 115200 flow
and get the same result.
And I "diff"ed the hci_h4.c file in linux-2.6.9 and linux-2.6.18 and foun=
d they are almost the same.
Who has any ideas?
Thanks in advance.


-----=D4=AD=CA=BC=D3=CA=BC=FE-----
=B7=A2=BC=FE=C8=CB:"Marcel Holtmann"=20
=B7=A2=CB=CD=CA=B1=BC=E4:2006-10-19 01:20:19
=CA=D5=BC=FE=C8=CB:"BlueZ development"=20
=B3=AD=CB=CD:(=CE=DE)
=D6=F7=CC=E2:Re: [Bluez-devel] BGB204 Can't init device hci0: Connection =
timed out (110)


From: "Marcel Holtmann"=20
To: "BlueZ development"=20
Date: Thu, 19 Oct 2006 01:20:19 +0800 (CST)
Subject: Re: [Bluez-devel] BGB204 Can't init device hci0: Connection time=
d out (110)



> Hi,
>=20
> > I'm using Philips(NXP)BGB204 bluetooth Sip under the Linux 2.6.9
> > kernel and ran into problems now. The scenario was as follows:
>=20
> I have a BGB208 for testing and have some similar problems. The 2.6.9
> should work fine, but I would prefer if you test with a 2.6.18 kernel
> instead, because that one is more recent.
>=20
> However the following line should attach the device correctly.
>=20
> =09./hciattach ttyS1 any 115200 flow
>=20
> If you use the Ericsson id, it will start with 57600 and then try to
> switch into the higher baudrate. As far as I know all BGB from Philips
> boot up by default in 115200.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
> -----------------------------------------------------------------------=
--
> Using Tomcat but need to do more? Need to support web services, securit=
y?
> Get stuff done quickly with pre-integrated technology to make your job =
easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
--Boundary-=_UKJRWcUkVNwPefddWcVewBfTbwBH
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<blockquote style=3D"border-left: 2px solid rgb(160, 198, 229); padding-l=
eft: 5px; margin-left: 5px; margin-right: 0px;"><blockquote style=3D"bord=
er-left: 2px solid rgb(160, 198, 229); padding-left: 5px; margin-left: 5p=
x; margin-right: 0px;">Thanks for your reply, Marcel.<br>I have tried as =
your instruction, i.e., <br>./hciattach ttyS1 any 115200 flow<br>and get =
the same result.<br>And I "diff"ed the hci_h4.c file in linux-2.6.9 and l=
inux-2.6.18 and found they are almost the same.<br>Who has any ideas?<br>=
Thanks in advance.<br><br><blockquote style=3D"border-left: 2px solid rgb=
(160, 198, 229); padding-left: 5px; margin-left: 5px; margin-right: 0px;"=
><hr color=3D"#a0c6e5" size=3D"1"><br>-----=D4=AD=CA=BC=D3=CA=BC=FE-----<=
br>=B7=A2=BC=FE=C8=CB:"Marcel Holtmann" <marcel@holtmann.org><br>=B7=A2=CB=
=CD=CA=B1=BC=E4:2006-10-19 01:20:19<br>=CA=D5=BC=FE=C8=CB:"BlueZ developm=
ent" <bluez-devel@lists.sourceforge.net><br>=B3=AD=CB=CD:(=CE=DE)<br>=D6=F7=
=CC=E2:Re: [Bluez-devel] BGB204 Can't init device hci0: Connection timed =
out (110)<br><br><br>From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 01:20:19 +0800 (CST)
Subject: Re: [Bluez-devel] BGB204 Can't init device hci0: Connection time=
d out (110)



&gt; Hi,
&gt;=20
&gt; &gt; I'm using Philips(NXP)BGB204 bluetooth Sip under the Linux 2.6.=
9
&gt; &gt; kernel and ran into problems now. The scenario was as follows:
&gt;=20
&gt; I have a BGB208 for testing and have some similar problems. The 2.6.=
9
&gt; should work fine, but I would prefer if you test with a 2.6.18 kerne=
l
&gt; instead, because that one is more recent.
&gt;=20
&gt; However the following line should attach the device correctly.
&gt;=20
&gt; =09./hciattach ttyS1 any 115200 flow
&gt;=20
&gt; If you use the Ericsson id, it will start with 57600 and then try to
&gt; switch into the higher baudrate. As far as I know all BGB from Phili=
ps
&gt; boot up by default in 115200.
&gt;=20
&gt; Regards
&gt;=20
&gt; Marcel
&gt;=20
&gt;=20
&gt;=20
&gt; --------------------------------------------------------------------=
-----
&gt; Using Tomcat but need to do more? Need to support web services, secu=
rity?
&gt; Get stuff done quickly with pre-integrated technology to make your j=
ob easier
&gt; Download IBM WebSphere Application Server v.1.0.1 based on Apache Ge=
ronimo
&gt; http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D=
263057&amp;dat=3D121642
&gt; _______________________________________________
&gt; Bluez-devel mailing list
&gt; Bluez-devel@lists.sourceforge.net
&gt; https://lists.sourceforge.net/lists/listinfo/bluez-devel
&gt; </bluez-devel@lists.sourceforge.net></marcel@holtmann.org></bluez-de=
vel@lists.sourceforge.net></marcel@holtmann.org></blockquote></blockquote=
></blockquote><br><!-- footer --><br>
--Boundary-=_UKJRWcUkVNwPefddWcVewBfTbwBH--


--===============1048231054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1048231054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1048231054==--
