Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604182118w6f25db3ei437dde8f23c93436@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Programming in C with Bluetooth Sockets
In-Reply-To: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_253_4749226.1145420297526"
References: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
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
Date: Wed, 19 Apr 2006 09:48:17 +0530

------=_Part_253_4749226.1145420297526
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I think u are not doing the socket programmin properly
check out this link
http://people.csail.mit.edu/albert/bluez-intro/index.html by Albert

On 4/19/06, Eric Munson <ebmunson@gmail.com> wrote:
>
> I am attempting to move data across a bluetooth connection using
> RFCOMM sockets in C.
>
> I am able to establish the connection and I can successfully send and
> receive the first four bytes of the message.  The sending program
> reports a complete success and the receiving program only reads the
> first four characters.
>
> I have tried several things to make this work, first was to send the
> message size initially and then break the message up into pieces no
> bigger than 4 bytes and send them individually.  The sending program
> again reports a complete success and the receiving program gets the
> correct message size and only the first four bytes of the message.
>
> The next step I tried was to have each side close the socket after
> each transmission and open a new socket for each data chunk.  This led
> to the same results as before.
>
> I am at a loss about what I am doing wrong after searching the web for
> information on bluetooth socket programming.  Has Anyone seen this
> sort of problem before and if so what did you do to fix it?  Thanks
> for your help.
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_253_4749226.1145420297526
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I think u are not doing the socket programmin properly<br>check out this li=
nk <a href=3D"http://people.csail.mit.edu/albert/bluez-intro/index.html">ht=
tp://people.csail.mit.edu/albert/bluez-intro/index.html</a> by Albert<br><b=
r>
<div><span class=3D"gmail_quote">On 4/19/06, <b class=3D"gmail_sendername">=
Eric Munson</b> &lt;<a href=3D"mailto:ebmunson@gmail.com">ebmunson@gmail.co=
m</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
I am attempting to move data across a bluetooth connection using<br>RFCOMM =
sockets in C.<br><br>I am able to establish the connection and I can succes=
sfully send and<br>receive the first four bytes of the message.&nbsp;&nbsp;=
The sending program
<br>reports a complete success and the receiving program only reads the<br>=
first four characters.<br><br>I have tried several things to make this work=
, first was to send the<br>message size initially and then break the messag=
e up into pieces no
<br>bigger than 4 bytes and send them individually.&nbsp;&nbsp;The sending =
program<br>again reports a complete success and the receiving program gets =
the<br>correct message size and only the first four bytes of the message.<b=
r><br>
The next step I tried was to have each side close the socket after<br>each =
transmission and open a new socket for each data chunk.&nbsp;&nbsp;This led=
<br>to the same results as before.<br><br>I am at a loss about what I am do=
ing wrong after searching the web for
<br>information on bluetooth socket programming.&nbsp;&nbsp;Has Anyone seen=
 this<br>sort of problem before and if so what did you do to fix it?&nbsp;&=
nbsp;Thanks<br>for your help.<br><br><br>----------------------------------=
---------------------
<br>This SF.Net email is sponsored by xPML, a groundbreaking scripting lang=
uage<br>that extends applications into web and mobile media. Attend the liv=
e webcast<br>and join the prime developer group breaking into this new codi=
ng territory!
<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=110944&amp;bi=
d$1720&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=11094=
4&amp;bid$1720&amp;dat=121642</a><br>______________________________________=
_________
<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourcef=
orge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_253_4749226.1145420297526--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
