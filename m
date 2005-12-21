Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
From: Nigel Sim <nigel.sim@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
In-Reply-To: <43A78D40.7070209@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15589_3732393.1135126745476"
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
	 <43A78D40.7070209@xmission.com>
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
Date: Wed, 21 Dec 2005 10:59:05 +1000

------=_Part_15589_3732393.1135126745476
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, new cvs version, I get this:
mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play
00:0A:56:00:B5:91 -
subbands =3D 8 blocks =3D 16 bitpool =3D 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo
len=3D2048
Header size=3D28
Sample Rate:44100
Channels:2
Using address: 00:0A:56:00:B5:91
Found A2DP Sink
Found A2DP Sink at the destination
Connected [imtu 672, omtu 672, flush_to 65535]
Sent the Stream End Point Discovery Command
couldn't get avdtp_discover (only 2 bytes read)

On 12/20/05, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Nigel
>
> > A2DP with the bluetooth-alsa project doesn't work with the Blueant
> > stereo headphones, and by looking at this page it appears that it might
> > be because these headphones don't support AVDTP
> > (http://www.robertwebbe.nl/extendedA2DP.html) Is this possible?
>
> if I remember my alphabet soup correctly, avdtp is a fundamental part of
> a2dp.
>
> > couldn't get avdtp_discover
> > Sent the Stream End Point Discovery Command
>
> i'm not sure why it can't read this information back. perhaps the
> headset for some reason does not report any supported codecs?
>
> i've improved the debug output somewhat. you could try it again.
>
> brad
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_15589_3732393.1135126745476
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, new cvs version, I get this:<br>
mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play 00:0A:56:00=
:B5:91 -<br>
subbands =3D 8 blocks =3D 16 bitpool =3D 32<br>
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.<br>
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.<br>
...<br>
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo<br>
len=3D2048<br>
Header size=3D28<br>
Sample Rate:44100<br>
Channels:2<br>
Using address: 00:0A:56:00:B5:91<br>
Found A2DP Sink<br>
Found A2DP Sink at the destination<br>
Connected [imtu 672, omtu 672, flush_to 65535]<br>
Sent the Stream End Point Discovery Command<br>
couldn't get avdtp_discover (only 2 bytes read)<br><br><div><span class=3D"=
gmail_quote">On 12/20/05, <b class=3D"gmail_sendername">Brad Midgley</b> &l=
t;<a href=3D"mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt; wr=
ote:
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Nigel<br><=
br>&gt; A2DP with the bluetooth-alsa project doesn't work with the Blueant<=
br>
&gt; stereo headphones, and by looking at this page it appears that it migh=
t<br>&gt; be because these headphones don't support AVDTP<br>&gt; (<a href=
=3D"http://www.robertwebbe.nl/extendedA2DP.html">http://www.robertwebbe.nl/=
extendedA2DP.html
</a>) Is this possible?<br><br>if I remember my alphabet soup correctly, av=
dtp is a fundamental part of<br>a2dp.<br><br>&gt; couldn't get avdtp_discov=
er<br>&gt; Sent the Stream End Point Discovery Command<br><br>i'm not sure =
why it can't read this information back. perhaps the
<br>headset for some reason does not report any supported codecs?<br><br>i'=
ve improved the debug output somewhat. you could try it again.<br><br>brad<=
br><br><br>-------------------------------------------------------<br>This=
=20
SF.net email is sponsored by: Splunk Inc. Do you grep through log files<br>=
for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search engi=
ne that makes<br>searching your log files as easy as surfing the&nbsp;&nbsp=
;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br>
<a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3D=
click">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclic=
k</a><br>_______________________________________________<br>Bluez-devel mai=
ling list<br>
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sour=
ceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/=
bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><b=
r>
</blockquote></div><br>

------=_Part_15589_3732393.1135126745476--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
