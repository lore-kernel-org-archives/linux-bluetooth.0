Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100705290618n2b74dbcfmfa997c87f344a6a0@mail.gmail.com>
Date: Tue, 29 May 2007 10:18:01 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1180434383.3030.70.camel@cookie.hadess.net>
MIME-Version: 1.0
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
	<089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
	<1180032597.14752.13.camel@cookie.hadess.net>
	<1180096233.14752.27.camel@cookie.hadess.net>
	<1180097928.14752.33.camel@cookie.hadess.net>
	<1180105720.14752.49.camel@cookie.hadess.net>
	<2d5a2c100705282058o22ace961y93308be3340bb2d4@mail.gmail.com>
	<1180434383.3030.70.camel@cookie.hadess.net>
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
Content-Type: multipart/mixed; boundary="===============1969161329=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1969161329==
Content-Type: multipart/alternative;
	boundary="----=_Part_244157_1861171.1180444681122"

------=_Part_244157_1861171.1180444681122
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Comments in line:

On 5/29/07, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2007-05-29 at 00:58 -0300, Luiz Augusto von Dentz wrote:
> > I consider this as a wizard for printers, like in NetwokManager the
> > network wizard also
> > does start a discovery and it work like a charm but in my opinion it
> > doesnt belong to bluez utils.
>
> It's a standard feature of cups backends. If they support it, they
> should list the accessible/known printers in the vicinity.
>
> > Having each wizard to rely in its own discovery is probably a bad
> > design, we can probably integrate
> > all wizard together and then having services configuring them in the
> > background. This way we
> > could leave to the user to use periodic scan and popup specific device
> > wizard dependent on
> > each service when active. Also in my opinion it should exist a printer
> > service for those that want to
> > configure its devices that are not in discoverable mode.
>
> True, it would be much better. But in the meanwhile, this patch simply
> implements a CUPS feature and allows us to have some basic integration
> in the distribution-provided printer tools.


So we may mark this as subject to change.

Being able to configure the printer via a bluetooth configuration wizard
> requires a bit more work, but it's also on my plans. There should be a
> CUPS service that would allow hcid to add/remove bluetooth printers from
> cups with minimum user interaction.


My idea is to have printer service more generic, the bluetooth wizard could
do
CUPS integration as it would integrate with any other system wide
integration.

> Btw, The printer wizard as it is now wont work with periodic
> > discovery, signals DiscoveryStarted and
> > DiscoveryCompleted are not emitted while in periodic  discovery.
>
> The cups backend isn't supposed to run forever, so it can't do periodic
> discovery.


Well that is not the case of being running forever but you could probably
test if the periodic scan is active before you start a blocking discovery.
My main concern is about multiple process doing this, the probability of
having collisions while doing sdp searches could be very high as it is very
common to have more than one functionality in a device, this leaves wizard
processes very complicated and may force them to reschedule on each
collision .

--
> Bastien Nocera <hadess@hadess.net>
>
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



--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

------=_Part_244157_1861171.1180444681122
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Comments in line:<br><br><div><span class=3D"gmail_quote">On 5/29/07, <b cl=
ass=3D"gmail_sendername">Bastien Nocera</b> &lt;<a href=3D"mailto:hadess@ha=
dess.net">hadess@hadess.net</a>&gt; wrote:</span><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2007-05-29 at 00:58 -0300, Luiz Augusto von Dentz wrote:<br>&gt; I =
consider this as a wizard for printers, like in NetwokManager the<br>&gt; n=
etwork wizard also<br>&gt; does start a discovery and it work like a charm =
but in my opinion it
<br>&gt; doesnt belong to bluez utils.<br><br>It&#39;s a standard feature o=
f cups backends. If they support it, they<br>should list the accessible/kno=
wn printers in the vicinity.<br><br>&gt; Having each wizard to rely in its =
own discovery is probably a bad
<br>&gt; design, we can probably integrate<br>&gt; all wizard together and =
then having services configuring them in the<br>&gt; background. This way w=
e<br>&gt; could leave to the user to use periodic scan and popup specific d=
evice
<br>&gt; wizard dependent on<br>&gt; each service when active. Also in my o=
pinion it should exist a printer<br>&gt; service for those that want to<br>=
&gt; configure its devices that are not in discoverable mode.<br><br>True, =
it would be much better. But in the meanwhile, this patch simply
<br>implements a CUPS feature and allows us to have some basic integration<=
br>in the distribution-provided printer tools.</blockquote><div><br>So we m=
ay mark this as subject to change.<br></div><br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
Being able to configure the printer via a bluetooth configuration wizard<br=
>requires a bit more work, but it&#39;s also on my plans. There should be a=
<br>CUPS service that would allow hcid to add/remove bluetooth printers fro=
m
<br>cups with minimum user interaction.</blockquote><div><br>My idea is to =
have printer service more generic, the bluetooth wizard could do<br>CUPS in=
tegration as it would integrate with any other system wide integration.
<br></div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt=
; Btw, The printer wizard as it is now wont work with periodic<br>&gt; disc=
overy, signals DiscoveryStarted and
<br>&gt; DiscoveryCompleted are not emitted while in periodic&nbsp;&nbsp;di=
scovery.<br><br>The cups backend isn&#39;t supposed to run forever, so it c=
an&#39;t do periodic<br>discovery.</blockquote><div><br>Well that is not th=
e case of being running forever but you could probably
<br>test if the periodic scan is active before you start a blocking discove=
ry.<br>My main concern is about multiple process doing this, the probabilit=
y of<br>having collisions while doing sdp searches could be very high as it=
 is very
<br>common to have more than one functionality in a device, this leaves wiz=
ard<br>processes very complicated and may force them to reschedule on each =
collision .<br></div><br><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
--<br>Bastien Nocera &lt;<a href=3D"mailto:hadess@hadess.net">hadess@hadess=
.net</a>&gt;<br><br><br>---------------------------------------------------=
----------------------<br>This SF.net email is sponsored by DB2 Express<br>
Download DB2 Express C - the FREE version of DB2 express and take<br>contro=
l of your XML. No limits. Just data. Click to get it now.<br><a href=3D"htt=
p://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a>
<br>_______________________________________________<br>Bluez-devel mailing =
list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@li=
sts.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/l=
istinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br><br clear=3D"all"><br>-- <br>Luiz Augusto von Dentz<br>Engenhei=
ro de Computa=E7=E3o

------=_Part_244157_1861171.1180444681122--


--===============1969161329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1969161329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1969161329==--
