Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
Date: Fri, 29 Jun 2007 15:10:28 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46852386.8050608@free.fr>
MIME-Version: 1.0
References: <46852386.8050608@free.fr>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0516508528=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0516508528==
Content-Type: multipart/alternative;
	boundary="----=_Part_81603_16927828.1183140628453"

------=_Part_81603_16927828.1183140628453
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Fabien,

The API is not properly design for audio over hci that's why you are
confused.
Those methods make no sense as you had mentioned the commands always
come from/goes to alsa plugin (we have just one plugin for pcm that should
handle any kind of audio device) via unix socket. So a normal scenarios whe=
n
sco over hci is to CreateHeadset in the very first time, this will salve th=
e
device
in the storage so it is no longer necessary to create it anymore. This mean
we
don't need any method call to the API to get audio working while in hci
mode,
the plugin already works on demand and I currently fixing the concurrent
connections when an application want to open the device for playback and
capture at same time.
The current API is only useful for audio over PCM, in that case I guess we
need
the API methods to be able to control the streams.
We could disable those concurrent method while in hci mode as they probably
break
the plugin stream, actually they normally affects only the rfcomm socket
because
sco socket got duped in the process so plugin got its own reference that is
not
affected by API calls, but anyway this is a not common behavior for a
headset.

btw, switching between audio device is currently done by changing its
default device.

On 6/29/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
>
>
> Hi Bluez developer,
>
> I'm trying to move forward on the design of the Bluez audio API. I'm
> gonna suggest some new methods and signals to handle HFP and A2DP,
> however at first i feel the need to understand the following methods and
> signals:
>
> Methods:
> --------
> void Play()
> void Stop()
> uint16 GetSpeakerGain()
> uint16 GetMicrophoneGain()
> void SetSpeakerGain(uint16 gain)
> void SetMicrophoneGain(uint16 gain)
>
> Signals:
> ------------
>
> void SpeakerGainChanged(uint16 gain)
> void MicrophoneGainChanged(uint16 gain)
>
> Here is the question : aren't those actions and events not supposed to
> be handled by the various ALSA plugins,
> that would communicate using a dedicated unix socket ?
>
> In fact i'm afraid of the following issues if those methods/signals are
> available:
> * An application could use snd_pcm_start to start playing, and another
> one could shut down the stream using
> Stop() : the result would certainly be an unexpectedly broken stream.
> * Application developpers could be rather confused (Which one of Play()
> or snd_pcm_start should i use? Or maybe i should use both? In this case
> which one am i supposed to call first ?)
> * If the ALSA plugin is supposed to call those method by itself, this
> would mean bring dbus in each
> application process' space, which is not that nice...
> * Gain management signals and functions are redundant with equivalent
> ALSA&GStreamer functions.
>
> I hope this will bring some light on the expected use of those
> methods/signals...
>
> Cheers,
>
> Fabien
>
>
>
>
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

------=_Part_81603_16927828.1183140628453
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Fabien,<br><br>The API is not properly design for audio over hci that=
&#39;s why you are confused.<br>Those methods make no sense as you had ment=
ioned the commands always<br>come from/goes to alsa plugin (we have just on=
e plugin for pcm that should=20
<br>handle any kind of audio device) via unix socket. So a normal scenarios=
 when<br>sco over hci is to CreateHeadset in the very first time, this will=
 salve the device<br>in the storage so it is no longer necessary to create =
it anymore. This mean we
<br>don&#39;t need any method call to the API to get audio working while in=
 hci mode,<br>the plugin already works on demand and I currently fixing the=
 concurrent <br>connections when an application want to open the device for=
 playback and
<br>capture at same time.<br>The current API is only useful for audio over =
PCM, in that case I guess we need<br>the API methods to be able to control =
the streams.<br>We could disable those concurrent method while in hci mode =
as they probably break
<br>the plugin stream, actually they normally affects only the rfcomm socke=
t because<br>sco socket got duped in the process so plugin got its own refe=
rence that is not <br>affected by API calls, but anyway this is a not commo=
n behavior for a headset.
<br><br>btw, switching between audio device is currently done by changing i=
ts default device.<br><br><div><span class=3D"gmail_quote">On 6/29/07, <b c=
lass=3D"gmail_sendername">Fabien Chevalier</b> &lt;<a href=3D"mailto:fabche=
valier@free.fr">
fabchevalier@free.fr</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;"><br>Hi Bluez developer,<br><br>I&#39;m trying to m=
ove forward on the design of the Bluez audio API. I&#39;m
<br>gonna suggest some new methods and signals to handle HFP and A2DP,<br>h=
owever at first i feel the need to understand the following methods and<br>=
signals:<br><br>Methods:<br>--------<br>void Play()<br>void Stop()<br>uint1=
6 GetSpeakerGain()
<br>uint16 GetMicrophoneGain()<br>void SetSpeakerGain(uint16 gain)<br>void =
SetMicrophoneGain(uint16 gain)<br><br>Signals:<br>------------<br><br>void =
SpeakerGainChanged(uint16 gain)<br>void MicrophoneGainChanged(uint16 gain)
<br><br>Here is the question : aren&#39;t those actions and events not supp=
osed to<br>be handled by the various ALSA plugins,<br>that would communicat=
e using a dedicated unix socket ?<br><br>In fact i&#39;m afraid of the foll=
owing issues if those methods/signals are
<br>available:<br> * An application could use snd_pcm_start to start playin=
g, and another<br>one could shut down the stream using<br>Stop() : the resu=
lt would certainly be an unexpectedly broken stream.<br> * Application deve=
loppers could be rather confused (Which one of Play()
<br>or snd_pcm_start should i use? Or maybe i should use both? In this case=
<br>which one am i supposed to call first ?)<br> * If the ALSA plugin is su=
pposed to call those method by itself, this<br>would mean bring dbus in eac=
h
<br>application process&#39; space, which is not that nice...<br> * Gain ma=
nagement signals and functions are redundant with equivalent<br>ALSA&amp;GS=
treamer functions.<br><br>I hope this will bring some light on the expected=
 use of those
<br>methods/signals...<br><br>Cheers,<br><br>Fabien<br><br><br><br><br><br>=
<br>-----------------------------------------------------------------------=
--<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express=
 C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a h=
ref=3D"http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerba=
r/db2/</a><br>_______________________________________________<br>Bluez-deve=
l mailing list
<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</=
a>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Luiz Augusto von De=
ntz<br>Engenheiro de Computa=E7=E3o

------=_Part_81603_16927828.1183140628453--


--===============0516508528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0516508528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0516508528==--
