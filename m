Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 9 Apr 2007 10:07:22 +0200
Message-ID: <3EA145998677314383CADD272E25B442510F4B@vmjhbex01.virginmobile.co.za>
From: "Gerhard de Jager" <Gerhard.deJager@virginmobile.co.za>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] BT headset - alsa error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0288064765=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0288064765==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C77A7E.1A1BC213"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C77A7E.1A1BC213
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm trying to use plugz and headsetd to stream sound from mplayer to a
Nokia HS-56W bluetooth headset. I'm not using btsco kernel module,
rather the ALSA plugin written by Fabien Chevalier.
       =20
I've setup my .asoundrc file with the address of the BT headset, and
when I try to run mplayer with -ao alsa:device=3Dheadset, everything =
seems
to be fine in terms that the connection is made to the headset and PIN
is exchanged, bit instead of hearing the sound in the headset I only
hear static, no sound.
       =20
After a while mplayer print the following error message:
       =20
alsa-play: write error: Resource temporarily unavailable
alsa-play: trying to reset soundcard
       =20
I have to do CTRL-C to stop mplayer, and then the static in the headset
stops.
       =20
Any idea why alsa get the "Resource temporarily unavailable" error?
       =20
Some logs from /var/log/messages:
       =20
        Apr  8 17:37:02 tux hcid[7698]: pin_code_request =
(sba=3D00:14:A4:FF:65:CA, dba=3D00:02:76:5C:29:96)
        Apr  8 17:37:02 tux hcid[7698]: link_key_notify =
(sba=3D00:14:A4:FF:65:CA,  dba=3D00:02:76:5C:29:96)
        Apr  8 17:37:03 tux headsetd[8770]: Changing state: =
Paging-->Connecting=20
        Apr  8 17:37:03 tux headsetd[8770]: Changing state: =
Connecting-->Ready
        Apr  8 17:37:03 tux headsetd[8770]: Changing state: =
Ready-->Opening
        Apr  8 17:37:03 tux bluetooth: Starting bluetooth service
        Apr  8 17:37:03 tux headsetd[8770]: SCO channel opened =
handle=3D0x0001 mtu=3D64
        Apr  8 17:37:03 tux headsetd[8770]: Changing state: =
Opening-->Streaming
        Apr  8 17:37:03 tux bluetooth: Starting hidd
       =20
       =20
Thanx in advance!
Gerhard

------_=_NextPart_001_01C77A7E.1A1BC213
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>BT headset - alsa error</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I'm trying to use plugz and headsetd to stream sound =
from mplayer to a<BR>
Nokia HS-56W bluetooth headset. I'm not using btsco kernel module,<BR>
rather the ALSA plugin written by Fabien Chevalier.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
I've setup my .asoundrc file with the address of the BT headset, and<BR>
when I try to run mplayer with -ao alsa:device=3Dheadset, everything =
seems<BR>
to be fine in terms that the connection is made to the headset and =
PIN<BR>
is exchanged, bit instead of hearing the sound in the headset I only<BR>
hear static, no sound.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
After a while mplayer print the following error message:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
alsa-play: write error: Resource temporarily unavailable<BR>
alsa-play: trying to reset soundcard<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
I have to do CTRL-C to stop mplayer, and then the static in the =
headset<BR>
stops.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Any idea why alsa get the &quot;Resource temporarily unavailable&quot; =
error?<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Some logs from /var/log/messages:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:02 tux =
hcid[7698]: pin_code_request (sba=3D00:14:A4:FF:65:CA, =
dba=3D00:02:76:5C:29:96)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:02 tux =
hcid[7698]: link_key_notify (sba=3D00:14:A4:FF:65:CA,&nbsp; =
dba=3D00:02:76:5C:29:96)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
headsetd[8770]: Changing state: Paging--&gt;Connecting<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
headsetd[8770]: Changing state: Connecting--&gt;Ready<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
headsetd[8770]: Changing state: Ready--&gt;Opening<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
bluetooth: Starting bluetooth service<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
headsetd[8770]: SCO channel opened handle=3D0x0001 mtu=3D64<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
headsetd[8770]: Changing state: Opening--&gt;Streaming<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Apr&nbsp; 8 17:37:03 tux =
bluetooth: Starting hidd<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
Thanx in advance!<BR>
Gerhard</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C77A7E.1A1BC213--


--===============0288064765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0288064765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0288064765==--
