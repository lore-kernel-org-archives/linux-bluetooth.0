Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092604597481f1a9@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1127644396.6362.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1348_21614191.1127735947095"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
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
Date: Mon, 26 Sep 2005 08:59:07 -0300

------=_Part_1348_21614191.1127735947095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Define clear object paths and interfaces will make easier define rules in
the D-Bus configuration file. In this file it's possible specify the
permissions for send and receive messages based on the interfaces, paths an=
d
users/groups.

Based on your comment I suggested the paths and interfaces. Defining this
structure it's possible allow only the "root" or a "bluez manager"
user/group change the adapter settings.


SERVICE BUS NAME: org.bluez

<=3D=3D=3D=3D=3D=3D=3D Device =3D=3D=3D=3D=3D=3D>
description: device specific configuration services. eg: (#1)display local
devices, inqmode, inqtype, up, down, reset, auth, noauth, encrypt, ...

object path: /org/bluez/Device
interface: /org/bluez/Device

<=3D=3D=3D=3D=3D=3D=3D Manager =3D=3D=3D=3D=3D=3D>
description: connection services. eg: inquiry, remote name, info,
master/slave role switch, active connecions and profile specific tasks.
Multiple local adapters scenario will be considered. The default object pat=
h
and the adapter specific paths will provide the same services.

/***** HCI ******/
default object path:/org/bluez/Manager/hci (will use the default device in
the kernel)
object path: /org/bluez/Manager/hci0/hci
object path: /org/bluez/Manager/hci1/hci
interface: org.bluez.Manager.hci

/***** SDP ******/
default object path:/org/bluez/Manager/sdp
object path: /org/bluez/Manager/hci0/sdp
object path: /org/bluez/Manager/hci1/sdp
interface: org.bluez.Manager.sdp

/***** PAN ******/
default object path:/org/bluez/Manager/pan
object path: /org/bluez/Manager/hci0/pan
object path: /org/bluez/Manager/hci1/pan
interface: org.bluez.Manager.pan

/***** RFCOMM ******/
default object path:/org/bluez/Manager/rfcomm
object path: /org/bluez/Manager/hci0/rfcomm
object path: /org/bluez/Manager/hci1/rfcomm
interface: org.bluez.Manager.rfcomm

...
(#1) Probably the display local devices should be moved to other path due
the permissions that I comment before. User applications should be able lis=
t
the local adapters to use in the pan, rfcomm, sdp ...


For me, your suggestion or my last suggestion are fine, both can address th=
e
permissions. You have the decision in your hands! :)


Regards,
Claudio

On 9/25/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > Sorry, but the last patch(hcid_dbus_0007.patch) was not
> > based on the latest CVS version.
>
> I realized that yesterday, but I am in Prague now for the UnPlugFest and
> haven't had Internet access for two days. The patch looks good and I
> think we now have a nice and clean base to start with. However there are
> some names I like to change. For example using org.bluez.Device for all
> device specific configuration, like name changes. And org.bluez.Manager
> for Inquiry stuff etc. Do you think that makes sense?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_1348_21614191.1127735947095
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
Define clear object paths and interfaces will make easier define rules
in the D-Bus configuration file. In this file it's possible specify the
permissions for send and receive messages based on the interfaces,
paths and users/groups.<br>
<br>
Based on your comment I suggested the paths and interfaces. Defining
this structure it's possible allow only the &quot;root&quot; or a &quot;blu=
ez manager&quot;
user/group change the adapter settings.<br>
<br>
<br>
SERVICE BUS NAME: org.bluez<br>
<br>
&lt;=3D=3D=3D=3D=3D=3D=3D Device =3D=3D=3D=3D=3D=3D&gt;<br>
description: device specific configuration services. eg: (#1)display
local devices, inqmode, inqtype, up, down, reset, auth, noauth,
encrypt, ...<br>
<br>
object path: /org/bluez/Device<br>
interface: /org/bluez/Device<br>
<br>
&lt;=3D=3D=3D=3D=3D=3D=3D Manager =3D=3D=3D=3D=3D=3D&gt;<br>
description: connection services. eg: inquiry, remote name, info,
master/slave role switch, active connecions and profile specific tasks.<br>
Multiple local adapters scenario will be considered. The default object
path and the adapter specific paths will provide the same services.<br>
<br>
/***** HCI ******/<br>
default object path:/org/bluez/Manager/hci (will use the default device in =
the kernel)<br>
object path: /org/bluez/Manager/hci0/hci<br>
object path: /org/bluez/Manager/hci1/hci<br>
interface: org.bluez.Manager.hci<br>
<br>
/***** SDP ******/<br>
default object path:/org/bluez/Manager/sdp<br>
object path: /org/bluez/Manager/hci0/sdp<br>
object path: /org/bluez/Manager/hci1/sdp<br>
interface: org.bluez.Manager.sdp<br>
<br>
/***** PAN ******/<br>
default object path:/org/bluez/Manager/pan<br>
object path: /org/bluez/Manager/hci0/pan<br>
object path: /org/bluez/Manager/hci1/pan<br>
interface: org.bluez.Manager.pan<br>
<br>
/***** RFCOMM ******/<br>
default object path:/org/bluez/Manager/rfcomm<br>
object path: /org/bluez/Manager/hci0/rfcomm<br>
object path: /org/bluez/Manager/hci1/rfcomm<br>
interface: org.bluez.Manager.rfcomm<br>
<br>
...<br>
(#1) Probably the display local devices should be moved to other path
due the permissions that I comment before. User&nbsp; applications
should be able list the local adapters to use in the pan, rfcomm, sdp
...<br>
<br>
<br>
For me, your suggestion or my last suggestion are fine, both can
address the permissions. You have the decision in your hands! :)<br>
<br>
<br>
Regards,<br>
Claudio<br><br><div><span class=3D"gmail_quote">On 9/25/05, <b class=3D"gma=
il_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.or=
g">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; Sorry, but the last patch(hcid_dbus_0007.patch) was=
 not<br>&gt; based on the latest CVS version.<br><br>I realized that yester=
day, but I am in Prague now for the UnPlugFest and<br>haven't had Internet =
access for two days. The patch looks good and I
<br>think we now have a nice and clean base to start with. However there ar=
e<br>some names I like to change. For example using org.bluez.Device for al=
l<br>device specific configuration, like name changes. And org.bluez.Manage=
r
<br>for Inquiry stuff etc. Do you think that makes sense?<br><br>Regards<br=
><br>Marcel<br><br><br><br><br>--------------------------------------------=
-----------<br>SF.Net email is sponsored by:<br>Tame your development chall=
enges with Apache's Geronimo App Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_1348_21614191.1127735947095--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
