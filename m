Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050912160979b5ba49@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Sig Fault)
In-Reply-To: <1126561206.24935.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16861_21311128.1126566555975"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade>
	 <5256d0b050909012577fcb19c@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>
	 <20050909132940.GE17543@spring.luon.net>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
	 <1126561206.24935.1.camel@localhost.localdomain>
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
Date: Mon, 12 Sep 2005 20:09:15 -0300

------=_Part_16861_21311128.1126566555975
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Regarding the reply_handler_function, please check if it is relevant.
I you want I can send only the changes for handle the error messages.

Regards,
Claudio.


On 9/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Claudio,
>=20
> > I am sending a new patch that contains the following enhancements:
> > 1. Support multiple D-Bus versions(0.23, 0.30...)
> > 2. Fixed error handling ServiceDoesNotExist, NoReply,
> > UnknownService, ...
> > This condition is causing sig fault due the wrong pin value.
> > Scenario: D-Bus pin helper enabled
> > and an error different than wrong argument triggered.
>=20
> since bluez-utils-2.21 is out, I am going do remove the support for the
> old D-Bus 0.23 API now. So there is no need for any compat code.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_16861_21311128.1126566555975
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
Regarding the reply_handler_function, please check if it is relevant.<br>
I you want I can send only the changes for handle the error messages.<br>
<br>
Regards,<br>
Claudio.<br>
<br>
<br><div><span class=3D"gmail_quote">On 9/12/05, <b class=3D"gmail_senderna=
me">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@h=
oltmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
Hi Claudio,<br><br>&gt; I am sending a new patch that contains the followin=
g enhancements:<br>&gt; 1. Support multiple D-Bus versions(0.23, 0.30...)<b=
r>&gt; 2. Fixed error handling ServiceDoesNotExist, NoReply,<br>&gt; Unknow=
nService, ...
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;This condition is causing sig fault due the=
 wrong pin value.<br>&gt; Scenario: D-Bus pin helper enabled<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;and an error different than wrong argument triggered.<br><=
br>since bluez-utils-2.21 is out, I am going do remove the support for the
<br>old D-Bus 0.23 API now. So there is no need for any compat code.<br><br=
>Regards<br><br>Marcel<br><br><br><br><br>---------------------------------=
----------------------<br>SF.Net email is Sponsored by the Better Software =
Conference &amp; EXPO
<br>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Pract=
ices<br>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams=
 * Testing &amp; QA<br>Security * Process Improvement &amp; Measurement *=
=20
<a href=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><br>__=
_____________________________________________<br>Bluez-devel mailing list<b=
r><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.so=
urceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_16861_21311128.1126566555975--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
