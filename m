Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0603101837u485c4500m8aaaa988450c107c@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] set/read flush timeout
In-Reply-To: <441211DA.4060600@fillibach.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6927_20442323.1142044664885"
References: <441211DA.4060600@fillibach.de>
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
Date: Fri, 10 Mar 2006 21:37:44 -0500

------=_Part_6927_20442323.1142044664885
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You need to actually set the flush timeout value... notice that timeout is
never set, and argv[2] is never used...

Regards,
Albert

On 3/10/06, Kosta Welke <kosta@fillibach.de> wrote:
>
> Hi!
>
> I'm trying to do VoIP over PAN, and thus need to set (and read) the ACL
> flush timeout. I tried modifying Albert Huang example code, but it does
> not seem to work. Could someone give me a small hint what is wrong?
>
> http://lastpageofthe.net/setflush.c
>
> Disclamer: I'm a complete noob when it comes to HCI requests, so please
> forgive this "Help! Fix my problem!"-Mail. On the positive side, as soon
> as it works, I want to put it into hcitool.
>
> Yours,
> Kosta
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> that extends applications into web and mobile media. Attend the live
> webcast
> and join the prime developer group breaking into this new coding
> territory!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_6927_20442323.1142044664885
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You need to actually set the flush timeout value... notice that timeout is =
never set, and argv[2] is never used...<br>
<br>
Regards,<br>
Albert<br><br><div><span class=3D"gmail_quote">On 3/10/06, <b class=3D"gmai=
l_sendername">Kosta Welke</b> &lt;<a href=3D"mailto:kosta@fillibach.de">kos=
ta@fillibach.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi!<br><br>I'm trying to do VoIP over PAN, and thus need to set (and read) =
the ACL<br>flush timeout. I tried modifying Albert Huang example code, but =
it does<br>not seem to work. Could someone give me a small hint what is wro=
ng?
<br><br><a href=3D"http://lastpageofthe.net/setflush.c">http://lastpageofth=
e.net/setflush.c</a><br><br>Disclamer: I'm a complete noob when it comes to=
 HCI requests, so please<br>forgive this &quot;Help! Fix my problem!&quot;-=
Mail. On the positive side, as soon
<br>as it works, I want to put it into hcitool.<br><br>Yours,<br>Kosta<br><=
br><br>-------------------------------------------------------<br>This SF.N=
et email is sponsored by xPML, a groundbreaking scripting language<br>that =
extends applications into web and mobile media. Attend the live webcast
<br>and join the prime developer group breaking into this new coding territ=
ory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D1109=
44&amp;bid=3D241720&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=
=3Dlnk&amp;kid=3D110944&amp;bid=3D241720&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_6927_20442323.1142044664885--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
