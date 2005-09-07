Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c05090706433d62924b@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdp_connect, how to make it shorter ?
In-Reply-To: <1125922154.11955.17.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8528_13711334.1126100584072"
References: <becc9d2c0508300646fe3b33e@mail.gmail.com>
	 <1125922154.11955.17.camel@pegasus>
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
Date: Wed, 7 Sep 2005 15:43:04 +0200

------=_Part_8528_13711334.1126100584072
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok, so what value can i use instead of SDP_RETRY_IF_BUSY ?

thanks a lot
Andrea



On 9/5/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Andrea,
>=20
> > i need to browse a set of random bt device for
> > a specific sdp profile. So use a function like
> > the "do_search" of sdptool.
> > But when an inquired bt device does not
> > aswer the request, the sdp_connect tries
> > for a long time to estabilish a connection,
> > and this is bad for my project.
> > How can i make much shorter the the sdp_connect
> > timeout ?
>=20
> don't use the SDP_RETRY_IF_BUSY flag in sdp_connect().
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

------=_Part_8528_13711334.1126100584072
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok, so what value can i use instead of SDP_RETRY_IF_BUSY ?<br>
<br>
thanks a lot<br>
Andrea<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 9/5/05, <b class=3D"gmail_sende=
rname">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marce=
l@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi Andrea,<br><br>&gt; i need to browse a set of random bt device for<br>&g=
t; a specific sdp profile. So use a function like<br>&gt; the &quot;do_sear=
ch&quot; of sdptool.<br>&gt; But when an inquired bt device does not<br>
&gt; aswer the request, the sdp_connect tries<br>&gt; for a long time to es=
tabilish a connection,<br>&gt; and this is bad for my project.<br>&gt; How =
can i make much shorter the the sdp_connect<br>&gt; timeout ?<br><br>don't =
use the SDP_RETRY_IF_BUSY flag in sdp_connect().
<br><br>Regards<br><br>Marcel<br><br><br><br><br>--------------------------=
-----------------------------<br>SF.Net email is Sponsored by the Better So=
ftware Conference &amp; EXPO<br>September 19-22, 2005 * San Francisco, CA *=
 Development Lifecycle Practices
<br>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams * T=
esting &amp; QA<br>Security * Process Improvement &amp; Measurement * <a hr=
ef=3D"http://www.sqe.com/bsce5sf">http://www.sqe.com/bsce5sf</a><br>_______=
________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_8528_13711334.1126100584072--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
