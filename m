Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20611132243l173f149br90ffb8401c1c3396@mail.gmail.com>
Date: Tue, 14 Nov 2006 14:43:33 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1161284638.7885.11.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20610152225h7e020518m3c6062ce9be25044@mail.gmail.com>
	<1161000951.10392.26.camel@localhost>
	<3f5a9ba20610190107je24b0bbg6bd5da0a05f6e0f2@mail.gmail.com>
	<1161284638.7885.11.camel@localhost>
Cc: ml@felicis.org
Subject: Re: [Bluez-devel] the effect of linux 2.6.18 to the bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1042240747=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1042240747==
Content-Type: multipart/alternative;
	boundary="----=_Part_97205_21636485.1163486613942"

------=_Part_97205_21636485.1163486613942
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Martin,
   I have done some tests like you mentioned.

   A real machine (P4 3.0G+1G RAM)
   Debian Linux (original kernel 2.6.8)
   Bluez 3.6

   I have rebuilt the kernels in debian way:
                                      2.6.16.13-4 from opensuse 10.1
                                      2.6.17 from kernel.org
                                      2.6.18 from kernel org
                                      2.6.18-mh7 (with the patch mh7 from
bluez)

  The speed of OBEX is similar, but still low. about 5Kps. < 15~30 Kps (You=
r
results.)
   I don't know why.
   The configure?
   Could you give me your .config file when you build the kernel.
   Thank you very much.


2006/10/20, Martin R=F6hricht <ml@felicis.org>:
>
> Am Donnerstag, den 19.10.2006, 16:07 +0800 schrieb Mingfan.Lu:
>
> > I don't know whether the config make it happen or there is something
> > wrong with it?
> > So, Martin, How about you make config when you building your new
> > kernel?
>
> I build the kernels the "debian way" cause I use Ubuntu as well. So
> basically:
> (1) tar xjf linux-2.6.18.x.tar.bz2
> (2) cd linux-2.6.18.x
> (3) patch -p1 < ../patch-2.6.18-mh6
> (4) cp /boot/config-2.6.15-26-686 .config
> (5) make oldconfig
> [edit some config options manually if necessary]
> (6) fakeroot make-kpkg kernel_image modules_image --initrd --revision
> mh6 binary
> (7) cd ..
> (8) dpkg -i kernel-image-2.6.18.xmh6_i386.deb
>
> Edit /boot/grub/menu.lst if necessary and that's it.
> Your problems are really strange. How do you measure the time? I don't
> think it has anything to do with the config file per se. But I know of
> some pretty neat and improved debugging facilities -- maybe you want to
> check out that there is nothing in action that slows down the machine
> just for the purpose of deadlock detections.
>
> I'm sorry about it, but it seems extremely hard to me locating such a
> problem that never affects one of my machines. :-/
>
> Good luck,
> Martin
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
With respects,
   Mingfan.Lu

------=_Part_97205_21636485.1163486613942
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Martin,</div>
<div>&nbsp;&nbsp; I have done some tests like you mentioned.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; A real machine&nbsp;(P4 3.0G+1G RAM)</div>
<div>&nbsp;&nbsp; Debian Linux (original kernel 2.6.8)</div>
<div>&nbsp;&nbsp;&nbsp;Bluez 3.6</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
<div>&nbsp;&nbsp; I have rebuilt the kernels in debian way:</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 2.6.16.13-4 from&nbsp;opensuse 10.1</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 2.6.17 from <a href=3D"http://kernel.org">kernel.org</a></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;2.6.18 from kernel org</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 2.6.18-mh7 (with the patch&nbsp;mh7&nbsp;from bluez)</div>
<div>&nbsp;&nbsp; </div>
<div>&nbsp; The speed of OBEX is <font style=3D"BACKGROUND-COLOR: #ffff99">=
similar</font>, but still&nbsp;low. about 5Kps. &lt; 15~30 Kps (Your result=
s.)</div>
<div>&nbsp;&nbsp; I don't know why.</div>
<div>&nbsp;&nbsp; The configure?</div>
<div>&nbsp;&nbsp;&nbsp;Could you give me&nbsp;your .config file when you bu=
ild the kernel.</div>
<div>&nbsp;&nbsp; Thank you very much.<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">2006/10/20, Martin R=F6hricht &lt;<a href=
=3D"mailto:ml@felicis.org">ml@felicis.org</a>&gt;:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Am Donnerstag, den 19.10.2006, 1=
6:07 +0800 schrieb Mingfan.Lu:<br><br>&gt; I don't know whether the config =
make it happen or there is something
<br>&gt; wrong with it?<br>&gt; So, Martin, How about you make config when =
you building your new<br>&gt; kernel?<br><br>I build the kernels the &quot;=
debian way&quot; cause I use Ubuntu as well. So<br>basically:<br>(1) tar xj=
f=20
linux-2.6.18.x.tar.bz2<br>(2) cd linux-2.6.18.x<br>(3) patch -p1 &lt; ../pa=
tch-2.6.18-mh6<br>(4) cp /boot/config-2.6.15-26-686 .config<br>(5) make old=
config<br>[edit some config options manually if necessary]<br>(6) fakeroot =
make-kpkg kernel_image modules_image --initrd --revision
<br>mh6 binary<br>(7) cd ..<br>(8) dpkg -i kernel-image-2.6.18.xmh6_i386.de=
b<br><br>Edit /boot/grub/menu.lst if necessary and that's it.<br>Your probl=
ems are really strange. How do you measure the time? I don't<br>think it ha=
s anything to do with the config file per se. But I know of
<br>some pretty neat and improved debugging facilities -- maybe you want to=
<br>check out that there is nothing in action that slows down the machine<b=
r>just for the purpose of deadlock detections.<br><br>I'm sorry about it, b=
ut it seems extremely hard to me locating such a
<br>problem that never affects one of my machines. :-/<br><br>Good luck,<br=
>Martin<br><br><br><br>----------------------------------------------------=
---------------------<br>Using Tomcat but need to do more? Need to support =
web services, security?
<br>Get stuff done quickly with pre-integrated technology to make your job =
easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache=
 Geronimo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=
=3D120709&amp;bid=3D263057&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforg=
e.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
With respects,<br>&nbsp;&nbsp; Mingfan.Lu=20

------=_Part_97205_21636485.1163486613942--


--===============1042240747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1042240747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1042240747==--
