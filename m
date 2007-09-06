Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W25F1578F21DADF5271926AD7C40@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 6 Sep 2007 13:03:17 +0200
In-Reply-To: <1187957213.15402.137.camel@violet>
References: <076BF2A0-A0AF-44B5-9A4D-2BC3EBBE2940@cadvium.net>
	<1187957213.15402.137.camel@violet>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] SCO Question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0216044624=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0216044624==
Content-Type: multipart/alternative;
	boundary="_956886a9-23f5-45ed-8665-da668a52aff2_"

--_956886a9-23f5-45ed-8665-da668a52aff2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I have now redirected SCO to ALSA. I setup ALSA as a player, that is, sound=
 shall be played on the soundcard. The hardest part in ALSA was to set the =
correct number of frames and number of periods, but with the help of tutori=
als on the web it worked out.
=20
Now I have set up ALSA to play 32 frames, 2 periods, mono, 8 kHz, S16_LE (s=
igned 16 bits little endian on my Intel XScale PXA255). This means 64 bytes=
 of data (one frame =3D one sample is 2 bytes when mono). This corresponds =
to sound from SCO.
=20
Unfortunately, on my system SCO delivers only 60 bytes of data per read ope=
ration, HV3 delivers 30 bytes in one package, which doesn't add up with the=
 soundcard. The soundcard (AC97-based) wants 16, 32, 64 bytes and so on. Th=
erefore the sound isn't of good quality. On other soundcards it may be poss=
ible to set a frame size which corresponds exactly to SCO.
=20
I think I will have to do some buffering from SCO before allowing ALSA to p=
lay sound.=20
=20
-Mikael
> From: marcel@holtmann.org> To: bluez-devel@lists.sourceforge.net> Date: F=
ri, 24 Aug 2007 14:06:53 +0200> Subject: Re: [Bluez-devel] SCO Question> > =
Hi Robert,> > > How would I go about redirecting incoming SCO data to an al=
sa device, > > and transmit incoming audio data out as SCO?> > > > I have r=
ead the following pages,> > http://wiki.bluez.org/wiki/Audio> > http://wiki=
.bluez.org/wiki/HOWTO/AudioDevices> > > > but everything described seems to=
 do too much. I would prefer to > > handle the RFCOMM channel, and SDP regi=
stration elsewhere. > > Presently, I just want to determine how to redirect=
 the SCO traffic.> > actually you can't really do SCO without a profile. In=
 theory you can,> but that is to compatible with out devices. Since this ki=
nd of> application doesn't really make sense for most people we didn't focu=
s on> it and so nothing like that is available. However hstest.c and other =
SCO> demos can be used to quickly write something like that. The hardest pa=
rt> is to get the ALSA thing right. Again, you have to write that by> yours=
elf since we have no need for this right now.> > Regards> > Marcel> > > > -=
------------------------------------------------------------------------> T=
his SF.net email is sponsored by: Splunk Inc.> Still grepping through log f=
iles to find problems? Stop.> Now Search log events and configuration files=
 using AJAX and a browser.> Download your FREE copy of Splunk now >> http:/=
/get.splunk.com/> _______________________________________________> Bluez-de=
vel mailing list> Bluez-devel@lists.sourceforge.net> https://lists.sourcefo=
rge.net/lists/listinfo/bluez-devel
_________________________________________________________________
Nu kan du f=E5r Messenger i mobilen, l=E4s mer!
http://www.mobil.msn.se/=

--_956886a9-23f5-45ed-8665-da668a52aff2_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
I have now redirected SCO to ALSA. I setup ALSA as a player, that is, sound=
 shall be played on the soundcard. The hardest part in ALSA was to set the =
correct number of frames and number of periods, but with the help of tutori=
als on the web it worked out.<BR>
&nbsp;<BR>
Now I have set up ALSA to play 32 frames, 2 periods, mono, 8 kHz, S16_LE (s=
igned 16 bits little endian on my Intel XScale PXA255). This means 64 bytes=
 of data (one frame =3D one sample is 2 bytes when mono). This corresponds =
to sound from SCO.<BR>
&nbsp;<BR>
Unfortunately, on my system SCO delivers only 60 bytes of data per read ope=
ration, HV3&nbsp;delivers 30 bytes in one package,&nbsp;which doesn't add u=
p with the soundcard. The soundcard (AC97-based) wants 16, 32, 64 bytes and=
 so on. Therefore the sound isn't of good quality. On other soundcards it m=
ay be possible to set a frame size which corresponds exactly to SCO.<BR>
&nbsp;<BR>
I think I will have to do some buffering from SCO before allowing ALSA to p=
lay sound. <BR>
&nbsp;<BR>
-Mikael<BR>
<BR>&gt; From: marcel@holtmann.org<BR>&gt; To: bluez-devel@lists.sourceforg=
e.net<BR>&gt; Date: Fri, 24 Aug 2007 14:06:53 +0200<BR>&gt; Subject: Re: [B=
luez-devel] SCO Question<BR>&gt; <BR>&gt; Hi Robert,<BR>&gt; <BR>&gt; &gt; =
How would I go about redirecting incoming SCO data to an alsa device, <BR>&=
gt; &gt; and transmit incoming audio data out as SCO?<BR>&gt; &gt; <BR>&gt;=
 &gt; I have read the following pages,<BR>&gt; &gt; http://wiki.bluez.org/w=
iki/Audio<BR>&gt; &gt; http://wiki.bluez.org/wiki/HOWTO/AudioDevices<BR>&gt=
; &gt; <BR>&gt; &gt; but everything described seems to do too much. I would=
 prefer to <BR>&gt; &gt; handle the RFCOMM channel, and SDP registration el=
sewhere. <BR>&gt; &gt; Presently, I just want to determine how to redirect =
the SCO traffic.<BR>&gt; <BR>&gt; actually you can't really do SCO without =
a profile. In theory you can,<BR>&gt; but that is to compatible with out de=
vices. Since this kind of<BR>&gt; application doesn't really make sense for=
 most people we didn't focus on<BR>&gt; it and so nothing like that is avai=
lable. However hstest.c and other SCO<BR>&gt; demos can be used to quickly =
write something like that. The hardest part<BR>&gt; is to get the ALSA thin=
g right. Again, you have to write that by<BR>&gt; yourself since we have no=
 need for this right now.<BR>&gt; <BR>&gt; Regards<BR>&gt; <BR>&gt; Marcel<=
BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; ----------------------------------------=
---------------------------------<BR>&gt; This SF.net email is sponsored by=
: Splunk Inc.<BR>&gt; Still grepping through log files to find problems? St=
op.<BR>&gt; Now Search log events and configuration files using AJAX and a =
browser.<BR>&gt; Download your FREE copy of Splunk now &gt;&gt; http://get.=
splunk.com/<BR>&gt; _______________________________________________<BR>&gt;=
 Bluez-devel mailing list<BR>&gt; Bluez-devel@lists.sourceforge.net<BR>&gt;=
 https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR><BR><br /><hr =
/>Skapa ditt personliga s=F6kdjur och g=F6r dina s=F6kningar lite roligare =
med SearchPet! <a href=3D'http://searchpet.live.se' target=3D'_new'>SearchP=
et</a></body>
</html>=

--_956886a9-23f5-45ed-8665-da668a52aff2_--


--===============0216044624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0216044624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0216044624==--
