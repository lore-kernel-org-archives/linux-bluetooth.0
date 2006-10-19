Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610190107je24b0bbg6bd5da0a05f6e0f2@mail.gmail.com>
Date: Thu, 19 Oct 2006 16:07:36 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1161000951.10392.26.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20610152225h7e020518m3c6062ce9be25044@mail.gmail.com>
	<1161000951.10392.26.camel@localhost>
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
Content-Type: multipart/mixed; boundary="===============0594580953=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0594580953==
Content-Type: multipart/alternative;
	boundary="----=_Part_192535_12257782.1161245256274"

------=_Part_192535_12257782.1161245256274
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, Martin,

Thank you for you nice help.

I retest it in a ubuntu machine (kernel version 2.6.15), bluez lib's
 version is 2.24
Then I rebuilt 2.6.18 in the ubuntu machine.
I still found that 2.6.18 is much slower than 2.6.15 when pushing obex over
bluez.

when I rebuit 2.6.18 in the 2.6.15 kernel machine:

make mrproper
make oldconfig (use default value for every new config)
make
make modules_install
make install
mkinitramfs -o /boot/initrd.img-2.6.18 2.6.18

I don't know whether the config make it happen or there is something wrong
with it?
So, Martin, How about you make config when you building your new kernel?

Thanks very much.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2006/10/16, Martin R=F6hricht <ml@felicis.org>:
>
> Am Montag, den 16.10.2006, 13:25 +0800 schrieb Mingfan.Lu:
> > the following is my test result in a real machine:
> > [...]
>
> Okay, due to your tenacious demand, I compiled and installed a plain
> 2.6.18.1 vanilla kernel as well as a 2.6.18.1 kernel with the latest
> -mh5 patch applied.
> I will show you my test results for two files, the first being 1376034
> bytes (1,31MB) in size and the second being 2397995 bytes (2,29MB) in
> size.
> Let me at first mention the results that I got. I didn't encounter any
> slowness by using a 2.6.18.1 vanilla kernel. However it looks like the
> newly introduced and applied flow control may slow down the transfer
> speed. But be aware that (L2CAP) flow control mode is in action only by
> using two Linux kernels that have one of the latest -mh* patches
> applied! This mode is not(!) used by transmission between a Linux
> computer and another one that uses a proprietary Bluetooth software
> stack (even if the new Symbian OS may be able to use flow control mode,
> too), or say two Linux computers of which one has a kernel without this
> new patch applied.
> You didn't specify your exact settings -> did you apply one of the
> latest -mh* patches to you 2.6.18 kernel or not? Which computers did you
> use (one is the Linux computer but who is the other one)?
>
> So here are my results. The first three tests were done between a Linux
> computer and an Apple iMac G4 with the Apple Bluetooth stack that comes
> with Mac OS X 10.4:
>
> Test with kernel 2.6.18.1 and Apple Bluetooth Stack:
> Retrieval:
> 1376034 bytes -> 58 sec -> 23KB/s
> 2397995 bytes -> 95 sec -> 25KB/s
>
> Transmission:
> 1376034 bytes -> 42 sec -> 32KB/s
> 2397995 bytes -> 73 sec -> 32KB/s
>
>
> Test with kernel 2.6.15 (Ubuntu Dapper Drake) and Apple Bluetooth Stack:
> Retrieval:
> 1376034 bytes -> 57 sec -> 24KB/s
> 2397995 bytes -> 99 sec -> 24KB/s
>
> Transmission:
> 1376034 bytes -> 46 sec -> 29KB/s
> 2397995 bytes -> 77 sec -> 30KB/s
>
>
> Test with kernel 2.6.18.1-mh5 and Apple Bluetooth Stack:
> Retrieval:
> 1376034 bytes -> 54 sec -> 25KB/s
> 2397995 bytes -> 94 sec -> 25KB/s
>
> Transmission:
> 1376034 bytes -> 43 sec -> 31KB/s
> 2397995 bytes -> 73 sec -> 32KB/s
>
>
> ------------(now between two Linux computers)---------
> Test with kernel 2.6.18.1-mh5 to kernel 2.6.18.1-mh5
> Retrieval:
> 1376034 bytes -> 88 sec -> 15KB/s
> 2397995 bytes -> 154 sec -> 15KB/s
>
> Transmission:
> 1376034 bytes -> 82 sec -> 16KB/s
> 2397995 bytes -> 140 sec -> 17KB/s
>
>
> Test with kernel 2.6.18.1-mh5 to kernel 2.6.15 (Ubuntu Dapper Drake)
> Retrieval:
> 1376034 bytes -> 57 sec -> 24KB/s
> 2397995 bytes -> 99 sec -> 24KB/s
>
> Transmission:
> 1376034 bytes -> 68 sec -> 20KB/s
> 2397995 bytes -> 114 sec -> 21KB/s
>
>
> As you can see -- the transmission speed is quite constant between the
> same setups. Two things would need more investigations:
> (1) Why is it that a file transfer from Linux to Apple is faster than
>    between two Linux entities?
> (2) Is it really L2CAP Flow Control Mode that slows down the connection
>    with its protocol overhead?
>
> If Flow Control Mode really slows down the connection, we should try to
> implement a user interface to enable or disable this mode. But currently
> this is not urgent as no other device makes use of it.
>
> Martin
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

------=_Part_192535_12257782.1161245256274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi, Martin,</div>
<div>&nbsp;</div>
<div>Thank you for you nice help.</div>
<div>&nbsp;</div>
<div>I&nbsp;retest&nbsp;it&nbsp;in a ubuntu machine (kernel version 2.6.15)=
, bluez lib's &nbsp;version is 2.24</div>
<div>Then I rebuilt 2.6.18 in the ubuntu machine.</div>
<div>I still found that 2.6.18 is much slower than 2.6.15 when pushing obex=
 over bluez.</div>
<div>&nbsp;</div>
<div>when I rebuit 2.6.18&nbsp;in the 2.6.15 kernel machine:</div>
<div>&nbsp;</div>
<div>make mrproper</div>
<div>make oldconfig (use default value for every new config)</div>
<div>make </div>
<div>make modules_install</div>
<div>make install</div>
<div>mkinitramfs -o /boot/initrd.img-2.6.18 2.6.18</div>
<div>&nbsp;</div>
<div>I don't know whether the config make it happen or there is something w=
rong with it?</div>
<div>So, Martin, How about you make config when you building your new kerne=
l?</div>
<div>&nbsp;</div>
<div>Thanks very much.</div>
<div>&nbsp;</div>
<div><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</d=
iv>
<div><span class=3D"gmail_quote">2006/10/16, Martin R=F6hricht &lt;<a href=
=3D"mailto:ml@felicis.org">ml@felicis.org</a>&gt;:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Am Montag, den 16.10.2006, 13:25=
 +0800 schrieb Mingfan.Lu:<br>&gt; the following is my test result in a rea=
l machine:
<br>&gt; [...]<br><br>Okay, due to your tenacious demand, I compiled and in=
stalled a plain<br><a href=3D"http://2.6.18.1">2.6.18.1</a> vanilla kernel =
as well as a <a href=3D"http://2.6.18.1">2.6.18.1</a> kernel with the lates=
t
<br>-mh5 patch applied.<br>I will show you my test results for two files, t=
he first being 1376034<br>bytes (1,31MB) in size and the second being 23979=
95 bytes (2,29MB) in<br>size.<br>Let me at first mention the results that I=
 got. I didn't encounter any
<br>slowness by using a <a href=3D"http://2.6.18.1">2.6.18.1</a> vanilla ke=
rnel. However it looks like the<br>newly introduced and applied flow contro=
l may slow down the transfer<br>speed. But be aware that (L2CAP) flow contr=
ol mode is in action only by
<br>using two Linux kernels that have one of the latest -mh* patches<br>app=
lied! This mode is not(!) used by transmission between a Linux<br>computer =
and another one that uses a proprietary Bluetooth software<br>stack (even i=
f the new Symbian OS may be able to use flow control mode,
<br>too), or say two Linux computers of which one has a kernel without this=
<br>new patch applied.<br>You didn't specify your exact settings -&gt; did =
you apply one of the<br>latest -mh* patches to you 2.6.18 kernel or not? Wh=
ich computers did you
<br>use (one is the Linux computer but who is the other one)?<br><br>So her=
e are my results. The first three tests were done between a Linux<br>comput=
er and an Apple iMac G4 with the Apple Bluetooth stack that comes<br>with M=
ac OS X=20
10.4:<br><br>Test with kernel <a href=3D"http://2.6.18.1">2.6.18.1</a> and =
Apple Bluetooth Stack:<br>Retrieval:<br>1376034 bytes -&gt; 58 sec -&gt; 23=
KB/s<br>2397995 bytes -&gt; 95 sec -&gt; 25KB/s<br><br>Transmission:<br>137=
6034 bytes -&gt; 42 sec -&gt; 32KB/s
<br>2397995 bytes -&gt; 73 sec -&gt; 32KB/s<br><br><br>Test with kernel 2.6=
.15 (Ubuntu Dapper Drake) and Apple Bluetooth Stack:<br>Retrieval:<br>13760=
34 bytes -&gt; 57 sec -&gt; 24KB/s<br>2397995 bytes -&gt; 99 sec -&gt; 24KB=
/s
<br><br>Transmission:<br>1376034 bytes -&gt; 46 sec -&gt; 29KB/s<br>2397995=
 bytes -&gt; 77 sec -&gt; 30KB/s<br><br><br>Test with kernel 2.6.18.1-mh5 a=
nd Apple Bluetooth Stack:<br>Retrieval:<br>1376034 bytes -&gt; 54 sec -&gt;=
 25KB/s
<br>2397995 bytes -&gt; 94 sec -&gt; 25KB/s<br><br>Transmission:<br>1376034=
 bytes -&gt; 43 sec -&gt; 31KB/s<br>2397995 bytes -&gt; 73 sec -&gt; 32KB/s=
<br><br><br>------------(now between two Linux computers)---------<br>Test =
with kernel=20
2.6.18.1-mh5 to kernel 2.6.18.1-mh5<br>Retrieval:<br>1376034 bytes -&gt; 88=
 sec -&gt; 15KB/s<br>2397995 bytes -&gt; 154 sec -&gt; 15KB/s<br><br>Transm=
ission:<br>1376034 bytes -&gt; 82 sec -&gt; 16KB/s<br>2397995 bytes -&gt; 1=
40 sec -&gt; 17KB/s
<br><br><br>Test with kernel 2.6.18.1-mh5 to kernel 2.6.15 (Ubuntu Dapper D=
rake)<br>Retrieval:<br>1376034 bytes -&gt; 57 sec -&gt; 24KB/s<br>2397995 b=
ytes -&gt; 99 sec -&gt; 24KB/s<br><br>Transmission:<br>1376034 bytes -&gt; =
68 sec -&gt; 20KB/s
<br>2397995 bytes -&gt; 114 sec -&gt; 21KB/s<br><br><br>As you can see -- t=
he transmission speed is quite constant between the<br>same setups. Two thi=
ngs would need more investigations:<br>(1) Why is it that a file transfer f=
rom Linux to Apple is faster than
<br>&nbsp;&nbsp; between two Linux entities?<br>(2) Is it really L2CAP Flow=
 Control Mode that slows down the connection<br>&nbsp;&nbsp; with its proto=
col overhead?<br><br>If Flow Control Mode really slows down the connection,=
 we should try to
<br>implement a user interface to enable or disable this mode. But currentl=
y<br>this is not urgent as no other device makes use of it.<br><br>Martin<b=
r><br><br>-----------------------------------------------------------------=
--------
<br>Using Tomcat but need to do more? Need to support web services, securit=
y?<br>Get stuff done quickly with pre-integrated technology to make your jo=
b easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apac=
he Geronimo
<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&a=
mp;bid=3D263057&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3Dlnk=
&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642</a><br>________________=
_______________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br>With respects,<=
br>&nbsp;&nbsp; Mingfan.Lu=20

------=_Part_192535_12257782.1161245256274--


--===============0594580953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0594580953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0594580953==--
