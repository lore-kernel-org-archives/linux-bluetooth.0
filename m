Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0510140857k365b72c3v95aadfe99d86c0b3@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] RFCOMM Socket Question
In-Reply-To: <4E28CEA517A795438B120F62D182A8C9236CD8@I2KM11-UKBR.domain1.systemhost.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26780_31251066.1129305443080"
References: <4E28CEA517A795438B120F62D182A8C9236CD8@I2KM11-UKBR.domain1.systemhost.net>
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
Date: Fri, 14 Oct 2005 11:57:23 -0400

------=_Part_26780_31251066.1129305443080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

http://people.csail.mit.edu/albert/bluez-intro/x499.html#bzi-dynamic-port-n=
umbers

-albert

On 10/14/05, graeme.n.brown@bt.com <graeme.n.brown@bt.com> wrote:
>
>
> Hi
>
> If I'm trying to program in BlueZ accepting connections on an rfcosocket,
> can I specify
> a port value which will allow me to accept incoming RFCOMM connections on
> any RFCOMM
> channel (a wild-card channel specification) ? If so, how do I set the
>
> /* RFCOMM socket address */
> struct sockaddr_rc {
> sa_family_t rc_family;
> bdaddr_t rc_bdaddr;
> uint8_t rc_channel;
> };
>
>
> sockaddr_rc.rc_channel to do this before I call bind ?
>
> E.g.
>
> int listenfd, cliSocket ;
> sockaddr_rc addr, raddr ;
> socklen_t optlen;
>
> listenfd =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> if (listenfd < 0) {
> printf(Can't create socket: %s (%d)\n", strerror(errno), errno);
> exit(1);
> }
>
> /* Bind to local address */
> addr.rc_family =3D AF_BLUETOOTH;
> bacpy(&addr.rc_bdaddr, BDADDR_ANY);
> addr.rc_channel =3D /* XXX <-- Can I specify a wild-card RFCPMM Channel h=
ere
> ? How ? XXXX */
>
> if (bind(listenfd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> printf( "Can't bind socket: %s (%d)\n", strerror(errno), errno);
> close(listenfd);
> exit(1);
> }
>
> memset(&raddr, 0, sizeof(raddr));
> optlen =3D sizeof(raddr);
> cliSocket =3D accept(listenfd, (struct sockaddr *) &raddr, &optlen);
>
> if (cliSocket < 0) {
> printf(buff, "Accept failed: %s (%d)\n", strerror(errno), errno);
> close(listenfd) ;
> exit(1);
> }
>
> /** Use new connection on cliSocket ...... **/
>
>
> Thanks
>
> Graeme Brown
>
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_26780_31251066.1129305443080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<a href=3D"http://people.csail.mit.edu/albert/bluez-intro/x499.html#bzi-dyn=
amic-port-numbers">http://people.csail.mit.edu/albert/bluez-intro/x499.html=
#bzi-dynamic-port-numbers</a><br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 10/14/05, <b class=3D"gm=
ail_sendername"><a href=3D"mailto:graeme.n.brown@bt.com">graeme.n.brown@bt.=
com</a></b> &lt;<a href=3D"mailto:graeme.n.brown@bt.com">graeme.n.brown@bt.=
com
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;"><br>Hi<br><br>If I'm trying to program in BlueZ accepting connections =
on an rfcosocket, can I specify
<br>a port value which will allow me to accept incoming RFCOMM connections =
on any RFCOMM<br>channel (a wild-card channel specification) ? If so, how d=
o I set the<br><br>/* RFCOMM socket address */<br>struct sockaddr_rc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sa_family_t&nbsp;&nbsp;&nbs=
p;&nbsp; rc_family;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bdad=
dr_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc_bdaddr;<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; rc_channel;<br>};<br><br><br>sockaddr_rc.rc_channel to =
do this before I call bind ?<br><br>E.g.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;int listenfd, cliSocket ;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sockaddr_rc addr, raddr=
 ;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;socklen_t optlen;<br>=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;listenfd =3D socket(PF_=
BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;if (listenfd &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(Can't create socket: %s (%d)\n&quot;, st=
rerror(errno), errno);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit(1);<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Bind to local address */<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;addr.rc_family =3D AF_BLUETOOTH;<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bacpy(&amp;addr.rc_bdaddr, BDAD=
DR_ANY);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;addr.rc_channel
=3D&nbsp;&nbsp;/* XXX &lt;-- Can I specify a wild-card RFCPMM Channel
here ? How ?&nbsp;&nbsp;XXXX */<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;if (bind(listenfd, (struct sockaddr *) &amp;addr, sizeof(addr))=
 &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf( &quot;Can't bind socket: %s (%d)\n&quot;, strerror(errno), errno);<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(liste=
nfd);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memset(&amp;raddr, 0, sizeof(raddr));<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;optlen =3D sizeof(raddr);<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cliSocket =3D accept(listen=
fd, (struct sockaddr *) &amp;raddr, &amp;optlen);<br><br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (cliSocket &lt; 0) {
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
printf(buff, &quot;Accept failed: %s (%d)\n&quot;, strerror(errno), errno);=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; close(listenfd) ;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/** Use new =
connection on cliSocket ......&nbsp;&nbsp; **/<br><br><br>
Thanks<br><br>Graeme Brown<br><br><br><br><br><br><br>---------------------=
----------------------------------<br>This SF.Net email is sponsored by:<br=
>Power Architecture Resource Center: Free content, downloads, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-u=
sers@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br></blockquote></div><br>

------=_Part_26780_31251066.1129305443080--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
