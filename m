Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092105492fce2ff2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1127292701.495.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_393_22977905.1127306974749"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
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
Date: Wed, 21 Sep 2005 09:49:34 -0300

------=_Part_393_22977905.1127306974749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I will analize our comments.

service_table_t and the function create_error_reply_message will be shared
by other profiles(pan, hid, rfcomm, ...)
this the reason to put in the dbus-internal.h file.
Regarding the Bluetooth error codes, we can add the code in the D-Bus error
messages as a argument. My proposal
is use a standard like this:

org.bluez.hci.error.UnknowMethod
org.bluez.hci.error.WrongSignature
org.bluez.hci.error.WrongParam
org.bluez.hci.error.Failed /* here we can add the bluetooth error code */
org.bluez.hci.error.Busy
org.bluez.hci.error.NoDevFound

 I will send a new path soon.

Regards,
Claudio.

On 9/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > I am sending the initial patch that implementing the skeleton
> > of the hcid D-Bus services.
> >
> > Run hcid with a non-daemon option to see the output
> >
> > Send the following messages to see the message handling.
> >
> > dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/h=
ci
> > org.bluez.hci.PeriodicInqReq byte:1 byte:2 byte:3
> > dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/h=
ci
> > org.bluez.hci.CancelPeriodicInqReq
> > dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/h=
ci
> > org.bluez.hci.InquiryReq byte:1
> > dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/h=
ci
> > org.bluez.hci.RoleSwitchReq string:panu byte:1
> >
> > Suggestions are welcome!
>
> I am not complete through all the changes yet, because the last week was
> quite busy. However for what do we need a dbus-internal.h? I don't see
> any need for it and it would be great if everything is inside dbus.h. If
> we reach the level where stuff gets more generic and can also be reused
> by pand etc. then we should think about moving it into the common/
> toplevel directory. The same applies for common.c. For now simply put
> into dbus.c and resend the patch.
>
> I am not happy with EXEC_RESULT. We should simply use an uint32 for it
> and then reuse the Bluetooth error codes and define some special ones
> for us. The enum is the wrong choice here.
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

------=_Part_393_22977905.1127306974749
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I will analize our comments.<br>
<br>
service_table_t and the function create_error_reply_message will be shared =
by other profiles(pan, hid, rfcomm, ...)<br>
this the reason to put in the dbus-internal.h file. <br>
Regarding the Bluetooth error codes, we can add the code in the D-Bus error=
 messages as a argument. My proposal<br>
is use a standard like this:<br>
<br>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8">or=
g.bluez.hci.error.UnknowMethod<br>
org.bluez.hci.error.WrongSignature<br>
org.bluez.hci.error.WrongParam<br>
org.bluez.hci.error.Failed&nbsp; /* here we can add the bluetooth error cod=
e */<br>
org.bluez.hci.error.Busy<br>
org.bluez.hci.error.NoDevFound<meta name=3D"Generator" content=3D"Kate, the=
 KDE Advanced Text Editor"><br>
<br>



<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8">
<meta name=3D"Generator" content=3D"Kate, the KDE Advanced Text Editor">I w=
ill send a new path soon.<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 9/21/05, <b class=3D"gm=
ail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; I am sending the initial patch that implementing th=
e skeleton<br>&gt; of the hcid D-Bus services.<br>&gt;<br>&gt; Run hcid wit=
h a non-daemon option to see the output<br>&gt;<br>&gt; Send the following =
messages to see the message handling.
<br>&gt;<br>&gt; dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez=
 /org/bluez/hci<br>&gt; org.bluez.hci.PeriodicInqReq byte:1 byte:2 byte:3<b=
r>&gt; dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/blue=
z/hci
<br>&gt; org.bluez.hci.CancelPeriodicInqReq<br>&gt; dbus-send --system --ty=
pe=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci<br>&gt; org.bluez.hci.In=
quiryReq byte:1<br>&gt; dbus-send --system --type=3Dmethod_call --dest=3Dor=
g.bluez
 /org/bluez/hci<br>&gt; org.bluez.hci.RoleSwitchReq string:panu byte:1<br>&=
gt;<br>&gt; Suggestions are welcome!<br><br>I am not complete through all t=
he changes yet, because the last week was<br>quite busy. However for what d=
o we need a=20
dbus-internal.h? I don't see<br>any need for it and it would be great if ev=
erything is inside dbus.h. If<br>we reach the level where stuff gets more g=
eneric and can also be reused<br>by pand etc. then we should think about mo=
ving it into the common/
<br>toplevel directory. The same applies for common.c. For now simply put<b=
r>into dbus.c and resend the patch.<br><br>I am not happy with EXEC_RESULT.=
 We should simply use an uint32 for it<br>and then reuse the Bluetooth erro=
r codes and define some special ones
<br>for us. The enum is the wrong choice here.<br><br>Regards<br><br>Marcel=
<br><br><br><br><br>-------------------------------------------------------=
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_393_22977905.1127306974749--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
