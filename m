Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604021036g3ddf7f68qe34a792e35d91e6@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] More then 2 RFCOMM channels open
In-Reply-To: <5f34bf160604020326h3c60ae7bmd4a214cca69d5e87@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1666_27919976.1143999369901"
References: <5f34bf160604020326h3c60ae7bmd4a214cca69d5e87@mail.gmail.com>
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
Date: Sun, 2 Apr 2006 13:36:09 -0400

------=_Part_1666_27919976.1143999369901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

bluez has no software limitations here.  This should be possible, but may b=
e
limited by your hardware.  You'll want to figure out which chipset your
dongles are using and then make sure that they can support scatternets.  Yo=
u
may also need to manually perform role switches to minimize scatternet
formation.  You can open more than one minicom at a time.

-albert

On 4/2/06, elad wertzberger <wertzber@gmail.com> wrote:
>
> Hi All,
>
> We are students building a network from bluetooth
> modules and bluez.
> We connected 2 units in Serial Port Profile using minicom application
> and RFCOMM channels.
> We want to pass information from Module A to Module B through Module C
> (A -> C -> B).
> Like a repeater in bluetooth.
> the problem is that we cannot open RFCOMM connection between more then
> 2 units. (??)
> 1. Is it possible to open in bluez an RFCOMM
>    connection with 3 units, means from A to C and
>    from b to C at the same time ?
> 2.Do you support it in software ? is there a hardware
>   limitation ? (with bluetooth 1.1)
> 3.Can we open more then one minicom at the same time?
>
> Best Regards,
> Elad wertzberger
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

------=_Part_1666_27919976.1143999369901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

bluez has no software limitations here.&nbsp; This should be possible,
but may be limited by your hardware.&nbsp; You'll want to figure out
which chipset your dongles are using and then make sure that they can
support scatternets.&nbsp; You may also need to manually perform role
switches to minimize scatternet formation.&nbsp; You can open more than
one minicom at a time.<br>
<br>
-albert<br>
<br><div><span class=3D"gmail_quote">On 4/2/06, <b class=3D"gmail_sendernam=
e">elad wertzberger</b> &lt;<a href=3D"mailto:wertzber@gmail.com">wertzber@=
gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
Hi All,<br><br>We are students building a network from bluetooth<br>modules=
 and bluez.<br>We connected 2 units in Serial Port Profile using minicom ap=
plication<br>and RFCOMM channels.<br>We want to pass information from Modul=
e A to Module B through Module C
<br>(A -&gt; C -&gt; B).<br>Like a repeater in bluetooth.<br>the problem is=
 that we cannot open RFCOMM connection between more then<br>2 units. (??)<b=
r>1. Is it possible to open in bluez an RFCOMM<br>&nbsp;&nbsp; connection w=
ith 3 units, means from A to C and
<br>&nbsp;&nbsp; from b to C at the same time ?<br>2.Do you support it in s=
oftware ? is there a hardware<br>&nbsp;&nbsp;limitation ? (with bluetooth 1=
.1)<br>3.Can we open more then one minicom at the same time?<br><br>Best Re=
gards,<br>Elad wertzberger
<br><br><br>-------------------------------------------------------<br>This=
 SF.Net email is sponsored by xPML, a groundbreaking scripting language<br>=
that extends applications into web and mobile media. Attend the live webcas=
t
<br>and join the prime developer group breaking into this new coding territ=
ory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=110944&am=
p;bid$1720&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=
=110944&amp;bid$1720&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_1666_27919976.1143999369901--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
