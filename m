Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 5 Nov 2007 22:59:14 -0500
Message-ID: <C041389043587644A5B9F3006A412D76043B42@eevsbs.EEV.local>
From: "Tom McKaige" <tmckaige@eeventures.net>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] a2dp support for multiple headphones through multiple
	dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1331229304=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1331229304==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82029.6518EB6E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C82029.6518EB6E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone,
=20
I am new to both linux and BLUEZ...=20
I am interested in the feasibility of getting multiple A2DP headsets =
playing audio through multiple USB->BT dongles simultaneously.  From the =
below two references I am confused if this is a "future wish" or already =
implemented feature in the current 3.22.  I highlighted in red the =
source of my confusion.
=20
If this feature is already implemented can someone give me a quick =
example of how to set up asound.conf and asoundrc so that I can get =
audio to multiple headsets. I don't require any more than a one to one =
headphone to dongle relationship. =20
=20
If its not already done what would be a sufficient bounty for this?
=20
Thanks in advance
Tom=20
=20
http://wiki.bluez.org/wiki/Audio
FROM the section 'Control socket API"=20

"Plugz does not have any way to handle multiple independent headsets. We =
should at least make a design that doesn't prevent multiple headsets. =
The dbus interface allows us to be specific about what headset we want =
to connect or which headset has connected itself. The dbus api will =
probably also need to pass an index for talking to that headset along =
with connection events. It would usually be 0 (meaning the only set =
connected) but it could be 1, 2, 3. We'd have to set up device entries =
in asound.conf for all these, eg: bluetooth (aka bluetooth0), =
bluetooth1, bluetooth2. These would have an index parameter set to the =
right value."

=20


asound.conf =B6


We will have to put a bunch of entries in here that applications can be =
pointed at, 0 in the examples is to signify the first/only device, ie =
device_index=3D0. could also have alsa entries for 1, 2, 3=20

*	voice, aka voice0 (audio_preference=3Dvoice; will use sco and/or =
wired)=20
*	hifi, aka hifi0 (audio_preference=3Dhifi; will use a2dp or wired for =
output, wired mic)=20
*	auto, aka auto0 (audio_preference=3Dauto; autodetect profile)=20
*	loud, aka loud0 (alternate_speaker_device=3Ddefault; will send sound, =
eg ringer, to any headset too)=20
*	any, aka any0 (audio_preference=3Dnone; always prefer a2dp, sco, then =
wired)=20


------_=_NextPart_001_01C82029.6518EB6E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D'Arial' =
color=3D#000000 size=3D2>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Hi =
everyone,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am new to both linux and =0A=
BLUEZ...&nbsp;</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am interested in the feasibility of =
getting =0A=
multiple A2DP headsets playing audio through multiple USB-&gt;BT dongles =0A=
simultaneously.&nbsp; From the below two references I am confused if =
this is a =0A=
"future wish" or already implemented feature in the =
current&nbsp;3.22.&nbsp; I =0A=
highlighted in red the source of my confusion.</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>If this feature is already implemented =
can someone =0A=
give me a quick example of how to set up asound.conf =
and&nbsp;asoundrc&nbsp;so =0A=
that&nbsp;I can get&nbsp;audio to multiple headsets.&nbsp;I don't =
require any =0A=
more than a one to one headphone to dongle relationship.&nbsp; =
</FONT></DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>If its not already done what would be a sufficient bounty for =
this?</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Thanks in advance</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Tom</FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2><A =0A=
href=3D"/exchweb/bin/redir.asp?URL=3Dhttp://wiki.bluez.org/wiki/Audio" =0A=
target=3D_blank>http://wiki.bluez.org/wiki/Audio</A></FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>FROM the section '<FONT =0A=
face=3D"Times New Roman">Control socket API"</FONT><A class=3Danchor =0A=
title=3D"Link to this section" href=3D""><FONT face=3D"Times New Roman"> =0A=
</FONT></A></FONT></DIV>=0A=
<DIV>=0A=
<P>"<STRONG><FONT color=3D#ff0000>Plugz does not have any way to handle =
multiple =0A=
independent headsets. We should at least make a design that doesn't =
prevent =0A=
multiple headsets. The dbus interface allows us to be specific about =
what =0A=
headset we want to connect or which headset has connected =0A=
itself.</FONT></STRONG> The dbus api will probably also need to pass an =
index =0A=
for talking to that headset along with connection events. It would =
usually be 0 =0A=
(meaning the only set connected) but it could be 1, 2, 3. We'd have to =
set up =0A=
device entries in asound.conf for all these, eg: bluetooth (aka =
bluetooth0), =0A=
bluetooth1, bluetooth2. These would have an index parameter set to the =
right =0A=
value."</P>=0A=
<P>&nbsp;</P>=0A=
<H3 id=3Dasound.conf>asound.conf<A class=3Danchor title=3D"Link to this =
section" =0A=
href=3D""> =B6</A></H3>=0A=
<P><FONT color=3D#ff0000><STRONG>We will have to put a bunch of entries =
in here =0A=
that applications can be pointed at, 0 in the examples is to signify the =0A=
first/only device, ie device_index=3D0. could also have alsa entries for =
1, 2, 3 =0A=
</STRONG></FONT></P>=0A=
<UL>=0A=
  <LI>voice, aka voice0 (audio_preference=3Dvoice; will use sco and/or =
wired) =0A=
  <LI>hifi, aka hifi0 (audio_preference=3Dhifi; will use a2dp or wired =
for output, =0A=
  wired mic) =0A=
  <LI>auto, aka auto0 (audio_preference=3Dauto; autodetect profile) =0A=
  <LI>loud, aka loud0 (alternate_speaker_device=3Ddefault; will send =
sound, eg =0A=
  ringer, to any headset too) =0A=
  <LI>any, aka any0 (audio_preference=3Dnone; always prefer a2dp, sco, =
then wired) =0A=
  </LI></UL></DIV></FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C82029.6518EB6E--


--===============1331229304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1331229304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1331229304==--
