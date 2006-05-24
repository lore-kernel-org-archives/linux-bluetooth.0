Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605231806o3b84eeb3x35f374a9e624e194@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Bluez service discovery
In-Reply-To: <57354.80.203.47.235.1148404102.squirrel@webmail.uio.no>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_78795_12829649.1148432786748"
References: <57354.80.203.47.235.1148404102.squirrel@webmail.uio.no>
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
Date: Tue, 23 May 2006 21:06:26 -0400

------=_Part_78795_12829649.1148432786748
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have you added the Bluetooth Base UUID, or one of the UUID functions
specific to reserved UUIDs?

-albert

On 5/23/06, markusv@student.matnat.uio.no <markusv@student.matnat.uio.no>
wrote:
>
>
> I have generated my own service and generated a UUID with uuidgen. But my
> laptop does not find my service on the phone! If i change the uuid to
> search for on the laptop to 0x1002 the public brose root, as far as I kno=
w
> it should than give me all services on the phone. But still no services
> are found. Searching with sdptool finds all services on the phone
> including my own. Why can't I find them in my C program? I would realy
> appreciate some help here. I have spent far to much time on that now, and
> I need that to work for my master thesis.
>
> Markus
>
>
>
> >Individual devices (e.g. phones) do not have UUIDs.  Services do.  If
> you're
> >implementing a Bluetooth profile, that profile should come with a
> >preassigned UUID.  If you're creating your own custom service that's not
> >part of the Bluetooth profiles or specifications, make your own uuid wit=
h
> >uuidgen.
> >
> >More generally, a UUID is a 128-bit identifier.  Bluetooth has this
> notion
> >of 16-bit and 32-bit reserved UUIDs.  These are really 128-bit UUIDs, bu=
t
> >with the lower 112/96 bits fixed to the Bluetooth Base UUID.  If you fin=
d
> a
> >service with a 16-bit UUID (e.g. Serial Port Profile is 0x1101, then you
> may
> >need to convert it to the full 128-bit UUID.
>
> -albert
>
> On 5/23/06, Rajan Rengasamy <rajanrengasamy@mac.com> wrote:
> >
> > Hi Albert, if u dont mind me asking, would you be able to guide me on
> how
> > i can get my phone's UUID? please thanks.
> > i also have a k750.
> >
> > On Tuesday, May 23, 2006, at 07:54AM, Albert Huang <albert@csail.mit.ed=
u
> >
> > wrote:
> >
> > >
> > ><<Original Attached>>
> >
> >
> > Rajan
> > -------------
> > Tat Twvam Asi
> >
> >
> > If you're using a Bluetooth reserved UUID, make sure that you've
> correctly
> > specified it by adding the Bluetooth Base UUID.
> >
> > -albert
> >
> > On 5/19/06, markusv@student.matnat.uio.no <markusv@student.matnat.uio.n=
o
> >
> > wrote:
> > >
> > >
> > > hi
> > > I am trying to discover services on my cellular phone a Sony Ericsson
> > > k750
> > > i. I am running ubuntu and the Bluez bluetooth protocol stack. I have
> > > followed this example:
> > > http://people.csail.mit.edu/albert/bluez-intro/x601.html
> > > I have ofcourse changed the bluetooth address and the uuid to match m=
y
> > > phone and service. But still my program finds no services on the
> phone??
> > > What is wrong here? Anybody have some hints?
> > >
> > > Thanks
> > > Markus
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > -------------------------------------------------------
> > > Using Tomcat but need to do more? Need to support web services,
> > > security?
> > > Get stuff done quickly with pre-integrated technology to make your jo=
b
> > > easier
> > > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > > Geronimo
> > >
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > >
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
> >
> >
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_78795_12829649.1148432786748
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have you added the Bluetooth Base UUID, or one of the UUID functions specif=
ic to reserved UUIDs?<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 5/23/06, <b class=3D"gma=
il_sendername"><a href=3D"mailto:markusv@student.matnat.uio.no">markusv@stu=
dent.matnat.uio.no</a></b> &lt;<a href=3D"mailto:markusv@student.matnat.uio=
.no">
markusv@student.matnat.uio.no</a>&gt; wrote:</span><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;"><br>I have generated my own service and g=
enerated a UUID with uuidgen. But my
<br>laptop does not find my service on the phone! If i change the uuid to<b=
r>search for on the laptop to 0x1002 the public brose root, as far as I kno=
w<br>it should than give me all services on the phone. But still no service=
s
<br>are found. Searching with sdptool finds all services on the phone<br>in=
cluding my own. Why can't I find them in my C program? I would realy<br>app=
reciate some help here. I have spent far to much time on that now, and<br>
I need that to work for my master thesis.<br><br>Markus<br><br><br><br>&gt;=
Individual devices (e.g. phones) do not have UUIDs.&nbsp;&nbsp;Services do.=
&nbsp;&nbsp;If you're<br>&gt;implementing a Bluetooth profile, that profile=
 should come with a
<br>&gt;preassigned UUID.&nbsp;&nbsp;If you're creating your own custom ser=
vice that's not<br>&gt;part of the Bluetooth profiles or specifications, ma=
ke your own uuid with<br>&gt;uuidgen.<br>&gt;<br>&gt;More generally, a UUID=
 is a 128-bit identifier.&nbsp;&nbsp;Bluetooth has this notion
<br>&gt;of 16-bit and 32-bit reserved UUIDs.&nbsp;&nbsp;These are really 12=
8-bit UUIDs, but<br>&gt;with the lower 112/96 bits fixed to the Bluetooth B=
ase UUID.&nbsp;&nbsp;If you find a<br>&gt;service with a 16-bit UUID (e.g. =
Serial Port Profile is 0x1101, then you may
<br>&gt;need to convert it to the full 128-bit UUID.<br><br>-albert<br><br>=
On 5/23/06, Rajan Rengasamy &lt;<a href=3D"mailto:rajanrengasamy@mac.com">r=
ajanrengasamy@mac.com</a>&gt; wrote:<br>&gt;<br>&gt; Hi Albert, if u dont m=
ind me asking, would you be able to guide me on how
<br>&gt; i can get my phone's UUID? please thanks.<br>&gt; i also have a k7=
50.<br>&gt;<br>&gt; On Tuesday, May 23, 2006, at 07:54AM, Albert Huang &lt;=
<a href=3D"mailto:albert@csail.mit.edu">albert@csail.mit.edu</a>&gt;<br>&gt=
; wrote:
<br>&gt;<br>&gt; &gt;<br>&gt; &gt;&lt;&lt;Original Attached&gt;&gt;<br>&gt;=
<br>&gt;<br>&gt; Rajan<br>&gt; -------------<br>&gt; Tat Twvam Asi<br>&gt;<=
br>&gt;<br>&gt; If you're using a Bluetooth reserved UUID, make sure that y=
ou've correctly
<br>&gt; specified it by adding the Bluetooth Base UUID.<br>&gt;<br>&gt; -a=
lbert<br>&gt;<br>&gt; On 5/19/06, <a href=3D"mailto:markusv@student.matnat.=
uio.no">markusv@student.matnat.uio.no</a> &lt;<a href=3D"mailto:markusv@stu=
dent.matnat.uio.no">
markusv@student.matnat.uio.no</a>&gt;<br>&gt; wrote:<br>&gt; &gt;<br>&gt; &=
gt;<br>&gt; &gt; hi<br>&gt; &gt; I am trying to discover services on my cel=
lular phone a Sony Ericsson<br>&gt; &gt; k750<br>&gt; &gt; i. I am running =
ubuntu and the Bluez bluetooth protocol stack. I have
<br>&gt; &gt; followed this example:<br>&gt; &gt; <a href=3D"http://people.=
csail.mit.edu/albert/bluez-intro/x601.html">http://people.csail.mit.edu/alb=
ert/bluez-intro/x601.html</a><br>&gt; &gt; I have ofcourse changed the blue=
tooth address and the uuid to match my
<br>&gt; &gt; phone and service. But still my program finds no services on =
the phone??<br>&gt; &gt; What is wrong here? Anybody have some hints?<br>&g=
t; &gt;<br>&gt; &gt; Thanks<br>&gt; &gt; Markus<br>&gt; &gt;<br>&gt; &gt;
<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &=
gt; -------------------------------------------------------<br>&gt; &gt; Us=
ing Tomcat but need to do more? Need to support web services,<br>&gt; &gt; =
security?
<br>&gt; &gt; Get stuff done quickly with pre-integrated technology to make=
 your job<br>&gt; &gt; easier<br>&gt; &gt; Download IBM WebSphere Applicati=
on Server v.1.0.1 based on Apache<br>&gt; &gt; Geronimo<br>&gt; &gt; <a hre=
f=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D2=
63057&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057=
&amp;dat=3D121642</a><br>&gt; &gt;<br>&gt; &gt; ___________________________=
____________________<br>&gt; &gt; Bluez-users mailing list<br>&gt; &gt; <a =
href=3D"mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; &gt; <a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users</a><br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt;<br><br>
<br><br>-------------------------------------------------------<br>Using To=
mcat but need to do more? Need to support web services, security?<br>Get st=
uff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D12070=
9&amp;bid=3D263057&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=3D=
lnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-user=
s@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

------=_Part_78795_12829649.1148432786748--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
