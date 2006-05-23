Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0605230838j63763d58i202639a6266e4434@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez service discovery
In-Reply-To: <9763591.1148373977331.JavaMail.rajanrengasamy@mac.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_72457_12782922.1148398681152"
References: <48637.156.116.2.246.1148036921.squirrel@webmail.uio.no>
	 <ef9938ec0605221453g29a81633v337564b60eb4e010@mail.gmail.com>
	 <9763591.1148373977331.JavaMail.rajanrengasamy@mac.com>
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
Date: Tue, 23 May 2006 11:38:01 -0400

------=_Part_72457_12782922.1148398681152
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Individual devices (e.g. phones) do not have UUIDs.  Services do.  If you'r=
e
implementing a Bluetooth profile, that profile should come with a
preassigned UUID.  If you're creating your own custom service that's not
part of the Bluetooth profiles or specifications, make your own uuid with
uuidgen.

More generally, a UUID is a 128-bit identifier.  Bluetooth has this notion
of 16-bit and 32-bit reserved UUIDs.  These are really 128-bit UUIDs, but
with the lower 112/96 bits fixed to the Bluetooth Base UUID.  If you find a
service with a 16-bit UUID (e.g. Serial Port Profile is 0x1101, then you ma=
y
need to convert it to the full 128-bit UUID.

-albert

On 5/23/06, Rajan Rengasamy <rajanrengasamy@mac.com> wrote:
>
> Hi Albert, if u dont mind me asking, would you be able to guide me on how
> i can get my phone's UUID? please thanks.
> i also have a k750.
>
> On Tuesday, May 23, 2006, at 07:54AM, Albert Huang <albert@csail.mit.edu>
> wrote:
>
> >
> ><<Original Attached>>
>
>
> Rajan
> -------------
> Tat Twvam Asi
>
>
> If you're using a Bluetooth reserved UUID, make sure that you've correctl=
y
> specified it by adding the Bluetooth Base UUID.
>
> -albert
>
> On 5/19/06, markusv@student.matnat.uio.no <markusv@student.matnat.uio.no>
> wrote:
> >
> >
> > hi
> > I am trying to discover services on my cellular phone a Sony Ericsson
> > k750
> > i. I am running ubuntu and the Bluez bluetooth protocol stack. I have
> > followed this example:
> > http://people.csail.mit.edu/albert/bluez-intro/x601.html
> > I have ofcourse changed the bluetooth address and the uuid to match my
> > phone and service. But still my program finds no services on the phone?=
?
> > What is wrong here? Anybody have some hints?
> >
> > Thanks
> > Markus
> >
> >
> >
> >
> >
> >
> >
> > -------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services,
> > security?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>

------=_Part_72457_12782922.1148398681152
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Individual devices (e.g. phones) do not have UUIDs.&nbsp; Services do.&nbsp=
; If you're implementing a Bluetooth profile, that profile should come with=
 a preassigned UUID.&nbsp; If you're creating your own custom service that'=
s not part of the Bluetooth profiles or specifications, make your own uuid =
with uuidgen.
<br><br>More generally, a UUID is a 128-bit identifier.&nbsp; Bluetooth has=
 this notion of 16-bit and 32-bit reserved UUIDs.&nbsp; These are really 12=
8-bit UUIDs, but with the lower 112/96 bits fixed to the Bluetooth Base UUI=
D.&nbsp; If you find a service with a 16-bit UUID (
e.g. Serial Port Profile is 0x1101, then you may need to convert it to the =
full 128-bit UUID.<br><br>-albert<br><br><div><span class=3D"gmail_quote">O=
n 5/23/06, <b class=3D"gmail_sendername">Rajan Rengasamy</b> &lt;<a href=3D=
"mailto:rajanrengasamy@mac.com">
rajanrengasamy@mac.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;"><div style=3D"direction: ltr;">Hi Albert, if u d=
ont mind me asking, would you be able to guide me on how i can get my phone=
's UUID? please thanks.
<br>i also have a k750.<br><br>On Tuesday, May 23, 2006, at 07:54AM, Albert=
 Huang &lt;<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=
=3D"mailto:albert@csail.mit.edu">albert@csail.mit.edu</a>&gt; wrote:<br><br=
>
&gt;<br>&gt;&lt;&lt;Original Attached&gt;&gt;<br><br><br>Rajan<br>---------=
----<br>Tat Twvam Asi<br><br></div><br>If you're using a Bluetooth reserved=
 UUID, make sure that you've correctly specified it by adding the Bluetooth=
 Base UUID.
<br><br>-albert<br><br><div><span class=3D"gmail_quote">On 5/19/06, <b clas=
s=3D"gmail_sendername"><a href=3D"mailto:markusv@student.matnat.uio.no" tar=
get=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
markusv@student.matnat.uio.no</a></b> &lt;<a href=3D"mailto:markusv@student=
.matnat.uio.no" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(wind=
ow,event,this)">markusv@student.matnat.uio.no</a>&gt; wrote:</span><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>hi<br>I am trying to discover services on my cellular phone a Sony Eric=
sson k750<br>i. I am running ubuntu and the Bluez bluetooth protocol stack.=
 I have<br>followed this example:<br><a href=3D"http://people.csail.mit.edu=
/albert/bluez-intro/x601.html" target=3D"_blank" onclick=3D"return top.js.O=
penExtLink(window,event,this)">

http://people.csail.mit.edu/albert/bluez-intro/x601.html</a><br>I have ofco=
urse changed the bluetooth address and the uuid to match my<br>phone and se=
rvice. But still my program finds no services on the phone??<br>What is wro=
ng here? Anybody have some hints?
<br><br>Thanks<br>Markus<br><br><br><br><br><br><br><br>-------------------=
------------------------------------<br>Using Tomcat but need to do more? N=
eed to support web services, security?<br>Get stuff done quickly with pre-i=
ntegrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D12070=
9&amp;bid=3D263057&amp;dat=3D121642" target=3D"_blank" onclick=3D"return to=
p.js.OpenExtLink(window,event,this)">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057=
&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"=
_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Bluez-user=
s@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

<br></blockquote></div><br>

------=_Part_72457_12782922.1148398681152--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
