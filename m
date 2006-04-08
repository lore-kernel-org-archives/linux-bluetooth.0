Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604072112s584171c1k1735683254792fcf@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO transparent transmission
In-Reply-To: <4436772F.6030300@csr.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22309_21090851.1144469559376"
References: <9ec07a230604041044j6b1b91f4ue25b44f2ed6f7c55@mail.gmail.com>
	 <fe0a97c20604042223o7c59fb5fq871a004292ac1c55@mail.gmail.com>
	 <4436772F.6030300@csr.com>
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
Date: Sat, 8 Apr 2006 09:42:39 +0530

------=_Part_22309_21090851.1144469559376
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey Steven...
For a CSR USB chip when the SCO mapping is over HCI is it possible to chang=
e
the voice settings to send PCM samples over the air?

On 4/7/06, Steven Singer <steven.singer@csr.com> wrote:
>
> Sowmya Gattupalli wrote:
> > On 4/4/06, Israel Gu=EDo <israzar@gmail.com> wrote:
> >> example, with 0x0063 as voice settings. I have tried it with my
> Bluetooth
> > How did u use CVSD when transmitting over sco?? [...]
>
> He was quite clear that he'd used voice settigns 0x0063. The last two
> bits indicate transparent coding and not CVSD.
>
> Israel, you need to be sure you're sending data at exactly the right
> average data rate. SCO links are synchronous and if you don't provide
> data at exactly the right rate then something somewhere in the
> system will have to insert or delete samples.
>
> It would also be helpful if you stated what chip and firmware version
> you were using.
>
>         - Steven
> --
>
>
> To access the latest news from CSR copy this link into a web browser:
> http://www.csr.com/email_sig.php
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

------=_Part_22309_21090851.1144469559376
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey Steven... <br>
For a CSR USB chip when the SCO mapping is over HCI is it possible to
change the voice settings to send PCM samples over the air?<br><br><div><sp=
an class=3D"gmail_quote">On 4/7/06, <b class=3D"gmail_sendername">Steven Si=
nger</b> &lt;<a href=3D"mailto:steven.singer@csr.com">steven.singer@csr.com=
</a>
&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>Sowmya Gattupalli wrote:<br>&gt; On 4/4/06, Israel Gu=EDo &lt;<a href=3D"m=
ailto:israzar@gmail.com">
israzar@gmail.com</a>&gt; wrote:<br>&gt;&gt; example, with 0x0063 as voice =
settings. I have tried it with my Bluetooth<br>&gt; How did u use CVSD when=
 transmitting over sco?? [...]<br><br>He was quite clear that he'd used voi=
ce settigns 0x0063. The last two
<br>bits indicate transparent coding and not CVSD.<br><br>Israel, you need =
to be sure you're sending data at exactly the right<br>average data rate. S=
CO links are synchronous and if you don't provide<br>data at exactly the ri=
ght rate then something somewhere in the
<br>system will have to insert or delete samples.<br><br>It would also be h=
elpful if you stated what chip and firmware version<br>you were using.<br><=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Steven<br>--<br><br><b=
r>To access the latest news from CSR copy this link into a web browser:&nbs=
p;&nbsp;
<a href=3D"http://www.csr.com/email_sig.php">http://www.csr.com/email_sig.p=
hp</a><br><br><br>-------------------------------------------------------<b=
r>This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
<br>that extends applications into web and mobile media. Attend the live we=
bcast<br>and join the prime developer group breaking into this new coding t=
erritory!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=1109=
44&amp;bid$1720&amp;dat=121642">
http://sel.as-us.falkag.net/sel?cmdlnk&amp;kid=110944&amp;bid$1720&amp;dat=
=121642</a><br>_______________________________________________<br>Bluez-dev=
el mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Blu=
ez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_22309_21090851.1144469559376--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
