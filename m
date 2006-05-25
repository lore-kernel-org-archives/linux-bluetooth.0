Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605251023g6fd903acx1b31be93f07223d5@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Bluez service discovery
In-Reply-To: <56326.80.203.47.235.1148559121.squirrel@webmail.uio.no>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4094_1806397.1148577822093"
References: <56326.80.203.47.235.1148559121.squirrel@webmail.uio.no>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 25 May 2006 13:23:42 -0400

------=_Part_4094_1806397.1148577822093
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 5/25/06, markusv@student.matnat.uio.no <markusv@student.matnat.uio.no>
wrote:
>
>
> My UUID is: 1c712d88aac711da818a000bcd4e8912. I created this with uuidgen=
.
> I have done nothing more to it. Do I have to??


No, that's fine.

What do I have to do? How
> do I add the Bluetooth Base UUID or one of the UUID functions specific to
> reserved UUIDs?


To create a valid UUID out of a 16-bit reserved UUID, use
sdp_uuid16_create.  See sdp_lib.h for details, it should be pretty self
explanatory.  There a bunch of defined constants in sdp.h that you can also
use.  e.g.

{
  uuid_t u;
  sdp_uuid16_create( &u, PUBLIC_BROWSE_GROUP );
}

If you continue to have trouble, download the bluez source code and examine
sdptool.c

-albert

Markus
>
> > Have you added the Bluetooth Base UUID, or one of the UUID functions
> >  specific to reserved UUIDs?
> >
> > -albert
> >
> > On 5/23/06, markusv@st... <markusv@st...>
> > wrote:
> >
> >
> > I have generated my own service and generated a UUID with uuidgen. But
> my
> > laptop does not find my service on the phone! If i change the uuid to
> > search for on the laptop to 0x1002 the public brose root, as far as I
> know
> > it should than give me all services on the phone. But still no services
> > are found. Searching with sdptool finds all services on the phone
> > including my own. Why can't I find them in my C program? I would realy
> > appreciate some help here. I have spent far to much time on that now,
> and
> > I need that to work for my master thesis.
> >
> > Markus
> >
> >
> >
> > >Individual devices (e.g. phones) do not have UUIDs.  Services do.  If
> > you're
> > >implementing a Bluetooth profile, that profile should come with a
> > >preassigned UUID.  If you're creating your own custom service that's
> not
> > >part of the Bluetooth profiles or specifications, make your own uuid
> with
> > >uuidgen.
> > >
> > >More generally, a UUID is a 128-bit identifier.  Bluetooth has this
> > notion
> > >of 16-bit and 32-bit reserved UUIDs.  These are really 128-bit UUIDs,
> but
> > >with the lower 112/96 bits fixed to the Bluetooth Base UUID.  If you
> find
> > a
> > >service with a 16-bit UUID (e.g. Serial Port Profile is 0x1101, then
> you
> > may
> > >need to convert it to the full 128-bit UUID.
> >
> > -albert
> >
> > On 5/23/06, Rajan Rengasamy <rajanrengasamy@ma...> wrote:
> > >
> > > Hi Albert, if u dont mind me asking, would you be able to guide me on
> > how
> > > i can get my phone's UUID? please thanks.
> > > i also have a k750.
> > >
> > > On Tuesday, May 23, 2006, at 07:54AM, Albert Huang <albert@cs...
> > >
> > > wrote:
> > >
> > > >
> > > ><<Original Attached>>
> > >
> > >
> > > Rajan
> > > -------------
> > > Tat Twvam Asi
> > >
> > >
> > > If you're using a Bluetooth reserved UUID, make sure that you've
> > correctly
> > > specified it by adding the Bluetooth Base UUID.
> > >
> > > -albert
> > >
> > > On 5/19/06, markusv@st... <markusv@st...
> > >
> > > wrote:
> > > >
> > > >
> > > > hi
> > > > I am trying to discover services on my cellular phone a Sony
> Ericsson
> > > > k750
> > > > i. I am running ubuntu and the Bluez bluetooth protocol stack. I
> have
> > > > followed this example:
> > > > http://people.csail.mit.edu/albert/bluez-intro/x601.html
> > > > I have ofcourse changed the bluetooth address and the uuid to match
> my
> > > > phone and service. But still my program finds no services on the
> > phone??
> > > > What is wrong here? Anybody have some hints?
> > > >
> > > > Thanks
> > > > Markus
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > -------------------------------------------------------
> > > > Using Tomcat but need to do more? Need to support web services,
> > > > security?
> > > > Get stuff done quickly with pre-integrated technology to make your
> job
> > > > easier
> > > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > > > Geronimo
> > > >
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > > >
> > > > _______________________________________________
> > > > Bluez-users mailing list
> > > > Bluez-users@li...
> > > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > >
> > >
> > >
> > >
> >
> >
> >
> > -------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services,
> security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@li...
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>
>
> -------------------------------------------------------
> All the advantages of Linux Managed Hosting--Without the Cost and Risk!
> Fully trained technicians. The highest number of Red Hat certifications i=
n
> the hosting industry. Fanatical Support. Click to learn more
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D107521&bid=3D248729&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_4094_1806397.1148577822093
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 5/25/06, <b class=3D"gmail_send=
ername"><a href=3D"mailto:markusv@student.matnat.uio.no">markusv@student.ma=
tnat.uio.no</a></b> &lt;<a href=3D"mailto:markusv@student.matnat.uio.no">ma=
rkusv@student.matnat.uio.no
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;"><br>My UUID is: 1c712d88aac711da818a000bcd4e8912. I created this with =
uuidgen.
<br>I have done nothing more to it. Do I have to?? </blockquote><div><br>No=
, that's fine.<br></div><br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
What do I have to do? How<br>do I add the Bluetooth Base UUID or one of the=
 UUID functions specific to<br>reserved UUIDs?</blockquote><div><br>To crea=
te a valid UUID out of a 16-bit reserved UUID, use sdp_uuid16_create.&nbsp;=
 See sdp_lib.h for details, it should be pretty self explanatory.&nbsp; The=
re a bunch of defined constants in=20
sdp.h that you can also use.&nbsp; e.g.<br><br>{<br>&nbsp; uuid_t u;<br>&nb=
sp; sdp_uuid16_create( &amp;u, PUBLIC_BROWSE_GROUP );<br>}<br><br>If you co=
ntinue to have trouble, download the bluez source code and examine sdptool.=
c<br><br>-albert
<br></div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Mar=
kus<br><br>&gt; Have you added the Bluetooth Base UUID, or one of the UUID =
functions
<br>&gt;&nbsp;&nbsp;specific to reserved UUIDs?<br>&gt;<br>&gt; -albert<br>=
&gt;<br>&gt; On 5/23/06, markusv@st... &lt;markusv@st...&gt;<br>&gt; wrote:=
<br> &gt;<br> &gt;<br> &gt; I have generated my own service and generated a=
 UUID with uuidgen. But my
<br> &gt; laptop does not find my service on the phone! If i change the uui=
d to<br> &gt; search for on the laptop to 0x1002 the public brose root, as =
far as I know<br> &gt; it should than give me all services on the phone. Bu=
t still no services
<br> &gt; are found. Searching with sdptool finds all services on the phone=
<br> &gt; including my own. Why can't I find them in my C program? I would =
realy<br> &gt; appreciate some help here. I have spent far to much time on =
that now, and
<br> &gt; I need that to work for my master thesis.<br> &gt;<br> &gt; Marku=
s<br> &gt;<br> &gt;<br> &gt;<br> &gt; &gt;Individual devices (e.g. phones) =
do not have UUIDs.&nbsp;&nbsp;Services do.&nbsp;&nbsp;If<br> &gt; you're<br=
> &gt; &gt;implementing a Bluetooth profile, that profile should come with =
a
<br> &gt; &gt;preassigned UUID.&nbsp;&nbsp;If you're creating your own cust=
om service that's not<br> &gt; &gt;part of the Bluetooth profiles or specif=
ications, make your own uuid with<br> &gt; &gt;uuidgen.<br> &gt; &gt;<br> &=
gt; &gt;More generally, a UUID is a 128-bit identifier.&nbsp;&nbsp;Bluetoot=
h has this
<br> &gt; notion<br> &gt; &gt;of 16-bit and 32-bit reserved UUIDs.&nbsp;&nb=
sp;These are really 128-bit UUIDs, but<br> &gt; &gt;with the lower 112/96 b=
its fixed to the Bluetooth Base UUID.&nbsp;&nbsp;If you find<br> &gt; a<br>=
 &gt; &gt;service with a 16-bit UUID (
e.g. Serial Port Profile is 0x1101, then you<br> &gt; may<br> &gt; &gt;need=
 to convert it to the full 128-bit UUID.<br> &gt;<br> &gt; -albert<br> &gt;=
<br> &gt; On 5/23/06, Rajan Rengasamy &lt;rajanrengasamy@ma...&gt; wrote:
<br> &gt; &gt;<br> &gt; &gt; Hi Albert, if u dont mind me asking, would you=
 be able to guide me on<br> &gt; how<br> &gt; &gt; i can get my phone's UUI=
D? please thanks.<br> &gt; &gt; i also have a k750.<br> &gt; &gt;<br> &gt; =
&gt; On Tuesday, May 23, 2006, at 07:54AM, Albert Huang &lt;
albert@cs...<br> &gt; &gt;<br> &gt; &gt; wrote:<br> &gt; &gt;<br> &gt; &gt;=
 &gt;<br> &gt; &gt; &gt;&lt;&lt;Original Attached&gt;&gt;<br> &gt; &gt;<br>=
 &gt; &gt;<br> &gt; &gt; Rajan<br> &gt; &gt; -------------<br> &gt; &gt; Ta=
t Twvam Asi
<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt; If you're using a Bluetooth rese=
rved UUID, make sure that you've<br> &gt; correctly<br> &gt; &gt; specified=
 it by adding the Bluetooth Base UUID.<br> &gt; &gt;<br> &gt; &gt; -albert
<br> &gt; &gt;<br> &gt; &gt; On 5/19/06, markusv@st... &lt;markusv@st...<br=
> &gt; &gt;<br> &gt; &gt; wrote:<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> =
&gt; &gt; &gt; hi<br> &gt; &gt; &gt; I am trying to discover services on my=
 cellular phone a Sony Ericsson
<br> &gt; &gt; &gt; k750<br> &gt; &gt; &gt; i. I am running ubuntu and the =
Bluez bluetooth protocol stack. I have<br> &gt; &gt; &gt; followed this exa=
mple:<br> &gt; &gt; &gt; <a href=3D"http://people.csail.mit.edu/albert/blue=
z-intro/x601.html">
http://people.csail.mit.edu/albert/bluez-intro/x601.html</a><br> &gt; &gt; =
&gt; I have ofcourse changed the bluetooth address and the uuid to match my=
<br> &gt; &gt; &gt; phone and service. But still my program finds no servic=
es on the
<br> &gt; phone??<br> &gt; &gt; &gt; What is wrong here? Anybody have some =
hints?<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; Thanks<br> &gt; &gt; &gt; Mark=
us<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &=
gt;
<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt;<br> &gt; &gt; &gt=
; -------------------------------------------------------<br> &gt; &gt; &gt=
; Using Tomcat but need to do more? Need to support web services,<br> &gt; =
&gt; &gt; security?
<br> &gt; &gt; &gt; Get stuff done quickly with pre-integrated technology t=
o make your job<br> &gt; &gt; &gt; easier<br> &gt; &gt; &gt; Download IBM W=
ebSphere Application Server v.1.0.1 based on Apache<br> &gt; &gt; &gt; Gero=
nimo
<br> &gt; &gt; &gt;<br> &gt; <a href=3D"http://sel.as-us.falkag.net/sel?cmd=
=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642">http://sel.as-us=
.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D12164=
2</a><br> &gt; &gt; &gt;
<br> &gt; &gt; &gt; _______________________________________________<br> &gt=
; &gt; &gt; Bluez-users mailing list<br> &gt; &gt; &gt; Bluez-users@li...<b=
r> &gt; &gt; &gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/b=
luez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br> &gt; &gt; =
&gt;<br> &gt; &gt;<br> &gt; &gt;<br> &gt; &gt;<br> &gt;<br> &gt;<br> &gt;<b=
r> &gt; -------------------------------------------------------<br> &gt; Us=
ing Tomcat but need to do more? Need to support web services, security?
<br> &gt; Get stuff done quickly with pre-integrated technology to make you=
r job<br> &gt; easier<br> &gt; Download IBM WebSphere Application Server v.=
1.0.1 based on Apache Geronimo<br> &gt; <a href=3D"http://sel.as-us.falkag.=
net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057=
&amp;dat=3D121642</a><br> &gt; ____________________________________________=
___<br> &gt; Bluez-users mailing list<br> &gt; Bluez-users@li...<br> &gt; <=
a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br> &gt;<br><b=
r><br><br><br>-------------------------------------------------------<br>Al=
l the advantages of Linux Managed Hosting--Without the Cost and Risk!<br>
Fully trained technicians. The highest number of Red Hat certifications in<=
br>the hosting industry. Fanatical Support. Click to learn more<br><a href=
=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D107521&amp;bid=3D24=
8729&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D107521&amp;bid=3D248729=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforg=
e.net">
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br></blockquote></div><br>

------=_Part_4094_1806397.1148577822093--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
