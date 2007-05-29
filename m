Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100705282058o22ace961y93308be3340bb2d4@mail.gmail.com>
Date: Tue, 29 May 2007 00:58:48 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180105720.14752.49.camel@cookie.hadess.net>
MIME-Version: 1.0
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179936924.3629.88.camel@cookie.hadess.net>
	<1179937606.3629.92.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
	<089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
	<1180032597.14752.13.camel@cookie.hadess.net>
	<1180096233.14752.27.camel@cookie.hadess.net>
	<1180097928.14752.33.camel@cookie.hadess.net>
	<1180105720.14752.49.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2086431130=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2086431130==
Content-Type: multipart/alternative;
	boundary="----=_Part_237898_11175960.1180411128428"

------=_Part_237898_11175960.1180411128428
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I consider this as a wizard for printers, like in NetwokManager the network
wizard also
does start a discovery and it work like a charm but in my opinion it doesnt
belong to bluez utils.

Having each wizard to rely in its own discovery is probably a bad design, w=
e
can probably integrate
all wizard together and then having services configuring them in the
background. This way we
could leave to the user to use periodic scan and popup specific device
wizard dependent on
each service when active. Also in my opinion it should exist a printer
service for those that want to
configure its devices that are not in discoverable mode.

Btw, The printer wizard as it is now wont work with periodic discovery,
signals DiscoveryStarted and
DiscoveryCompleted are not emitted while in periodic  discovery.

On 5/25/07, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Fri, 2007-05-25 at 13:58 +0100, Bastien Nocera wrote:
> > On Fri, 2007-05-25 at 13:30 +0100, Bastien Nocera wrote:
> > > On Thu, 2007-05-24 at 19:50 +0100, Bastien Nocera wrote:
> > > <snip>
> > > > This is most ugly. There should really be a helper function for
> that, or
> > > > hcid should pass a decoded argument.
> > > >
> > > > Anyway, it's implemented now, along with a port to pure D-Bus, and
> can
> > > > use the builtin eglib instead of the system one.
> > >
> > > And an updated version which pulls the IEEE1284 ID from the attribute=
s
> > > of the SDP record. This means that it takes 2 clicks in most config
> > > tools to add the printer (add printer, and select the bluetooth
> > > printer).
> > >
> > > If you're using the system hcid instead of the patched in bluez-utils=
,
> > > you'll need to replace the line:
> > > const char *svc_id =3D "hcrp"; /* aka 0x1126 */
> > > with:
> > > const char *svc_id =3D "00001126-0000-1000-8000-00805F9B34FB";
> > > in cups/main.c device_get_ieee1284_id()
> > >
> > > Patch attached.
> >
> > With some indentation changes, at Marcel's request.
>
> - Don't typedef BluezCupsDevice
> - Fix includes from common/
> - Simplify Makefile.am slightly
> - Remove already committed eglib changes
>
> --
> Bastien Nocera <hadess@hadess.net>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

------=_Part_237898_11175960.1180411128428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I consider this as a wizard for printers, like in NetwokManager the network=
 wizard also<br>does start a discovery and it work like a charm but in my o=
pinion it doesnt belong to bluez utils.<br><br>Having each wizard to rely i=
n its own discovery is probably a bad design, we can probably integrate
<br>all wizard together and then having services configuring them in the ba=
ckground. This way we<br>could leave to the user to use periodic scan and p=
opup specific device wizard dependent on<br>each service when active. Also =
in my opinion it should exist a printer service for those that want to
<br>configure its devices that are not in discoverable mode.<br><br>Btw, Th=
e printer wizard as it is now wont work with periodic discovery, signals Di=
scoveryStarted and<br>DiscoveryCompleted are not emitted while in periodic&=
nbsp; discovery.=20
<br><br><div><span class=3D"gmail_quote">On 5/25/07, <b class=3D"gmail_send=
ername">Bastien Nocera</b> &lt;<a href=3D"mailto:hadess@hadess.net">hadess@=
hadess.net</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
On Fri, 2007-05-25 at 13:58 +0100, Bastien Nocera wrote:<br>&gt; On Fri, 20=
07-05-25 at 13:30 +0100, Bastien Nocera wrote:<br>&gt; &gt; On Thu, 2007-05=
-24 at 19:50 +0100, Bastien Nocera wrote:<br>&gt; &gt; &lt;snip&gt;<br>
&gt; &gt; &gt; This is most ugly. There should really be a helper function =
for that, or<br>&gt; &gt; &gt; hcid should pass a decoded argument.<br>&gt;=
 &gt; &gt;<br>&gt; &gt; &gt; Anyway, it&#39;s implemented now, along with a=
 port to pure D-Bus, and can
<br>&gt; &gt; &gt; use the builtin eglib instead of the system one.<br>&gt;=
 &gt;<br>&gt; &gt; And an updated version which pulls the IEEE1284 ID from =
the attributes<br>&gt; &gt; of the SDP record. This means that it takes 2 c=
licks in most config
<br>&gt; &gt; tools to add the printer (add printer, and select the bluetoo=
th<br>&gt; &gt; printer).<br>&gt; &gt;<br>&gt; &gt; If you&#39;re using the=
 system hcid instead of the patched in bluez-utils,<br>&gt; &gt; you&#39;ll=
 need to replace the line:
<br>&gt; &gt; const char *svc_id =3D &quot;hcrp&quot;; /* aka 0x1126 */<br>=
&gt; &gt; with:<br>&gt; &gt; const char *svc_id =3D &quot;00001126-0000-100=
0-8000-00805F9B34FB&quot;;<br>&gt; &gt; in cups/main.c device_get_ieee1284_=
id()
<br>&gt; &gt;<br>&gt; &gt; Patch attached.<br>&gt;<br>&gt; With some indent=
ation changes, at Marcel&#39;s request.<br><br>- Don&#39;t typedef BluezCup=
sDevice<br>- Fix includes from common/<br>- Simplify <a href=3D"http://Make=
file.am">
Makefile.am</a> slightly<br>- Remove already committed eglib changes<br><br=
>--<br>Bastien Nocera &lt;<a href=3D"mailto:hadess@hadess.net">hadess@hades=
s.net</a>&gt;<br><br>------------------------------------------------------=
-------------------
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C=
 - the FREE version of DB2 express and take<br>control of your XML. No limi=
ts. Just data. Click to get it now.<br><a href=3D"http://sourceforge.net/po=
werbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________=
________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-dev=
el@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br><br></b=
lockquote></div><br><br clear=3D"all"><br>-- <br>Luiz Augusto von Dentz<br>=
Engenheiro de Computa=E7=E3o

------=_Part_237898_11175960.1180411128428--


--===============2086431130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2086431130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2086431130==--
