Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604212141g18cc5aa4j9847815cb71947ac@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rfcomm and voice
In-Reply-To: <ef9938ec0604211342j7ce87f49y8b7bad4354e5bbd8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6350_7092077.1145680863253"
References: <fe0a97c20604182131u46bc58b0g7aa370a8b87fdd98@mail.gmail.com>
	 <ef9938ec0604211342j7ce87f49y8b7bad4354e5bbd8@mail.gmail.com>
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
Date: Sat, 22 Apr 2006 10:11:03 +0530

------=_Part_6350_7092077.1145680863253
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

well Albert ... it worked with rfcomm... (seriously) wrote a client which
reads from /dev/.dsp... opens a socket and writes to the other bluetooth
socket in the server prog. And the server binds and listens and gets all th=
e
packets and writes to the /dev/dsp.....

so I speak and hear whatever I speak in a few seconds...

But now I wanna know whether it is a duplex channel or not... is rfcomm a
duplex channel....

Iam yet to try with  SCO.... but I was getting a recv error ( Connection
reset by peer) God knows why

On 4/22/06, Albert Huang <albert@csail.mit.edu> wrote:
>
> This is possible, but if you want to send voice, why not use SCO?
>
> -albert
>
>
> On 4/19/06, Sowmya Gattupalli < sowmya.gattupalli@gmail.com> wrote:
> >
> > Hi all
> > I wanna know if I can send the voice over rfcomm between 2 linux boxes
> > enabled with BlueZ....
> > I reading the /dev/dsp and sending the voice bytes using rfcomm sockets
> > to other machine and simultaneously writig to /dev/dsp..... Have anyone=
 of u
> > tried to implement this???
> >
> >
> >
> > regards
> > Soumya
> >
>
>

------=_Part_6350_7092077.1145680863253
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

well Albert ... it worked with rfcomm... (seriously) wrote a client
which reads from /dev/.dsp... opens a socket and writes to the other
bluetooth socket in the server prog. And the server binds and listens
and gets all the packets and writes to the /dev/dsp..... <br>
<br>
so I speak and hear whatever I speak in a few seconds... <br>
<br>
But now I wanna know whether it is a duplex channel or not... is rfcomm a d=
uplex channel.... <br>
<br>
Iam yet to try with&nbsp; SCO.... but I was getting a recv error ( Connecti=
on reset by peer) God knows why <br><br><div><span class=3D"gmail_quote">On=
 4/22/06, <b class=3D"gmail_sendername">Albert Huang</b> &lt;<a href=3D"mai=
lto:albert@csail.mit.edu">
albert@csail.mit.edu</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;"><div style=3D"direction: ltr;">This is possible, b=
ut if you want to send voice, why not use SCO?
<br></div><div style=3D"direction: ltr;"><span class=3D"sg"><br>-albert</sp=
an></div><div style=3D"direction: ltr;"><span class=3D"e" id=3D"q_10abe3121=
5ac44e1_2"><br><br><div><span class=3D"gmail_quote">On 4/19/06, <b class=3D=
"gmail_sendername">
Sowmya Gattupalli</b> &lt;<a href=3D"mailto:sowmya.gattupalli@gmail.com" ta=
rget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">
sowmya.gattupalli@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;"><div style=3D"direction: ltr;">Hi all<br>I =
wanna know if I can send the voice over rfcomm between 2 linux boxes enable=
d with BlueZ....=20
<br>I reading the /dev/dsp and sending the voice bytes using rfcomm
sockets to other machine and simultaneously writig to /dev/dsp.....
Have anyone of u tried to implement this??? <br><br><br><br>regards<br>Soum=
ya<br>

</div></blockquote></div><br>

</span></div></blockquote></div><br>

------=_Part_6350_7092077.1145680863253--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
