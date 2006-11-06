Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <454EF3C0.000191.16073@bj126app52.126.com>
Date: Mon, 6 Nov 2006 16:35:12 +0800 (CST)
From: "device_driver" <device_driver@126.com>
To: "bluez development" <bluez-devel@lists.sourceforge.net>
References: <453447B2.000105.05297@bj126app48.126.com>
	<1161192019.30606.20.camel@localhost>
	<453C3732.00005F.08492@bj126app50.126.com>
In-Reply-To: <453C3732.00005F.08492@bj126app50.126.com>
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
Content-Type: multipart/mixed; boundary="===============0691868312=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0691868312==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_slsSQQnSnZReLjSntnAOMMMdvzte"


--Boundary-=_slsSQQnSnZReLjSntnAOMMMdvzte
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

It turns out to be a hardware design fault, and I have solved it by mysel=
f.
Now I can freely transfer files to and from my board through this BGB204 =
bluetooth Sip.
Thanks anyway

Best regards

Qinghua

=D4=DA2006-10-23=A3=AC"device_driver" <device_driver@126.com> =D0=B4=B5=C0=
=A3=BA
 From: "device_driver" <device_driver@126.com>
To: "bluez development" <bluez-devel@lists.sourceforge.net>
Date: Mon, 23 Oct 2006 11:29:54 +0800 (CST)
Subject: Re: [Bluez-devel] BGB204 Can't init d evice hci0: Connection tim=
ed out (110)

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


--Boundary-=_slsSQQnSnZReLjSntnAOMMMdvzte
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<blockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
px 0px 0px 0.8ex; padding-left: 1ex;">It turns out to be a hardware desig=
n fault, and I have solved it by myself.<br>Now I can freely transfer fil=
es to and from my board through this BGB204 bluetooth Sip.<br>Thanks anyw=
ay<br><br>Best regards<br><br>Qinghua<br><br>=D4=DA2006-10-23=A3=AC"devic=
e_driver" &lt;device_driver@126.com&gt; =D0=B4=B5=C0=A3=BA<br> <blockquot=
e style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0px 0px 0px=
 0.8ex; padding-left: 1ex;">From: "device_driver" &lt;device_driver@126.c=
om&gt;<br>To: "bluez development" &lt;bluez-devel@lists.sourceforge.net&g=
t;<br>Date: Mon, 23 Oct 2006 11:29:54 +0800 (CST)<br>Subject: Re: [Bluez-=
devel] BGB204 Can't init d evice hci0: Connection timed out (110)<br><br>=
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
></blockquote><br><!-- footer --><br></blockquote></blockquote><br><!-- f=
ooter --><br><br><br><br><br><div style=3D"border-bottom:1px solid #999">=
</div><br>=0A=0A=09<font color=3D"black" style=3D"font-size:14.8px"> =C4=E3=
 =D3=CA =CF=E4 =C0=EF =BE=D3 =C8=BB =D3=D0 =BB=FD =B7=D6 , =D5=E2 =C4=E3 =
=D6=AA =B5=C0 =C2=F0 ? </font>=0A=09<br>=0A=09 <a href=3D"http://adtaobao=
=2Eallyes.com/main/adfclick?db=3Dadtaobao&bid=3D600,597,58&cid=3D30015,19=
8,1&sid=3D32501&show=3Dignore&url=3Dhttp://event.mail.163.com/taobao/inde=
x.htm" target=3D"_blank" style=3D"font-size:13px;line-height:160%;color:b=
lue"> =D3=CA =CF=E4  =BB=FD=B7=D6 =BE=D3 =C8=BB =C4=DC =BB=BB 20 =D4=AA =C7=
=AE , =D5=E2 =C4=E3 =D2=B2 =D6=AA =B5=C0 =C2=F0 ? =B5=E3 =B4=CB =B6=D2 =BB=
=BB 20 =D4=AA >> </a>=0A=0A
--Boundary-=_slsSQQnSnZReLjSntnAOMMMdvzte--


--===============0691868312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0691868312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0691868312==--
