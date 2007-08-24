Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W2714BF579C6DC788F8247CD7D70@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 24 Aug 2007 13:35:31 +0200
In-Reply-To: <076BF2A0-A0AF-44B5-9A4D-2BC3EBBE2940@cadvium.net>
References: <076BF2A0-A0AF-44B5-9A4D-2BC3EBBE2940@cadvium.net>
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
Content-Type: multipart/mixed; boundary="===============1122008010=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1122008010==
Content-Type: multipart/alternative;
	boundary="_80a39df3-bdfa-4a03-8d3f-34434074b2f5_"

--_80a39df3-bdfa-4a03-8d3f-34434074b2f5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello Robert!
=20
I want to do the same thing as you. The methods for redirecting audio accor=
ding to the different HOWTO:s seems to involve A2D2P which, I think, is use=
d for point-to-point communication with a headset. A2D2P is not SCO, but ra=
ther ACL (am I right)?
=20
I would like to receive SCO and redirect it to the sound card via Alsa. The=
 idea is that I will recieve SCO in a buffer and then write the buffer to t=
he sound card with Alsa functions. The sound card must be initalized with t=
he correct parameters regarding sample rate, PCM format and so on before be=
ginning to write to the buffer.
=20
I will also record voice via the sound card and then write to a buffer to t=
he socket for SCO.
=20
We have a test version where the voice from a Bluetooth client is echoed ba=
ck from the master to the client. The result is that the person talking in =
the headset will here himself. This is simply done by reading the SCO socke=
t and writing back the same data to the socket.
=20
-Mikael> To: bluez-devel@lists.sourceforge.net> From: rbscott@cadvium.net> =
Date: Wed, 22 Aug 2007 11:23:16 -0700> Subject: [Bluez-devel] SCO Question>=
 > Hello Bluez,> > How would I go about redirecting incoming SCO data to an=
 alsa device, > and transmit incoming audio data out as SCO?> > I have read=
 the following pages,> http://wiki.bluez.org/wiki/Audio> http://wiki.bluez.=
org/wiki/HOWTO/AudioDevices> > but everything described seems to do too muc=
h. I would prefer to > handle the RFCOMM channel, and SDP registration else=
where. > Presently, I just want to determine how to redirect the SCO traffi=
c.> > Thanks,> --robert> > ------------------------------------------------=
-------------------------> This SF.net email is sponsored by: Splunk Inc.> =
Still grepping through log files to find problems? Stop.> Now Search log ev=
ents and configuration files using AJAX and a browser.> Download your FREE =
copy of Splunk now >> http://get.splunk.com/> _____________________________=
__________________> Bluez-devel mailing list> Bluez-devel@lists.sourceforge=
.net> https://lists.sourceforge.net/lists/listinfo/bluez-devel
_________________________________________________________________
Dela filer, prata och spela spel med dina v=E4nner p=E5 Messenger!
http://get.live.com/?revipcountry=3Dse=

--_80a39df3-bdfa-4a03-8d3f-34434074b2f5_
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
Hello Robert!<BR>
&nbsp;<BR>
I want to do the same thing as you. The methods for redirecting audio accor=
ding to the different HOWTO:s seems to involve A2D2P which, I think, is use=
d for point-to-point communication with a headset. A2D2P is not SCO, but ra=
ther ACL (am I right)?<BR>
&nbsp;<BR>
I would like to receive&nbsp;SCO and redirect it to the sound card via Alsa=
. The idea is that I will recieve SCO in a buffer and then write the buffer=
 to the sound card with Alsa functions. The sound card must be initalized w=
ith the correct parameters regarding sample rate, PCM format and so on befo=
re beginning to write to the buffer.<BR>
&nbsp;<BR>
I will also record voice via the sound card and then write to a buffer to t=
he socket for SCO.<BR>
&nbsp;<BR>
We have a test version where the voice from a Bluetooth client is echoed ba=
ck from the master to the client. The result is that the person talking in =
the headset will here himself. This is simply done by reading the SCO socke=
t and writing back the same data to the socket.<BR>
&nbsp;<BR>
-Mikael<BR><BR>&gt; To: bluez-devel@lists.sourceforge.net<BR>&gt; From: rbs=
cott@cadvium.net<BR>&gt; Date: Wed, 22 Aug 2007 11:23:16 -0700<BR>&gt; Subj=
ect: [Bluez-devel] SCO Question<BR>&gt; <BR>&gt; Hello Bluez,<BR>&gt; <BR>&=
gt; How would I go about redirecting incoming SCO data to an alsa device, <=
BR>&gt; and transmit incoming audio data out as SCO?<BR>&gt; <BR>&gt; I hav=
e read the following pages,<BR>&gt; http://wiki.bluez.org/wiki/Audio<BR>&gt=
; http://wiki.bluez.org/wiki/HOWTO/AudioDevices<BR>&gt; <BR>&gt; but everyt=
hing described seems to do too much. I would prefer to <BR>&gt; handle the =
RFCOMM channel, and SDP registration elsewhere. <BR>&gt; Presently, I just =
want to determine how to redirect the SCO traffic.<BR>&gt; <BR>&gt; Thanks,=
<BR>&gt; --robert<BR>&gt; <BR>&gt; ----------------------------------------=
---------------------------------<BR>&gt; This SF.net email is sponsored by=
: Splunk Inc.<BR>&gt; Still grepping through log files to find problems? St=
op.<BR>&gt; Now Search log events and configuration files using AJAX and a =
browser.<BR>&gt; Download your FREE copy of Splunk now &gt;&gt; http://get.=
splunk.com/<BR>&gt; _______________________________________________<BR>&gt;=
 Bluez-devel mailing list<BR>&gt; Bluez-devel@lists.sourceforge.net<BR>&gt;=
 https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR><BR><br /><hr =
/>Dela filer, prata och spela spel med dina v=E4nner p=E5 Messenger, ladda =
ner senaste versionen h=E4r! <a href=3D'http://g.msn.com/8reen_us/SV/INSTAL=
L_MSN_MESSENGER_DL.EXE' target=3D'_new'>Messenger</a></body>
</html>=

--_80a39df3-bdfa-4a03-8d3f-34434074b2f5_--


--===============1122008010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1122008010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1122008010==--
