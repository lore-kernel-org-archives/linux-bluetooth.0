Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80510150319o37f31416scad1cf9a28907114@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1129288960.5057.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4250_3828253.1129371554045"
References: <45bf5ff80510140328me0ad427k4c1a8269cc97dccb@mail.gmail.com>
	 <1129288960.5057.44.camel@localhost.localdomain>
Subject: [Bluez-devel] =?ISO-8859-1?Q?Re:_[Bluez-devel]_Cant=B4t_connect_RF?= =?ISO-8859-1?Q?COMM_socket:_Device_or_resource_busy?=
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
Date: Sat, 15 Oct 2005 11:19:14 +0100

------=_Part_4250_3828253.1129371554045
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello
Marcel
 Im using debian sarge, all my packages are sync with this repository deb
http://bluez.sourceforge.net/download/debian/ ./
 Anyway looking at the dates of the packages i see they are quite old ... m=
y
bluez-utils is 2.9-2 from the 13 Aug 2004 ...hcicump is 1.5-2 from the 28 t=
h
nov 2002 .... is there another debian repository with the latest packages?
 Thanks
Regards
Artur

 On 10/14/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Artur,
>
> > Im having this problem of getting this error message when i try to run
> > the following command:
> >
> > rfcomm -i hci1 connect 1 00:13:FD:BB:22:3F 9
> >
> >
> > Can't connect RFCOMM socket: Device or resource busy
> >
> > This happens everytime im downloading a file, i stop the bluetooth on
> > my cell phone then i reconnect and try to send the same file. Is there
> > a solution to handle this problem without reseting the hci1 ?
> >
> > Even if i try to restart the bluetooth daemon the error persists, only
> > reseting my machine im able to connect again using the rfcomm command.
> > Im using debian sarge with the bluez packages.
> >
> >
> >
> > The output from from hcidump when i try to perform this operation is:
>
> install the latest hcidump and use the -X and -V parameters.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

------=_Part_4250_3828253.1129371554045
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello</div>
<div>Marcel</div>
<div>&nbsp;</div>
<div>Im using debian sarge, all my packages are sync with this repository d=
eb <a href=3D"http://bluez.sourceforge.net/download/debian/">http://bluez.s=
ourceforge.net/download/debian/</a> ./</div>
<div>&nbsp;</div>
<div>Anyway looking at the dates of the packages i see they are quite old .=
.. my bluez-utils is 2.9-2 from the 13 Aug 2004 ...hcicump is 1.5-2 from th=
e 28 th nov 2002 .... is there another debian repository with the latest pa=
ckages?
</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Regards</div>
<div>Artur<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 10/14/05, <b class=3D"gmail_sendername"=
>Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holt=
mann.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Artur,<br><br>&gt; Im having =
this problem of getting this error message when i try to run<br>&gt; the fo=
llowing command:
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rfcomm -i =
hci1 connect 1 00:13:FD:BB:22:3F 9<br>&gt;<br>&gt;<br>&gt; Can't connect RF=
COMM socket: Device or resource busy<br>&gt;<br>&gt; This happens everytime=
 im downloading a file, i stop the bluetooth on
<br>&gt; my cell phone then i reconnect and try to send the same file. Is t=
here<br>&gt; a solution to handle this problem without reseting the hci1 ?<=
br>&gt;<br>&gt; Even if i try to restart the bluetooth daemon the error per=
sists, only
<br>&gt; reseting my machine im able to connect again using the rfcomm comm=
and.<br>&gt; Im using debian sarge with the bluez packages.<br>&gt;<br>&gt;=
<br>&gt;<br>&gt; The output from from hcidump when i try to perform this op=
eration is:
<br><br>install the latest hcidump and use the -X and -V parameters.<br><br=
>Regards<br><br>Marcel<br><br><br><br><br>---------------------------------=
----------------------<br>This SF.Net email is sponsored by:<br>Power Archi=
tecture Resource Center: Free content, downloads, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br><br></blockquote></div><br>

------=_Part_4250_3828253.1129371554045--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
