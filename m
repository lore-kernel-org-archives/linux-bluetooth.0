Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604190956r40a902b5sce596c16e40ce8e1@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Programming in C with Bluetooth Sockets
In-Reply-To: <c6a2f99a0604190804k7de31858i94b74e2d06b3ff11@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4002_25573710.1145465816147"
References: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
	 <fe0a97c20604182118w6f25db3ei437dde8f23c93436@mail.gmail.com>
	 <c6a2f99a0604190804k7de31858i94b74e2d06b3ff11@mail.gmail.com>
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
Date: Wed, 19 Apr 2006 12:56:56 -0400

------=_Part_4002_25573710.1145465816147
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

use hcidump -X -V to examine the packets that actually get transmitted and
received.  That might give you some insight on where things are going wrong=
.

-albert

On 4/19/06, Eric Munson <ebmunson@gmail.com> wrote:
>
> Thanks for the link, but I have already been through that
> documentation and my initial attempt was a direct copy of of his
> RFCOMM socket code found here:
> http://people.csail.mit.edu/albert/bluez-intro/x499.html  This code
> gave the results that I am describing (only getting the first 4 bytes
> of a string).
>
> Thanks,
> Eric
>
> On 4/18/06, Sowmya Gattupalli <sowmya.gattupalli@gmail.com> wrote:
> > I think u are not doing the socket programmin properly
> > check out this link
> > http://people.csail.mit.edu/albert/bluez-intro/index.html
> > by Albert
> >
> >
> > On 4/19/06, Eric Munson <ebmunson@gmail.com> wrote:
> > >
> >  I am attempting to move data across a bluetooth connection using
> > RFCOMM sockets in C.
> >
> > I am able to establish the connection and I can successfully send and
> > receive the first four bytes of the message.  The sending program
> > reports a complete success and the receiving program only reads the
> > first four characters.
> >
> > I have tried several things to make this work, first was to send the
> > message size initially and then break the message up into pieces no
> > bigger than 4 bytes and send them individually.  The sending program
> > again reports a complete success and the receiving program gets the
> > correct message size and only the first four bytes of the message.
> >
> >  The next step I tried was to have each side close the socket after
> > each transmission and open a new socket for each data chunk.  This led
> > to the same results as before.
> >
> > I am at a loss about what I am doing wrong after searching the web for
> > information on bluetooth socket programming.  Has Anyone seen this
> > sort of problem before and if so what did you do to fix it?  Thanks
> > for your help.
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> > that extends applications into web and mobile media. Attend the live
> webcast
> > and join the prime developer group breaking into this new coding
> territory!
> > http://sel.as-us.falkag.net/sel?cmdlnk&kid=110944&bid$1720&dat=121642
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=120709&bid&3057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_4002_25573710.1145465816147
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

use hcidump -X -V to examine the packets that actually get transmitted and =
received.&nbsp; That might give you some insight on where things are going =
wrong.<br><br>-albert<br><br><div><span class=3D"gmail_quote">On 4/19/06, <=
b class=3D"gmail_sendername">
Eric Munson</b> &lt;<a href=3D"mailto:ebmunson@gmail.com">ebmunson@gmail.co=
m</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
Thanks for the link, but I have already been through that<br>documentation =
and my initial attempt was a direct copy of of his<br>RFCOMM socket code fo=
und here:<br><a href=3D"http://people.csail.mit.edu/albert/bluez-intro/x499=
.html">
http://people.csail.mit.edu/albert/bluez-intro/x499.html</a>&nbsp;&nbsp;Thi=
s code<br>gave the results that I am describing (only getting the first 4 b=
ytes<br>of a string).<br><br>Thanks,<br>Eric<br><br>On 4/18/06, Sowmya Gatt=
upalli &lt;
<a href=3D"mailto:sowmya.gattupalli@gmail.com">sowmya.gattupalli@gmail.com<=
/a>&gt; wrote:<br>&gt; I think u are not doing the socket programmin proper=
ly<br>&gt; check out this link<br>&gt; <a href=3D"http://people.csail.mit.e=
du/albert/bluez-intro/index.html">
http://people.csail.mit.edu/albert/bluez-intro/index.html</a><br>&gt; by Al=
bert<br>&gt;<br>&gt;<br>&gt; On 4/19/06, Eric Munson &lt;<a href=3D"mailto:=
ebmunson@gmail.com">ebmunson@gmail.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt;&=
nbsp;&nbsp;I am attempting to move data across a bluetooth connection using
<br>&gt; RFCOMM sockets in C.<br>&gt;<br>&gt; I am able to establish the co=
nnection and I can successfully send and<br>&gt; receive the first four byt=
es of the message.&nbsp;&nbsp;The sending program<br>&gt; reports a complet=
e success and the receiving program only reads the
<br>&gt; first four characters.<br>&gt;<br>&gt; I have tried several things=
 to make this work, first was to send the<br>&gt; message size initially an=
d then break the message up into pieces no<br>&gt; bigger than 4 bytes and =
send them individually.&nbsp;&nbsp;The sending program
<br>&gt; again reports a complete success and the receiving program gets th=
e<br>&gt; correct message size and only the first four bytes of the message=
.<br>&gt;<br>&gt;&nbsp;&nbsp;The next step I tried was to have each side cl=
ose the socket after
<br>&gt; each transmission and open a new socket for each data chunk.&nbsp;=
&nbsp;This led<br>&gt; to the same results as before.<br>&gt;<br>&gt; I am =
at a loss about what I am doing wrong after searching the web for<br>&gt; i=
nformation on bluetooth socket programming.&nbsp;&nbsp;Has Anyone seen this
<br>&gt; sort of problem before and if so what did you do to fix it?&nbsp;&=
nbsp;Thanks<br>&gt; for your help.<br>&gt;<br>&gt;<br>&gt; ----------------=
---------------------------------------<br>&gt; This SF.Net email is sponso=
red by xPML, a groundbreaking scripting language
<br>&gt; that extends applications into web and mobile media. Attend the li=
ve webcast<br>&gt; and join the prime developer group breaking into this ne=
w coding territory!<br>&gt; <a href=3D"http://sel.as-us.falkag.net/sel?cmdl=
nk&amp;kid=110944&amp;bid$1720&amp;dat=121642">
http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=110944&amp;bid$1720&amp;dat=
=121642</a><br>&gt; _______________________________________________<br>&gt;=
 Bluez-users mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourc=
eforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lists.sour=
ceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists=
/listinfo/bluez-users</a><br>&gt;<br>&gt;<br><br><br>----------------------=
---------------------------------
<br>Using Tomcat but need to do more? Need to support web services, securit=
y?<br>Get stuff done quickly with pre-integrated technology to make your jo=
b easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apac=
he Geronimo
<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=120709&amp;bi=
d&amp;3057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=
=120709&amp;bid&amp;3057&amp;dat=121642</a><br>____________________________=
___________________
<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourcef=
orge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_4002_25573710.1145465816147--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
