Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0602261808q7974b833j3fe199143cfa4bbf@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] RFCOMM Server: accept does not block
In-Reply-To: <9e3a30280602261729u52e8b48ap5a90d422e4ddc44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3424_9173638.1141006080994"
References: <9e3a30280602261729u52e8b48ap5a90d422e4ddc44@mail.gmail.com>
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
Date: Sun, 26 Feb 2006 21:08:00 -0500

------=_Part_3424_9173638.1141006080994
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Use perror to find out what went wrong.

http://beej.us/guide/bgnet/output/html/errnoman.html

-albert

On 2/26/06, Deniz Demir <denizdemir@gmail.com> wrote:
>
> Hi,
>
> I want to run a small rfcomm server, however it does not block on
> accept, and returns immediately with -1 as socket descriptor (last
> line prints -1 right away).
>
> I have the following code:
>
>     // allocate socket
>     s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>
>     // bind socket to port 1 of the first available
>     // local bluetooth adapter
>     loc_addr.rc_family =3D AF_BLUETOOTH;
>     loc_addr.rc_bdaddr =3D *BDADDR_ANY;
>     loc_addr.rc_channel =3D (uint8_t) 1;
>     bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
>
>     // put socket into listening mode
>     listen(s, 1);
>
>     // accept one connection
>     client =3D accept(s, (struct sockaddr *)&rem_addr, &opt);
>     printf("client: %d \n", client);
>
> I expected it would block on accept function until a connection
> request came in. I appreciate any comments.
>
> Thanks,
> Deniz
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> that extends applications into web and mobile media. Attend the live
> webcast
> and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=110944&bid$1720&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3424_9173638.1141006080994
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Use perror to find out what went wrong.<br>
<br>
<a href=3D"http://beej.us/guide/bgnet/output/html/errnoman.html">http://bee=
j.us/guide/bgnet/output/html/errnoman.html</a><br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 2/26/06, <b class=3D"gma=
il_sendername">Deniz Demir</b> &lt;<a href=3D"mailto:denizdemir@gmail.com">=
denizdemir@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
Hi,<br><br>I want to run a small rfcomm server, however it does not block o=
n<br>accept, and returns immediately with -1 as socket descriptor (last<br>=
line prints -1 right away).<br><br>I have the following code:<br><br>&nbsp;=
&nbsp;&nbsp;&nbsp;// allocate socket
<br>&nbsp;&nbsp;&nbsp;&nbsp;s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO=
_RFCOMM);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// bind socket to port 1 of the fi=
rst available<br>&nbsp;&nbsp;&nbsp;&nbsp;// local bluetooth adapter<br>&nbs=
p;&nbsp;&nbsp;&nbsp;loc_addr.rc_family =3D AF_BLUETOOTH;<br>&nbsp;&nbsp;&nb=
sp;&nbsp;loc_addr.rc_bdaddr =3D *BDADDR_ANY;
<br>&nbsp;&nbsp;&nbsp;&nbsp;loc_addr.rc_channel =3D (uint8_t) 1;<br>&nbsp;&=
nbsp;&nbsp;&nbsp;bind(s, (struct sockaddr *)&amp;loc_addr, sizeof(loc_addr)=
);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// put socket into listening mode<br>&nbs=
p;&nbsp;&nbsp;&nbsp;listen(s, 1);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;// accept =
one connection<br>&nbsp;&nbsp;&nbsp;&nbsp;client =3D accept(s, (struct sock=
addr *)&amp;rem_addr, &amp;opt);
<br>&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;client: %d \n&quot;, client);<br><=
br>I expected it would block on accept function until a connection<br>reque=
st came in. I appreciate any comments.<br><br>Thanks,<br>Deniz<br><br><br>-=
------------------------------------------------------
<br>This SF.Net email is sponsored by xPML, a groundbreaking scripting lang=
uage<br>that extends applications into web and mobile media. Attend the liv=
e webcast<br>and join the prime developer group breaking into this new codi=
ng territory!
<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=110944&amp;bi=
d$1720&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=11094=
4&amp;bid$1720&amp;dat=121642</a><br>______________________________________=
_________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_3424_9173638.1141006080994--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
