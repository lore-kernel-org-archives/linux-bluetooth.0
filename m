Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <HCEOIFALKKLBLJPENPNOGEEHCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0002_01C5E537.44FEABF0"
Subject: [Bluez-users] bluez and asterisk
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 9 Nov 2005 14:09:59 -0000

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C5E537.44FEABF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello All,

I have been trying to tackle Theo Zourzouvillys' project on setting up
bluetooth support for Asterisk
(http://crazygreek.co.uk/content/chan_bluetooth), but have run into problems
and since his mailing list link does not work, I turn to you at bluez-users.

My goal is to set up a voice->gsm gateway whereby I can send a call over SIP
which routes that call out over a mobile connected via Bluetooth. Being able
to send up to four simultaneous calls to be routed via four different
mobiles would be even better :-). It seems that Theo's is the perfect
project...

I am sure there is someone out there who has done this and can help/hint
me...

I have successfully:
1. integrated chan_bluetooth into asterisk
2. installed bluez protocol stack:
  a.. bluez-libs-2.22.tar.gz
  b.. bluez-utils-2.22.tar.gz
  c.. bluez-pin-0.26.tar.gz
  d.. bluez-firmware-1.1.tar.gz
  e.. bluez-hcidump-1.27.tar.gz
  f.. bluez-hciemu-1.2.tar.gz
    from www.bluez.org

At this point, on the bluetooth side, my bluetooth dongle can scan and
recognise bluetooth enabled phones. However...

At starting up Asterisk, I get the following error messages:

 [chan_bluetooth.so] => (Bluetooth Channel Driver)
  == Parsing '/etc/asterisk/bluetooth.conf': Found
Jan  9 11:44:14 NOTICE[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1825
rfcomm_listen: Listening for RFCOMM channel 3 connections on FD 11
Jan  9 11:44:14 NOTICE[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1825
rfcomm_listen: Listening for RFCOMM channel 6 connections on FD 12
Jan  9 11:44:14 ERROR[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1841
sco_listen: Can't create SCO socket: No such file or directory (errno: 2)
Jan  9 11:44:14 WARNING[3401]: loader.c:345 ast_load_resource:
chan_bluetooth.so: load_module failed, returning -1
  == Unregistered channel type 'BLT'
Jan  9 11:44:14 WARNING[3401]: loader.c:440 load_modules: Loading module
chan_bluetooth.so failed!

Below are my various config files. Theo did not mention anything about
rfcomm so I am not sure if I am to use this, so I have been playing about a
little and learning at the same time, so please be patient with me and any
advice/info is much appreciated...


  These are my configuration files:

/etc/bluetooth/rfcomm.conf:

rfcomm0 {
        bind yes;
        device 00:0E:6D:34:BD:B1;
        channel 3;
        comment "Bluetooth device";
}

/etc/asterisk/bluetooth.conf:

[general]
rfchannel_ag = 3
interface = 0

;; A Nokia 6310i
[00:0E:6D:34:BD:B1]
name        = Nokia
type        = AG
channel     = 3
autoconnect = yes

/etc/asterisk/extensions.conf:

[general]
static=yes
writeprotect=yes
autofallthrough=yes

[globals]
DEFAULT_RINGING_TIME=20

[default]
exten => _01,1,Dial(SIP/${EXTEN})
exten => _02,1,Dial(SIP/${EXTEN})
exten => _03,1,Dial(BLT/test/XXX)

 (where XXX is the mobile phone number)


Also, there is a bug reported at Theo's site regarding SCO links which is
similar to what I am doing here...any ideas on this?

FYI:
- I have loaded rfcomm, l2cap, hci_usb, bluez modules successfully to the
system.
- hciconfig shows the interface to be UP
- hcitool scan recognises bluetooth phone

Forgive me for the long entry. In anticipation of ALL replies,

Khaled




______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________

------=_NextPart_000_0002_01C5E537.44FEABF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D421155213-09112005><FONT=20
color=3D#0000ff>Hello All,</FONT></SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>I have been trying to tackle Theo =
Zourzouvillys'=20
project on setting up bluetooth support for Asterisk (<A=20
href=3D"http://crazygreek.co.uk/content/chan_bluetooth">http://crazygreek=
.co.uk/content/chan_bluetooth</A>),=20
but have run into problems and since his mailing list link does not =
work, I turn=20
to you at bluez-users.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>My goal is to set up a voice-&gt;gsm gateway=20
whereby&nbsp;I&nbsp;</SPAN></FONT></FONT><FONT face=3DArial><FONT =
color=3D#0000ff=20
size=3D2><SPAN class=3D421155213-09112005><FONT size=3D2>can send a call =
over SIP=20
which routes that call out over a mobile connected via Bluetooth. Being =
able to=20
send up to four simultaneous calls to be routed via four different =
mobiles would=20
be even better :-). It seems that Theo's is the perfect=20
project...</DIV></FONT></SPAN></FONT></FONT>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>I am sure there is someone out there who has =
done this=20
and can help/hint me...</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>I have =
successfully:</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>1. integrated chan_bluetooth into=20
asterisk</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005>2. installed bluez protocol=20
stack:</SPAN></FONT></FONT></DIV><FONT><SPAN =
class=3D421155213-09112005><!--StartFragment -->
<UL style=3D"LIST-STYLE: none none outside">
  <LI><A=20
  =
onmouseover=3D"window.status=3D'http://bluez.sf.net/download/bluez-libs-2=
.22.tar.gz'; return true;"=20
  onmouseout=3D"window.status=3D''; return true;"=20
  =
href=3D"http://www.bluez.org/redirect.php?url=3Dhttp%3A%2F%2Fbluez.sf.net=
%2Fdownload%2Fbluez-libs-2.22.tar.gz"><FONT=20
  face=3DArial size=3D2>bluez-libs-2.22.tar.gz</FONT></A></LI>
  <LI><A=20
  =
onmouseover=3D"window.status=3D'http://bluez.sf.net/download/bluez-utils-=
2.22.tar.gz'; return true;"=20
  onmouseout=3D"window.status=3D''; return true;"=20
  =
href=3D"http://www.bluez.org/redirect.php?url=3Dhttp%3A%2F%2Fbluez.sf.net=
%2Fdownload%2Fbluez-utils-2.22.tar.gz"><FONT=20
  face=3DArial size=3D2>bluez-utils-2.22.tar.gz</FONT></A></LI>
  <LI><A=20
  =
onmouseover=3D"window.status=3D'ftp://gpe.handhelds.org/projects/gpe/sour=
ce/bluez-pin-0.26.tar.gz'; return true;"=20
  onmouseout=3D"window.status=3D''; return true;"=20
  =
href=3D"http://www.bluez.org/redirect.php?url=3Dftp%3A%2F%2Fgpe.handhelds=
.org%2Fprojects%2Fgpe%2Fsource%2Fbluez-pin-0.26.tar.gz"><FONT=20
  face=3DArial size=3D2>bluez-pin-0.26.tar.gz</FONT></A></LI>
  <LI><FONT face=3DArial><FONT color=3D#0000ff><FONT=20
  size=3D2>bluez-firmware-1.1.tar.gz<SPAN=20
  =
class=3D421155213-09112005>&nbsp;&nbsp;</SPAN></FONT></FONT></FONT></LI>
  <LI><A=20
  =
onmouseover=3D"window.status=3D'http://bluez.sf.net/download/bluez-hcidum=
p-1.27.tar.gz'; return true;"=20
  onmouseout=3D"window.status=3D''; return true;"=20
  =
href=3D"http://www.bluez.org/redirect.php?url=3Dhttp%3A%2F%2Fbluez.sf.net=
%2Fdownload%2Fbluez-hcidump-1.27.tar.gz"><FONT=20
  face=3DArial size=3D2>bluez-hcidump-1.27.tar.gz</FONT></A></LI>
  <LI><A=20
  =
onmouseover=3D"window.status=3D'http://bluez.sf.net/download/bluez-hciemu=
-1.2.tar.gz'; return true;"=20
  onmouseout=3D"window.status=3D''; return true;"=20
  =
href=3D"http://www.bluez.org/redirect.php?url=3Dhttp%3A%2F%2Fbluez.sf.net=
%2Fdownload%2Fbluez-hciemu-1.2.tar.gz"><FONT=20
  face=3DArial size=3D2>bluez-hciemu-1.2.tar.gz</FONT></A><SPAN=20
  class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff=20
  size=3D2>&nbsp;</FONT></SPAN></LI></UL>
<DIV><SPAN class=3D421155213-09112005>&nbsp;&nbsp;&nbsp;&nbsp;<FONT =
face=3DArial=20
color=3D#0000ff size=3D2>from <A=20
href=3D"http://www.bluez.org">www.bluez.org</A>&nbsp;</FONT></SPAN></DIV>=

<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =
size=3D2>At=20
this point, on the bluetooth&nbsp;side, my bluetooth dongle&nbsp;can =
scan and=20
recognise bluetooth enabled phones. However...</FONT></SPAN></DIV>
<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =

size=3D2>At&nbsp;starting up Asterisk, I get the following error=20
messages:</FONT></SPAN></DIV>
<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D421155213-09112005><FONT face=3DArial=20
size=3D2>&nbsp;[chan_bluetooth.so] =3D&gt; (Bluetooth Channel =
Driver)<BR>&nbsp; =3D=3D=20
Parsing '/etc/asterisk/bluetooth.conf': Found<BR>Jan&nbsp; 9 11:44:14=20
NOTICE[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1825 =
rfcomm_listen:=20
Listening for RFCOMM channel 3 connections on FD 11<BR>Jan&nbsp; 9 =
11:44:14=20
NOTICE[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1825 =
rfcomm_listen:=20
Listening for RFCOMM channel 6 connections on FD 12<BR>Jan&nbsp; 9 =
11:44:14=20
ERROR[3401]: /usr/src/chan_bluetooth/chan_bluetooth.c:1841 sco_listen: =
Can't=20
create SCO socket: No such file or directory (errno: 2)<BR>Jan&nbsp; 9 =
11:44:14=20
WARNING[3401]: loader.c:345 ast_load_resource: chan_bluetooth.so: =
load_module=20
failed, returning -1<BR>&nbsp; =3D=3D Unregistered channel type =
'BLT'<BR>Jan&nbsp; 9=20
11:44:14 WARNING[3401]: loader.c:440 load_modules: Loading module=20
chan_bluetooth.so failed!</FONT></SPAN></DIV></SPAN></FONT>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D421155213-09112005></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D421155213-09112005><SPAN=20
class=3D421155213-09112005><FONT face=3DArial color=3D#0000ff =
size=3D2>Below are my=20
various config files. Theo did not mention anything about rfcomm so I am =
not=20
sure if I am to use this, so I have been playing about a little and =
learning at=20
the same time, so please be patient with me and any advice/info is much=20
appreciated...</FONT></SPAN></SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005><SPAN=20
class=3D421155213-09112005></SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D421155213-09112005><SPAN=20
class=3D421155213-09112005></SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D421155213-09112005>&nbsp;</SPAN>&nbsp;These are my configuration =

files:</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>/etc/bluetooth/rfcomm.conf:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>rfcomm0=20
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bind yes;</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=20
00:0E:6D:34:BD:B1;</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel=20
3;</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment=20
"Bluetooth device";<BR>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT =
size=3D2>/etc/asterisk/bluetooth.conf:<SPAN=20
class=3D421155213-09112005><FONT=20
color=3D#0000ff>&nbsp;</FONT></SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D421155213-09112005>&nbsp;</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>[general]<BR>rfchannel_ag =3D =
3<BR>interface =3D=20
0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>;; A Nokia=20
6310i<BR>[00:0E:6D:34:BD:B1]<BR>name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D=20
Nokia<BR>type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=20
AG<BR>channel&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<BR>autoconnect =3D =
yes</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>/etc/asterisk/extensions.conf:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>[general]<BR>static=3Dyes<BR>writeprotect=3Dyes<BR>autofallthrou=
gh=3Dyes</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>[globals]<BR>DEFAULT_RINGING_TIME=3D20</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[default]<BR>exten =3D&gt;=20
_01,1,Dial(SIP/${EXTEN})<BR>exten =3D&gt; =
_02,1,Dial(SIP/${EXTEN})<BR>exten =3D&gt;=20
_03,1,Dial(BLT/test/XXX)<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;(where XXX is the mobile phone =
number)</DIV>
<DIV><FONT color=3D#0000ff></FONT><FONT color=3D#0000ff></FONT><FONT=20
color=3D#0000ff></FONT><FONT color=3D#0000ff></FONT><FONT=20
color=3D#0000ff></FONT><BR></DIV>
<DIV><FONT color=3D#0000ff>Also, there is a bug reported at Theo's site =
regarding=20
SCO links which is similar to what I am doing here...any ideas on=20
this?</FONT></DIV>
<DIV><FONT color=3D#0000ff></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff>FYI:</FONT></DIV>
<DIV><FONT color=3D#0000ff>- I have loaded rfcomm, l2cap, hci_usb, bluez =
modules=20
successfully to the system.</FONT></DIV>
<DIV><FONT color=3D#0000ff>- hciconfig shows the interface to be =
UP</FONT></DIV>
<DIV><FONT color=3D#0000ff>- hcitool scan recognises bluetooth =
phone</FONT></DIV>
<DIV><FONT color=3D#0000ff></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff>Forgive me for the long entry. In =
anticipation of ALL=20
replies,</FONT></DIV>
<DIV><FONT color=3D#0000ff></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff>Khaled</FONT></DIV>
<DIV><BR></FONT><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;</FONT>&nbsp;</DIV><BR>___________________________________=
___________________________________<BR>This=20
email has been scanned by the MessageLabs Email Security System.<BR>For =
more=20
information please visit http://www.messagelabs.com/email=20
<BR>_____________________________________________________________________=
_<BR></BODY></HTML>

------=_NextPart_000_0002_01C5E537.44FEABF0--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
