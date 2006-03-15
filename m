Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00603150040p3baf9d54o54a9a93cd58b874a@mail.gmail.com>
From: "Arpit Rai" <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Multiple connections between USB dongles
In-Reply-To: <1141917840.4605.36.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7462_32094124.1142412035533"
References: <94e407f00603090536g6e039055tad50e96bf5be8ea9@mail.gmail.com>
	 <1141917840.4605.36.camel@aeonflux.holtmann.net>
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
Date: Wed, 15 Mar 2006 16:40:35 +0800

------=_Part_7462_32094124.1142412035533
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel

This is what the hcidump returns

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:10:60:B3:2D:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed

Regards
Arpit

On 3/9/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > I'm using Broadcom based dongles.
> >
> > I'm using hcitool cc <BD-ADDR> to connect to other bluetooth dongles.
> > The problem is, at a time I can have only 2 connections. To connect to
> > a third dongle I have to kill one of the 2 earlier connections. Any
> > idea why this is happening?
>
> run "hcidump -X -V" and look for the actual error message.
>
> Regards
>
> Marcel
>
>
>
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_7462_32094124.1142412035533
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel<br>
<br>
This is what the hcidump returns<br>
<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:10:60:B3:2D:04 ptype 0xcc18 rswitch 0x01 clkof=
fset 0x0000<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x0c ncmd 1<br>
&nbsp;&nbsp;&nbsp; Error: Command Disallowed<br>
<br>
Regards<br>
Arpit<br><br><div><span class=3D"gmail_quote">On 3/9/06, <b class=3D"gmail_=
sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">=
marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
Hi Arpit,<br><br>&gt; I'm using Broadcom based dongles.<br>&gt;<br>&gt; I'm=
 using hcitool cc &lt;BD-ADDR&gt; to connect to other bluetooth dongles.<br=
>&gt; The problem is, at a time I can have only 2 connections. To connect t=
o
<br>&gt; a third dongle I have to kill one of the 2 earlier connections. An=
y<br>&gt; idea why this is happening?<br><br>run &quot;hcidump -X -V&quot; =
and look for the actual error message.<br><br>Regards<br><br>Marcel<br>
<br><br><br><br><br>-------------------------------------------------------=
<br>This SF.Net email is sponsored by xPML, a groundbreaking scripting lang=
uage<br>that extends applications into web and mobile media. Attend the liv=
e webcast
<br>and join the prime developer group breaking into this new coding territ=
ory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D1109=
44&amp;bid=3D241720&amp;dat=3D121642">http://sel.as-us.falkag.net/sel?cmd=
=3Dlnk&amp;kid=3D110944&amp;bid=3D241720&amp;dat=3D121642
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-user=
s@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

------=_Part_7462_32094124.1142412035533--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
