Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0603122239ldeaecd1v5cfc49c4022a0ea1@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] set/read flush timeout
In-Reply-To: <44123BB2.5090707@fillibach.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8601_18648878.1142231972170"
References: <441211DA.4060600@fillibach.de>
	 <ef9938ec0603101837u485c4500m8aaaa988450c107c@mail.gmail.com>
	 <44123BB2.5090707@fillibach.de>
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
Date: Mon, 13 Mar 2006 01:39:32 -0500

------=_Part_8601_18648878.1142231972170
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You'll need to read the Bluetooth spec for this, look for the
read_automatic_flush_timeout part of the HCI section.  Build a command
packet similar to how it's done for writing, and use the rparam field to
read the results.  If you're confused, take a look at how the other read
commands work.

-albert

On 3/10/06, Kosta Welke <kosta@fillibach.de> wrote:
>
> Albert Huang wrote:
> > You need to actually set the flush timeout value... notice that timeout
> > is never set, and argv[2] is never used...
>
> Okai, consider this my entry to "stupidest post on this list" :)
>
> Anyway, can you tell me how to read the flush timeout?
>
> Thanks in advance,
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

------=_Part_8601_18648878.1142231972170
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You'll need to read the Bluetooth spec for this, look for the
read_automatic_flush_timeout part of the HCI section.&nbsp; Build a
command packet similar to how it's done for writing, and use the rparam
field to read the results.&nbsp; If you're confused, take a look at how
the other read commands work.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 3/10/06, <b class=3D"gma=
il_sendername">Kosta Welke</b> &lt;<a href=3D"mailto:kosta@fillibach.de">ko=
sta@fillibach.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Albert Huang wrote:<br>&gt; You need to actually set the flush timeout valu=
e... notice that timeout<br>&gt; is never set, and argv[2] is never used...=
<br><br>Okai, consider this my entry to &quot;stupidest post on this list&q=
uot; :)
<br><br>Anyway, can you tell me how to read the flush timeout?<br><br>Thank=
s in advance,<br>Kosta<br><br><br>-----------------------------------------=
--------------<br>This SF.Net email is sponsored by xPML, a groundbreaking =
scripting language
<br>that extends applications into web and mobile media. Attend the live we=
bcast<br>and join the prime developer group breaking into this new coding t=
erritory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=
=3D110944&amp;bid=3D241720&amp;dat=3D121642">
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D110944&amp;bid=3D241720=
&amp;dat=3D121642</a><br>_______________________________________________<br=
>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforg=
e.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_8601_18648878.1142231972170--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
