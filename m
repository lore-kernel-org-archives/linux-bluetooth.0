Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <004501c4749c$9958f280$5000005a@naxus>
From: "Carlos AM" <Carlos@naxus.biz>
To: "lista bluez" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] modify RFCOMM_DISC_TIMEOUT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C474AC.DED6EA00"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Jul 2004 14:12:09 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C474AC.DED6EA00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel

I think that i've finally found the origin of the errors. The kernel log
shows:

(...)
<4> Unknown HCI packet type 01
(...)


This message is dropped every five minutes (aproximately) and the packet
type is not always 01. It seems that the serial communication (UART) =
with
the bluetooth module (EYMF2CAMM from TAIYO YUDEN) isn't very confiable. =
Do
you agree?

I used to attach the hci device using this command:
/bluez/bluezmain hciattach -n /dev/tts/2 any 115200
and always works.

Then I configured the kernel with BCSP support and tried to attach the
device using:
/bluez/bluezmain hciattach -n /dev/tts/2 bcsp 115200
/bluez/bluezmain hciattach -n /dev/tts/2 swave 115200

but none of them work at all. The error message is [hcid] Can't init =
device
hci0. Connection timed out(110)

What do you think about it?


Thanks for your interest.
Best Regards
CarlosAM








----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Carlos AM" <Carlos@naxus.biz>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Friday, July 23, 2004 11:39 AM
Subject: Re: [Bluez-devel] modify RFCOMM_DISC_TIMEOU

> Hi Carlos,
>
> > I run a rfcomm server built on top of bluez using sockets, the =
client
runs a
> > different bluetooth protocol implementation that is very buggy and
sometimes
> > stops the rfcomm comunication without sending a DISC. So the rfcomm
server
> > waits for 20 seconds (RFCOMM_DISC_TIMEOUT) and then closes the
connections
> > and become available again. The sending loop of the server is:
> >
> > //using sockets
> > //send until write returns -1
> >  while(n>=3D0)
> >  {
> >     n=3Dwrite(client,s,strlen(s));
> >     sleep(1);
> >  }
> > //go to listen again
> >
> >
> > If the client simply stops the communication, not disconnect, the =
server
> > must be available as soon as possible. 20 seconds it's too long for =
our
> > application.
>
> what you want is an idle timeout detection. The RFCOMM_DISC_TIMEOUT is
> not meant for doing this. Show us the output of "hcidump -x -t" while
> this happens.
>
> Regards
>
> Marcel
>
>

Carlos AM
Naxus Conectividad M=F3vil
------=_NextPart_000_0032_01C474AC.DED6EA00
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>Hi=20
Marcel<BR><BR>I think that i've finally found the origin of the errors. =
The=20
kernel log<BR>shows:<BR><BR>(...)<BR>&lt;4&gt; Unknown HCI packet type=20
01<BR>(...)<BR><BR><BR>This message is dropped every five minutes =
(aproximately)=20
and the packet<BR>type is not always 01. It seems that the serial =
communication=20
(UART) with<BR>the bluetooth module (EYMF2CAMM from TAIYO YUDEN) isn't =
very=20
confiable. Do<BR>you agree?<BR><BR>I used to attach the hci device using =
this=20
command:<BR>/bluez/bluezmain hciattach -n /dev/tts/2 any 115200<BR>and =
always=20
works.<BR><BR>Then I configured the kernel with BCSP support and tried =
to attach=20
the<BR>device using:<BR>/bluez/bluezmain hciattach -n /dev/tts/2 bcsp=20
115200<BR>/bluez/bluezmain hciattach -n /dev/tts/2 swave =
115200<BR><BR>but none=20
of them work at all. The error message is [hcid] Can't init =
device<BR>hci0.=20
Connection timed out(110)<BR><BR>What do you think about =
it?<BR><BR><BR>Thanks=20
for your interest.<BR>Best=20
Regards<BR>CarlosAM<BR><BR><BR><BR><BR><BR><BR><BR><BR>----- Original =
Message=20
-----<BR>From: "Marcel Holtmann" &lt;</FONT><A=20
href=3D"mailto:marcel@holtmann.org"><FONT face=3D"Times New Roman"=20
size=3D3>marcel@holtmann.org</FONT></A><FONT face=3D"Times New Roman"=20
size=3D3>&gt;<BR>To: "Carlos AM" &lt;</FONT><A=20
href=3D"mailto:Carlos@naxus.biz"><FONT face=3D"Times New Roman"=20
size=3D3>Carlos@naxus.biz</FONT></A><FONT face=3D"Times New Roman"=20
size=3D3>&gt;<BR>Cc: "BlueZ Mailing List" &lt;</FONT><A=20
href=3D"mailto:bluez-devel@lists.sourceforge.net"><FONT face=3D"Times =
New Roman"=20
size=3D3>bluez-devel@lists.sourceforge.net</FONT></A><FONT face=3D"Times =
New Roman"=20
size=3D3>&gt;<BR>Sent: Friday, July 23, 2004 11:39 AM<BR>Subject: Re:=20
[Bluez-devel] modify RFCOMM_DISC_TIMEOU<BR><BR>&gt; Hi =
Carlos,<BR>&gt;<BR>&gt;=20
&gt; I run a rfcomm server built on top of bluez using sockets, the=20
client<BR>runs a<BR>&gt; &gt; different bluetooth protocol =
implementation that=20
is very buggy and<BR>sometimes<BR>&gt; &gt; stops the rfcomm =
comunication=20
without sending a DISC. So the rfcomm<BR>server<BR>&gt; &gt; waits for =
20=20
seconds (RFCOMM_DISC_TIMEOUT) and then closes the<BR>connections<BR>&gt; =
&gt;=20
and become available again. The sending loop of the server is:<BR>&gt;=20
&gt;<BR>&gt; &gt; //using sockets<BR>&gt; &gt; //send until write =
returns=20
-1<BR>&gt; &gt;&nbsp; while(n&gt;=3D0)<BR>&gt; &gt;&nbsp; {<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; n=3Dwrite(client,s,strlen(s));<BR>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp; sleep(1);<BR>&gt; &gt;&nbsp; }<BR>&gt; &gt; =
//go to=20
listen again<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; If the client simply =
stops=20
the communication, not disconnect, the server<BR>&gt; &gt; must be =
available as=20
soon as possible. 20 seconds it's too long for our<BR>&gt; &gt;=20
application.<BR>&gt;<BR>&gt; what you want is an idle timeout detection. =
The=20
RFCOMM_DISC_TIMEOUT is<BR>&gt; not meant for doing this. Show us the =
output of=20
"hcidump -x -t" while<BR>&gt; this happens.<BR>&gt;<BR>&gt;=20
Regards<BR>&gt;<BR>&gt; Marcel<BR>&gt;<BR>&gt;</FONT><BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Carlos AM<BR>Naxus Conectividad=20
M=F3vil</FONT></DIV></BODY></HTML>

------=_NextPart_000_0032_01C474AC.DED6EA00--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
