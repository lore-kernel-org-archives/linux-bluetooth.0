Return-Path: <cyrus@holtmann.org>
Message-ID: <eba8281a0806131353m67d78395md62074bfa13bc9a9@mail.gmail.com>
Date: Fri, 13 Jun 2008 21:53:09 +0100
From: "Valerio Valerio" <vdv100@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100806131229l79022c48w65489072f2e6ca36@mail.gmail.com>
MIME-Version: 1.0
References: <eba8281a0806111502j7caebdeav83e3fc038b0c943f@mail.gmail.com>
	<2d5a2c100806131229l79022c48w65489072f2e6ca36@mail.gmail.com>
Subject: Re: [Bluez-devel] Listen a already open socket by the OS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0390235030=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0390235030==
Content-Type: multipart/alternative;
	boundary="----=_Part_32420_8094931.1213390389635"

------=_Part_32420_8094931.1213390389635
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

2008/6/13 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:

> I supposed you are the OpenMoko student in charge of remote control.

Yap you are right :)

>
> You better join #bluez @ freenode to stay tunned about bluetooth and
> BlueZ, now about HID channels, we already are listen them in hcid, so
> you don't need to worry if you are running hcid for the server part.
> The tricky part is the client side, when the device act as a
> mouse/keyboard, Im afraid there is no library to assist you with HID
> protocol and I think you cannot connect in such psm without being root
> either. If Im correct about those points then I think it is better to
> code the missing HID support inside bluez-utils.


Yes the psm 17 (control channel) require root, because is one of the
reserved psm,  my previous problem is that I had the hidd server running in
the client side, if I disable it I can listen the sockets that I need
without problems.

If one of the BlueZ developer with knowledge of HID, give some orientation
for a while, maybe I can do some code that can be useful for other
developers and integrated in the bluez-utils.

Best regards,

--=20
Val=E9rio Val=E9rio

http://www.valeriovalerio.org


>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computa=E7=E3o
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_32420_8094931.1213390389635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br><div class=3D"gmail_quote">2008/6/13 Luiz Augusto von Dentz &lt;=
<a href=3D"mailto:luiz.dentz@gmail.com">luiz.dentz@gmail.com</a>&gt;:<br><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I supposed you are the OpenMoko student in charge of remote control.</block=
quote><div>Yap you are right :) <br></div><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
<br>
You better join #bluez @ freenode to stay tunned about bluetooth and<br>
BlueZ, now about HID channels, we already are listen them in hcid, so<br>
you don&#39;t need to worry if you are running hcid for the server part.<br=
>
The tricky part is the client side, when the device act as a<br>
mouse/keyboard, Im afraid there is no library to assist you with HID<br>
protocol and I think you cannot connect in such psm without being root<br>
either. If Im correct about those points then I think it is better to<br>
code the missing HID support inside bluez-utils.</blockquote><div>&nbsp;</d=
iv><div>Yes the psm 17 (control channel) require root, because is one of th=
e reserved psm,&nbsp; my previous problem is that I had the hidd server run=
ning in the client side, if I disable it I can listen the sockets that I ne=
ed without problems.<br>
<br>If one of the BlueZ developer with knowledge of HID, give some orientat=
ion for a while, maybe I can do some code that can be useful for other deve=
lopers and integrated in the bluez-utils.<br><br>Best regards,<br><br>-- <b=
r>
Val=E9rio Val=E9rio<br><br><a href=3D"http://www.valeriovalerio.org">http:/=
/www.valeriovalerio.org</a><br><br></div><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<br>
<br>
--<br>
Luiz Augusto von Dentz<br>
Engenheiro de Computa=E7=E3o<br>
<br>
-------------------------------------------------------------------------<b=
r>
Check out the new SourceForge.net Marketplace.<br>
It&#39;s the best place to buy or sell services for<br>
just about anything Open Source.<br>
<a href=3D"http://sourceforge.net/services/buy/index.php" target=3D"_blank"=
>http://sourceforge.net/services/buy/index.php</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br=
>
</blockquote></div><br><br clear=3D"all"><br><br>

------=_Part_32420_8094931.1213390389635--


--===============0390235030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0390235030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0390235030==--
